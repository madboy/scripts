import fileinput

for line in fileinput.input():
  print('line', line)
