-- Drop existing tables and views to avoid errors
DROP VIEW IF EXISTS HighPaidEmployees;
DROP VIEW IF EXISTS EmployeeDepartmentView;
DROP VIEW IF EXISTS HRView;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

-- Step 1: Create Tables
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary INT,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

-- Step 2: Insert Sample Data
INSERT INTO Departments VALUES
(1, 'HR'), (2, 'IT'), (3, 'Finance');

INSERT INTO Employees VALUES
(101, 'Alice', 60000, 1),
(102, 'Bob', 50000, 2),
(103, 'Charlie', 45000, 2),
(104, 'David', 70000, 3),
(105, 'Eva', 30000, 1);

-- Step 3: Create Basic View
CREATE VIEW AllEmployees AS
SELECT EmpID, EmpName, Salary, DeptID
FROM Employees;

-- Step 4: Create a View with a Filter
CREATE VIEW HighPaidEmployees AS
SELECT EmpName, Salary
FROM Employees
WHERE Salary > 50000;

-- Step 5: Create a JOIN View
CREATE VIEW EmployeeDepartmentView AS
SELECT E.EmpName, E.Salary, D.DeptName
FROM Employees E
JOIN Departments D ON E.DeptID = D.DeptID;

-- Step 6: Create View with WITH CHECK OPTION
CREATE VIEW HRView AS
SELECT * FROM Employees
WHERE DeptID = 1
WITH CHECK OPTION;

-- Step 7: Try inserting into HRView (only works if DeptID = 1)
-- This will succeed
INSERT INTO HRView VALUES (106, 'Farah', 40000, 1);

-- This will fail (because DeptID ≠ 1)
-- INSERT INTO HRView VALUES (107, 'George', 40000, 2);

-- Step 8: Drop a View
-- DROP VIEW IF EXISTS HighPaidEmployees;

-- Step 9: Query Views
SELECT * FROM AllEmployees;
SELECT * FROM HighPaidEmployees;
SELECT * FROM EmployeeDepartmentView;
SELECT * FROM HRView;