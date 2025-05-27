from pathlib import Path
from collections import Dict, List

fn main() raises:
  data = Path("problems/01/data.txt").read_text()
  left = List[Int]()
  right = List[Int]()
  
  for line in data.splitlines():
    numbers = line[].split("   ")
    left.append(Int(numbers[0]))
    right.append(Int(numbers[1]))

  elem_count = Dict[Int, Int]()

  for i in range(len(right)):
    x = right[i]
    if x in elem_count:
      elem_count[x] += 1
    else:
      elem_count[x] = 1

  result = 0
  for i in range(len(left)):
    x = left[i]
    if x in elem_count:
      result += x * elem_count[x]

  print(result)
