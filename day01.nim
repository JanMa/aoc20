import strutils

echo "Starting day one..."
let i = readFile("input/day-1.txt").strip().split("\n")
var input: seq[int]
for s in i:
  input.add(parseInt(s))

block outer:
  for i in countup(0,input.len-1):
    for j in countup(i+1,input.len-1):
      if input[i] + input[j] == 2020:
        echo input[i], " ", input[j]
        echo "Part one: ", input[i] * input[j]
        break outer

block outer2:
  for i in countup(0,input.len-1):
    for j in countup(i+1,input.len-1):
      for k in countup(j+1,input.len-1):
        if input[i] + input[j] + input[k] == 2020:
          echo input[i], " ", input[j], " ", input[k]
          echo "Part two: ", input[i] * input[j] * input[k]
          break outer2
