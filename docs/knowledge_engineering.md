# Knowledge Engineering Document

## Laptop Recommendation Expert System

### 1. Overview

This system is a **rule-based expert system** designed to recommend suitable laptops based on user requirements such as budget, intended usage, portability, and battery life.

The system demonstrates a clear mapping between **perceptions (user inputs)** and **actions (system recommendations)** using SWI-Prolog's backward-chaining inference engine, with a Python front-end for user interaction.

---

### 2. PEAS Analysis

The expert system can be formally described using the **PEAS** framework:

| Component | Description |
|-----------|-------------|
| **Performance Measure** | Accuracy and relevance of laptop recommendations; whether the suggested laptop type, specifications, and specific models match the user's stated needs and budget. |
| **Environment** | A set of user-provided constraints: budget (integer in USD), primary use case, portability preference, and battery requirement. The environment is **fully observable**, **deterministic**, **static**, **discrete**, and **single-agent**. |
| **Actuators** | Text-based output — the system prints the recommended laptop type, ideal specifications, a natural-language explanation, and a list of specific laptop models within budget. |
| **Sensors** | Text-based input — four prompted questions answered by the user via the terminal (budget, use, portability, battery). |

---

### 3. Technologies Used

| Technology | Role |
|------------|------|
| **SWI-Prolog** | Knowledge base and inference engine (backward chaining) |
| **Python 3** | User interface — collects input and displays results |
| **pyswip** | Bridge library connecting Python to SWI-Prolog |

---

### 4. Knowledge Acquisition

Knowledge was acquired from:

- **Domain expertise** — general understanding of laptop hardware categories (gaming, programming, AI/ML, student, business) and the specifications each category demands.
- **Market research** — real-world laptop models, their prices, and specifications were catalogued to populate the laptop database (26 models across 5 categories).
- **User profiling** — common decision factors (budget range, primary workload, need for portability, battery life expectations) were identified as the key inputs.

---

### 5. Knowledge Representation

The knowledge base (`Knowledge_base/laptop_rules.pl`) is represented using Prolog's native constructs:

#### 5.1 Dynamic Facts (User Inputs)

User answers are asserted at runtime as dynamic facts:

```prolog
:- dynamic budget/1.
:- dynamic use/1.
:- dynamic portability/1.
:- dynamic battery_need/1.
```

Example — after the user enters a budget of 1500 and use of `programming`:

```prolog
budget(1500).
use(programming).
```

#### 5.2 Derived Facts (Budget Classification)

The system classifies the raw budget into three symbolic levels:

```prolog
budget_level(low)    :- budget(B), B =< 700.
budget_level(medium) :- budget(B), B > 700, B =< 1200.
budget_level(high)   :- budget(B), B > 1200.
```

| Level | Range |
|-------|-------|
| Low | $0 – $700 |
| Medium | $701 – $1,200 |
| High | > $1,200 |

#### 5.3 Laptop Type Facts

```prolog
laptop_type(gaming).
laptop_type(programming).
laptop_type(student).
laptop_type(business).
laptop_type(ai_ml).
```

#### 5.4 Recommendation Rules

Rules map user inputs to a laptop type:

```prolog
% Gaming — requires high budget + gaming use
recommend(gaming) :-
    use(gaming),
    budget_level(high).

% AI / ML — requires high budget + ai_ml use
recommend(ai_ml) :-
    use(ai_ml),
    budget_level(high).

% Programming — medium or high budget + programming use
recommend(programming) :-
    use(programming),
    budget_level(medium).

recommend(programming) :-
    use(programming),
    budget_level(high).

% Student — low budget + general use + high portability
recommend(student) :-
    use(general),
    portability(high),
    budget_level(low).

% Business — office use + high battery + high portability
recommend(business) :-
    use(office),
    battery_need(high),
    portability(high).
```

#### 5.5 Specification Facts

Each laptop type maps to an ideal hardware profile:

```prolog
specs(gaming,       cpu('Intel i7 / Ryzen 7'), ram('16GB'),  storage('512GB SSD'), gpu('Dedicated GPU'),         battery('Medium')).
specs(ai_ml,        cpu('Intel i7 / Ryzen 7'), ram('32GB'),  storage('1TB SSD'),   gpu('High-End Dedicated GPU'), battery('Low')).
specs(programming,  cpu('Intel i5 / Ryzen 5'), ram('16GB'),  storage('512GB SSD'), gpu('Integrated GPU'),         battery('High')).
specs(student,      cpu('Intel i3 / Ryzen 3'), ram('8GB'),   storage('256GB SSD'), gpu('Integrated GPU'),         battery('High')).
specs(business,     cpu('Intel i5 / Ryzen 5'), ram('16GB'),  storage('512GB SSD'), gpu('Integrated GPU'),         battery('High')).
```

#### 5.6 Laptop Model Database

Real-world laptops are stored as 8-arity facts:

```prolog
% laptop(Name, Type, Price, CPU, RAM, Storage, GPU, BatteryLife)
laptop('MacBook Pro 14 M3', programming, 1600, 'Apple M3 Pro', '18GB', '512GB SSD', 'Integrated GPU', '12 hrs').
```

The database contains **26 laptop models** spread across the five categories.

