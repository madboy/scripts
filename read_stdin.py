import fileinput
from collections import defaultdict

values = defaultdict(lambda : defaultdict(int))

for line in fileinput.input():
  print('line', line)
