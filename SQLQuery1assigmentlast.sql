-- 1. Create a database named CompanyDB
CREATE DATABASE CompanyDB;
GO

-- 2. Use CompanyDB database and create the Employee table
USE CompanyDB;
GO

CREATE TABLE Employee (
    EmpID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Designation VARCHAR(50),
    Salary DECIMAL(10, 2),
    City VARCHAR(50),
    Gender CHAR(1),
    JoiningDate DATE,
    Age INT
);
GO

-- 3. Add a new column Email to the Employee table
ALTER TABLE Employee
ADD Email VARCHAR(50);
GO

-- 4. Modify the Email column to increase its size
ALTER TABLE Employee
ALTER COLUMN Email VARCHAR(100);
GO

-- 5. Rename the column City to Location
EXEC sp_rename 'Employee.City', 'Location', 'COLUMN';
GO

-- 6. Rename Employee to EmployeeDetails and back to Employee
EXEC sp_rename 'Employee', 'EmployeeDetails';
GO
EXEC sp_rename 'EmployeeDetails', 'Employee';
GO

-- 7. Drop the Email column from the Employee table
ALTER TABLE Employee
DROP COLUMN Email;
GO

-- 8. Check the structure of the Employee table
EXEC sp_help 'Employee';
GO

-- 9. Make EmpID column the Primary Key
ALTER TABLE Employee
ALTER COLUMN EmpID INT NOT NULL;
GO
ALTER TABLE Employee
ADD CONSTRAINT PK_Employee PRIMARY KEY (EmpID);
GO

-- 10. Add a NOT NULL constraint on the FirstName column
ALTER TABLE Employee
ALTER COLUMN FirstName VARCHAR(50) NOT NULL;
GO

-- 11. Add a UNIQUE constraint on a newly added Email column
ALTER TABLE Employee
ADD Email VARCHAR(100);
GO
ALTER TABLE Employee
ADD CONSTRAINT UQ_Employee_Email UNIQUE (Email);
GO

-- 12. Add a DEFAULT constraint on the Department column
ALTER TABLE Employee
ADD CONSTRAINT DF_Employee_Department DEFAULT 'General' FOR Department;
GO

-- 13. Add a CHECK constraint on the Salary column (Salary >= 10000)
ALTER TABLE Employee
ADD CONSTRAINT CK_Employee_Salary CHECK (Salary >= 10000);
GO

-- 14. Add a CHECK constraint on the Age column (Between 18 and 60)
ALTER TABLE Employee
ADD CONSTRAINT CK_Employee_Age CHECK (Age BETWEEN 18 AND 60);
GO

-- 15. Remove the CHECK constraint applied on the Salary column
ALTER TABLE Employee
DROP CONSTRAINT CK_Employee_Salary;
GO

-- 16. Add Manager_EmpID column and a CHECK constraint so it cannot equal EmpID
ALTER TABLE Employee
ADD Manager_EmpID INT;
GO
ALTER TABLE Employee
ADD CONSTRAINT CK_Employee_Manager CHECK (Manager_EmpID <> EmpID);
GO

-- 17. Insert 15 records into the Employee table
INSERT INTO Employee (EmpID, FirstName, LastName, Department, Designation, Salary, Location, Gender, JoiningDate, Age, Email, Manager_EmpID)
VALUES 
(1, 'Amit', 'Sharma', 'IT', 'Manager', 55000, 'Mumbai', 'M', '2020-01-15', 35, 'amit@company.com', NULL),
(2, 'Priya', 'Singh', 'HR', 'Executive', 25000, 'Delhi', 'F', '2021-03-10', 28, 'priya@company.com', 1),
(3, 'Rahul', 'Verma', 'Sales', 'Analyst', 18000, 'Mumbai', 'M', '2022-05-20', 25, 'rahul@company.com', 1),
(4, 'Sneha', 'Patel', 'Finance', 'Analyst', 32000, 'Pune', 'F', '2019-11-01', 30, 'sneha@company.com', 1),
(5, 'Rohan', 'Mehta', 'IT', 'Executive', 28000, 'Delhi', 'M', '2021-08-15', 27, 'rohan@company.com', 1),
(6, 'Ananya', 'Roy', 'HR', 'Manager', 50000, 'Mumbai', 'F', '2018-02-12', 38, 'ananya@company.com', NULL),
(7, 'Vikas', 'Gupta', 'Sales', 'Executive', 14000, 'Delhi', 'M', '2023-01-05', 23, 'vikas@company.com', 6),
(8, 'Pooja', 'Nair', 'IT', 'Analyst', 35000, 'Pune', 'F', '2020-09-18', 29, 'pooja@company.com', 1),
(9, 'Karan', 'Joshi', 'Finance', 'Manager', 60000, 'Mumbai', 'M', '2017-06-25', 42, 'karan@company.com', NULL),
(10, 'Neha', 'Kapoor', 'Sales', 'Analyst', 12000, 'Delhi', 'F', '2023-04-11', 22, 'neha@company.com', 6),
(11, 'Aakash', 'Chawla', 'IT', 'Executive', 27000, 'Pune', 'M', '2022-07-01', 26, 'aakash@company.com', 1),
(12, 'Simran', 'Kaur', 'HR', 'Analyst', 22000, 'Mumbai', 'F', '2021-12-01', 27, 'simran@company.com', 6),
(13, 'Siddharth', 'Rao', 'Finance', 'Executive', 29000, 'Delhi', 'M', '2020-04-15', 31, 'siddharth@company.com', 9),
(14, 'Aarti', 'Mishra', 'IT', 'Analyst', 31000, 'Mumbai', 'F', '2019-10-10', 32, 'aarti@company.com', 1),
(15, 'Varun', 'Bhatia', 'Sales', 'Manager', 48000, 'Pune', 'M', '2018-08-20', 36, 'varun@company.com', NULL);

