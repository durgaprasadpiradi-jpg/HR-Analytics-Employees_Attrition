SELECT
Attrition,
COUNT(*) AS employee_count
FROM Employees
GROUP BY Attrition;

SELECT
Department,
COUNT(*) AS total_employees
FROM Employees
GROUP BY Department
ORDER BY total_employees DESC;

SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left
FROM Employees
GROUP BY Department
ORDER BY employees_left DESC;

WITH DepartmentStats AS (
    SELECT
        Department,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left
    FROM Employees
    GROUP BY Department
)
SELECT
    Department,
    total_employees,
    employees_left,
    ROUND(100.0 * employees_left / total_employees, 2) AS attrition_rate
FROM DepartmentStats
ORDER BY attrition_rate DESC;

SELECT
    Department,
    JobRole,
    MonthlyIncome,
    RANK() OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome DESC
    ) AS salary_rank
FROM Employees;

WITH SalaryRanking AS (
    SELECT
        Department,
        JobRole,
        MonthlyIncome,
        RANK() OVER (
            PARTITION BY Department
            ORDER BY MonthlyIncome DESC
        ) AS salary_rank
    FROM Employees
)
SELECT *
FROM SalaryRanking
WHERE salary_rank <= 3
ORDER BY Department, salary_rank;

SELECT
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left
FROM Employees
GROUP BY age_group
ORDER BY employees_left DESC;

SELECT COUNT(*) AS total_employees
FROM Employees;

SELECT
    OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END) / COUNT(*),
        2
    ) AS attrition_rate
FROM Employees
GROUP BY OverTime
ORDER BY attrition_rate DESC;

SELECT
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS employees_left
FROM Employees
GROUP BY JobRole
ORDER BY employees_left DESC;

SELECT
    BusinessTravel,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS attrition_rate
FROM Employees
GROUP BY BusinessTravel
ORDER BY attrition_rate DESC;

SELECT
    JobSatisfaction,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS attrition_rate
FROM Employees
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

SELECT
    CASE
        WHEN MonthlyIncome < 3000 THEN 'Low Salary'
        WHEN MonthlyIncome BETWEEN 3000 AND 6000 THEN 'Medium Salary'
        WHEN MonthlyIncome BETWEEN 6001 AND 10000 THEN 'High Salary'
        ELSE 'Very High Salary'
    END AS salary_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS attrition_rate
FROM Employees
GROUP BY salary_group
ORDER BY attrition_rate DESC;

SELECT
    CASE
        WHEN YearsAtCompany < 2 THEN '0-1 Years'
        WHEN YearsAtCompany BETWEEN 2 AND 5 THEN '2-5 Years'
        WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 Years'
        ELSE '10+ Years'
    END AS experience_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS attrition_rate
FROM Employees
GROUP BY experience_group
ORDER BY attrition_rate DESC;

SELECT
    Gender,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS attrition_rate
FROM Employees
GROUP BY Gender
ORDER BY attrition_rate DESC;

SELECT
    EducationField,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS attrition_rate
FROM Employees
GROUP BY EducationField
ORDER BY attrition_rate DESC;

SELECT
    WorkLifeBalance,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS attrition_rate
FROM Employees
GROUP BY WorkLifeBalance
ORDER BY attrition_rate DESC;

SELECT
    Attrition,
    COUNT(*) AS total_employees,
    ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income
FROM Employees
GROUP BY Attrition;

SELECT
    OverTime,
    BusinessTravel,
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left
FROM Employees
GROUP BY OverTime, BusinessTravel, JobRole
HAVING SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) > 0
ORDER BY employees_left DESC;

WITH SalaryRanking AS (
    SELECT
        EmployeeNumber,
        Department,
        JobRole,
        MonthlyIncome,
        RANK() OVER (
            PARTITION BY Department
            ORDER BY MonthlyIncome DESC
        ) AS salary_rank
    FROM Employees
)
SELECT
    Department,
    JobRole,
    MonthlyIncome,
    salary_rank
FROM SalaryRanking
WHERE salary_rank <= 3
ORDER BY Department, salary_rank;

WITH DepartmentTotals AS (
    SELECT
        Department,
        COUNT(*) AS total_employees
    FROM Employees
    GROUP BY Department
),
DepartmentAttrition AS (
    SELECT
        Department,
        SUM(CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END) AS employees_left
    FROM Employees
    GROUP BY Department
)
SELECT
    t.Department,
    t.total_employees,
    a.employees_left,
    ROUND(
        100.0 * a.employees_left / t.total_employees,
        2
    ) AS attrition_rate
FROM DepartmentTotals t
JOIN DepartmentAttrition a
    ON t.Department = a.Department
ORDER BY attrition_rate DESC;

SELECT
    Department,
    EmployeeNumber,
    MonthlyIncome,
    SUM(MonthlyIncome) OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS running_total_income
FROM Employees
ORDER BY Department, MonthlyIncome;

SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    LAG(MonthlyIncome) OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome
    ) AS previous_income,
    MonthlyIncome - LAG(MonthlyIncome) OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome
    ) AS income_difference
FROM Employees
ORDER BY Department, MonthlyIncome;

WITH EmployeeRisk AS (
    SELECT
        EmployeeNumber,
        Department,
        MonthlyIncome,
        OverTime,
        Attrition,
        CASE
            WHEN OverTime = 'Yes'
                 AND MonthlyIncome < 3000
                THEN 'Review'
            WHEN OverTime = 'Yes'
                THEN 'Monitor'
            ELSE 'Standard'
        END AS review_group
    FROM Employees
)
SELECT
    review_group,
    COUNT(*) AS total_employees,
    SUM(
        CASE WHEN Attrition = 'Yes'
             THEN 1 ELSE 0
        END
    ) AS employees_left
FROM EmployeeRisk
GROUP BY review_group
ORDER BY employees_left DESC;

SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    ROUND(
        PERCENT_RANK() OVER (
            PARTITION BY Department
            ORDER BY MonthlyIncome
        ),
        2
    ) AS salary_percent_rank
FROM Employees
ORDER BY Department, salary_percent_rank DESC;

SELECT
    e.EmployeeNumber,
    e.Department,
    e.JobRole,
    e.MonthlyIncome
FROM Employees e
WHERE e.MonthlyIncome > (
    SELECT AVG(e2.MonthlyIncome)
    FROM Employees e2
    WHERE e2.Department = e.Department
)
ORDER BY e.Department, e.MonthlyIncome DESC;

SELECT
    e.Department,
    e.EmployeeNumber,
    e.JobRole,
    e.Attrition
FROM Employees e
WHERE e.Attrition = 'Yes'
AND EXISTS (
    SELECT 1
    FROM Employees e2
    WHERE e2.Department = e.Department
      AND e2.OverTime = 'Yes'
)
ORDER BY e.Department, e.EmployeeNumber;

SELECT
    EmployeeNumber,
    Department,
    JobRole,
    MonthlyIncome,
    NTILE(4) OVER (
        PARTITION BY Department
        ORDER BY MonthlyIncome
    ) AS salary_quartile
FROM Employees
ORDER BY Department, salary_quartile;

SELECT
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS missing_age,
    SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS missing_department,
    SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 ELSE 0 END) AS missing_income,
    SUM(CASE WHEN Attrition IS NULL THEN 1 ELSE 0 END) AS missing_attrition
FROM Employees;

