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
  valid_tickets: seq[seq[int]]

#lookup start of tickets
for i, l in input.pairs:
  if l == "nearby tickets:":
    start = i+1
    break

proc valid(f: int, field: seq[(string,seq[int],seq[int])]): bool=
  any(field, proc (x: (string,seq[int],seq[int])): bool = f in x[1] or f in x[2])

proc matchingField(f: int, field: seq[(string,seq[int],seq[int])]): seq[string]=
  var m = filter(field, proc (x: (string,seq[int],seq[int])): bool = f in x[1] or f in x[2])
  if m.len > 0:
    result = m.mapIt(it[0])

for i in countup(start,input.len-1):
  var l = input[i].split(",").mapIt(parseInt(it))
  for f in l:
    if not f.valid(field): sum += f
    else: valid_tickets.add(l)

valid_tickets = valid_tickets.deduplicate()
echo "Part one: ", sum

var
  matchingFields = newSeq[seq[seq[string]]](valid_tickets[0].len)
  assignedFields = newSeq[string](valid_tickets[0].len)

for v in valid_tickets:
  for i, f in v.pairs:
    var m = matchingField(f,field)
    if m.len > 0:
      matchingFields[i].add(m)

while "" in assignedFields:
  for i,f in matchingFields.mpairs:
   var possibleFields: seq[string]
   for a in assignedFields:
     for j in f.mitems:
       j = filter(j, proc(x: string): bool= x != a)
   for j in field:
     if all(f, proc(x: seq[string]): bool= j[0] in x ):
       possibleFields.add(j[0])
   if possibleFields.len == 1:
     assignedFields[i] = possibleFields[0]

for i, j in assignedFields.pairs: echo "Field ", i, ": ", j

var
  myticket: seq[int]
  sum2: seq[int]

#lookup my ticket
for i, l in input.pairs:
  if l == "your ticket:":
    myticket = input[i+1].split(",").mapIt(parseInt(it))
    break

for i, f in assignedFields.pairs:
  if f.startsWith("departure"):
    sum2.add(myticket[i])

echo "Part two: ", foldl(sum2, a * b)
