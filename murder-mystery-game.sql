-- Record your SQL detective process here!  Write down: 
--   1. The SQL queries you ran
--   2. Any notes or insights as SQL comments
--   3. Your final conclusion: who did it?

-- Using these SQL clauses will help you solve the mystery: 
--    SELECT, FROM, WHERE, AND, OR, ORDER BY, LIMIT, LIKE, DISTINCT, BETWEEN, AS

-- writing a comment like this

-- selecting all columns from the crime scene report
SELECT * FROM crime_scene_report;

--A crime has taken place and the detective needs your help. 
--The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by retrieving the corresponding crime scene report from the police department’s database.

--MY SQL Murder Mystery Detective Process

-- First, I needed to retrieve the crime scene report for the murder
-- that happened in SQL City on January 15, 2018.
SELECT *
FROM crime_scene_report
WHERE city = 'SQL City'
  AND type = 'murder'
  AND date = 20180115;

-- From the report, I learned that there were two witnesses:
-- One lives at the last house on Northwestern Dr.
-- The second one is named Annabel and lives on Franklin Ave.


-- I then searched for the person living at the last house on Northwestern Dr.
-- Since "last house" likely means the highest address number,
-- I ordered the addresses in descending order and limited it to 1 result.
SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1;

-- This returned Morty Schapiro (person_id = 14887),
-- so I checked his interview next.


-- I read Morty’s interview to gather clues about the suspect.
SELECT *
FROM interview
WHERE person_id = 14887;

-- From Morty’s statement, I learned that:
-- The suspect had a Get Fit Now Gym bag.
-- The membership ID started with "48Z".
-- Only gold members have those bags.
-- The suspect’s car plate included "H42W".


-- Using that clue, I searched for gold gym members
-- whose membership ID starts with 48Z.
SELECT *
FROM get_fit_now_member
WHERE membership_status = 'gold'
  AND id LIKE '48Z%';

-- This narrowed the suspects down to two people:
-- Joe Germuska and Jeremy Bowers.


-- To narrow it further, I then used the license plate clue.
-- I joined the person and drivers_license tables
-- to check which suspect had a plate containing H42W.
SELECT p.name, dl.plate_number
FROM person p
JOIN drivers_license dl
  ON p.license_id = dl.id
WHERE p.id IN (28819, 67318);

-- Jeremy Bowers’ plate matched the clue ("0H42W2"),
-- so I concluded he was the murderer.


-- I submitted Jeremy Bowers as the murderer to confirm.
INSERT INTO solution VALUES (1, 'Jeremy Bowers');
SELECT value FROM solution;

-- The system confirmed that Jeremy Bowers was the killer.


-- Bonus~ Finding the mastermind behind the crime

-- I then read Jeremy Bowers’ interview to see who hired him.
SELECT *
FROM interview
WHERE person_id = 67318;

-- Jeremy said he was hired by a wealthy woman who:
----Is about 65–67 inches tall
---- Has red hair
---- Drives a Tesla Model S
---- Attended the SQL Symphony Concert 3 times in December 2017


-- I searched the drivers_license table for women
-- matching the physical description and car details.

-- I used BETWEEN because the clue gave a height range
-- so it helped me find the people whose height falls BETWEEN that range
SELECT *
FROM drivers_license
WHERE gender = 'female'
  AND hair_color = 'red'
  AND height BETWEEN 65 AND 67
  AND car_make = 'Tesla'
  AND car_model = 'Model S';

-- This gave me a small list of possible matches.


-- Next, I checked who attended the SQL Symphony Concert

-- the clue said the person attended the concert three times in December 2017.
-- so I COUNTED how many times each person_id appeared and only kept who appeared 3 times only

-- I GROUPED the results by person_id so I could see how many times each person attended the concert separately
-- I used GROUP BY because the clue required finding someone who appeared exactly three times.So GROUP BY helps me to sort
SELECT person_id, COUNT(*) as attendance_count
FROM facebook_event_checkin
WHERE event_name = 'SQL Symphony Concert'
  AND date BETWEEN 20171201 AND 20171231
GROUP BY person_id
HAVING COUNT(*) = 3; -- HAVING lets me filter the groups after COUNTING
-- I used it to keep only the people who showed up three times

-- Two people attended three times.


-- I retrieved their names from the person table.
SELECT p.id, p.name
FROM person p
WHERE p.id IN (24556, 99716);

-- The two names were Bryan Pardo and Miranda Priestly.


-- Finally, I confirmed which one matched the red hair,
-- Tesla Model S, and height description.

-- I needed to see the suspects' license plate numbers.
-- The person table stores their license_id.
-- The drivers_license table stores the actual plate number.
-- So I connected the two tables using the license_id
-- so I could see each person's name and their plate number together and that's what JOIN means
SELECT p.name
FROM person p
JOIN drivers_license dl
  ON p.license_id = dl.id
WHERE p.id IN (24556, 99716)
  AND dl.hair_color = 'red'
  AND dl.height BETWEEN 65 AND 67
  AND dl.car_make = 'Tesla'
  AND dl.car_model = 'Model S';

-- This confirmed that Miranda Priestly matches all clues.


-- MY Final Conclusion

-- The murderer was Jeremy Bowers.
-- The mastermind behind the crime was Miranda Priestly.

----------YOURS TRULY~DETECTIVE AINSLIE----------
