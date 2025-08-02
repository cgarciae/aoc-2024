import sys

def parse_input(content):
    rules_str, updates_str = content.split("\n\n")

    rules = []
    for line in rules_str.splitlines():
        if line:
            parts = line.split("|")
            rules.append((int(parts[0]), int(parts[1])))

    updates = []
    for line in updates_str.splitlines():
        if line:
            updates.append([int(p) for p in line.split(",")])

    return rules, updates

def is_correctly_ordered(update, rules_set):
    for i in range(len(update)):
        for j in range(i + 1, len(update)):
            p1 = update[i]
            p2 = update[j]
            if (p2, p1) in rules_set:
                return False
    return True

def main():
    # Test with test.txt first
    try:
        with open("problems/05/test.txt", "r") as f:
            test_content = f.read()
        print("--- Testing with test.txt ---")
        test_rules, test_updates = parse_input(test_content)
        rules_set = set(test_rules)

        expected_results = [True, True, True, False, False, False]
        correctly_ordered_test_updates = []
        for i, update in enumerate(test_updates):
            result = is_correctly_ordered(update, rules_set)
            if result:
                correctly_ordered_test_updates.append(update)
            assert result == expected_results[i]

        print("All test cases passed!")

        middle_page_numbers_test = []
        for update in correctly_ordered_test_updates:
            middle_index = (len(update) - 1) // 2
            middle_page_numbers_test.append(update[middle_index])

        print("Middle pages of correctly ordered test updates:", middle_page_numbers_test)
        print("Sum of middle pages for test data:", sum(middle_page_numbers_test))
        assert sum(middle_page_numbers_test) == 143

    except FileNotFoundError:
        print("test.txt not found.")
    except Exception as e:
        print("Error during testing:", e)

    # Process the actual data
    try:
        with open("problems/05/data.txt", "r") as f:
            file_content = f.read()

        rules, updates = parse_input(file_content)
        rules_set = set(rules)

        correctly_ordered_updates = []
        for update in updates:
            if is_correctly_ordered(update, rules_set):
                correctly_ordered_updates.append(update)

        middle_page_numbers = []
        for update in correctly_ordered_updates:
            middle_index = (len(update) - 1) // 2
            middle_page_numbers.append(update[middle_index])

        print("\n--- Processing data.txt ---")
        print("Number of correctly ordered updates:", len(correctly_ordered_updates))
        print("Middle page numbers of correctly ordered updates:", middle_page_numbers)
        print("Sum of middle pages for data.txt:", sum(middle_page_numbers))

    except FileNotFoundError:
        print("data.txt not found.")
        sys.exit(1)
    except Exception as e:
        print("Error processing data.txt:", e)


if __name__ == "__main__":
    main()
