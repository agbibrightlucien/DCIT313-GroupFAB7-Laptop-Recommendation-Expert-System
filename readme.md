# Laptop Recommendation Expert System

A rule-based expert system that recommends the best laptop for you based on your budget, intended use, portability needs, and battery requirements. Built with **SWI-Prolog** for knowledge representation and inference, and **Python** for the user interface.

> **Course:** DCIT 313 — Artificial Intelligence  
> **Group:** FAB7

---

## Group Members

| #   | Name                      | Student ID |
| --- | ------------------------- | ---------- |
| 1   | Asantewaa Isabella        | 22069268   |
| 2   | Agbi Bright Lucien Junior | 22045903   |
| 3   | Crystal Hazekawa          | 22244923   |
| 4   | Loretta Opoku Nsiah       | 22098316   |
| 5   | Gabriel Ofobiri Twum      | 22044996   |
| 6   | Anaam Francis Asiaktewon  | 22050404   |
| 7   | Michael Gorswin Achel     | 22056801   |

---

## Features

- Classifies user budget into **low** (≤ $700), **medium** ($701–$1200), and **high** (> $1200).
- Supports five usage categories: **Gaming**, **Programming**, **AI/ML**, **General (Student)**, and **Office (Business)**.
- Recommends a laptop _type_ with ideal specifications (CPU, RAM, Storage, GPU, Battery).
- Suggests **specific real-world laptop models** that match the recommended type and fit within the user's budget.
- Provides a human-readable **explanation** for every recommendation.
- Uses Prolog's backward-chaining inference engine for logical reasoning.

---

## System Architecture

```
┌──────────────┐       ┌──────────────────┐       ┌───────────────────────┐
│              │       │                  │       │                       │
│  User Input  │──────▶│  Python (pyswip) │──────▶│  Prolog Knowledge Base│
│  (terminal)  │       │  interface.py    │◀──────│  laptop_rules.pl      │
│              │       │                  │       │                       │
└──────────────┘       └──────────────────┘       └───────────────────────┘
                              │
                              ▼
                     Recommendation +
                     Matching Laptops
```

**Flow:**

1. The user answers four questions (budget, use, portability, battery).
2. Python asserts these answers as Prolog facts.
3. Prolog applies its recommendation rules, finds specs, generates an explanation, and filters matching laptop models within the budget.
4. Python displays the results.

---

## Project Structure

```
├── readme.md                        # This file
├── docs/
│   └── knowledge_engineering.md     # Knowledge engineering documentation
├── interface/
│   └── interface.py                 # Python CLI interface (pyswip)
└── Knowledge_base/
    └── laptop_rules.pl              # Prolog knowledge base & rules
```

---

## Technologies

| Technology       | Role                                                   |
| ---------------- | ------------------------------------------------------ |
| **SWI-Prolog**   | Knowledge base, inference engine, rule-based reasoning |
| **Python 3**     | User interface and I/O                                 |
| **pyswip**       | Python ↔ Prolog bridge library                         |
| **Git / GitHub** | Version control and collaboration                      |

---

## Prerequisites

