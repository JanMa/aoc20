import strutils

echo "Starting day two..."
let i = open("input/day-2.txt")

type
  Policy = object
    min, max: int
    letter: char
  Password = object
    policy: Policy
    value: string
    valid: bool

var passwords: seq[Password]
var line = ""

while readLine(i, line):
  var s = line.split(" ")
  var min_max = s[0].split("-")
  passwords.add(Password(value: s[2],
                         policy: Policy(min: parseInt(min_max[0]),
                                        max: parseInt(min_max[1]),
                                        letter: s[1][0])))

proc check_pwd(pwd: var Password): int =
  let c = count(pwd.value, pwd.policy.letter)
  if c >= pwd.policy.min and c <= pwd.policy.max:
    pwd.valid = true
    result = 1
  else:
    pwd.valid = false

proc check_pwd_2(pwd: var Password): int =
  if pwd.value[pwd.policy.min-1] == pwd.policy.letter and
     pwd.value[pwd.policy.max-1] != pwd.policy.letter or
     pwd.value[pwd.policy.min-1] != pwd.policy.letter and
     pwd.value[pwd.policy.max-1] == pwd.policy.letter:
    pwd.valid = true
    result = 1
  else:
    pwd.valid = false

var valid = 0
for p in passwords.mitems:
  valid += check_pwd(p)
echo "Part one: ", valid

valid = 0
for p in passwords.mitems:
  valid += check_pwd_2(p)
echo "Part two: ", valid
i.close()
