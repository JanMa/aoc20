import math, strutils, tables

type
  Bit = range[0..2^36-1]

proc applyMask(x: Bit, m: string): Bit=
  var b = toBin(x,36)
  for i in countup(0,m.len-1):
    if m[i] == 'X': continue
    b[i] = m[i]
  result = Bit(parseBinInt(b))

var
  memory = initTable[Bit,Bit]()
  input = readFile("input/day14.txt").strip().split("\n")
  sum = 0

var mask: string
for l in input:
  if l[0..3] == "mask":
    mask = l[7..^1]
  else:
    var
      a = Bit(parseInt(l[4..l.find("]",5)-1]))
      v = Bit(parseInt(l[l.find("=",0)+2..^1]))
      m = applyMask(v, mask)
    memory[a] = m


for i in memory.values: sum += i

echo "Part one: ", sum
