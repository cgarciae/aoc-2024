from pathlib import Path


fn main() raises:
    lines = Path("problems/04/data.txt").read_text().splitlines()
    total = 0
    m_or_s = (String("M"), String("S"))
    for i in range(1, len(lines) - 1):
        for j in range(1, len(lines[i]) - 1):
            if lines[i][j] != "A":
                continue

            if (
                # diagonal down
                lines[i - 1][j - 1] in m_or_s
                and lines[i + 1][j + 1] in m_or_s
                and lines[i - 1][j - 1] != lines[i + 1][j + 1]
                # diagonal up
                and lines[i + 1][j - 1] in m_or_s
                and lines[i - 1][j + 1] in m_or_s
                and lines[i + 1][j - 1] != lines[i - 1][j + 1]
            ):
                total += 1

    print("Total:", total)
