#!/usr/bin/env python
"""
An example of a script reading data from stdin
or from a while and does some processing on
the lines.

This specific exmaples reads messages in syslog
and counts them per 'unit'
"""
import fileinput
from collections import defaultdict


data = defaultdict(lambda : defaultdict(int))
matches = []

out_format = '{}\t{}\t{}'

for line in fileinput.input():
    if 'wpa_supplicant' in line:
        matches.append(line.strip())

splits = (match.split(' ') for match in matches)

# this nees to change to handle potential duplicate
# messages for one unit
for s in splits:
    timestamp = s[2]
    unit = s[5]
    message = ' '.join(s[6:])
    data[unit]['count'] += 1
    data[unit]['message'] = message

for k in data.keys():
    print(out_format.format(k, data[k]['message'], data[k]['count']))
