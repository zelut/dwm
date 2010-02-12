#!/usr/bin/env python

import re, sys

pattern = re.compile(r'Battery\s+(\d+):\s+(\w+),\s+(\d+)%')
items = pattern.findall(sys.stdin.read())

new = []
for item in items:
    new.append('Battery %s: %s, %s%%' % item)

print ' | '.join(new)
