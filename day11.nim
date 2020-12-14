import strutils, sequtils

echo "Starting day eleven..."

var
  input = readFile("input/day-11.txt").strip().split("\n")

proc occupied(input: seq[string], i,j: int): int =
  for v in @[i-1,i,i+1]:
    if v < 0 or v >= input.len: continue
    for h in @[j-1,j,j+1]:
      if h < 0 or h >= input[v].len: continue
      if h == j and v == i: continue
      # echo "input[",v,"][",h,"]=",input[v][h]
      if input[v][h] == '#': result += 1

proc occupied_2(input: seq[string], i,j: int): int =
  # echo "i: ",i
  # echo "j: ",j
  #up
  # echo "up"
  for k in countdown(i-1,0):
    # # echo "input[",k,"][",j,"]=",input[k][j]
    if input[k][j] == 'L': break
    if input[k][j] == '#':
      result += 1
      break
  #down
  # echo "down"
  for k in countup(i+1,input.len-1):
    # # echo "input[",k,"][",j,"]=",input[k][j]
    if input[k][j] == 'L': break
    if input[k][j] == '#':
      result += 1
      break
  #right
  # echo "right"
  for k in countup(j+1,input[i].len-1):
    # echo "input[",i,"][",k,"]=",input[i][k]
    if input[i][k] == 'L': break
    if input[i][k] == '#':
      result += 1
      break
  #left
  # echo "left"
  for k in countdown(j-1,0):
    # echo "input[",i,"][",k,"]=",input[i][k]
    if input[i][k] == 'L': break
    if input[i][k] == '#':
      result += 1
      break
  #up right
  # echo "up right"
  var
    v = i-1
    h = j+1
  while v >= 0 and h < input[i].len:
    # echo "input[",v,"][",h,"]=",input[v][h]
    if input[v][h] == 'L': break
    if input[v][h] == '#':
      result += 1
      break
    v -= 1
    h += 1
  #up left
  # echo "up left"
  v = i-1
  h = j-1
  while v >= 0 and h >= 0:
    # echo "input[",v,"][",h,"]=",input[v][h]
    if input[v][h] == 'L': break
    if input[v][h] == '#':
      result += 1
      break
    v -= 1
    h -= 1
  #down left
  # echo "down left"
  v = i+1
  h = j-1
  while v < input.len and h >= 0:
    # echo "input[",v,"][",h,"]=",input[v][h]
    if input[v][h] == 'L': break
    if input[v][h] == '#':
      result += 1
      break
    v += 1
    h -= 1
  #down right
  # echo "down right"
  v = i+1
  h = j+1
  while v < input.len and h < input[i].len:
    # echo "input[",v,"][",h,"]=",input[v][h]
    if input[v][h] == 'L': break
    if input[v][h] == '#':
      result += 1
      break
    v += 1
    h += 1

proc pretty(input: seq[string]) =
  for l in input: echo l

proc occupiedSeats(input: seq[string],limit: int, algo: proc): seq[string]=
  result = input
  for i in countup(0,input.len-1):
   for j in countup(0,input[i].len-1):
     case input[i][j]:
       of 'L':
         if algo(input,i,j) == 0: result[i][j] = '#'
       of '.': continue
       of '#':
         if algo(input,i,j) >= limit: result[i][j] = 'L'
       else: echo "invalid char"

var
  tmp = occupiedSeats(input,4,occupied)
  tmp_2 = occupiedSeats(tmp,4,occupied)
  sum_1 = 0

while tmp != tmp_2:
  tmp = tmp_2
  tmp_2 = occupiedSeats(tmp,4,occupied)

for l in tmp: sum_1 += l.count('#')
echo "Part one: ", sum_1

var
  tmp_3 = occupiedSeats(input,5,occupied_2)
  tmp_4 = occupiedSeats(tmp_3,5,occupied_2)
  sum_2 = 0

while tmp_3 != tmp_4:
  tmp_3 = tmp_4
  tmp_4 = occupiedSeats(tmp_3,5,occupied_2)

for l in tmp_4: sum_2 += l.count('#')
echo "Part two: ", sum_2
