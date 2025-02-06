use salary_2021;

 /* 1. Average Salary by Industry and Gender */

SELECT 
    industry, 
    gender, 
    AVG(annual_salary) AS average_salary
FROM mailstone_1
GROUP BY industry, gender
ORDER BY industry, gender;

/* 2. Total Salary Compensation by Job Title */

SELECT 
    job_title, 
    SUM(Annual_salary + Additional_monetary_compensation) AS total_compensation
FROM mailstone_1
GROUP BY job_title
ORDER BY total_compensation DESC;

/* 3. Salary Distribution by Education Level */

SELECT 
    Qualification, 
    AVG(annual_salary) AS average_salary, 
    MIN(annual_salary) AS minimum_salary, 
    MAX(annual_salary) AS maximum_salary
FROM mailstone_1
GROUP BY Qualification
ORDER BY average_salary DESC;

/* 4. Number of Employees by Industry and Years of Experience */

SELECT 
    industry, 
    Professional_experience, 
    COUNT(*) AS employee_count
FROM mailstone_1
GROUP BY industry, Professional_experience
ORDER BY employee_count desc;

/* 5. Median Salary by Age Range and Gender */

WITH RankedSalaries AS (
    SELECT 
        Annual_salary,
        age_range,
        gender,
        ROW_NUMBER() OVER (PARTITION BY age_range, gender ORDER BY Annual_salary) AS row_num,
        COUNT(*) OVER (PARTITION BY age_range, gender) AS total_count
    FROM mailstone_1
)
SELECT age_range, gender,
       CASE 
           WHEN total_count % 2 = 1 THEN
		
               MAX(CASE WHEN row_num = (total_count + 1) / 2 THEN Annual_salary END) 
           ELSE
	
              AVG(CASE WHEN row_num IN (total_count / 2, total_count / 2 + 1) THEN Annual_salary END)
       END AS median_salary
FROM RankedSalaries
GROUP BY age_range, gender
ORDER BY age_range;

/* 6. Job Titles with the Highest Salary in Each Country */

SELECT Country, Job_Title, MAX(Annual_Salary) AS Highest_Salary
FROM mailstone_1
GROUP BY Country, Job_Title
ORDER BY Highest_Salary DESC;

/* 7. Average Salary by City and Industry */

SELECT 
    City, 
    Industry, 
    AVG(Annual_Salary) AS Average_Salary
FROM mailstone_1
GROUP BY City, Industry
ORDER BY Average_salary desc;

/* 8. Percentage of Employees with Additional Monetary Compensation by Gender */

SELECT 
    Gender, 
    ROUND(COUNT(CASE WHEN Additional_Monetary_Compensation > 0 THEN 1 END) * 100.0 / COUNT(*), 2) AS Percentage_With_Compensation
FROM mailstone_1
GROUP BY Gender
ORDER BY Gender;

/* 9. Total Compensation by Job Title and Years of Experience */

SELECT 
    Job_Title, 
    Professional_experience, 
    SUM(Annual_Salary + Additional_Monetary_Compensation) AS Total_Compensation
FROM mailstone_1
GROUP BY Job_Title, Professional_experience
ORDER BY Total_Compensation DESC;

/* 10. Average Salary by Industry, Gender, and Education Level */

SELECT 
    Industry, 
    Gender, 
    Qualification AS Education_Level, 
    AVG(Annual_Salary) AS Average_Salary
FROM mailstone_1
GROUP BY Industry, Gender, Qualification
ORDER BY Average_salary desc;