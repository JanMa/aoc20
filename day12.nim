import strutils, sequtils

var
  input = readFile("input/day-12.txt").strip().split("\n")

type
  Direction = int # 0: north 1: east 2: south 3: west
  Ferry = object
    position: (int,int)
    direction: Direction
    waypoint: (int,int)

var ferry = Ferry(position: (0,0),direction: 1)

for l in input:
  case l[0]:
    of 'N': ferry.position[1] += parseInt(l[1..^1])
    of 'E': ferry.position[0] += parseInt(l[1..^1])
    of 'S': ferry.position[1] -= parseInt(l[1..^1])
    of 'W': ferry.position[0] -= parseInt(l[1..^1])
    of 'R': ferry.direction = ( ( parseInt(l[1..^1]) div 90 ) + ferry.direction ) mod 4
    of 'L':
      ferry.direction = ( - ( parseInt(l[1..^1]) div 90 ) + ferry.direction ) mod 4
      if ferry.direction < 0 : ferry.direction += 4
    of 'F':
      case ferry.direction:
        of 0: ferry.position[1] += parseInt(l[1..^1])
        of 1: ferry.position[0] += parseInt(l[1..^1])
        of 2: ferry.position[1] -= parseInt(l[1..^1])
        of 3: ferry.position[0] -= parseInt(l[1..^1])
        else: echo "invalid direction ", ferry.direction
    else: echo "invalid op ", l[0]

echo "Part one: ", abs(ferry.position[0]) + abs(ferry.position[1])
ferry = Ferry(position: (0,0),direction: 1, waypoint: (10,1))

for l in input:
  case l[0]:
    of 'N': ferry.waypoint[1] += parseInt(l[1..^1])
    of 'E': ferry.waypoint[0] += parseInt(l[1..^1])
    of 'S': ferry.waypoint[1] -= parseInt(l[1..^1])
    of 'W': ferry.waypoint[0] -= parseInt(l[1..^1])
    of 'R':
      case parseInt(l[1..^1]):
        of 90:  ferry.waypoint = (ferry.waypoint[1],-ferry.waypoint[0])
        of 180: ferry.waypoint = (-ferry.waypoint[0],-ferry.waypoint[1])
        of 270:  ferry.waypoint = (-ferry.waypoint[1],ferry.waypoint[0])
        else: echo "wrong degree"
    of 'L':
      case parseInt(l[1..^1]):
        of 90:  ferry.waypoint = (-ferry.waypoint[1],ferry.waypoint[0])
        of 180: ferry.waypoint = (-ferry.waypoint[0],-ferry.waypoint[1])
        of 270:  ferry.waypoint = (ferry.waypoint[1],-ferry.waypoint[0])
        else: echo "wrong degree"
    of 'F':
      ferry.position[0] = ferry.position[0] + parseInt(l[1..^1]) * ferry.waypoint[0]
      ferry.position[1] = ferry.position[1] + parseInt(l[1..^1]) * ferry.waypoint[1]
    else: echo "invalid op ", l[0]

echo "Part two: ", abs(ferry.position[0]) + abs(ferry.position[1])
