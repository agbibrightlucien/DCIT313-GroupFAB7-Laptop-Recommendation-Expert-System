from pyswip import Prolog

prolog = Prolog()
prolog.consult("../Knowledge_base/laptop_rules.pl")


def clear_previous():
    prolog.query("clear_facts")


def get_user_input():

    budget = int(input("Enter your budget (USD): "))
    use = input("Primary use (gaming/programming/ai_ml/general/office): ").lower()
    portability = input("Portability needed? (high/low): ").lower()
    battery = input("Battery requirement (high/medium/low): ").lower()

    return budget, use, portability, battery


def send_facts(budget, use, portability, battery):

    prolog.assertz(f"budget({budget})")
    prolog.assertz(f"use({use})")
    prolog.assertz(f"portability({portability})")
    prolog.assertz(f"battery_need({battery})")


def get_recommendation():

    result = list(prolog.query("recommend(Type)"))

    if not result:
        return None

    laptop_type = result[0]['Type']

    specs = list(
        prolog.query(f"specs({laptop_type},CPU,RAM,Storage,GPU,Battery)")
    )[0]

    explanation = list(
        prolog.query(f"explain({laptop_type},E)")
    )[0]['E']

    # Query specific laptops that match the type and fit within budget I guess
    laptops = list(
        prolog.query(
            f"suitable_laptop(Name, {laptop_type}, Price, CPU, RAM, Storage, GPU, BatteryLife)"
        )
    )

    return laptop_type, specs, explanation, laptops


def display_result(result):

    if result is None:
        print("\nNo suitable recommendation found.")
        return

    laptop_type, specs, explanation, laptops = result

    print("\n--- Recommendation ---\n")

    print("Laptop Type:", laptop_type)

    print("\nSuggested Specifications:")
    print("  CPU:", specs["CPU"])
    print("  RAM:", specs["RAM"])
    print("  Storage:", specs["Storage"])
    print("  GPU:", specs["GPU"])
    print("  Battery:", specs["Battery"])

    print("\nExplanation:")
    print(explanation)

    if laptops:
        print("\n--- Specific Laptops Within Your Budget ---\n")
        for i, lp in enumerate(laptops, 1):
            print(f"  {i}. {lp['Name']}")
            print(f"     Price: ${lp['Price']}")
            print(f"     CPU: {lp['CPU']}  |  RAM: {lp['RAM']}  |  Storage: {lp['Storage']}")
            print(f"     GPU: {lp['GPU']}  |  Battery: {lp['BatteryLife']}")
            print()
    else:
        print("\nNo specific laptop models found within your budget for this category.")


def main():

    clear_previous()

    budget, use, portability, battery = get_user_input()

    send_facts(budget, use, portability, battery)

    result = get_recommendation()

    display_result(result)


if __name__ == "__main__":
    main()