
DECLARE @SqlStmt NVARCHAR(MAX) = '';

SELECT @SqlStmt += 'ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(parent_object_id)) 
    + '.' + QUOTENAME(OBJECT_NAME(parent_object_id)) 
    + ' DROP CONSTRAINT ' + QUOTENAME(name) + ';' + CHAR(13)
FROM sys.foreign_keys
WHERE referenced_object_id = OBJECT_ID('Department');

IF @SqlStmt <> '' 
    EXEC sp_executesql @SqlStmt;


DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100),
    Location VARCHAR(100)
);

CREATE TABLE Employee (
    EID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    Salary DECIMAL(10, 2),
    DeptID INT,
    CONSTRAINT FK_Employee_Department FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    Status VARCHAR(50)
);

-- 1. Get Employees by Department and Minimum Salary
CREATE OR ALTER PROCEDURE GetEmployeesByDeptAndSalary
    @DeptID INT,
    @MinSalary DECIMAL(10, 2)
AS
BEGIN
    SELECT * 
    FROM Employee
    WHERE DeptID = @DeptID AND Salary > @MinSalary;
END;
GO

-- 2. Get Total Employee Count in a Department (OUTPUT Parameter)
CREATE OR ALTER PROCEDURE GetEmployeeCountByDept
    @DeptID INT,
    @TotalEmployees INT OUTPUT
AS
BEGIN
    SELECT @TotalEmployees = COUNT(*)
    FROM Employee
    WHERE DeptID = @DeptID;
END;
GO

-- 3. Update Employee Salary by Percentage
CREATE OR ALTER PROCEDURE IncreaseEmployeeSalaryByPercent
    @EID INT,
    @PercentageIncrease DECIMAL(5, 2)
AS
BEGIN
    UPDATE Employee
    SET Salary = Salary + (Salary * (@PercentageIncrease / 100.0))
    WHERE EID = @EID;
END;
GO

-- 4. Insert New Department Record
CREATE OR ALTER PROCEDURE InsertDepartment
    @DeptID INT,
    @DeptName VARCHAR(100),
    @Location VARCHAR(100)
AS
BEGIN
    INSERT INTO Department (DeptID, DeptName, Location)
    VALUES (@DeptID, @DeptName, @Location);
END;
GO

-- 5. Update Employee Salary to Specific Value
CREATE OR ALTER PROCEDURE UpdateEmployeeSalary
    @EID INT,
    @NewSalary DECIMAL(10, 2)
AS
BEGIN
    UPDATE Employee
    SET Salary = @NewSalary
    WHERE EID = @EID;
END;
GO

-- 6. Search Employees by Starting Letter
CREATE OR ALTER PROCEDURE SearchEmployeesByNamePrefix
    @SearchString VARCHAR(10)
AS
BEGIN
    SELECT * 
    FROM Employee
    WHERE EmpName LIKE @SearchString + '%';
END;
GO

-- 7. Get Average Salary of All Employees
CREATE OR ALTER PROCEDURE GetAverageSalary
AS
BEGIN
    SELECT AVG(Salary) AS AverageSalary
    FROM Employee;
END;
GO

-- 8. Get Employees Within Salary Range
CREATE OR ALTER PROCEDURE GetEmployeesBySalaryRange
    @MinSalary DECIMAL(10, 2),
    @MaxSalary DECIMAL(10, 2)
AS
BEGIN
    SELECT * 
    FROM Employee
    WHERE Salary BETWEEN @MinSalary AND @MaxSalary;
END;
GO

-- 9. Update Project Status
CREATE OR ALTER PROCEDURE UpdateProjectStatus
    @ProjectID INT,
    @NewStatus VARCHAR(50)
AS
BEGIN
    UPDATE Project
    SET Status = @NewStatus
    WHERE ProjectID = @ProjectID;
END;
GO

-- 10. Get Department Count by Location
CREATE OR ALTER PROCEDURE GetDepartmentCountByLocation
    @Location VARCHAR(100)
AS
BEGIN
    SELECT COUNT(*) AS DepartmentCount
    FROM Department
    WHERE Location = @Location;
END;
GO