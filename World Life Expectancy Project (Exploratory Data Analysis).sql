SELECT * 
FROM bakery.worldlifexpectancy;

--  Visualizing life expectancy change over 15 years within each country
SELECT Country,  MIN(`Lifeexpectancy`), MAX(`Lifeexpectancy`),
ROUND(MAX(`Lifeexpectancy`) -  MIN(`Lifeexpectancy`),1) AS Life_Increase_over_15_years
FROM bakery.worldlifexpectancy
GROUP BY Country
HAVING  MIN(`Lifeexpectancy`) <> 0
AND  MAX(`Lifeexpectancy`) <> 0
ORDER BY Life_Increase_over_15_years desc
;

SELECT Country,  MIN(`Lifeexpectancy`), MAX(`Lifeexpectancy`),
ROUND(MAX(`Lifeexpectancy`) -  MIN(`Lifeexpectancy`),1) AS Life_Increase_over_15_years
FROM bakery.worldlifexpectancy
GROUP BY Country
HAVING  MIN(`Lifeexpectancy`) <> 0
AND  MAX(`Lifeexpectancy`) <> 0
ORDER BY Life_Increase_over_15_years ASC
;

-- Visualizing the average life expectancy by the year on average
SELECT Year, Round(AVG(`Lifeexpectancy`),2)
FROM bakery.worldlifexpectancy
WHERE `Lifeexpectancy` <> 0
AND `Lifeexpectancy` <> 0
GROUP BY Year
ORDER BY Year
;

SELECT * 
FROM bakery.worldlifexpectancy
;

-- Visualizing the average life expectancy and GDP per Country 
SELECT Country, Round(AVG(`Lifeexpectancy`),1) as Avg_LifeExpectancy, Round(AVG(`GDP`),1) as Avg_GDP
FROM bakery.worldlifexpectancy
GROUP BY Country
HAVING  Avg_GDP <> 0
AND Avg_LifeExpectancy <> 0 
ORDER BY  Avg_GDP asc
;                                                      -- i noticed lower gdp's are correlated to lower life expectancy 


SELECT Country, Round(AVG(`Lifeexpectancy`),1) as Avg_LifeExpectancy, Round(AVG(GDP),1) as Avg_GDP
FROM bakery.worldlifexpectancy
GROUP BY Country
HAVING  Avg_GDP <> 0
AND Avg_LifeExpectancy <> 0 
ORDER BY  Avg_GDP desc
;                                                      -- this confirmed higher gdp's are correlated to higher life expectancy 


-- Finding a count of countries with high gdps
SELECT Round(AVG(GDP),1) as Avg_GDP
FROM bakery.worldlifexpectancy;                         -- Average gdp is 6342.1


SELECT 
SUM(CASE WHEN GDP >= 6342.1 THEN 1 ELSE 0 END) High_GDP_Count,
ROUND(AVG(CASE WHEN GDP >= 6342.1 THEN `Lifeexpectancy` ELSE NULL END),1) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 6342.1 THEN 1 ELSE 0 END) LOW_GDP_Count, 
ROUND(AVG(CASE WHEN GDP <= 6342.1 THEN `Lifeexpectancy` ELSE NULL END),1) LOW_GDP_Life_Expectancy
FROM  bakery.worldlifexpectancy
;                                 -- Shows how much times GDP is Above the Average (608), and the average Life Expectancy for gdps above the average gdp is 77 years old. 
							      -- Shows how much times GDP is Below the Average (2330), and the average Life Expectancy for gdps below the average gdp is 66.8 years old. 
                                  
-- Finding a count of developed countries vs  developing countries and each counterparts average life expectancy 
SELECT Status, COUNT(DISTINCT Country), ROUND(avg(`Lifeexpectancy`),1) avg_life
FROM bakery.worldlifexpectancy
group by Status;                         -- Average lige expectancy for developed country is 79.2 , while for devoloping countries its 66.8 but 
                                          --  thats because its more devloping countries(161) in this graph than it is for devloped (32)

 -- How much people died on average per year in each country 
SELECT Country, Year, `Lifeexpectancy`, `AdultMortality`,
SUM(`AdultMortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM bakery.worldlifexpectancy
;       


                                  
                                  