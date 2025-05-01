-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
SELECT gender, COUNT(*) AS Gender_Total
FROM Human_Resources
GROUP BY gender
ORDER BY Gender_Total DESC;

-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT race, COUNT(*) AS Race_Total
FROM Human_Resources
GROUP BY race 
ORDER BY Race_Total DESC;

-- 4. How many employees work at headquarters versus remote locations?
SELECT location, COUNT(*) AS Location_Total
FROM Human_Resources
GROUP BY location
ORDER BY Location_Total DESC;

-- 5. What is the average length of employment for employees who have been terminated?
SELECT 
	AVG(DATEDIFF(DAY, hire_date, GETDATE()))/365 AS Avg_Length_Employment
FROM Human_Resources
WHERE termdate < GETDATE() AND termdate IS NOT NULL;

-- 6. How does the gender distribution vary across departments and job titles?
SELECT department, gender, COUNT(*) AS Gender_Total
FROM Human_Resources
GROUP BY gender, department
ORDER BY Gender_Total DESC;

SELECT jobtitle, gender, COUNT(*) AS Gender_Total
FROM Human_Resources
GROUP BY gender, jobtitle
ORDER BY Gender_Total DESC;

-- 7. What is the distribution of job titles across the company?
SELECT jobtitle, COUNT(*) AS Avg_Jobtitle
FROM Human_Resources
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Which department has the highest turnover rate?
SELECT department,
	total_count,
	terminated_count,
	ROUND(CAST(terminated_count AS FLOAT) /total_count, 3) AS termination_rate
FROM(
	SELECT department,
	COUNT(*) AS total_count,
	SUM(CASE WHEN termdate IS NOT NULL AND termdate <= GETDATE() THEN 1 ELSE 0 END) AS terminated_count
	FROM Human_Resources
	GROUP BY department
	) AS subquery
ORDER BY ROUND(CAST(terminated_count AS float) / total_count,3) DESC;

-- 9. What is the distribution of employees across locations by city and state?
SELECT location_state, location_city, COUNT(*) AS Count_Location
FROM Human_Resources
GROUP BY location_state, location_city
ORDER BY location_state, Count_Location DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT
	YEAR,
	hires,
	terminations,
	hires - terminations AS Net_Changes,
	ROUND(CAST(hires - terminations AS float) / hires * 100, 3) AS Net_Change_Percent
FROM(
	SELECT YEAR(hire_date) AS YEAR,
	COUNT(*) AS hires,
	SUM(CASE WHEN termdate IS NOT NULL AND termdate <= GETDATE() THEN 1 ELSE 0 END) AS terminations
	FROM Human_Resources
	GROUP BY YEAR(hire_date)
	) AS subquery
ORDER BY YEAR ASC;

-- 11. What is the tenure distribution for each department?
SELECT department, ROUND(AVG(DATEDIFF(DAY,termdate, hire_date)/365),0) AS Avg_tenure
FROM Human_Resources
WHERE termdate <= GETDATE() AND termdate IS NOT NULL 
GROUP BY department;