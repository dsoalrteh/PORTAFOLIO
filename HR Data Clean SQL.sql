SELECT * FROM Human_Resources;

SELECT
	COLUMN_NAME,
	DATA_TYPE,
	CHARACTER_MAXIMUM_LENGTH
FROM
	INFORMATION_SCHEMA.COLUMNS
WHERE
	TABLE_NAME = 'Human_Resources';

BEGIN TRANSACTION;

--NORMALIZED THE FORMAT COLUMN birthdate to FORMATE DATE
SELECT birthdate FROM Human_Resources;

UPDATE Human_Resources
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN FORMAT(TRY_CONVERT(DATE, birthdate, 101), 'dd-MM-yyyy')
	WHEN birthdate LIKE '%-%' THEN FORMAT(TRY_CONVERT(DATE, birthdate, 1), 'dd-MM-yyyy')
	ELSE NULL
END;

--NORMALIZED THE FORMAT COLUMN hire_date to FORMATE DATE
SELECT hire_date FROM Human_Resources;

UPDATE Human_Resources
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN FORMAT(TRY_CONVERT(DATE, hire_date, 101), 'dd-MM-yyyy')
	WHEN hire_date LIKE '%-%' THEN FORMAT(TRY_CONVERT(DATE, hire_date, 1), 'dd-MM-yyyy')
	ELSE NULL
END;

--NORMALIZED THE FORMAT COLUMN termndate to FORMATE DATE
SELECT termdate FROM Human_Resources;

ALTER TABLE Human_Resources
ALTER COLUMN termdate VARCHAR(50) NULL;

SELECT termdate
FROM Human_Resources
WHERE ISDATE(LEFT(termdate, 10)) = 0 AND termdate IS NOT NULL;

UPDATE Human_Resources
SET termdate =
	CASE 
		WHEN ISDATE(LEFT(termdate, 10)) = 1 THEN LEFT(termdate,10)
		ELSE NULL
	END
WHERE termdate IS NOT NULL;

ALTER TABLE Human_Resources
ALTER COLUMN termdate DATE;

SELECT * FROM Human_Resources;



