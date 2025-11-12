-- ==========================================================
-- PROJECT TITLE: Employee Management System (Simple Version)
-- TECHNOLOGY: MySQL
-- AUTHOR: Vaishnavi Mudiraj
-- ==========================================================

-- Drop existing tables if they exist (to avoid duplicates)
DROP TABLE IF EXISTS Salary_Log;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;

-- 1️⃣ Create Department Table
CREATE TABLE Department (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

-- 2️⃣ Create Employee Table
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    job_title VARCHAR(50),
    salary DECIMAL(10,2),
    dept_id INT,
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- 3️⃣ Create Salary_Log Table (manual logging instead of trigger)
CREATE TABLE Salary_Log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    changed_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);

-- 4️⃣ Insert Data into Department
INSERT INTO Department (dept_name, location) VALUES
('HR', 'Hyderabad'),
('Finance', 'Mumbai'),
('IT', 'Bangalore'),
('Marketing', 'Chennai');

-- 5️⃣ Insert Data into Employee
INSERT INTO Employee (emp_name, job_title, salary, dept_id, hire_date) VALUES
('Vaishnavi Mudiraj', 'HR Executive', 35000, 1, '2022-02-12'),
('Karthik Rao', 'Software Engineer', 55000, 3, '2021-07-05'),
('Suresh Kumar', 'Accountant', 45000, 2, '2020-03-15'),
('Priya Sharma', 'Marketing Lead', 50000, 4, '2023-01-10');

-- ==========================================================
-- 🔹 BASIC SQL QUERIES
-- ==========================================================

-- Show all employees
SELECT * FROM Employee;

-- Show all departments
SELECT * FROM Department;

-- ==========================================================
-- 🔹 JOINS
-- ==========================================================

-- INNER JOIN: Show employees with their department names
SELECT 
    e.emp_id, e.emp_name, e.job_title, e.salary, d.dept_name
FROM 
    Employee e
INNER JOIN 
    Department d 
ON 
    e.dept_id = d.dept_id;

-- LEFT JOIN: Show all employees even if department is missing
SELECT 
    e.emp_name, d.dept_name
FROM 
    Employee e
LEFT JOIN 
    Department d 
ON 
    e.dept_id = d.dept_id;

-- GROUP BY Example: Average salary per department
SELECT 
    d.dept_name, AVG(e.salary) AS avg_salary
FROM 
    Employee e
JOIN 
    Department d 
ON 
    e.dept_id = d.dept_id
GROUP BY 
    d.dept_name;

-- ==========================================================
-- 🔹 MANUAL SALARY LOG (Instead of Trigger)
-- ==========================================================

-- Simulate a salary update and log it manually
UPDATE Employee SET salary = 60000 WHERE emp_id = 2;

-- Log the change manually (this replaces trigger)
INSERT INTO Salary_Log (emp_id, old_salary, new_salary)
VALUES (2, 55000, 60000);

-- Check Salary Log table
SELECT * FROM Salary_Log;


CREATE VIEW Employee_Department_View AS
SELECT 
    e.emp_name, e.job_title, e.salary, d.dept_name
FROM 
    Employee e
JOIN 
    Department d ON e.dept_id = d.dept_id;

-- Show the view
SELECT * FROM Employee_Department_View;


