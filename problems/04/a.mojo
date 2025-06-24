from pathlib import Path


fn is_xmas(
    read lines: List[String], owned i: Int, owned j: Int, di: Int, dj: Int
) -> Bool:
    if not (0 <= i + 3 * di < len(lines) and 0 <= j + 3 * dj < len(lines[0])):
        return False
    n = 0
    while n < 4:
        char = lines[i][j]
        if (
            (n == 0 and char == "X")
            or (n == 1 and char == "M")
            or (n == 2 and char == "A")
            or (n == 3 and char == "S")
        ):
            n += 1
        else:
            return False
        i += di
        j += dj
    return True


fn main() raises:
    lines = Path("problems/04/data.txt").read_text().splitlines()
    total = 0
    directions: Dict[String, Tuple[Int, Int]] = {
        "down": (1, 0),
        "down-right": (1, 1),
        "right": (0, 1),
        "up-right": (-1, 1),
        "up": (-1, 0),
        "up-left": (-1, -1),
        "left": (0, -1),
        "down-left": (1, -1)
    }
    for i in range(len(lines)):
        for j in range(len(lines[i])):
            if lines[i][j] != "X":
                continue
            
            for entry in directions.items():
                di, dj = entry.value
                if is_xmas(lines, i, j, di, dj):
                    total += 1

    print("Total:", total)
