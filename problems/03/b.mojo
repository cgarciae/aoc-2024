from pathlib import Path


fn parse_digit[
    origin: Origin[False]
](owned data: StringSlice[origin]) -> Tuple[
    Optional[String], StringSlice[origin]
]:
    if not data or not data[0].isdigit():
        return Optional[String](None), data
    return Optional[String](data[0]), data[1:]


fn parse_number[
    origin: Origin[False]
](owned data: StringSlice[origin]) raises -> Tuple[
    Optional[Int], StringSlice[origin]
]:
    var digits = String("")
    while True:
        digit, data = parse_digit(data)
        if digit is None:
            break
        digits += digit.value()
    if not digits:
        return Optional[Int](None), data
    return Optional(Int(digits)), data


fn parse_str[
    origin: Origin[False]
](owned data: StringSlice[origin], target: String) -> Tuple[
    Optional[String], StringSlice[origin]
]:
    if not data.startswith(target):
        return Optional[String](None), data
    data = data[len(target) :]
    return Optional[String](target), data


fn parse_mul[
    origin: Origin[False]
](owned data: StringSlice[origin]) raises -> Tuple[
    Optional[Int], StringSlice[origin]
]:
    mul, data = parse_str(data, "mul(")
    if mul is None:
        return Optional[Int](None), data
    left, data = parse_number(data)
    if left is None:
        return Optional[Int](None), data
    comma, data = parse_str(data, ",")
    if comma is None:
        return Optional[Int](None), data
    right, data = parse_number(data)
    if right is None:
        return Optional[Int](None), data
    close_paren, data = parse_str(data, ")")
    if close_paren is None:
        return Optional[Int](None), data
    result = left.value() * right.value()
    return Optional[Int](result), data


fn main() raises:
    data = StringSlice(Path("problems/03/data.txt").read_text())
    total = 0
    do_mul = True
    while data:
        # print(data, do_mul, total)
        do, data = parse_str(data, "do()")
        if do is not None:
            do_mul = True
            continue
        dont, data = parse_str(data, "don't()")
        if dont is not None:
            do_mul = False
            continue

        if do_mul:
            mul, data = parse_mul(data)
            if mul is not None:
                total += mul.value()
                continue
        # nothing matched, advance one character
        data = data[1:]
    print(total)
