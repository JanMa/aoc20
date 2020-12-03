import strutils

echo "Starting day three..."
let i = readFile("input/day-3.txt").strip().split("\n")

proc slope(i: seq[string], r,d: int): int =
  var j,k = 0
  while j < i.len:
   if i[j][k] == '#':
       result += 1
   k = ( k + r ) mod i[j].len
   j += d

echo "Part one: ", slope(i,3,1)
echo "Part two: ", (slope(i,1,1) * slope(i,3,1) * slope(i,5,1) * slope(i,7,1) * slope(i,1,2))