1. **Python 3.8+** — [python.org](https://www.python.org/downloads/)
2. **SWI-Prolog** — [swi-prolog.org](https://www.swi-prolog.org/Download.html)
   - During installation on Windows, **check the option to add SWI-Prolog to PATH**.
3. **pyswip** Python package.

---

## Installation & Setup

```bash
# 1. Clone the repository
git clone https://github.com/<your-org>/DCIT313-GroupFAB7-Laptop-Recommendation-Expert-System.git
cd DCIT313-GroupFAB7-Laptop-Recommendation-Expert-System

# 2. (Optional) Create and activate a virtual environment
python -m venv venv
venv\Scripts\activate        # Windows
# source venv/bin/activate   # macOS / Linux

# 3. Install the Python dependency
pip install pyswip
```

---

## How to Run

```bash
cd interface
python interface.py
```

The system will prompt you for four inputs:

| Prompt                  | Accepted Values                                       |
| ----------------------- | ----------------------------------------------------- |
| **Budget (USD)**        | Any positive integer (e.g. `1500`)                    |
| **Primary use**         | `gaming`, `programming`, `ai_ml`, `general`, `office` |
| **Portability**         | `high`, `low`                                         |
| **Battery requirement** | `high`, `medium`, `low`                               |

---

## Sample Output

```
Enter your budget (USD): 2000
Primary use (gaming/programming/ai_ml/general/office): programming
Portability needed? (high/low): high
Battery requirement (high/medium/low): high

--- Recommendation ---

Laptop Type: programming

Suggested Specifications:
  CPU: Intel i5 / Ryzen 5
  RAM: 16GB
  Storage: 512GB SSD
  GPU: Integrated GPU
  Battery: High

Explanation:
Recommended a programming laptop because your primary use is programming
and your budget is 2000.

--- Specific Laptops Within Your Budget ---

  1. MacBook Pro 14 M3
     Price: $1600
     CPU: Apple M3 Pro  |  RAM: 18GB  |  Storage: 512GB SSD
     GPU: Integrated GPU  |  Battery: 12 hrs

  2. Dell XPS 15
     Price: $1400
     CPU: Intel i7-13700H  |  RAM: 16GB  |  Storage: 512GB SSD
     GPU: Integrated GPU  |  Battery: 10 hrs

  3. ThinkPad X1 Carbon Gen 11
     Price: $1500
     CPU: Intel i7-1365U  |  RAM: 16GB  |  Storage: 512GB SSD
     GPU: Integrated GPU  |  Battery: 11 hrs

  ...
```

---

## Knowledge Base Details

### Laptop Categories & Rules

| Category        | Triggers When                                                     |
| --------------- | ----------------------------------------------------------------- |
| **Gaming**      | Use = `gaming` and budget is **high** (> $1200)                   |
| **AI / ML**     | Use = `ai_ml` and budget is **high** (> $1200)                    |
| **Programming** | Use = `programming` and budget is **medium** or **high** (> $700) |
| **Student**     | Use = `general`, portability = `high`, budget is **low** (≤ $700) |
| **Business**    | Use = `office`, battery = `high`, portability = `high`            |

### Laptop Models in the Database (26 total)

| Category    | Models                                                                                                                |
| ----------- | --------------------------------------------------------------------------------------------------------------------- |
| Gaming      | ASUS ROG Strix G16, MSI Katana 15, Lenovo Legion Pro 5, ASUS ROG Zephyrus G16, Acer Nitro 5                           |
| Programming | MacBook Pro 14 M3, Dell XPS 15, ThinkPad X1 Carbon Gen 11, MacBook Air 15 M3, HP Spectre x360 16, Framework Laptop 16 |
| AI / ML     | Lenovo ThinkPad P16, Dell Precision 5680, MSI Creator Z17, ASUS ProArt Studiobook, MacBook Pro 16 M3 Max              |
| Student     | Acer Aspire 5, Lenovo IdeaPad 3, HP Laptop 15, ASUS VivoBook 15, Dell Inspiron 15                                     |
| Business    | ThinkPad T14s Gen 4, HP EliteBook 840 G10, Dell Latitude 7440, MacBook Air 13 M3, Lenovo ThinkPad X1 Nano             |

---

## How It Works (Technical)

1. **Fact Assertion** — User inputs are asserted as Prolog dynamic facts (`budget/1`, `use/1`, `portability/1`, `battery_need/1`).
2. **Inference** — Prolog's backward-chaining engine evaluates `recommend(Type)` rules against the asserted facts.
3. **Specification Lookup** — Once a type is determined, `specs/6` returns the ideal hardware profile.
4. **Model Filtering** — `suitable_laptop/8` finds all `laptop/8` facts whose type matches and whose price is within the user's budget.
5. **Explanation Generation** — `explain/2` uses `format/3` to build a natural-language justification.
6. **Cleanup** — `clear_facts/0` retracts all dynamic facts so the system can be queried again.

---

## Documentation

See [docs/knowledge_engineering.md](docs/knowledge_engineering.md) for the full knowledge engineering write-up, including knowledge representation details, inference strategy, and PEAS analysis.

---

## License

This project was created for academic purposes as part of DCIT 313 — Artificial Intelligence at the University of Ghana.
