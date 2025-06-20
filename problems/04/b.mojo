from pathlib import Path
from collections import Dict


@value
struct CacheKey(KeyElement):
    var i: Int
    var dir: Int
    var can_skip: Bool

    fn __str__(self) raises -> String:
        return String("CacheKey(i={}, dir={}, can_skip={})").format(
            self.i, self.dir, self.can_skip
        )

    fn __eq__(self, other: CacheKey) -> Bool:
        return self.i == other.i and self.dir == other.dir and self.can_skip == other.can_skip

    fn __ne__(self, other: CacheKey) -> Bool:
        return not self.__eq__(other)

    fn __hash__(self) -> UInt:
        return (
            UInt(self.i) * 31 + UInt(self.dir) * 17 + UInt(self.can_skip)
        ) % (2**64)


fn is_safe(
    i: Int,
    dir: Int,
    can_skip: Bool,
    numbers: List[Int],
    mut cache: Dict[CacheKey, Bool],
) raises -> Bool:
    key = CacheKey(i, dir, can_skip)
    if key in cache:
        return cache[key]

    if i >= len(numbers) - 1:
        cache[key] = True
        return True

    curr = numbers[i]

    fn will_be_safe(j: Int, can_skip: Bool) raises -> Bool:
        if j >= len(numbers):
            return True
        nxt = numbers[j]
        next_dir = 1 if nxt > curr else -1
        diff = abs(curr - nxt)

        if 0 < diff <= 3 and (dir == 0 or next_dir == dir):
            return is_safe(j, next_dir, can_skip, numbers, cache)
        return False

    result = will_be_safe(i + 1, can_skip)

    if not result and can_skip:
        result = will_be_safe(i + 2, False)

    cache[key] = result
    return result


fn main() raises:
    data = Path("problems/02/data.txt").read_text()
    total_safe = 0
    lines = data.splitlines()
    dir0 = 0
    for i in range(len(lines)):
        numbers_str = lines[i].split(" ")
        numbers = List[Int]()
        for j in range(len(numbers_str)):
            numbers.append(Int(numbers_str[j]))
        cache = Dict[CacheKey, Bool]()
        if is_safe(0, dir0, True, numbers, cache) or is_safe(
            1, dir0, False, numbers, cache
        ):
            total_safe += 1

    print("Total safe numbers:", total_safe)
