-- Step 1: Drop the table if it already exists
IF OBJECT_ID('dbo.Employee', 'U') IS NOT NULL
    DROP TABLE dbo.Employee;
GO

-- Step 2: Create the table properly
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    Bonus DECIMAL(10, 2),
    Experience INT,
    City VARCHAR(50)
);
GO

-- Step 3: Insert the data
INSERT INTO Employee (EmployeeID, Name, Department, Salary, Bonus, Experience, City) 
VALUES 
    (1, 'Anil Sharma', 'IT', 65000.00, 5000.00, 6, 'Mumbai'),
    (2, 'Priya Singh', 'HR', 48000.00, 3000.00, 4, 'Delhi'),
    (3, 'Amit Patel', 'IT', 55000.00, 4500.00, 7, 'Bangalore'),
    (4, 'Sneha Rao', 'Finance', 42000.00, 2500.00, 3, 'Mumbai'),
    (5, 'Aarav Kumar', 'IT', 52000.00, 4000.00, 2, 'Delhi');
GO

-- Step 4: Test your query
SELECT * 
FROM Employee 
WHERE Department = 'IT' AND Experience > 5;

-- 1. Salary > 50,000
SELECT * FROM Employee 
WHERE Salary > 50000;

-- 2. IT Dept & Experience > 5 years
SELECT * FROM Employee 
WHERE Department = 'IT' AND Experience > 5;

-- 3. Salary between 45,000 and 60,000
SELECT * FROM Employee 
WHERE Salary BETWEEN 45000 AND 60000;

-- 4. City in Mumbai or Delhi
SELECT * FROM Employee 
WHERE City IN ('Mumbai', 'Delhi');

-- 5. Name and Annual Income
SELECT Name, (Salary * 12 + ISNULL(Bonus, 0)) AS AnnualIncome 
FROM Employee;

-- 6. Name starts with 'A'
SELECT * FROM Employee 
WHERE Name LIKE 'A%';

-- 7. Highest salary
SELECT MAX(Salary) AS HighestSalary 
FROM Employee;

-- 8 & 11. Total bonus in IT department
SELECT SUM(Bonus) AS TotalITBonus 
FROM Employee 
WHERE Department = 'IT';

-- 9. Minimum and Maximum experience
SELECT MIN(Experience) AS MinExperience, MAX(Experience) AS MaxExperience 
FROM Employee;

-- 10. Employee count per department
SELECT Department, COUNT(*) AS EmployeeCount 
FROM Employee 
GROUP BY Department;

-- 12. Add Email column
ALTER TABLE Employee 
ADD Email VARCHAR(100);

-- 13. Change Salary data type (SSMS specific syntax)
ALTER TABLE Employee 
ALTER COLUMN Salary DECIMAL(10, 2);

-- 14. Drop Bonus column
ALTER TABLE Employee 
DROP COLUMN Bonus;