#!/usr/bin/env python
"""An example of a script reading data from stdin.

Or from a file and does some processing on
the lines.

This specific exmaples reads messages in syslog
and counts them per 'unit'

Usage: cat /var/log/syslog | ./read_stdin.py
"""
import fileinput
from collections import defaultdict, namedtuple


data = defaultdict(lambda : defaultdict(int))
Unit = namedtuple('Unit', ('name', 'message'))
matches = []

out_format = '{}\t{}\t{}'

for line in fileinput.input():
    if 'wpa_supplicant' in line:
        matches.append(line.strip())

splits = (match.split(' ') for match in matches)

for s in splits:
    timestamp = s[2]
    unit = s[5]
    message = ' '.join(s[6:])
    u = Unit(unit, message)
    data[u]['count'] += 1

for unit in data.keys():
    print(out_format.format(unit.name, unit.message, data[unit]['count']))
