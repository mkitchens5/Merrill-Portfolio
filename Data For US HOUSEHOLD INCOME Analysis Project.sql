SELECT * 
FROM us_project.us_household_income;

SELECT * 
FROM us_project.ushouseholdincome_statistics;

-- Finding who has the most land and water(consist of lakes, ocean) in a state
SELECT State_Name, SUM(Aland) as Land, SUM(AWater) as Water
FROM us_project.us_household_income
Group BY State_Name
Order By Land Desc
Limit 5;                     -- Shows the states with Top 5 most land

SELECT State_Name, SUM(Aland) as Land, SUM(AWater) as Water
FROM us_project.us_household_income
Group BY State_Name
Order By SUM(AWater) Desc
Limit 5;                     -- Shows the states with Top 5 most water

-- Finding who has the lowest and highest household income

SELECT u.State_Name, 
       ROUND(AVG(us.Mean), 1) AS Avg_Mean, 
       ROUND(AVG(us.Median), 1) AS Avg_Median
FROM us_project.us_household_income u
INNER JOIN us_project.ushouseholdincome_statistics us 
    ON u.id = us.id
WHERE us.Mean <> 0
GROUP BY u.State_Name
ORDER BY Avg_Mean ASC
LIMIT 10;    -- Shows who has the top 10 lowest incomes per household on average


 SELECT u.State_Name, ROUND(AVG(us.Mean),1), ROUND(AVG(us.Median),1)
FROM us_project.us_household_income u 
INNER Join us_project.ushouseholdincome_statistics us
	ON u.id = us.id 
WHERE us.Mean <> 0
GROUP BY u.State_Name
ORDER BY 3 ASC         
LIMIT 10       -- Shows who has the MOST top 10 lowest incomes per household on average
 ;

SELECT u.State_Name, ROUND(AVG(us.Mean),1), ROUND(AVG(us.Median),1)
FROM us_project.us_household_income u 
INNER Join us_project.ushouseholdincome_statistics us
	ON u.id = us.id 
WHERE us.Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC      
LIMIT 10           -- Shows who has the top 10 highest incomes per household on average
 ;
 
SELECT u.State_Name, ROUND(AVG(us.Mean),1), ROUND(AVG(us.Median),1)
FROM us_project.us_household_income u 
INNER Join us_project.ushouseholdincome_statistics us
	ON u.id = us.id 
WHERE us.Mean <> 0
GROUP BY u.State_Name
ORDER BY 3 DESC      
LIMIT 10           -- Shows who has the MOST top 10 highest incomes per household on average
 ;
 
SELECT Type, COUNT(Type), ROUND(AVG(us.Mean),1), ROUND(AVG(us.Median),1)
FROM us_project.us_household_income u 
INNER Join us_project.ushouseholdincome_statistics us
	ON u.id = us.id 
WHERE us.Mean <> 0
GROUP BY Type
HAVING COUNT(Type) > 20
ORDER BY 3 DESC      
LIMIT 5            -- Shows who has the top 5 highest incomes by the type of household they live in on average
 ;


SELECT Type, COUNT(Type), ROUND(AVG(us.Mean),1), ROUND(AVG(us.Median),1)
FROM us_project.us_household_income u 
INNER Join us_project.ushouseholdincome_statistics us
	ON u.id = us.id 
WHERE us.Mean <> 0
GROUP BY Type
HAVING COUNT(Type) > 20
ORDER BY 3       
LIMIT 5            -- Shows who has the top 5 lowest incomes by the type of household they live in on average
 ;

-- Finding City Income Averages in United States
SELECT u.State_Name, City, ROUND(AVG(us.Mean),1) as city_income_avg, ROUND(AVG(us.Median),1) as city_medianincome_avg
FROM us_project.us_household_income u 
INNER Join us_project.ushouseholdincome_statistics us
	ON u.id = us.id 
WHERE us.Mean <> 0
GROUP BY u.State_Name, City
ORDER BY 3 DESC      
LIMIT 15           -- Shows who has the MOST top 15 highest incomes per city on average
