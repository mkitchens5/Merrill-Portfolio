SELECT *
FROM bakery.ushouseholdincome;

SELECT *
FROM bakery.us_household_income_cleaned



DELIMITER $$
DROP PROCEDURE IF EXISTS Copy_and_Clean_Data;

CREATE PROCEDURE Copy_and_Clean_Data()
BEGIN
-- CREATING TABLE
	CREATE TABLE IF NOT EXISTS `us_household_income_Cleaned` (
	  `row_id` int DEFAULT NULL,
	  `id` int DEFAULT NULL,
	  `State_Code` int DEFAULT NULL,
	  `State_Name` text,
	  `State_ab` text,
	  `County` text,
	  `City` text,
	  `Place` text,
	  `Type` text,
	  `Primary` text,
	  `Zip_Code` bigint DEFAULT NULL,
	  `Area_Code` int DEFAULT NULL,
	  `ALand` bigint DEFAULT NULL,
	  `AWater` int DEFAULT NULL,
	  `Lat` double DEFAULT NULL,
	  `Lon` double DEFAULT NULL,
	  `TimeStamp` TIMESTAMP DEFAULT NULL
	) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- COPY DATA TO NEW TABLE 
	INSERT INTO us_household_income_Cleaned
    SELECT *, CURRENT_TIMESTAMP
    FROM bakery.ushouseholdincome;
		
	-- DATA CLEANING STEPS 
	-- 1. Remove Duplicates
	DELETE FROM us_household_income_Cleaned 
	WHERE 
		row_id IN (
		SELECT row_id
	FROM (
		SELECT row_id, id,
			ROW_NUMBER() OVER (
				PARTITION BY id,`TimeStamp`
				ORDER BY id,`TimeStamp`)AS row_num
		FROM             
			us_household_income_Cleaned
	) duplicates
	WHERE 
		row_num > 1
	);

	-- 2. Fixing some data quality issues by fixing typos and general standardization


	UPDATE us_household_income_Cleaned
	SET State_Name = 'Georgia'
	WHERE State_Name = 'georia';

	UPDATE us_household_income_Cleaned
	SET County = UPPER(County);

	UPDATE us_household_income_Cleaned
	SET City = UPPER(City);

	UPDATE us_household_income_Cleaned
	SET Place = UPPER(Place);

	UPDATE us_household_income_Cleaned
	SET State_Name = UPPER(State_Name);

	UPDATE us_household_income_Cleaned
	SET `Type` = 'CDP'
	WHERE `Type` = 'CPD';

	UPDATE us_household_income_Cleaned
	SET `Type` = 'Borough'
	WHERE `Type` = 'Boroughs';

END $$
DELIMITER $$;

CALL Copy_and_Clean_Data();


-- CREATE EVENT 
DROP EVENT  run_data_cleaning;


CREATE EVENT run_data_cleaning
       ON SCHEDULE EVERY 30 DAY
       DO CALL Copy_and_Clean_Data();







-- DEBUGGING OR CHECKING IF SP WORKS
		SELECT row_id, id, row_num
	FROM (
		SELECT row_id, id,
			ROW_NUMBER() OVER (
				PARTITION BY id
				ORDER BY id) AS row_num
		FROM 
			us_household_income_Cleaned
	) duplicates
	WHERE 
		row_num > 1;
    
    
	SELECT COUNT(row_id)
    FROM us_household_income_Cleaned;
    
    SELECT State_Name, COUNT(State_Name)
    FROM us_household_income_Cleaned
    GROUP BY State_Name ;
    
--    us_household_income_Cleaned
--    ushouseholdincome
-- TO see results use  this below
USE bakery;
SELECT *
FROM us_household_income_cleaned;

SELECT DISTINCT TimeStamp 
FROM bakery.us_household_income_cleaned;
