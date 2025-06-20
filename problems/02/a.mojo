from pathlib import Path

fn main() raises:
  data = Path("problems/02/data.txt").read_text()
  total_safe = 0
  for line in data.splitlines():
    numbers_str = line.split(" ")
    numbers = List[Int]()
    for i in range(len(numbers_str)):
      numbers.append(Int(numbers_str[i]))
    
    prev_dir = 1 if numbers[1] > numbers[0] else -1
    for i in range(1, len(numbers)):
      curr = numbers[i]
      prev = numbers[i - 1]
      curr_dir = 1 if curr > prev else -1
      diff = abs(curr - prev)
      if diff < 1 or diff > 3 or curr_dir != prev_dir:
        break
    else:
      total_safe += 1
    
  print("Total safe numbers:", total_safe)


