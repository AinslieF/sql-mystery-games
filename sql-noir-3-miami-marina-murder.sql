-- Record your SQL detective process here!  Write down: 
  -- 1. The SQL queries you ran
  -- 2. Any notes or insights as SQL comments
  -- 3. Your final conclusion: who did it?


-- First I looked at all the crime scenes
SELECT *
FROM crime_scene;

-- I looked through all of them and found the one at Coral Bay Marina on 19860814
-- The description of that scene said ~
-- 1. Someone lives on 300ish Ocean Drive
-- 2. Another person's first name ends with "ul"
------and their last name ends with "ez"


-- So I searched for the person living on 300ish Ocean Drive
SELECT *
FROM person
WHERE address LIKE '3% Ocean Drive%';

-- This result showed addresses starting with 3 on Ocean Drive
-- 33 Ocean Drive seemed too small to me
-- 369 Ocean Drive matched the clue 
-- That one gave me a Carlos Mendez (person_id = 101)


-- I then searched for the person whose name ends with "ul" and "ez"
SELECT *
FROM person
WHERE name LIKE '%ul%'
AND name LIKE '%ez';

-- This narrowed it down to Raul Gutierrez (person_id = 102)
-- Now I had two people seen near the marina ~
-- Both Carlos Mendez and Raul Gutierrez


-- I checked the interviews table
SELECT *
FROM interviews;

-- I read through the interviews
-- One person said ~ "Ask Raul. He knows more."


-- So I checked Raul’s interview
SELECT *
FROM interviews
WHERE person_id = 102;

-- Raul snitched and said someone checked into a hotel
-- with "Sunset" in the name


-- I then searched for hotels with "Sunset"
SELECT *
FROM hotel_checkins
WHERE hotel_name LIKE '%Sunset%';

-- This showed everybody who checked into
-- a hotel with "Sunset" in the name


-- I connected surveillance records to hotel check-ins
-- to see who stayed at hotels with "Sunset" in the name
SELECT *
FROM surveillance_records
JOIN hotel_checkins
ON surveillance_records.hotel_checkin_id = hotel_checkins.id
WHERE hotel_checkins.hotel_name LIKE '%Sunset%';

-- This showed which guests had suspicious activity


-- Then I looked up the names of the suspicious person IDs
SELECT *
FROM person
WHERE id = 8;

-- This showed Thomas Brown (person_id = 8).


-- I checked the confessions table
SELECT *
FROM confessions
WHERE person_id = 8;

-- This returned ~
-- "Alright! I did it. I was paid to make sure he never left the marina alive."


-- FINAL CONCLUSION
-- The murderer is Thomas Brown (person_id = 8)
-- Because he confessed to the crime!
