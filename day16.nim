import strutils, sequtils

var
  input = readFile("input/day-16.txt").strip().split("\n")
  field: seq[(string,seq[int],seq[int])]

# parse fields
for l in input:
  if l.len == 0: break
  var
    f = l.split(":")
    r = f[1].strip().split(" ")
    r1 = r[0].split("-").mapIt(parseInt(it))
    r2 = r[2].split("-").mapIt(parseInt(it))
  field.add((f[0],toseq(r1[0]..r1[1]),toseq(r2[0]..r2[1])))

var
  start = 0
  sum = 0

#lookup start of tickets
for i, l in input.pairs:
  if l == "nearby tickets:":
    start = i+1
    break

proc valid(f: int, field: seq[(string,seq[int],seq[int])]): bool=
  any(field, proc (x: (string,seq[int],seq[int])): bool = f in x[1] or f in x[2])

for i in countup(start,input.len-1):
  var l = input[i].split(",").mapIt(parseInt(it))
  for f in l:
    if not f.valid(field): sum += f

echo "Part one: ", sum
