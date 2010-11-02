#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

## launch agents
eval $(/usr/bin/killall ssh-agent; /usr/bin/ssh-agent)
eval $(/usr/bin/killall gpg-agent; /usr/bin/gpg-agent --daemon)

## launch dropbox, if installed
[ -x ~/.dropbox-dist/dropboxd & ]

## set the desktop background
[ -f ~/.fehbg ] && sh ~/.fehbg &
[ ! -f ~/.fehbg ] && feh --bg-scale dwm.png

## launch urxvt daemon
urxvtd -q -o -f

## set status bar output
while true; do
    xsetroot -name "$(iwconfig wlan0 | sed 's/ /\n/g' | grep Quality) | $(acpi -b | python battery.py) | $(perl server_room_temp.pl) | $(uptime | sed 's/.*://; s/,//g') | $(date "+%F %R") |"
    sleep 1m
done &

## launch dwm
exec dwm
