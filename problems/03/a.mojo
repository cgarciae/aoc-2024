from pathlib import Path

fn parse_digit(mut data: String) -> Tuple[Optional[String], String]:
    if not data or not data[0].isdigit():
        return Optional[String](None), data
    return Optional[String](data[0]), data[1:]

fn parse_number(mut data: String) raises -> Tuple[Optional[Int], String]:
    var digits = String("")
    while True:
        digit, data = parse_digit(data)
        if digit is None:
            break
        digits += digit.value()
    if not digits:
        return Optional[Int](None), data
    return Optional(Int(digits)), data

fn parse_str(mut data: String, target: String) -> Tuple[Optional[String], String]:
    if not data.startswith(target):
        return Optional[String](None), data
    data = data[len(target):]
    return Optional[String](target), data

fn parse_mul(mut data: String) raises -> Tuple[Optional[Int], String]:
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
    data = Path("problems/03/data.txt").read_text()
    total = 0
    while data:
        mul, data = parse_mul(data)
        if mul is not None:
            total += mul.value()
        else:
            data = data[1:]
    print(total)