import strutils

echo "Starting day four..."
let i = readFile("input/day-4.txt").strip()

type
  Pass = object
    byr, iyr, eyr, len: int
    hgt, hcl, ecl, pid, cid: string

proc valid(p: Pass): int =
  if p.len == 8 or p.len == 7 and p.cid.len == 0:
    result = 1

proc valid_2(p: Pass): int =
  result = 1
  if p.byr < 1920 or p.byr > 2002:
    return 0
  if p.iyr < 2010 or p.iyr > 2020:
    return  0
  if p.eyr < 2020 or p.eyr > 2030:
    return 0
  if p.hgt.len > 2:
    let h = parseInt(p.hgt[0..^3])
    case p.hgt[^2..^1]:
    of "cm":
      if h < 150 or h > 193:
        return 0
    of "in":
      if h < 59 or h > 76:
        return 0
    else:
      return 0
  else:
    return 0
  if p.hcl.len > 0 and p.hcl[0] == '#':
    try:
      discard parseHexInt(p.hcl)
    except:
      return 0
  else:
    return 0
  if p.ecl notin ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]:
    return 0
  if p.pid.len == 9:
    try:
      discard parseInt(p.pid)
    except:
      return 0
  else:
    return 0

  
var
  passports: seq[Pass]
  p: Pass
 
for l in i.splitLines():
  if l.len == 0:
    passports.add(p)
    p = Pass()
    continue
  for kv in l.split(' '):
    var keyval = kv.split(':')
    case keyval[0]:
      of "byr":
        p.byr = parseInt(keyval[1])
        p.len += 1
      of "eyr":
        p.eyr = parseInt(keyval[1])
        p.len += 1
      of "iyr":
        p.iyr = parseInt(keyval[1])
        p.len += 1
      of "hgt":
        p.hgt = keyval[1]
        p.len += 1
      of "hcl":
        p.hcl = keyval[1]
        p.len += 1
      of "ecl":
        p.ecl = keyval[1]
        p.len += 1
      of "pid":
        p.pid = keyval[1]
        p.len += 1
      of "cid":
        p.cid = keyval[1]
        p.len += 1
      else:
        echo "invalid key: ", keyval[0]

var valid_p, valid_p2 = 0
for p in passports:
  valid_p += p.valid()
  valid_p2 += p.valid_2()


echo "Part one: ", valid_p
echo "Part two: ", valid_p2
