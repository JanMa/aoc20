import strutils, sequtils

var
  input = "6,13,1,15,2,0".split(",").mapIt(parseInt(it))

while input.len != 2020:
  if not input[0..^2].contains(input[^1]): input.add(0)
  else:
    for i in countdown(input.len-2,0):
      if input[i] == input[^1]:
        input.add(input.len-1-i)
        break

echo input[^1]
