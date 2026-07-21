IF OBJECT_ID('Employees', 'U') IS NOT NULL
BEGIN
    PRINT 'Dropping existing Employees table...';
    DROP TABLE Employees;
END
GO

PRINT '========== CREATING EMPLOYEES TABLE ==========';

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10, 2) NULL,
    JoinDate DATE,
    Position VARCHAR(100)
);

PRINT 'Table created successfully!';
PRINT CHAR(10);
GO


PRINT '========== INSERTING INITIAL SAMPLE DATA ==========';

INSERT INTO Employees VALUES
(101, 'Adaeline', 'Cloud', 70000, '2023-01-10', 'Senior Developer'),
(102, 'john doe', 'Cloud', 65000, '2023-02-15', 'Developer'),
(103, 'Jessica Vu', 'AI', 80000, '2023-03-20', 'ML Engineer'),
(104, 'Lebron Brown', 'AI', 75000, '2023-04-10', 'Data Scientist'),
(105, 'Soo hyun', 'Finance', 60000, '2023-05-05', 'Accountant'),
(106, 'Nessa Barret', 'Finance', 15000, '2023-06-15', 'Junior Accountant'),
(107, 'Adam eve', 'HR', 58000, '2023-07-20', 'HR Manager');

PRINT 'Initial data inserted!';
PRINT 'Rows affected: ' + CAST(@@ROWCOUNT AS VARCHAR);
PRINT CHAR(10);


PRINT '========== INITIAL DATA ==========';
SELECT * FROM Employees ORDER BY Department, EmployeeID;
PRINT CHAR(10);
GO


PRINT '========== OPERATION 1: INSERT Single Employee ==========';
PRINT 'Inserting: Henry Wilson | Cloud | $72,000 | Developer';

INSERT INTO Employees (EmployeeID, EmployeeName, Department, Salary, JoinDate, Position)
VALUES (201, 'Henry Wilson', 'Cloud', 72000, '2024-01-15', 'Developer');

PRINT 'Result: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' row(s) inserted';
SELECT * FROM Employees WHERE EmployeeID = 201;
PRINT CHAR(10);
GO

PRINT '========== OPERATION 2: INSERT Multiple HR Employees ==========';
PRINT 'Inserting 3 new HR team members...';

INSERT INTO Employees (EmployeeID, EmployeeName, Department, Salary, JoinDate, Position)
VALUES 
    (202, 'Icarus Light', 'HR', 62000, '2024-02-01', 'HR Specialist'),
    (203, 'Jack Pirates', 'HR', 55000, '2024-02-10', 'Recruiter'),
    (204, 'Hannah Baker', 'HR', 60000, '2024-02-15', 'HR Coordinator');

PRINT 'Result: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows inserted';
SELECT * FROM Employees WHERE Department = 'HR' ORDER BY EmployeeID;
PRINT CHAR(10);
GO


PRINT '========== OPERATION 3: INSERT Employee WITHOUT Salary (NULL) ==========';
PRINT 'Inserting employees with NULL salary (to be assigned later)...';

INSERT INTO Employees (EmployeeID, EmployeeName, Department, JoinDate, Position, Salary)
VALUES 
    (301, 'jennie Garcia', 'Cloud', '2024-03-01', 'Junior Developer', NULL),
    (302, 'olivia Rodriguez', 'AI', '2024-03-05', 'Data Analyst', NULL);

PRINT 'Result: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows inserted';
PRINT 'Employees with NULL salary:';
SELECT * FROM Employees WHERE Salary IS NULL;
PRINT CHAR(10);
GO

PRINT '========== OPERATION 4: UPDATE Cloud Department Salaries to $85,000 ==========';
PRINT 'BEFORE UPDATE:';
SELECT EmployeeID, EmployeeName, Department, Salary FROM Employees WHERE Department = 'Cloud' ORDER BY EmployeeID;

UPDATE Employees
SET Salary = 85000
WHERE Department = 'Cloud';

PRINT CHAR(10) + 'Result: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows updated';
PRINT 'AFTER UPDATE:';
SELECT EmployeeID, EmployeeName, Department, Salary FROM Employees WHERE Department = 'Cloud' ORDER BY EmployeeID;
PRINT CHAR(10);
GO


PRINT '========== OPERATION 5: UPDATE Employee Department & Salary by Name ==========';
PRINT 'Updating Alice Johnson: Department -> AI, Salary -> $88,000';
PRINT 'BEFORE UPDATE:';
SELECT EmployeeID, EmployeeName, Department, Salary, Position FROM Employees WHERE EmployeeName = 'Adaeline';

UPDATE Employees
SET Department = 'AI', 
    Salary = 88000
