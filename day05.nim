import strutils

echo "Starting day five..."
var
  i = readFile("input/day-5.txt").strip().split("\n")
  id = 0
  seat_ids, all_ids, my_ids: seq[int]
# turn input into binary numbers
for it in i.mitems:
  it = it.multiReplace(("F", "0"),("B", "1"),("L","0"),("R","1"))
# generate seat ids and find biggest one
for s in i:
  var s_id = parseBinInt(s[0..6]) * 8 + parseBinInt(s[7..9])
  if s_id > id: id = s_id
  seat_ids.add(s_id)

echo "Part one: ", id

# generate all possible ids
for i in countup(0,127):
  for j in countup(0,7):
    all_ids.add(i * 8 + j)
# check for ids not on the list
for s in all_ids:
  if s notin seat_ids:
    my_ids.add(s)
# find my id
var k = 1
while k < my_ids.len-1:
  if my_ids[k] - 1 != my_ids[k-1] and
     my_ids[k] + 1 != my_ids[k+1]:
    echo "Part two: ", my_ids[k]
    break
  k += 1