#### 5.7 Budget Filtering Rule

```prolog
suitable_laptop(Name, Type, Price, CPU, RAM, Storage, GPU, BatteryLife) :-
    budget(B),
    laptop(Name, Type, Price, CPU, RAM, Storage, GPU, BatteryLife),
    Price =< B.
```

This rule returns only models whose price does not exceed the user's stated budget.

#### 5.8 Explanation Generation

```prolog
explain(Type, Explanation) :-
    use(U),
    budget(B),
    format(atom(Explanation),
           'Recommended a ~w laptop because your primary use is ~w and your budget is ~w.',
           [Type, U, B]).
```

#### 5.9 Fact Cleanup

```prolog
clear_facts :-
    retractall(budget(_)),
    retractall(use(_)),
    retractall(portability(_)),
    retractall(battery_need(_)),
    retractall(storage_need(_)).
```

---

### 6. Inference Mechanism

The system uses **backward chaining** (Prolog's default strategy):

1. The query `recommend(Type)` is posed.
2. Prolog searches its rule base top-down, attempting to unify `Type` with each rule head.
3. For each candidate rule, Prolog recursively tries to satisfy the body goals (`use/1`, `budget_level/1`, `portability/1`, `battery_need/1`).
4. `budget_level/1` is itself a derived fact — Prolog chains backward again to evaluate `budget(B)` and the arithmetic comparison.
5. The first rule whose body is fully satisfied succeeds, binding `Type`.

```
recommend(Type)
   └── use(U) ✓  (asserted fact)
   └── budget_level(Level)
          └── budget(B) ✓  (asserted fact)
          └── B > 700, B =< 1200 ✓  (arithmetic)
   └── Type = programming  ✓
```

---

### 7. System Architecture & Data Flow

```
┌──────────────┐        ┌──────────────────┐        ┌─────────────────────┐
│  User Input  │───────▶│  Python Interface │───────▶│  Prolog KB          │
│  (terminal)  │        │  (pyswip)        │        │  laptop_rules.pl    │
└──────────────┘        └────────┬─────────┘        └──────────┬──────────┘
                                 │                             │
                                 │  1. assertz(budget(1500))   │
                                 │  2. assertz(use(programming))│
                                 │  3. query recommend(Type)   │
                                 │◀────────────────────────────┘
                                 │     Type = programming
                                 │  4. query specs(...)
                                 │  5. query explain(...)
                                 │  6. query suitable_laptop(...)
                                 ▼
                        ┌──────────────────┐
                        │  Display Results │
                        │  (terminal)      │
                        └──────────────────┘
```

**Step-by-step:**

1. `clear_facts/0` retracts any previously asserted user facts.
2. Python collects four inputs from the user.
3. Each input is asserted into Prolog as a dynamic fact via `assertz/1`.
4. Python queries `recommend(Type)` — Prolog's inference engine fires the matching rule.
5. Python queries `specs/6` to retrieve the ideal hardware profile for the recommended type.
6. Python queries `explain/2` to obtain a natural-language justification.
7. Python queries `suitable_laptop/8` to find all stored laptop models of that type within the user's budget.
8. Results are formatted and displayed.

---

### 8. Knowledge Base Summary

| Predicate | Arity | Kind | Count | Purpose |
|-----------|-------|------|-------|---------|
| `budget/1` | 1 | Dynamic fact | 1 per session | Stores user's budget |
| `use/1` | 1 | Dynamic fact | 1 per session | Stores primary use case |
| `portability/1` | 1 | Dynamic fact | 1 per session | Stores portability preference |
| `battery_need/1` | 1 | Dynamic fact | 1 per session | Stores battery requirement |
| `budget_level/1` | 1 | Derived rule | 3 rules | Classifies budget into low/medium/high |
| `laptop_type/1` | 1 | Static fact | 5 facts | Enumerates valid laptop categories |
| `recommend/1` | 1 | Rule | 6 rules | Maps inputs → laptop type |
| `specs/6` | 6 | Static fact | 5 facts | Ideal specs per type |
| `laptop/8` | 8 | Static fact | 26 facts | Real-world laptop models |
| `suitable_laptop/8` | 8 | Rule | 1 rule | Filters models by budget |
| `explain/2` | 2 | Rule | 1 rule | Generates explanation text |
| `clear_facts/0` | 0 | Rule | 1 rule | Retracts all dynamic facts |

---

### 9. Limitations & Future Work

| Limitation | Possible Improvement |
|------------|----------------------|
| Only 5 use-case categories | Add categories like video editing, music production, etc. |
| No ranking — returns all matching models equally | Score and rank models by how closely they match preferences |
| Text-only interface | Build a web or GUI front-end |
| Static laptop database | Integrate a live API or web scraper for up-to-date pricing |
| No learning | Incorporate user feedback to refine rules over time |
| Explanation is basic | Provide per-spec justification (e.g., "16 GB RAM is recommended because…") |

---

### 10. Conclusion

This expert system demonstrates the core principles of knowledge engineering: structured **knowledge acquisition**, formal **knowledge representation** using Prolog facts and rules, and automated **inference** via backward chaining. The separation between the knowledge base (Prolog) and the interface (Python) follows best practices for expert system design, making the system modular, maintainable, and extensible.
