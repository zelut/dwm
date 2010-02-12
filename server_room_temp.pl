#!/usr/bin/perl

use IO::Socket::INET;

print &read_sensor("em01.part.net", "20");

sub read_sensor {
	my ($host, $timeout) = shift @_;

    my $remote = IO::Socket::INET->new (
         Proto    => "tcp",
         PeerAddr => $host,
         PeerPort => 80, 
         Timeout  => $timeout,
    );

    if (!$remote) {
        &debug("connect error: $!\n");
        print "0.0\n";
        exit($ERRORS{'UNKNOWN'});
    }
    &debug("connected to $host:80\n");

    my $didalarm = 0;
    my $hdrs = {};  
    my $read = {};
    eval {
        local $SIG{'ALRM'} = sub { $didalarm=1; die "alarm\n"; };
        alarm($timeout); 

        print $remote "GET /index.html?em345678\r\n";
        my $inhdr = 1;
        while (<$remote>) {
            if ($inhdr) {
                s/[\n\r]+$//;
                if (!length($_)) {
                    $inhdr = 0;
                } elsif (/^([^ :]+)([ :])\s*(.*)$/) {
                    my $n = lc $1;
                    my $v = $3;
                    if (!exists($hdrs->{$n})) {
                        $hdrs->{$n} = [$v];
                    } else {
                        push(@{$hdrs->{$n}}, $v);
                    }
                } else {
                    &debug("Unexpected HTTP header at line $.: $_\n");
                }
            } elsif (/E01.*T\D*([A-Z])\D*([0123456789.]+)\D*
                      HU\D*([0123456789.]+)\D*
                      IL\D*([0123456789.]+)/gx)
            {   
                $read->{'temp-unit'} = $1;
                $read->{'temperature'} = $2;
                $read->{'humidity'} = $3;
                $read->{'illumination'} = $4;
            }
        }
        close($remote);
        alarm(0);
    };

    if ($@) {
        die if $didalarm != 1;
        &debug("timeout(alarm) during sensor read\n");
        print "Unable to read sensor\n";
        exit($ERRORS{'UNKNOWN'});
    }

    return $read->{'temperature'};
};
sub debug {
    my ($msg) = @_;

    if ($opt_debug) {
        print STDERR $msg;
    }
};
