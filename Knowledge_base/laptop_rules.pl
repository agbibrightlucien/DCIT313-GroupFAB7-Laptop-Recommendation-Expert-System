% Laptop Recommendation Expert System Knowledge Base
% Uses rule-based reasoning

:- dynamic budget/1.
:- dynamic use/1.
:- dynamic portability/1.
:- dynamic battery_need/1.
:- dynamic storage_need/1.


% BUDGET CLASSIFICATION


budget_level(low) :-
    budget(B),
    B =< 700.

budget_level(medium) :-
    budget(B),
    B > 700,
    B =< 1200.

budget_level(high) :-
    budget(B),
    B > 1200.


% LAPTOP TYPES


laptop_type(gaming).
laptop_type(programming).
laptop_type(student).
laptop_type(business).
laptop_type(ai_ml).


% RECOMMENDATION RULES


% Gaming laptop
recommend(gaming) :-
    use(gaming),
    budget_level(high).

% AI / Machine Learning laptop
recommend(ai_ml) :-
    use(ai_ml),
    budget_level(high).

% Programming laptop
recommend(programming) :-
    use(programming),
    budget_level(medium).

recommend(programming) :-
    use(programming),
    budget_level(high).

% Student laptop
recommend(student) :-
    use(general),
    portability(high),
    budget_level(low).

% Business laptop
recommend(business) :-
    use(office),
    battery_need(high),
    portability(high).


% SPECIFICATION KNOWLEDGE


specs(gaming,
      cpu('Intel i7 / Ryzen 7'),
      ram('16GB'),
      storage('512GB SSD'),
      gpu('Dedicated GPU'),
      battery('Medium')).

specs(ai_ml,
      cpu('Intel i7 / Ryzen 7'),
      ram('32GB'),
      storage('1TB SSD'),
      gpu('High-End Dedicated GPU'),
      battery('Low')).

specs(programming,
      cpu('Intel i5 / Ryzen 5'),
      ram('16GB'),
      storage('512GB SSD'),
      gpu('Integrated GPU'),
      battery('High')).

specs(student,
      cpu('Intel i3 / Ryzen 3'),
      ram('8GB'),
      storage('256GB SSD'),
      gpu('Integrated GPU'),
      battery('High')).

specs(business,
      cpu('Intel i5 / Ryzen 5'),
      ram('16GB'),
      storage('512GB SSD'),
      gpu('Integrated GPU'),
      battery('High')).


% SPECIFIC LAPTOP MODELS
% laptop(Name, Type, Price, CPU, RAM, Storage, GPU, BatteryLife)

% Gaming laptops
laptop('ASUS ROG Strix G16',       gaming, 1500, 'Intel i7-13650HX',  '16GB', '512GB SSD', 'NVIDIA RTX 4060',    '6 hrs').
laptop('MSI Katana 15',            gaming, 1300, 'Intel i7-13620H',   '16GB', '512GB SSD', 'NVIDIA RTX 4060',    '5 hrs').
laptop('Lenovo Legion Pro 5',      gaming, 1800, 'AMD Ryzen 7 7745HX','16GB', '1TB SSD',   'NVIDIA RTX 4070',    '5 hrs').
laptop('ASUS ROG Zephyrus G16',    gaming, 2200, 'Intel i9-13900H',   '32GB', '1TB SSD',   'NVIDIA RTX 4080',    '6 hrs').
laptop('Acer Nitro 5',             gaming, 1100, 'AMD Ryzen 7 7735HS','16GB', '512GB SSD', 'NVIDIA RTX 4050',    '5 hrs').

