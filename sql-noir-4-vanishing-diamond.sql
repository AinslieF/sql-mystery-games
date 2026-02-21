-- Record your SQL detective process here!  Write down: 
  -- 1. The SQL queries you ran
  -- 2. Any notes or insights as SQL comments
  -- 3. Your final conclusion: who did it?


-- I Looked at the crime scene table to find the Fontainebleau case
SELECT *
FROM crime_scene;

-- I scanned through the crime_scene table to locate the case about the missing diamond


-- I then narrowed it down to the Fontainebleau Hotel case
SELECT *
FROM crime_scene
WHERE location LIKE '%Fontainebleau%';

-- I filtered by location to read the exact clues for this case
-- The description stated that ~
---- One suspect is a really famous actor
---- And the other is a woman consultant whose first name ends with "an"


-- So I Looked at the guest list
SELECT *
FROM guest;

-- I checked all guests to identify who was
---- The famous actor
---- The woman consultant whose first name ended with "an"


-- I pulled their witness statements
SELECT *
FROM witness_statements
WHERE guest_id = 116
OR guest_id = 129;

-- Guest 116 (Vivian Nair, a consultant) said that:
-- Someone was holding an invitation ending in "-R" and wore a navy suit with a white tie

-- Guest 129 (Clint Eastwood, a famous actor) said to:
-- "Meet me at the marina, dock 3."


-- So I Checked marina rentals for dock 3 on the date of the crime
SELECT *
FROM marina_rentals
WHERE dock_number = 3
AND rental_date = 19870520;

-- I filtered to dock 3 on the same date as the crime (19870520)
-- This gave me a list of possible suspects to look through


-- I joined marina_rentals with guest to see who those renters were
SELECT *
FROM marina_rentals
JOIN guest
ON marina_rentals.renter_guest_id = guest.id
WHERE marina_rentals.dock_number = 3
AND marina_rentals.rental_date = 19870520;

-- This showed me the names and invitation codes of everyone
-- who rented dock 3 on the day of the theft
-- So I focused on guests with an invitation code VIP-R


-- I then checked the attire registry
SELECT *
FROM attire_registry;

-- I searched the attire_registry for someone wearing
-- "navy suit & white tie" to match the consultant’s clue
-- Guest 105 matched exactly


-- I Confirmed who guest 105 was
SELECT *
FROM guest
WHERE id = 105;

-- Guest 105 is Mike Manning
-- He also had an invitation code VIP-R and rented dock 3 that day of the crime


-- I checked the final interview for confirmation
SELECT *
FROM final_interviews
WHERE guest_id = 105;

-- Mike Manning confessed that ~
-- "I was the one who took the crystal."


-- My Final Conclusion is that ~
-- Mike Manning stole the Heart of Atlantis diamond necklace!
