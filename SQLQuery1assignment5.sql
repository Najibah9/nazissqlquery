-- Switch context to master to safely drop and recreate the database
USE master;
GO

-- Drop database if it already exists to start completely fresh
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'CollegeDB')
BEGIN
    ALTER DATABASE CollegeDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE CollegeDB;
END
GO

-- Q1: Create a database for the college records.
CREATE DATABASE CollegeDB;
GO

USE CollegeDB;
GO

-- Q2: Create the Department table.
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);
GO

-- Q3: Create the Student table with all required columns and named Foreign Key constraint.
CREATE TABLE Student (
    RollNo INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL,
    Course VARCHAR(50) NOT NULL,
    Marks DECIMAL(5,2) CHECK (Marks BETWEEN 0 AND 100),
    City VARCHAR(50) NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    Age INT,
    AdmissionDate DATE NOT NULL,
    Fee DECIMAL(10,2) NOT NULL,
    DepartmentID INT,
    CONSTRAINT FK_Student_Department FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);
GO
Step 2: Insert 25 Sample Records
SQL
-- Insert Records into Department
INSERT INTO Department (DepartmentID, DepartmentName) VALUES
(101, 'Computer Science'),
(102, 'Commerce'),
(103, 'Arts'),
(104, 'Management'),
(105, 'Science');
GO

-- Insert 25 Records into Student
INSERT INTO Student (RollNo, StudentName, Course, Marks, City, Gender, Age, AdmissionDate, Fee, DepartmentID) VALUES
(1, 'Aarav Sharma', 'B.Tech', 85.50, 'Delhi', 'M', 20, '2023-07-15', 75000.00, 101),
(2, 'Ananya Sen', 'B.Com', 91.00, 'Kolkata', 'F', 19, '2023-08-01', 45000.00, 102),
(3, 'Rohan Verma', 'B.A', 68.00, 'Mumbai', 'M', 21, '2022-06-10', 30000.00, 103),
(4, 'Priya Patel', 'BBA', 78.25, 'Ahmedabad', 'F', 20, '2023-07-20', 60000.00, 104),
(5, 'Vikram Singh', 'B.Sc', 82.00, 'Jaipur', 'M', 22, '2021-07-11', 50000.00, 105),
(6, 'Neha Gupta', 'B.Tech', 94.50, 'Delhi', 'F', 19, '2023-07-12', 75000.00, 101),
(7, 'Siddharth Nair', 'B.Com', 55.00, 'Kochi', 'M', 20, '2022-08-15', 45000.00, 102),
(8, 'Kavya Reddy', 'B.A', 73.50, 'Hyderabad', 'F', 19, '2023-06-18', 30000.00, 103),
(9, 'Rahul Mehta', 'BBA', 88.00, 'Mumbai', 'M', 21, '2022-07-25', 60000.00, 104),
(10, 'Ishita Roy', 'B.Sc', 62.00, 'Kolkata', 'F', 20, '2022-07-05', 50000.00, 105),
(11, 'Aditya Kumar', 'B.Tech', 49.50, 'Patna', 'M', 21, '2022-07-14', 75000.00, 101),
(12, 'Sneha Joshi', 'B.Com', 81.00, 'Pune', 'F', 19, '2023-08-05', 45000.00, 102),
(13, 'Varun Chopra', 'B.A', 42.00, 'Delhi', 'M', 22, '2021-06-20', 30000.00, 103),
(14, 'Diya Kapoor', 'BBA', 90.00, 'Chandigarh', 'F', 20, '2023-07-22', 60000.00, 104),
(15, 'Karan Malhotra', 'B.Sc', 77.00, 'Lucknow', 'M', 21, '2022-07-01', 50000.00, 105),
(16, 'Riya Das', 'B.Tech', 89.00, 'Kolkata', 'F', 20, '2023-07-10', 75000.00, 101),
(17, 'Aman Trivedi', 'B.Com', 64.50, 'Kanpur', 'M', 22, '2021-08-10', 45000.00, 102),
(18, 'Pooja Bhat', 'B.A', 58.00, 'Bengaluru', 'F', 21, '2022-06-15', 30000.00, 103),
(19, 'Manish Yadav', 'BBA', 71.00, 'Agra', 'M', 20, '2023-07-19', 60000.00, 104),
(20, 'Shreya Saxena', 'B.Sc', 95.00, 'Delhi', 'F', 19, '2023-07-03', 50000.00, 105),
(21, 'Harsh Vardhan', 'B.Tech', 38.00, 'Jaipur', 'M', 22, '2021-07-16', 75000.00, 101),
(22, 'Meera Menon', 'B.Com', 86.50, 'Kochi', 'F', 20, '2022-08-02', 45000.00, 102),
(23, 'Devraj Rao', 'B.A', 66.00, 'Hyderabad', 'M', 19, '2023-06-21', 30000.00, 103),
(24, 'Tanvi Deshmukh', 'BBA', 83.00, 'Mumbai', 'F', 21, '2022-07-28', 60000.00, 104),
(25, 'Gaurav Pandey', 'B.Sc', 74.00, 'Varanasi', 'M', 20, '2022-07-08', 50000.00, 105);
GO
Step 3: Section 1 (DDL Queries Q4 to Q12)
SQL
-- Q4: Add a new column to the Student table to store the student's email address.
ALTER TABLE Student
ADD Email VARCHAR(50);
GO

