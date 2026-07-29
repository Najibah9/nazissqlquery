-- Drop existing tables first
IF OBJECT_ID('Employee', 'U') IS NOT NULL
    DROP TABLE Employee;

IF OBJECT_ID('Departments', 'U') IS NOT NULL
    DROP TABLE Departments;

-- Create Departments table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL UNIQUE,
    location VARCHAR(50) NOT NULL,
    budget DECIMAL(12,2) CHECK (budget >= 0)
);

-- Create Employee table
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    department_id INT,
    designation VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) CHECK (salary > 0),
    join_date DATE NOT NULL,
    manager_id INT,
    CONSTRAINT fk_department
        FOREIGN KEY (department_id)
        REFERENCES Departments(department_id),
    CONSTRAINT fk_manager
        FOREIGN KEY (manager_id)
        REFERENCES Employee(emp_id)
);
-- Insert Departments
INSERT INTO Departments VALUES
(101, 'HR', 'Ahmedabad', 500000),
(102, 'IT', 'Vadodara', 1200000),
(103, 'Finance', 'Surat', 800000),
(104, 'Marketing', 'Rajkot', 600000);

-- Insert Employees
INSERT INTO Employee VALUES
(1, 'Amit', 102, 'Software Engineer', 60000, '2023-01-10', NULL),
(2, 'Priya', 101, 'HR Executive', 45000, '2022-06-15', 1),
(3, 'Rahul', 103, 'Accountant', 50000, '2021-08-20', 1),
(4, 'Sneha', NULL, 'Intern', 20000, '2024-02-01', 2),
(5, 'Rohan', 102, 'Developer', 55000, '2023-07-18', 1);
SELECT * FROM Departments;

SELECT * FROM Employee;


SELECT e.emp_name, d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id;

SELECT e.emp_name, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id;

SELECT e.emp_name,
       e.designation,
       d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id;

SELECT d.department_name,
       d.location,
       e.emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

SELECT e.emp_name, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id;

SELECT e.emp_name, e.salary, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id;

SELECT e.emp_name, e.salary, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id;

SELECT e.emp_name, e.salary, d.department_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

SELECT d.department_name, d.budget, e.emp_name, e.salary
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

SELECT e.*, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id;

SELECT e.emp_name, e.designation, d.location
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id;

SELECT d.department_name, COUNT(e.emp_id) AS Employee_Count
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id
GROUP BY d.department_name;

SELECT e.emp_name, e.join_date, d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id;

SELECT d.department_name, e.emp_name, e.salary
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

SELECT e.emp_name, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id;

SELECT e.emp_name, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id;

SELECT e.emp_name, d.department_name, d.budget
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id
WHERE d.budget > 2000000;

SELECT d.department_name, d.location, e.emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

SELECT e.emp_name, e.designation, d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id;

SELECT e.emp_name, d.location
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id;

SELECT d.department_name, e.emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

SELECT e.emp_name, e.salary, d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id;

SELECT e.emp_name, e.manager_id, d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id;

SELECT d.department_name, d.budget, e.emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

SELECT e.emp_name, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id;

SELECT d.department_name, d.location, e.emp_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id;

-- 25
SELECT d.department_name, e.emp_name, e.designation
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

-- 26
SELECT e.emp_name, d.department_name, e.join_date
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id;

-- 27
SELECT e.*, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id;

-- 28
SELECT d.department_name, d.budget, e.emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

-- 29
SELECT e.emp_name, e.salary
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id
WHERE d.budget > 3000000;

-- 30
SELECT e.*, d.department_name, d.location
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id;

-- 31
SELECT d.department_name, e.emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

-- 32
SELECT e.emp_name, e.designation, d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id;

-- 33
SELECT d.department_name, d.budget, e.emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

-- 34
SELECT e.emp_name, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id;

-- 35
SELECT e.emp_name, e.salary, d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id;

-- 36
SELECT d.*, e.emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

-- 37
SELECT e.emp_name, d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id;

-- 38
SELECT e.emp_name, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id;

-- 39
SELECT d.department_name, d.location, e.emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

-- 40
SELECT e.emp_name, e.designation, d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id;

-- 41
SELECT e.emp_name, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id;

-- 42
SELECT d.department_name, e.emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

-- 43
SELECT e.emp_name, e.salary, d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id;

-- 44
SELECT e.*, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id;

-- 45
SELECT d.department_name, e.emp_name, d.location, d.budget
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

-- 46
SELECT e.emp_name, d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id;

-- 47
SELECT e.emp_name, e.designation, d.department_name
FROM Employee e
LEFT JOIN Departments d
ON e.department_id = d.department_id;

-- 48
SELECT d.department_name, d.budget, e.emp_name
FROM Departments d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

-- 49
SELECT e.emp_name, d.department_name
FROM Employee e
INNER JOIN Departments d
ON e.department_id = d.department_id;

-- 50
SELECT e.emp_name, d.department_name
FROM Employee e
FULL OUTER JOIN Departments d
ON e.department_id = d.department_id;