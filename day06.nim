import strutils

echo "Starting day six..."

type
  Group = seq[string]
var
  i = readFile("input/day-6.txt").strip()
  seen: seq[char]
  groups: seq[Group]
  group: Group
  sum_1, sum_2 = 0

proc allYes(g: Group, c: char): bool =
  for m in g:
    if c notin m:
      return false
  return true

for l in i.splitLines():
  if l.len == 0:
    sum_1 += seen.len
    seen = @[]
    groups.add(group)
    group = @[]
    continue
  group.add(l)
  for c in l:
    if c notin seen:
      seen.add(c)
sum_1 += seen.len
echo "Part one: ", sum_1

for g in groups:
  for c in 'a'..'z':
    if g.allYes(c): sum_2 += 1
echo "Part two: ", sum_2