-- Q5: Modify the data type/size of the email column you just added.
ALTER TABLE Student
ALTER COLUMN Email VARCHAR(100);
GO

-- Q6: Rename the newly added email column to something more suitable.
EXEC sp_rename 'Student.Email', 'StudentEmail', 'COLUMN';
GO

-- Q7: Drop the email column from the Student table.
ALTER TABLE Student
DROP COLUMN StudentEmail;
GO

-- Q8: Rename the Student table to StudentRecords and then rename it back to Student.
EXEC sp_rename 'Student', 'StudentRecords';
GO
EXEC sp_rename 'StudentRecords', 'Student';
GO

-- Q9: Write a query to view the complete structure of the Student table.
EXEC sp_help 'Student';
GO

-- Q10: Write a query to view the complete structure of the Department table.
EXEC sp_help 'Department';
GO

-- Q11: Truncate all the data from the Department table and recreate it.
-- (Must drop FK constraint first, truncate, then re-add FK constraint)
ALTER TABLE Student DROP CONSTRAINT FK_Student_Department;
GO

TRUNCATE TABLE Department;
GO

-- Re-insert Department data so foreign keys function
INSERT INTO Department (DepartmentID, DepartmentName) VALUES
(101, 'Computer Science'),
(102, 'Commerce'),
(103, 'Arts'),
(104, 'Management'),
(105, 'Science');
GO

ALTER TABLE Student
ADD CONSTRAINT FK_Student_Department FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);
GO

-- Q12: Drop the Department table and create it again with the same structure.
-- (Must drop FK constraint first, drop table, recreate table, re-add FK constraint)
ALTER TABLE Student DROP CONSTRAINT FK_Student_Department;
GO

DROP TABLE Department;
GO

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);
GO

ALTER TABLE Student
ADD CONSTRAINT FK_Student_Department FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);
GO

USE CollegeDB;
GO

-- -------------------------------------------------------------
-- Q13: Set the primary key on the Department table.
-- (If PK already exists from table creation, drop existing constraint first or define explicitly)
-- Assuming clean execution:
ALTER TABLE Department 
ADD CONSTRAINT PK_Department PRIMARY KEY (DepartmentID);
GO

-- -------------------------------------------------------------
-- Q14: Set the primary key on the Student table.
ALTER TABLE Student 
ADD CONSTRAINT PK_Student PRIMARY KEY (RollNo);
GO

-- -------------------------------------------------------------
-- Q15: Add a foreign key on the Student table referencing the Department table.
ALTER TABLE Student 
ADD CONSTRAINT FK_Student_Department 
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);
GO

-- -------------------------------------------------------------
-- Q16: Try inserting a student record with a department value that 
--      does not exist in the Department table and observe the result.
INSERT INTO Student (RollNo, StudentName, Course, Marks, City, Gender, Age, AdmissionDate, Fee, DepartmentID) 
VALUES (999, 'Test Student', 'B.Tech', 75.00, 'Delhi', 'M', 20, '2023-08-01', 50000.00, 999);
GO
/*
-- OBSERVED RESULT / ERROR:
-- Msg 547, Level 16, State 0, Line 1
-- The INSERT statement conflicted with the FOREIGN KEY constraint "FK_Student_Department". 
-- The conflict occurred in database "CollegeDB", table "dbo.Department", column 'DepartmentID'.
*/

-- -------------------------------------------------------------
-- Q17: Apply a NOT NULL constraint on the student's name column.
ALTER TABLE Student 
ALTER COLUMN StudentName VARCHAR(100) NOT NULL;
GO

