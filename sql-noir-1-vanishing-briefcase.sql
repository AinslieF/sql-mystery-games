-- Record your SQL detective process here!  Write down: 
  -- 1. The SQL queries you ran
  -- 2. Any notes or insights as SQL comments
  -- 3. Your final conclusion: who did it?

-- I Looked at all the crime scenes to find the correct case
SELECT *
FROM crime_scene;

-- Found the crime that took place at Blue Note Lounge (id 76)
-- The description said that a man in a trench coat with a scar on his left cheek fled the scene


-- So I Looked at all the suspects
SELECT *
FROM suspects;

-- This filtered the suspects using the clues from the description
SELECT *
FROM suspects
WHERE attire LIKE '%trench%'
AND scar LIKE '%left cheek%';

-- It returned two suspects ~
-- Frankie Lombardi (id 3) but when I ran query his came back NULL
-- Vincent Malone (id 183)


-- So I checked the interview for Vincent Malone
SELECT *
FROM interviews
WHERE suspect_id = 183;

-- And on his interview transcript he said "I wasn’t going to steal it, but I did."
-- To me this is a confession.


-- So in conclusion

-- The culprit is Vincent Malone (id 183).
-- 1. Evidence pointing to him ~
-- 2. The crime scene described a man in a trench coat with a scar on his left cheek.
-- 3. Vincent Malone matches that exact description.
-- 4. And he confessed in his interview.


