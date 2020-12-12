import strutils, sequtils, algorithm

var
  input = readFile("input/day-10.txt").strip().split("\n").mapIt(parseInt(it))

proc part_1(input: seq[int]): int=
  var
    i = input
    j_1,j_2,j_3 = 0

  i.add(0)
  i.add(i[i.maxIndex]+3)
  i.sort()
  for j in countup(0,i.len-2):
   case i[j+1]-i[j]:
     of 1: j_1 += 1
     of 2: j_2 += 1
     of 3: j_3 += 1
     else: echo "Joltage difference too big: ", i[j+1], "-", i[j], "=",i[j+1]-i[j]
  result = j_1 * j_3

echo "Part one: ",part_1(input)

proc mapCombinations(i: int): int=
  case i:
    of 1,2: result = 1
    of 3: result = 2
    of 4: result = 4
    of 5: result = 7
    else: echo i

proc part_2(input: seq[int]): int=
  var
    i = input
    tmp: seq[int]
    l = 1
  i.add(0)
  i.add(i[i.maxIndex]+3)
  i.sort()
  for j in countup(0,i.len-2):
    if i[j+1] == i[j]+1:
      l += 1
      continue
    tmp.add(l)
    l = 1
  tmp.apply(mapCombinations)
  result = tmp.foldl(a * b)

echo "Part two: ",part_2(input)