-- -------------------------------------------------------------
-- Q18: Apply a NOT NULL constraint on the course column.
ALTER TABLE Student 
ALTER COLUMN Course VARCHAR(50) NOT NULL;
GO

-- -------------------------------------------------------------
-- Q19: Apply a UNIQUE constraint on the roll number column.
ALTER TABLE Student 
ADD CONSTRAINT UQ_Student_RollNo UNIQUE (RollNo);
GO

-- -------------------------------------------------------------
-- Q20: Apply a UNIQUE constraint on the email column 
--      (add the column again if dropped earlier).
ALTER TABLE Student 
ADD Email VARCHAR(100);
GO

ALTER TABLE Student 
ADD CONSTRAINT UQ_Student_Email UNIQUE (Email);
GO

-- -------------------------------------------------------------
-- Q21: Apply a DEFAULT constraint on the city column with a default value of your choice.
ALTER TABLE Student 
ADD CONSTRAINT DF_Student_City DEFAULT 'Delhi' FOR City;
GO

-- -------------------------------------------------------------
-- Q22: Apply a DEFAULT constraint on the fee column with a default value.
ALTER TABLE Student 
ADD CONSTRAINT DF_Student_Fee DEFAULT 50000.00 FOR Fee;
GO

-- -------------------------------------------------------------
-- Q23: Apply a CHECK constraint on the marks column (between 0 and 100).
ALTER TABLE Student 
ADD CONSTRAINT CK_Student_Marks CHECK (Marks BETWEEN 0 AND 100);
GO

-- -------------------------------------------------------------
-- Q24: Apply a CHECK constraint on the age column (age >= 15).
ALTER TABLE Student 
ADD CONSTRAINT CK_Student_Age CHECK (Age >= 15);
GO

-- -------------------------------------------------------------
-- Q25: Apply a CHECK constraint on the gender column ('M' or 'F').
ALTER TABLE Student 
ADD CONSTRAINT CK_Student_Gender CHECK (Gender IN ('M', 'F'));
GO

-- -------------------------------------------------------------
-- Q26: Remove the CHECK constraint applied on the age column.
ALTER TABLE Student 
DROP CONSTRAINT CK_Student_Age;
GO

-- -------------------------------------------------------------
-- Q27: Remove the UNIQUE constraint applied on the roll number column.
ALTER TABLE Student 
DROP CONSTRAINT UQ_Student_RollNo;
GO

-- -------------------------------------------------------------
-- Q28: Remove the DEFAULT constraint applied on the fee column.
ALTER TABLE Student 
DROP CONSTRAINT DF_Student_Fee;
GO

-- -------------------------------------------------------------
-- Q29: Remove the foreign key constraint from the Student table.
ALTER TABLE Student 
DROP CONSTRAINT FK_Student_Department;
GO

-- -------------------------------------------------------------
-- Q30: Add the foreign key constraint back to the Student table.
ALTER TABLE Student 
ADD CONSTRAINT FK_Student_Department 
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);
GO

-- -------------------------------------------------------------
-- Q31: Remove the primary key from the Department table and then reapply it.
-- Note: Foreign Key referencing Department must be dropped first before dropping Department PK.
ALTER TABLE Student 
DROP CONSTRAINT FK_Student_Department;
GO

-- Drop Primary Key on Department
ALTER TABLE Department 
DROP CONSTRAINT PK_Department;
GO

-- Reapply Primary Key on Department
ALTER TABLE Department 
ADD CONSTRAINT PK_Department PRIMARY KEY (DepartmentID);
GO

-- Reapply Foreign Key on Student
ALTER TABLE Student 
ADD CONSTRAINT FK_Student_Department 
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);
GO

-- -------------------------------------------------------------
-- Q32: Try deleting a department from the Department table that is 
--      still referenced by a student and observe the result.
DELETE FROM Department 
WHERE DepartmentID = 101;
GO
/*
-- OBSERVED RESULT / ERROR:
-- Msg 547, Level 16, State 0, Line 1
-- The DELETE statement conflicted with the REFERENCE constraint "FK_Student_Department". 
-- The conflict occurred in database "CollegeDB", table "dbo.Student", column 'DepartmentID'.
*/

USE CollegeDB;
GO

-- -------------------------------------------------------------
-- Q33: Insert 5 records into the Department table.
-- (Note: If you already inserted these earlier, clear or use new IDs, 
--  or run this directly to populate 5 departments)
INSERT INTO Department (DepartmentID, DepartmentName) VALUES
(101, 'Computer Science'),
(102, 'Commerce'),
(103, 'Arts'),
(104, 'Management'),
(105, 'Science');
GO