-- 18. Insert a record without specifying Department (tests DEFAULT constraint)
INSERT INTO Employee (EmpID, FirstName, LastName, Designation, Salary, Location, Gender, JoiningDate, Age, Email)
VALUES (16, 'Deepak', 'Kumar', 'Executive', 20000, 'Delhi', 'M', '2023-06-01', 24, 'deepak@company.com');

-- 19. Update IT department salary by 10%
UPDATE Employee
SET Salary = Salary * 1.10
WHERE Department = 'IT';

-- 20. Update Designation for EmpID 5 to 'Senior Executive'
UPDATE Employee
SET Designation = 'Senior Executive'
WHERE EmpID = 5;

-- 21. Delete record of employee with EmpID 10
DELETE FROM Employee
WHERE EmpID = 10;

-- 22. Delete all employees with Salary less than 15,000
DELETE FROM Employee
WHERE Salary < 15000;

-- 23. Update Location from 'Mumbai' to 'Pune'
UPDATE Employee
SET Location = 'Pune'
WHERE Location = 'Mumbai';

-- 24. Intentional test for NOT NULL constraint (This query will fail deliberately)
-- INSERT INTO Employee (EmpID, FirstName, LastName) VALUES (17, NULL, 'Test');
-- 25. Display all records
SELECT * FROM Employee;

-- 26. Display FirstName, LastName, and Salary
SELECT FirstName, LastName, Salary FROM Employee;

-- 27. Display details of employees in 'HR' department
SELECT * FROM Employee 
WHERE Department = 'HR';

-- 28. Display distinct Department names
SELECT DISTINCT Department FROM Employee;

-- 29. Display total number of employees
SELECT COUNT(*) AS TotalEmployees FROM Employee;

-- 30. Display FirstName and Salary using alias MonthlySalary
SELECT FirstName, Salary AS MonthlySalary FROM Employee;

-- 31. Display all female employees
SELECT * FROM Employee 
WHERE Gender = 'F';

-- 32. Display top 5 highest paid employees
SELECT TOP 5 * FROM Employee 
ORDER BY Salary DESC;

-- 33. Salary greater than 30,000
SELECT * FROM Employee 
WHERE Salary > 30000;

-- 34. Department is 'IT' AND Salary > 25,000
SELECT * FROM Employee 
WHERE Department = 'IT' AND Salary > 25000;

-- 35. Department is 'HR' OR 'Finance'
SELECT * FROM Employee 
WHERE Department = 'HR' OR Department = 'Finance';

-- 36. Salary BETWEEN 20,000 and 40,000
SELECT * FROM Employee 
WHERE Salary BETWEEN 20000 AND 40000;

-- 37. Location IN ('Delhi', 'Mumbai', 'Pune')
SELECT * FROM Employee 
WHERE Location IN ('Delhi', 'Mumbai', 'Pune');

-- 38. FirstName starts with 'A'
SELECT * FROM Employee 
WHERE FirstName LIKE 'A%';

-- 39. FirstName ends with 'a'
SELECT * FROM Employee 
WHERE FirstName LIKE '%a';

-- 40. Department is NOT 'Sales'
SELECT * FROM Employee 
WHERE Department <> 'Sales';

-- 41. Total number of employees in each department
SELECT Department, COUNT(*) AS TotalEmployees 
FROM Employee 
GROUP BY Department;

-- 42. Average salary department-wise
SELECT Department, AVG(Salary) AS AvgSalary 
FROM Employee 
GROUP BY Department;

-- 43. Maximum salary in each department
SELECT Department, MAX(Salary) AS MaxSalary 
FROM Employee 
GROUP BY Department;

-- 44. Minimum salary city-wise (using column Location)
SELECT Location, MIN(Salary) AS MinSalary 
FROM Employee 
GROUP BY Location;

-- 45. Total salary paid, grouped by Designation
SELECT Designation, SUM(Salary) AS TotalSalary 
FROM Employee 
GROUP BY Designation;

-- 46. Departments having more than 3 employees
SELECT Department, COUNT(*) AS EmployeeCount 
FROM Employee 
GROUP BY Department 
HAVING COUNT(*) > 3;

-- 47. Departments whose average salary is greater than 30,000
SELECT Department, AVG(Salary) AS AvgSalary 
FROM Employee 
GROUP BY Department 
HAVING AVG(Salary) > 30000;

-- 48. Cities having total employee count greater than 2
SELECT Location, COUNT(*) AS EmployeeCount 
FROM Employee 
GROUP BY Location 
HAVING COUNT(*) > 2;

-- 49. Sorted by Salary in descending order
SELECT * FROM Employee 
ORDER BY Salary DESC;

-- 50. Sorted by Department (ASC) and then Salary (DESC)
SELECT * FROM Employee 
ORDER BY Department ASC, Salary DESC;