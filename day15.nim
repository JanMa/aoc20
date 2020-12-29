import strutils, sequtils, tables

var
  input = "6,13,1,15,2,0".split(",").mapIt(parseInt(it))

while input.len != 2020:
  if not input[0..^2].contains(input[^1]): input.add(0)
  else:
    for i in countdown(input.len-2,0):
      if input[i] == input[^1]:
        input.add(input.len-1-i)
        break

echo "Part one: ", input[^1]

var
  m = initTable[int,int]()
  last = input[5]
  turn = 5

for i in countup(0,4):
  m[input[i]] = i

while turn < 30000000 - 1:
  if not m.contains(last):
    m[last] = turn
    last = 0
  else:
    var tmp = last
    last = turn - m[last]
    m[tmp] = turn
  turn += 1

echo "Part two: ", last
