from pathlib import Path


fn is_xmas(
    read lines: List[String], mut i: Int, mut j: Int, di: Int, dj: Int
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
            print(n, char)
            n += 1
        else:
            print(n, char, "not match\n")
            return False
        i += di
        j += dj
    print("\n")
    return True


fn main() raises:
    lines = Path("problems/04/test.txt").read_text().splitlines()
    total = 0
    for i in range(len(lines)):
        for j in range(len(lines[i])):
            print(i, j)
            if is_xmas(lines, i, j, 1, 0):  # down
                total += 1
            if is_xmas(lines, i, j, 0, 1):  # right
                total += 1
            if is_xmas(lines, i, j, -1, 0):  # up
                total += 1
            if is_xmas(lines, i, j, 0, -1):  # left
                total += 1
            print(i, j, "total:", total)

    print("Total:", total)
