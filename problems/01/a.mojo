from pathlib import Path

fn main() raises:
  data = Path("problems/01/data.txt").read_text()
  left = List[Int]()
  right = List[Int]()
  for line in data.splitlines():
    numbers = line[].split("   ")
    left.append(Int(numbers[0]))
    right.append(Int(numbers[1]))

  sort(left)
  sort(right)

  result = 0
  for i in range(len(left)):
    a = left[i]
    b = right[i]
    result += abs(a - b)

  print(result)