-- -------------------------------------------------------------
-- Q34: Insert 20 records into the Student table with varied courses, 
--      cities, marks, and fees.
INSERT INTO Student (RollNo, StudentName, Course, Marks, City, Gender, Age, AdmissionDate, Fee, DepartmentID) VALUES
(1, 'Aarav Sharma', 'B.Tech', 85.50, 'Delhi', 'M', 20, '2023-07-15', 75000.00, 101),
(2, 'Ananya Sen', 'B.Com', 91.00, 'Kolkata', 'F', 19, '2023-08-01', 45000.00, 102),
(3, 'Rohan Verma', 'B.A', 68.00, 'Mumbai', 'M', 21, '2022-06-10', 30000.00, 103),
(4, 'Priya Patel', 'BBA', 78.25, 'Ahmedabad', 'F', 20, '2023-07-20', 60000.00, 104),
(5, 'Vikram Singh', 'B.Sc', 82.00, 'Jaipur', 'M', 22, '2021-07-11', 50000.00, 105),
(6, 'Neha Gupta', 'B.Tech', 94.50, 'Delhi', 'F', 19, '2023-07-12', 75000.00, 101),
(7, 'Siddharth Nair', 'B.Com', 32.00, 'Kochi', 'M', 20, '2022-08-15', 45000.00, 102),
(8, 'Kavya Reddy', 'B.A', 73.50, 'Hyderabad', 'F', 19, '2023-06-18', 30000.00, 103),
(9, 'Rahul Mehta', 'BBA', 88.00, 'Mumbai', 'M', 21, '2022-07-25', 60000.00, 104),
(10, 'Ishita Roy', 'B.Sc', 62.00, 'Kolkata', 'F', 20, '2022-07-05', 50000.00, 105),
(11, 'Aditya Kumar', 'B.Tech', 30.00, 'Patna', 'M', 21, '2022-07-14', 75000.00, 101),
(12, 'Sneha Joshi', 'B.Com', 81.00, 'Pune', 'F', 19, '2023-08-05', 45000.00, 102),
(13, 'Varun Chopra', 'B.A', 42.00, 'Delhi', 'M', 22, '2021-06-20', 30000.00, 103),
(14, 'Diya Kapoor', 'BBA', 90.00, 'Chandigarh', 'F', 20, '2023-07-22', 60000.00, 104),
(15, 'Karan Malhotra', 'B.Sc', 77.00, 'Lucknow', 'M', 21, '2022-07-01', 50000.00, 105),
(16, 'Riya Das', 'B.Tech', 89.00, 'Kolkata', 'F', 20, '2023-07-10', 75000.00, 101),
(17, 'Aman Trivedi', 'B.Com', 64.50, 'Kanpur', 'M', 22, '2021-08-10', 45000.00, 102),
(18, 'Pooja Bhat', 'B.A', 58.00, 'Bengaluru', 'F', 21, '2022-06-15', 30000.00, 103),
(19, 'Manish Yadav', 'BBA', 71.00, 'Agra', 'M', 20, '2023-07-19', 60000.00, 104),
(20, 'Shreya Saxena', 'B.Sc', 95.00, 'Delhi', 'F', 19, '2023-07-03', 50000.00, 105);
GO

-- -------------------------------------------------------------
-- Q35: Insert a record into the Student table without providing 
--      a value for the city column, to check the DEFAULT constraint.
-- (Ensure DF_Student_City default constraint is applied, e.g., 'Delhi')
INSERT INTO Student (RollNo, StudentName, Course, Marks, Gender, Age, AdmissionDate, Fee, DepartmentID) 
VALUES (21, 'Kunal Shah', 'B.Tech', 80.00, 'M', 20, '2023-08-10', 75000.00, 101);
GO

-- -------------------------------------------------------------
-- Q36: Insert a record into the Student table without providing 
--      a value for the fee column, to check the DEFAULT constraint.
-- (Ensure DF_Student_Fee default constraint is applied, e.g., 50000.00)
INSERT INTO Student (RollNo, StudentName, Course, Marks, City, Gender, Age, AdmissionDate, DepartmentID) 
VALUES (22, 'Tarun Bajaj', 'B.Com', 85.00, 'Mumbai', 'M', 19, '2023-08-11', 102);
GO

