from pathlib import Path

struct MapRange:
    var dest_start: Int
    var src_start: Int
    var length: Int

fn parse_input(content: String) raises -> (List[Int], List[List[MapRange]]):
    let blocks = content.split("\n\n")

    let seed_line = blocks[0]
    let seeds_str = seed_line.split(": ")[1]
    var seeds: List[Int] = []
    for seed in seeds_str.split(" "):
        if seed != "":
            seeds.append(seed.to_int())

    var maps: List[List[MapRange]] = []
    for i in range(1, len(blocks)):
        var current_map: List[MapRange] = []
        let lines = blocks[i].splitlines()
        for j in range(1, len(lines)):
            let parts = lines[j].split(" ")
            if len(parts) == 3:
                let dest_start = parts[0].to_int()
                let src_start = parts[1].to_int()
                let length = parts[2].to_int()
                current_map.append(MapRange(dest_start, src_start, length))
        maps.append(current_map)

    return seeds, maps

fn main() raises:
    let file_content = Path("problems/05/data.txt").read_text()

    print("Attempting to parse data.txt...")
    try:
        let seeds, maps = parse_input(file_content)
        print("Successfully parsed data.txt")
        print("Seeds:", seeds)
        print("Number of maps:", len(maps))
    except e:
        print("Failed to parse data.txt")
        print("Error:", e)
