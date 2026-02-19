-- Record your SQL detective process here!  Write down: 
  -- 1. The SQL queries you ran
  -- 2. Any notes or insights as SQL comments
  -- 3. Your final conclusion: who did it?


-- This is to find the crime scene using the known date and location given already
SELECT *
FROM crime_scene
WHERE date = 19830715
AND location = 'West Hollywood Records';

-- I searched for the crime that happened on July 15, 1983
-- At West Hollywood Records
-- The crime_scene id was 65


-- Getting witness clues for that crime
SELECT *
FROM witnesses
WHERE crime_scene_id = 65;

-- I looked up the witnesses connected to crime_scene_id 65
-- The witnesses said that the suspect wore a red bandana
-- And the suspect had on a gold watch


-- Finding the suspects with a red bandana
-- This query isn't necessary, but I added it for notes purposes
SELECT *
FROM suspects
WHERE bandana_color = 'red';

-- I searched for all suspects wearing a red bandana
-- And this gave me a list of possible suspects


-- Narrowing the suspects to those with BOTH clues
SELECT *
FROM suspects
WHERE bandana_color = 'red'
AND accessory = 'gold watch';

-- I narrowed the suspects to those who wore a red bandana
-- AND had a gold watch.
-- This left 3 suspects named ~
----Tony Ramirez (35)
----Mickey Rivera (44)
----Rico Delgado (97)


-- Checking interview of suspect 35
SELECT *
FROM interviews
WHERE suspect_id = 35;

-- Tony Ramirez denied being near the store so I know it can't be him


-- Checking interview of suspect 44
SELECT *
FROM interviews
WHERE suspect_id = 44;

-- Mickey Rivera also denied involvement


-- Checking interview of suspect 97
SELECT *
FROM interviews
WHERE suspect_id = 97;

-- Rico Delgado confessed that ~
-- "I couldn't help it. I snapped and took the record."


-- FINAL CONCLUSION IS :

-- The culprit is Rico Delgado (id 97).
-- Evidence shows ~
-- 1. A witness saw a suspect wearing a red bandana.
-- 2. A witness noticed the suspect had on a gold watch.
-- 3. Rico Delgado matched both of those clues.
-- 4. He confessed in his interview.