-- -------------------------------------------------------------
-- Q37: Update the marks of a student whose roll number is a specific value, 
--      increasing it by 5.
UPDATE Student
SET Marks = Marks + 5
WHERE RollNo = 1;
GO

-- -------------------------------------------------------------
-- Q38: Update the fee amount of all students belonging to a particular course.
UPDATE Student
SET Fee = Fee + 2000.00
WHERE Course = 'B.Tech';
GO

-- -------------------------------------------------------------
-- Q39: Update the city of a student from one city to another.
UPDATE Student
SET City = 'Bengaluru'
WHERE RollNo = 3;
GO

-- -------------------------------------------------------------
-- Q40: Update the department of a student to a different valid department.
UPDATE Student
SET DepartmentID = 104
WHERE RollNo = 5;
GO

-- -------------------------------------------------------------
-- Q41: Delete the record of a student with a specific roll number.
DELETE FROM Student
WHERE RollNo = 20;
GO

-- -------------------------------------------------------------
-- Q42: Delete all students whose marks are less than 35.
DELETE FROM Student
WHERE Marks < 35;
GO

-- -------------------------------------------------------------
-- Q43: Delete all students belonging to a particular city.
DELETE FROM Student
WHERE City = 'Jaipur';
GO

-- -------------------------------------------------------------
-- Q44: Insert a record leaving the student name blank (NULL) and check 
--      whether the NOT NULL constraint blocks it.
INSERT INTO Student (RollNo, StudentName, Course, Marks, City, Gender, Age, AdmissionDate, Fee, DepartmentID) 
VALUES (23, NULL, 'B.Tech', 70.00, 'Delhi', 'M', 20, '2023-08-01', 75000.00, 101);
GO
/*
-- OBSERVED RESULT / ERROR:
-- Msg 515, Level 16, State 2, Line 1
-- Cannot insert the value NULL into column 'StudentName', table 'CollegeDB.dbo.Student'; column does not allow nulls. INSERT fails.
*/

-- -------------------------------------------------------------
-- Q45: Insert a record with a duplicate roll number and check whether 
--      the UNIQUE / Primary Key constraint blocks it.
INSERT INTO Student (RollNo, StudentName, Course, Marks, City, Gender, Age, AdmissionDate, Fee, DepartmentID) 
VALUES (1, 'Duplicate Test', 'B.Tech', 70.00, 'Delhi', 'M', 20, '2023-08-01', 75000.00, 101);
GO
/*
-- OBSERVED RESULT / ERROR:
-- Msg 2627, Level 14, State 1, Line 1
-- Violation of PRIMARY KEY constraint 'PK_Student' (or UNIQUE constraint). 
-- Cannot insert duplicate key in object 'dbo.Student'. The duplicate key value is (1).
*/

-- -------------------------------------------------------------
-- Q46: Insert a record with age less than the allowed minimum (e.g., age < 15) 
--      and check whether the CHECK constraint blocks it.
-- (Assumes CK_Student_Age is active: CHECK (Age >= 15))
-- If constraint was dropped in Q26, re-add it first:
-- ALTER TABLE Student ADD CONSTRAINT CK_Student_Age CHECK (Age >= 15);

INSERT INTO Student (RollNo, StudentName, Course, Marks, City, Gender, Age, AdmissionDate, Fee, DepartmentID) 
VALUES (24, 'Child Student', 'B.Tech', 70.00, 'Delhi', 'M', 10, '2023-08-01', 75000.00, 101);
GO
/*
-- OBSERVED RESULT / ERROR:
-- Msg 547, Level 16, State 0, Line 1
-- The INSERT statement conflicted with the CHECK constraint "CK_Student_Age". 
-- The conflict occurred in database "CollegeDB", table "dbo.Student", column 'Age'.
*/

-- -------------------------------------------------------------
-- Q47: Update the marks of a student to a value greater than 100 and check 
--      whether the CHECK constraint blocks it.
-- (Assumes CK_Student_Marks is active: CHECK (Marks BETWEEN 0 AND 100))
UPDATE Student
SET Marks = 105.00
WHERE RollNo = 2;
GO
/*
-- OBSERVED RESULT / ERROR:
-- Msg 547, Level 16, State 0, Line 1
-- The UPDATE statement conflicted with the CHECK constraint "CK_Student_Marks". 
-- The conflict occurred in database "CollegeDB", table "dbo.Student", column 'Marks'.
*/

