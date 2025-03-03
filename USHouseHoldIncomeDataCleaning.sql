SELECT * 
FROM us_project.us_household_income;

SELECT * 
FROM us_project.ushouseholdincome_statistics;

-- Changing grammar in column name to a name more understandable
ALTER TABLE us_project.ushouseholdincome_statistics RENAME COLUMN `ï»¿id` TO `id`;

SELECT * 
FROM us_project.us_household_income;

SELECT * 
FROM us_project.ushouseholdincome_statistics;

-- finding duplicates in data 
SELECT id, COUNT(id) as duplicatefinder
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1;

SELECT *
FROM (
SELECT row_id, id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
FROM us_project.us_household_income) subqueryforduplicates
WHERE row_num > 1
;

-- Deleting duplicates
DELETE FROM us_project.us_household_income
WHERE row_id IN ( 
	SELECT row_id
	FROM (
		SELECT row_id, 
        id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
		FROM us_project.us_household_income
        ) subqueryforduplicates
		WHERE row_num > 1)
;
-- checking to see if duplicates were deleted 
SELECT *
FROM (
SELECT row_id, id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
FROM us_project.us_household_income) subqueryforduplicates
WHERE row_num > 1
;                                                                -- it was deleted which is what we want

-- checking for more corrupt data 
SELECT * 
FROM us_project.us_household_income;     -- noticed some places in the column AWater were 0 but that could just mean they didnt have rivers,lakes, etc in there county so im going to check.

SELECT Aland, AWater
FROM us_project.us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL )
AND (Aland = 0 OR Aland = '' OR Aland IS NULL )
;  
                                                       
SELECT  Aland, AWater
FROM us_project.us_household_income
WHERE  (Aland = 0 OR Aland = '' OR Aland IS NULL )  # This confirmed that this data was correct, AWater was only 0 where it was in counties full of land which is correct data
 
SELECT * 
FROM us_project.us_household_income;

SELECT type, COUNT(type)
FROM us_project.us_household_income
GROUP BY type;                                -- noticed there were duplicates in the type column so im going to update the table to remove duplicates

UPDATE us_project.us_household_income
SET Type = 'Borough'
WHERE Type =  'Boroughs'   

SELECT * 
FROM us_project.us_household_income;  -- data is clean!

SELECT * 
FROM us_project.us_household_income;

