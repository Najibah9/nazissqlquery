DROP TABLE IF EXISTS Employee;
GO

-- Create the table
CREATE TABLE Employee (
    EID INT PRIMARY KEY,
    Ename VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL
);
GO

-- Insert sample data
INSERT INTO Employee (EID, Ename, Department, Salary) VALUES
(101, 'Alice Smith', 'HR', 55000.00),
(102, 'Bob Johnson', 'IT', 75000.00),
(103, 'Charlie Brown', 'IT', 85000.00),
(104, 'Diana Prince', 'IT', 62000.00),
(105, 'Evan Wright', 'Finance', 90000.00),
(106, 'Fiona Gallagher', 'Finance', 65000.00),
(107, 'George Clark', 'Marketing', 48000.00);

-- 1. Display each Department and total employees
SELECT Department, COUNT(*) AS TotalEmployees
FROM Employee
GROUP BY Department;

-- 2. Highest salary and Average salary per department
SELECT Department, 
       MAX(Salary) AS HighestSalary, 
       AVG(Salary) AS AverageSalary
FROM Employee
GROUP BY Department;

-- 3. Count employees in each Department
SELECT Department, COUNT(EID) AS EmployeeCount
FROM Employee
GROUP BY Department;

-- 4. Minimum salary in each Department
SELECT Department, MIN(Salary) AS MinimumSalary
FROM Employee
GROUP BY Department;

-- 5. Departments with MORE THAN 2 employees
SELECT Department, COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY Department
HAVING COUNT(*) > 2;

-- 6. Departments where total salary payout is GREATER THAN 100,000
SELECT Department, SUM(Salary) AS TotalSalaryPayout
FROM Employee
GROUP BY Department
HAVING SUM(Salary) > 100000;

-- 7. Departments where average salary is ABOVE 60,000
SELECT Department, AVG(Salary) AS AverageSalary
FROM Employee
GROUP BY Department
HAVING AVG(Salary) > 60000;

-- 8. Departments with EXACTLY 1 employee
SELECT Department, COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY Department
HAVING COUNT(*) = 1;

-- 9. All employees sorted by Salary (Highest to Lowest)
SELECT *
FROM Employee
ORDER BY Salary DESC;

-- 10. All employees sorted by Ename (Alphabetical)
SELECT *
FROM Employee
ORDER BY Ename ASC;

-- 11. Sorted by Department, then by Ename
SELECT *
FROM Employee
ORDER BY Department ASC, Ename ASC;

-- Clear all data from the existing table
TRUNCATE TABLE Employee;

-- Insert sample data
INSERT INTO Employee (EID, Ename, Department, Salary) VALUES
(101, 'Alice Smith', 'HR', 55000.00),
(102, 'Bob Johnson', 'IT', 75000.00),
(103, 'Charlie Brown', 'IT', 85000.00),
(104, 'Diana Prince', 'IT', 62000.00),
(105, 'Evan Wright', 'Finance', 90000.00),
(106, 'Fiona Gallagher', 'Finance', 65000.00),
(107, 'George Clark', 'Marketing', 48000.00);