Section 5: Aggregation Functions — Q63 to Q80
63. Find the total number of students using COUNT.
64. Find the total number of students who belong to the 'Computer Science' course.
65. Find the total fee collected from all students using SUM.
66. Find the total fee collected from students of a specific course.
67. Find the average marks of all students using AVG.
68. Find the average fee paid by students belonging to a specific city.
69. Find the highest marks scored by any student using MAX.
70. Find the lowest marks scored by any student using MIN.
71. Find the highest fee paid by any student.
72. Find the lowest fee paid by any student.
73. Find the average age of all students.
74. Find the total number of distinct courses offered, using COUNT with DISTINCT.
75. Find the total number of distinct cities the students belong to.
76. Find the maximum age among all students.

77. Find the minimum age among all students.
78. Find the sum of marks of all students combined.
79. Find the average marks of only the female students.
80. Find the count of students who scored more than 90 marks.

USE CollegeDB;
GO

-- 81. Display the total number of students in each course, using GROUP BY.
SELECT Course, COUNT(*) AS TotalStudents
FROM Student
GROUP BY Course;
GO

-- 82. Display the average marks of students, grouped by course.
SELECT Course, AVG(Marks) AS AverageMarks
FROM Student
GROUP BY Course;
GO

-- 83. Display the total fee collected, grouped by department.
SELECT DepartmentID, SUM(Fee) AS TotalFee
FROM Student
GROUP BY DepartmentID;
GO

-- 84. Display the maximum marks scored, grouped by city.
SELECT City, MAX(Marks) AS MaxMarks
FROM Student
GROUP BY City;
GO

-- 85. Display the minimum age, grouped by gender.
SELECT Gender, MIN(Age) AS MinAge
FROM Student
GROUP BY Gender;
GO

-- 86. Display the count of students, grouped by city.
SELECT City, COUNT(*) AS StudentCount
FROM Student
GROUP BY City;
GO

-- 87. Display the average fee, grouped by course and city together.
SELECT Course, City, AVG(Fee) AS AverageFee
FROM Student
GROUP BY Course, City;
GO

-- 88. Display the sum of marks, grouped by department.
SELECT DepartmentID, SUM(Marks) AS TotalMarks
FROM Student
GROUP BY DepartmentID;
GO

-- 89. Display courses having more than 5 students enrolled, using HAVING.
SELECT Course, COUNT(*) AS TotalStudents
FROM Student
GROUP BY Course
HAVING COUNT(*) > 5;
GO

-- 90. Display cities having an average fee greater than 15,000, using HAVING.
SELECT City, AVG(Fee) AS AverageFee
FROM Student
GROUP BY City
HAVING AVG(Fee) > 15000;
GO

-- 91. Display departments having a total student count greater than 3, using HAVING.
SELECT DepartmentID, COUNT(*) AS TotalStudents
FROM Student
GROUP BY DepartmentID
HAVING COUNT(*) > 3;
GO

-- 92. Display courses having an average marks greater than 70, using HAVING.
SELECT Course, AVG(Marks) AS AverageMarks
FROM Student
GROUP BY Course
HAVING AVG(Marks) > 70;
GO

-- 93. Display genders having a maximum marks value greater than 95, using HAVING.
SELECT Gender, MAX(Marks) AS MaxMarks
FROM Student
GROUP BY Gender
HAVING MAX(Marks) > 95;
GO

-- 94. Display all student records sorted by marks in descending order, using ORDER BY.
SELECT *
FROM Student
ORDER BY Marks DESC;
GO

-- 95. Display all student records sorted by fee in ascending order.
SELECT *
FROM Student
ORDER BY Fee ASC;
GO

-- 96. Display all student records sorted by course (ascending) and then marks (descending).
SELECT *
FROM Student
ORDER BY Course ASC, Marks DESC;
GO

-- 97. Display all student records sorted by admission date, showing the most recently admitted students first.
SELECT *
FROM Student
ORDER BY AdmissionDate DESC;
GO

-- 98. Display the top 10 students with the highest marks, using ORDER BY along with a row-limiting clause.
SELECT TOP 10 *
FROM Student
ORDER BY Marks DESC;
GO

-- 99. Display all distinct courses sorted alphabetically.
SELECT DISTINCT Course
FROM Student
ORDER BY Course ASC;
GO

-- 100. Display department-wise student count sorted from highest to lowest count, combining GROUP BY and ORDER BY.
SELECT DepartmentID, COUNT(*) AS StudentCount
FROM Student
GROUP BY DepartmentID
ORDER BY StudentCount DESC;
GO