import strutils

echo "Starting day eight..."

var
  input = readFile("input/day-8.txt").strip().split("\n")

proc run(input: seq[string]): (int,int)=
  var
    i = 0
    executed: seq[int]
  while i notin executed and i < input.len:
   var operation = input[i].splitWhitespace()
   executed.add(i)
   case operation[0]:
     of "jmp": i += parseInt(operation[1])
     of "nop": i += 1
     of "acc":
       result[1] += parseInt(operation[1])
       i += 1
  result[0] = i

echo "Part one: ", run(input)[1]

for line in countup(0,input.len-1):
  var op = input[line][0..2]
  if op == "acc": continue
  var
    tmp = input
    res: (int,int)
  case op:
    of "jmp": tmp[line] = "nop"&input[line][3..^1]
    of "nop": tmp[line] = "jmp"&input[line][3..^1]
  res = run(tmp)
  if res[0] == input.len:
    echo "Part two: ", res[1]
    break
