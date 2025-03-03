SELECT * FROM bakery.worldlifexpectancy;

-- Checking for duplicates

SELECT Country, Year, 
CONCAT(Country, Year) as CountryAndYear, 
COUNT(CONCAT(Country, Year)) as Duplicate_Checker
FROM bakery.worldlifexpectancy
Group By Country, Year, CONCAT(Country, Year) 
Having Duplicate_Checker > 1
;

-- Writing code to find duplicates 
SELECT *
FROM (
SELECT Row_ID,CONCAT(Country, Year),
ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
FROM  bakery.worldlifexpectancy) AS row_table
WHERE Row_Num > 1 ;

-- 1. Deleting duplicates
DELETE FROM bakery.worldlifexpectancy
WHERE Row_ID IN (
    SELECT Row_ID 
    FROM (
        SELECT Row_ID,
               CONCAT(Country, Year) AS Country_Year,
               ROW_NUMBER() OVER (PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
        FROM bakery.worldlifexpectancy
    ) AS row_table
    WHERE Row_Num > 1
);
-- 2. Checking for blanks in each column and filling it with proper data

-- Finding Blanks in this Data Column called status
SELECT *
FROM bakery.worldlifexpectancy
WHERE Status = '';

-- Finding  data thats not blank in this Data Column called status
SELECT DISTINCT (Status)
FROM bakery.worldlifexpectancy
WHERE Status <> '';   -- i

-- Filling in the blank data with the proper data thats supposed to be included for developing
SELECT DISTINCT (Country)
FROM bakery.worldlifexpectancy
WHERE Status = 'Developing';


UPDATE bakery.worldlifexpectancy t1
JOIN bakery.worldlifexpectancy t2 ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''  
  AND t2.Status <> '' 
  AND t2.Status = 'Developing';
 -- using join to get blank data filled with the phrase 'Devloping' where the country was developing (correct data)

-- Finding Blanks in the Data Column called status to update whats left
SELECT *
FROM bakery.worldlifexpectancy
WHERE Status = '';

-- Filling in the blank data with the proper data thats supposed to be included for developed
SELECT DISTINCT (Country)
FROM bakery.worldlifexpectancy
WHERE Status = 'Developed';


UPDATE bakery.worldlifexpectancy t1
JOIN bakery.worldlifexpectancy t2 ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''  
  AND t2.Status <> '' 
  AND t2.Status = 'Developed';
 -- using join to get blank data filled with the phrase 'Devloping' where the country was developing (correct data)


-- Checking to see if theres any more blanks in status column 
SELECT *
FROM bakery.worldlifexpectancy
WHERE Status = ''; 

SELECT *
FROM bakery.worldlifexpectancy
WHERE Status IS NULL; -- there isnt any more blanks in status column

-- open it to see clean data    
SELECT * FROM bakery.worldlifexpectancy;