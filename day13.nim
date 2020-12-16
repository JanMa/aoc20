import strutils, sequtils

var
  input = readFile("input/day-13.txt").strip().split("\n")
  epoch = parseInt(input[0])
  bus_lines = input[1].split(",").filterIt(it != "x").mapIt(parseInt(it))

echo bus_lines
var time = epoch
block forever:
  while true:
    for b in bus_lines:
      if time mod b == 0:
        echo "Part one: ", (time - epoch) * b
        break forever
    time += 1
