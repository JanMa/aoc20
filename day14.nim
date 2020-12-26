import math, strutils, tables, sequtils

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

proc permutations(a: string): seq[string]=
  var n = a.count('X')
  if n == 0: return @[]
  var perm = toseq(0..2^n-1).mapIt(toBin(it,n))
  for p in perm.mitems():
    var i = a
    for j in i.mitems():
      if j == 'X':
        if len(p) > 0: j = p[0]
        if len(p) > 1: p = p[1..^1]
        else: p = ""
    result.add(i)

proc applyMask2(x: Bit, m: string): seq[Bit]=
  var b = toBin(x,36)
  for i in countup(0,m.len-1):
    if m[i] == '0': continue
    b[i] = m[i]
  result = permutations(b).mapIt(Bit(parseBinInt(it)))

mask = ""
sum = 0
memory = initTable[Bit,Bit]()
for l in input:
  if l[0..3] == "mask":
    mask = l[7..^1]
  else:
    var
      a = Bit(parseInt(l[4..l.find("]",5)-1]))
      v = Bit(parseInt(l[l.find("=",0)+2..^1]))
      m = applyMask2(a, mask)
    for i in m: memory[i] = v

for i in memory.values: sum += i

echo "Part two: ", sum
