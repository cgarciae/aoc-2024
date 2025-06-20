class AdventDay2:

    def __init__(self):
        """Read in the input file and store the data in a list of lists."""
        self.data = []
        self.unsafe = []
        with open('problems/02/data.txt', 'r') as f:
            for line in f.readlines():
                self.data.append([int(x) for x in line.split()])
        self.part1 = 0
        self.part2 = 0

    def find_safe_reports(self):
        """Find the number of safe rows in the input file and also stores
        any unsafe row's index in a list for part 2."""
        for i, row in enumerate(self.data):
            if self._is_safe_row(row):
                self.part1 += 1
                self.part2 += 1
            else:
                self.unsafe.append(i)

    def allow_one_bad_level(self):
        """Iterate over the unsafe rows and check if removing one integer
        makes the row safe."""
        for index in self.unsafe:
            row = self.data[index]
            for i in range(len(row)):
                if self._is_safe_row(row[:i] + row[i+1:]):
                    self.part2 += 1
                    break

    def _is_safe_row(self, row):
        """Check if the row is safe by checking if the absolute difference
        between each integer in the row is less than or equal to 3 and that
        the row is monotonicly increasing or decreasing."""
        self.row_diff_set = {row[j] - row[j-1] for j in range(1, len(row))}
        return (self.row_diff_set <= {1, 2, 3} or
                self.row_diff_set <= {-1, -2, -3})


if __name__ == '__main__':
    day2 = AdventDay2()
    day2.find_safe_reports()
    day2.allow_one_bad_level()
    print(day2.part1, day2.part2)