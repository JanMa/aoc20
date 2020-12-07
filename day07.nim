import strutils, parseutils, sequtils

var
  i = readFile("input/day-7.txt").strip()
  my_colors, seen = @["shiny gold"]
  count = 0

echo "Starting day seven..."

proc holdsColor(input, color: string): seq[string]=
  for l in input.splitLines():
    var
      c: string
      offset = l.parseUntil(c, " bags contain")
    if l[offset..^1].contains(color):
      result.add(c)

while my_colors.len > 0:
  var tmp: seq[string]
  for c in my_colors:
    tmp = tmp.concat(i.holdsColor(c))
  tmp = tmp.deduplicate()
  tmp.keepItIf(it notin seen)
  seen = seen.concat(tmp)
  count += tmp.len
  my_colors = tmp
  tmp = @[]

echo "Part one: ", count

proc containsBags(input, color: string): int=
  var i = input.split("\n")
  for l in i.mitems:
    if l.startsWith(color):
      l.removePrefix(color & " bags contain ")
      case l:
        of "no other bags.": return 0
        else:
          for b in l.split(", ").mapIt(it.splitWhitespace):
            result += parseInt(b[0]) * (containsBags(input, b[1]&" "&b[2]) + 1)

echo "Part two: ", containsBags(i, "shiny gold")
