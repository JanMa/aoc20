import strutils, sequtils, algorithm

echo "Starting day nine..."

var
  input = readFile("input/day-9.txt").strip().split("\n").mapIt(parseInt(it))
  preamble = 25
  solution_1, solution_2 = 0

for i in countup(preamble,input.len-1):
  block valid:
    for j in countup(i-preamble,i-1):
      for k in countup(j+1,i-1):
        if input[j]+input[k] == input[i]:
          break valid
    solution_1 = input[i]
    break

echo "Part one: ",solution_1

block found:
  for i in countup(0,input.len-1):
   var
     sum = input[i]
     range = @[sum]
   for j in countup(i+1,input.len-1):
     sum += input[j]
     range.add(input[j])
     if sum > solution_1: break
     if sum == solution_1:
       range.sort()
       solution_2 = range[0]+range[^1]
       break found

echo "Part two: ",solution_2
