
DELETE FROM armoury;
DELETE FROM weapons_bay;

-- 1. first cabinet
CREATE TABLE armoury (
    suit_id INT, 
    model VARCHAR(50), 
    color VARCHAR(50)
);

-- 2. second cabinet
CREATE TABLE weapons_bay (
    weapon_id INT, 
    weapon_name VARCHAR(50), 
    damage INT, 
    assigned_suit_id INT
);

-- 3. inserting multiple suits into the armoury
INSERT INTO armoury (suit_id, model, color) 
VALUES 
(1, 'Mark I', 'Scrap Metal'), 
(2, 'Mark II', 'Silver'), 
(3, 'Mark III', 'Hot Rod Red');

-- 4. inserting multiple weapons into the bay
INSERT INTO weapons_bay (weapon_id, weapon_name, damage, assigned_suit_id) 
VALUES 
(101, 'Flamethrower', 50, 1), 
(102, 'Repulsor', 100, 2), 
(103, 'Micro-Missiles', 150, 3), 
(104, 'Unibeam', 250, 3);

-- 5. reading everything from the armoury
SELECT * FROM armoury;

-- 6. reading everything from the weapons bay
SELECT * FROM weapons_bay;

-- 7. updating a specific suit's color
UPDATE armoury SET color = 'Matte Black' WHERE suit_id = 1;

-- 8. deleting a specific weapon
DELETE FROM weapons_bay WHERE weapon_id = 101;

-- 9. filtering suits by a specific color
SELECT * FROM armoury WHERE color = 'Hot Rod Red';

-- 10. counting the total number of weapons in the database
SELECT COUNT(*) FROM weapons_bay;



-- 11. joining both cabinets
SELECT * 
FROM armoury 
JOIN weapons_bay ON armoury.suit_id = weapons_bay.assigned_suit_id;

-- 12. joining cabinets, but only showing specific cols
SELECT armoury.model, weapons_bay.weapon_name 
FROM armoury 
JOIN weapons_bay ON armoury.suit_id = weapons_bay.assigned_suit_id;

-- 13. using aliases
SELECT A.model AS suit_name, W.weapon_name AS primary_weapon 
FROM armoury AS A 
JOIN weapons_bay AS W ON A.suit_id = W.assigned_suit_id;

-- 14. joining w a greater than filter
SELECT * 
FROM armoury 
JOIN weapons_bay ON armoury.suit_id = weapons_bay.assigned_suit_id 
WHERE weapons_bay.damage > 100;

-- 15. joining w an exact filter
SELECT * 
FROM armoury 
JOIN weapons_bay ON armoury.suit_id = weapons_bay.assigned_suit_id 
WHERE armoury.color = 'Silver';

-- 16. Join targeting one specific suit's gear
SELECT * 
FROM armoury 
JOIN weapons_bay ON armoury.suit_id = weapons_bay.assigned_suit_id 
WHERE armoury.suit_id = 3;

-- 17. joining with multiple conditions // AND
SELECT *
FROM armoury 
JOIN weapons_bay ON armoury.suit_id = weapons_bay.assigned_suit_id 
WHERE weapons_bay.damage >= 150 AND armoury.color = 'Hot Rod Red';

-- 18. joining and sorting by highest damage (DESC)
SELECT * 
FROM armoury 
JOIN weapons_bay ON armoury.suit_id = weapons_bay.assigned_suit_id 
ORDER BY weapons_bay.damage DESC;

-- 19. joining and counting how many weapons each suit has (GROUP BY)
SELECT armoury.model, COUNT(weapons_bay.weapon_id) AS total_weapons
FROM armoury 
JOIN weapons_bay ON armoury.suit_id = weapons_bay.assigned_suit_id 
GROUP BY armoury.model;

-- 20. joining and calculating total damage capacity for a specific suit (SUM)
SELECT SUM(weapons_bay.damage) AS total_firepower
FROM armoury 
JOIN weapons_bay ON armoury.suit_id = weapons_bay.assigned_suit_id 
WHERE armoury.suit_id = 3;

- - 21. normalization
CREATE TABLE weapon_categories(
category_id INT PRIMARY KEY,
name VARCHAR(50),
description VARCHAR(255)
);
    
INSERT INTO weapon_categories VALUES (1, 'Energy', 'High-heat discharge'), (2, 'Kinetic', 'Ballistic impact');
    
ALTER TABLE weapons_bay ADD COLUMN category_id INT;
    
UPDATE weapons_bay
SET category_id = 1
WHERE weapon_name = 'Repulsor';
    
INSERT INTO weapons_bay (weapon_id, weapon_name, damage, assigned_suit_id, category_id)
VALUES (101, 'Flamethrower', 50, 1, 2), (102, 'Repulsor', 100, 2, 1);
    
SELECT
weapons_bay.weapon_name,
weapon_categories.name AS category_name,
weapon_categories.description
FROM weapons_bay
JOIN weapon_categories ON weapons_bay.category_id = weapon_categories.category_id;