% Programming laptops
laptop('MacBook Pro 14 M3',         programming, 1600, 'Apple M3 Pro',      '18GB', '512GB SSD', 'Integrated GPU',     '12 hrs').
laptop('Dell XPS 15',              programming, 1400, 'Intel i7-13700H',   '16GB', '512GB SSD', 'Integrated GPU',     '10 hrs').
laptop('ThinkPad X1 Carbon Gen 11', programming, 1500, 'Intel i7-1365U',    '16GB', '512GB SSD', 'Integrated GPU',     '11 hrs').
laptop('MacBook Air 15 M3',        programming,  1300, 'Apple M3',          '16GB', '512GB SSD', 'Integrated GPU',     '15 hrs').
laptop('HP Spectre x360 16',       programming,  1600, 'Intel i7-13700H',   '16GB', '1TB SSD',   'Integrated GPU',     '10 hrs').
laptop('Framework Laptop 16',      programming,   900, 'AMD Ryzen 5 7640HS','16GB', '512GB SSD', 'Integrated GPU',     '9 hrs').

% AI / ML laptops
laptop('Lenovo ThinkPad P16',      ai_ml, 2500, 'Intel i9-13980HX',  '32GB', '1TB SSD',   'NVIDIA RTX 5000 Ada','5 hrs').
laptop('Dell Precision 5680',      ai_ml, 2800, 'Intel i9-13900H',   '64GB', '1TB SSD',   'NVIDIA RTX 4000 Ada','6 hrs').
laptop('MSI Creator Z17',          ai_ml, 2200, 'Intel i9-13900H',   '32GB', '1TB SSD',   'NVIDIA RTX 4080',    '5 hrs').
laptop('ASUS ProArt Studiobook',   ai_ml, 2600, 'Intel i9-13980HX',  '32GB', '2TB SSD',   'NVIDIA RTX 4070',    '5 hrs').
laptop('MacBook Pro 16 M3 Max',    ai_ml, 3000, 'Apple M3 Max',      '36GB', '1TB SSD',   'Integrated 40-core GPU','14 hrs').

% Student laptops
laptop('Acer Aspire 5',            student, 500, 'AMD Ryzen 3 7320U', '8GB',  '256GB SSD', 'Integrated GPU',     '8 hrs').
laptop('Lenovo IdeaPad 3',         student, 400, 'Intel i3-1215U',    '8GB',  '256GB SSD', 'Integrated GPU',     '7 hrs').
laptop('HP Laptop 15',             student, 450, 'Intel i3-1215U',    '8GB',  '256GB SSD', 'Integrated GPU',     '8 hrs').
laptop('ASUS VivoBook 15',         student, 500, 'AMD Ryzen 5 7520U', '8GB',  '512GB SSD', 'Integrated GPU',     '7 hrs').
laptop('Dell Inspiron 15',         student, 550, 'Intel i5-1235U',    '8GB',  '256GB SSD', 'Integrated GPU',     '8 hrs').

% Business laptops
laptop('ThinkPad T14s Gen 4',      business, 1200, 'Intel i7-1365U',    '16GB', '512GB SSD', 'Integrated GPU',     '11 hrs').
laptop('HP EliteBook 840 G10',     business, 1300, 'Intel i7-1365U',    '16GB', '512GB SSD', 'Integrated GPU',     '10 hrs').
laptop('Dell Latitude 7440',       business, 1400, 'Intel i7-1365U',    '16GB', '512GB SSD', 'Integrated GPU',     '10 hrs').
laptop('MacBook Air 13 M3',        business, 1100, 'Apple M3',          '16GB', '256GB SSD', 'Integrated GPU',     '15 hrs').
laptop('Lenovo ThinkPad X1 Nano',  business, 1500, 'Intel i7-1365U',    '16GB', '512GB SSD', 'Integrated GPU',     '12 hrs').


% MATCH SPECIFIC LAPTOPS TO BUDGET

suitable_laptop(Name, Type, Price, CPU, RAM, Storage, GPU, BatteryLife) :-
    budget(B),
    laptop(Name, Type, Price, CPU, RAM, Storage, GPU, BatteryLife),
    Price =< B.


% EXPLANATION SYSTEM


explain(Type, Explanation) :-
    use(U),
    budget(B),
    format(atom(Explanation),
    'Recommended a ~w laptop because your primary use is ~w and your budget is ~w.',
    [Type, U, B]).


% CLEANING OLD FACTS


clear_facts :-
    retractall(budget(_)),
    retractall(use(_)),
    retractall(portability(_)),
    retractall(battery_need(_)),
    retractall(storage_need(_)).