WHERE EmployeeName = 'Adaeline';

PRINT CHAR(10) + 'Result: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows updated';
PRINT 'AFTER UPDATE:';
SELECT EmployeeID, EmployeeName, Department, Salary, Position FROM Employees WHERE EmployeeName = 'Adaeline';
PRINT CHAR(10);
GO


PRINT '========== OPERATION 6: 10% APPRAISAL BOOST for AI Department ==========';
PRINT 'BEFORE APPRAISAL:';
SELECT EmployeeID, EmployeeName, Department, Salary FROM Employees WHERE Department = 'AI' ORDER BY EmployeeID;

UPDATE Employees
SET Salary = Salary * 1.10
WHERE Department = 'AI' AND Salary IS NOT NULL;

PRINT CHAR(10) + 'Result: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows updated (Salary * 1.10)';
PRINT 'AFTER 10% BOOST:';
SELECT EmployeeID, EmployeeName, Department, Salary FROM Employees WHERE Department = 'AI' ORDER BY EmployeeID;
PRINT CHAR(10);
GO


PRINT '========== OPERATION 7: ASSIGN $30,000 to All NULL Salaries ==========';
PRINT 'BEFORE:';
SELECT EmployeeID, EmployeeName, Department, Position, Salary FROM Employees WHERE Salary IS NULL;

UPDATE Employees
SET Salary = 30000
WHERE Salary IS NULL;

PRINT CHAR(10) + 'Result: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows updated';
PRINT 'AFTER - Updated employees:';
SELECT EmployeeID, EmployeeName, Department, Position, Salary FROM Employees WHERE EmployeeID IN (301, 302);
PRINT CHAR(10);
GO


PRINT '========== OPERATION 8: DELETE Specific Employee by ID ==========';
PRINT 'Deleting employee ID 301 (Leo Garcia)...';
PRINT 'BEFORE DELETE:';
SELECT * FROM Employees WHERE EmployeeID = 301;

DELETE FROM Employees
WHERE EmployeeID = 301;

PRINT CHAR(10) + 'Result: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' row(s) deleted';
PRINT 'VERIFICATION (employee should not exist):';
SELECT COUNT(*) as EmployeeCount FROM Employees WHERE EmployeeID = 301;
PRINT CHAR(10);
GO


PRINT '========== OPERATION 9: DELETE Entire Department (HR shutdown) ==========';
PRINT 'HR Department employees BEFORE deletion:';
SELECT COUNT(*) as HREmployeeCount FROM Employees WHERE Department = 'HR';
SELECT EmployeeID, EmployeeName, Department FROM Employees WHERE Department = 'HR' ORDER BY EmployeeID;

DELETE FROM Employees
WHERE Department = 'HR';

PRINT CHAR(10) + 'Result: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' row(s) deleted';
PRINT 'VERIFICATION (all HR employees should be gone):';
SELECT COUNT(*) as HREmployeeCount FROM Employees WHERE Department = 'HR';
PRINT CHAR(10);
GO


PRINT '========== OPERATION 10: DELETE Low-Salary Finance Employees (<$20,000) ==========';
PRINT 'Finance Department employees BEFORE deletion:';
SELECT EmployeeID, EmployeeName, Department, Salary FROM Employees WHERE Department = 'Finance' ORDER BY Salary;

DELETE FROM Employees
WHERE Department = 'Finance' AND Salary < 20000;

PRINT CHAR(10) + 'Result: ' + CAST(@@ROWCOUNT AS VARCHAR) + ' row(s) deleted';
PRINT 'Finance Department employees AFTER deletion:';
SELECT EmployeeID, EmployeeName, Department, Salary FROM Employees WHERE Department = 'Finance' ORDER BY Salary;
PRINT CHAR(10);
GO


PRINT CHAR(10) + '========== FINAL DATA AFTER ALL OPERATIONS ==========';
SELECT * FROM Employees ORDER BY Department, EmployeeID;

PRINT CHAR(10) + '========== SUMMARY STATISTICS ==========';
SELECT 
    Department,
    COUNT(*) as EmployeeCount,
    MIN(Salary) as MinSalary,
    MAX(Salary) as MaxSalary,
    AVG(Salary) as AvgSalary,
    SUM(Salary) as TotalPayroll
FROM Employees
GROUP BY Department
ORDER BY Department;

PRINT CHAR(10) + '========== TOTAL EMPLOYEES ==========';
SELECT COUNT(*) as TotalEmployees FROM Employees;

PRINT CHAR(10) + '✅ ALL 10 OPERATIONS COMPLETED SUCCESSFULLY!';
PRINT '========== END OF SCRIPT ==========';
GO
