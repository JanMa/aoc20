import strutils

echo "Starting day five..."

var
  i = readFile("input/day-5.txt").strip().split("\n")
  max_id = 0
  min_id = high(int)
  seat_ids, all_ids: seq[int]

# turn input into binary numbers
for it in i.mitems:
  it = it.multiReplace(("F", "0"),("B", "1"),("L","0"),("R","1"))

# generate seat ids and find biggest and smallest one
for s in i:
  var s_id = parseBinInt(s[0..6]) * 8 + parseBinInt(s[7..9])
  if s_id > max_id: max_id = s_id
  if s_id < min_id: min_id = s_id
  seat_ids.add(s_id)

echo "Part one: ", max_id
# generate all possible ids
for i in countup(0,127):
  for j in countup(0,7):
    all_ids.add(i * 8 + j)

# check for ids not on the list
# my id is the only one bigger than min_id and smaller than max_id
for s in all_ids:
  if s notin seat_ids:
    if s > min_id and s < max_id:
      echo "Part two: ", s
      break
