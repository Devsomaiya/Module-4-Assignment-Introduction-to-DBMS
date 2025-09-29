-- >------------------------->1   1
CREATE DATABASE IF NOT EXISTS school_db;
USE school_db;


CREATE TABLE students(
student_id    VARCHAR(10) PRIMARY KEY ,
student_name  VARCHAR(20) NOT NULL,
age           INT ,
class         VARCHAR(10) ,
address       VARCHAR(50) 
);

-- >------------------------->1   2
INSERT INTO students (student_id, student_name, age, class,address) 
VALUES
("101", "dev"     ,25  ,"1"  ,"gandhinagar"),
("102", "jainam"  ,19  ,"2"  ,"ahmedabad"),
("103", "harshid" ,21  ,"1"  ,"surendranagar"),
("104", "hardik"  ,21  ,"1"  ,"junagadh"),
("105", "aman"    ,24  ,"2"  ,"gwalior");


SELECT * FROM students;





--  **********************************************************

-- >------------------------->2   1 
SELECT student_name , age FROM students;

-- >------------------------->2   2
SELECT *FROM students WHERE age>10;






--  **********************************************************

-- >------------------------->3   1   --Create the teachers table

CREATE TABLE teachers (
teacher_id      VARCHAR(20) PRIMARY KEY    ,
teacher_name    VARCHAR(50) NOT NULL       ,
subject         VARCHAR(20) NOT NULL       ,
email           VARCHAR(30) UNIQUE
);

-- >------------------------->3   2   --Add teacher_id column to students table
ALTER TABLE students
ADD teacher_id VARCHAR(20);

-- Add foreign key constraint to link students with teachers
ALTER TABLE students
ADD CONSTRAINT fk_teacher
FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id);






--  **********************************************************

-- >-------------------------> 4   1 --Create a table courses with columns: course_id, course_name, and 
-- course_credits. Set the course_id as the primary key. 
-- Create the courses table
CREATE TABLE courses (
    course_id     VARCHAR(10) PRIMARY KEY,
    course_name   VARCHAR(50) NOT NULL,
    course_credits INT NOT NULL
);


-- >-------------------------> 4   2 -- Use the CREATE command to create a database university_db. 
-- Create a new database named university_db
CREATE DATABASE IF NOT EXISTS university_db;






--  **********************************************************

-- >-------------------------> 5   1 --Modify the courses table by adding a column course_duration using the ALTER command.
-- Add a new column course_duration to the courses table
ALTER TABLE courses
ADD course_duration VARCHAR(20);

-- >-------------------------> 5   2  -- Drop the course_credits column from the courses table.
-- Remove the course_credits column from the courses table
ALTER TABLE courses
DROP COLUMN course_credits;






--  **********************************************************

 -- 6 Lab 1: Drop the teachers table from the school_db database. 
 -- 6 Lab 2: Drop the students table from the school_db database and verify that the table has been removed. 

-- >-------------------------> 6   2
-- Drop the students table from school_db
DROP TABLE IF EXISTS students;

-- >-------------------------> 6   1
-- Drop the teachers table from school_db
DROP TABLE IF EXISTS teachers;



-- Verify the tables in school_db
SHOW TABLES;







--  **********************************************************
-- 7 Lab 1: Insert three records into the courses table using the INSERT command. 
-- 7 Lab 2: Update the course duration of a specific course using the UPDATE command. 
-- 7 Lab 3: Delete a course with a specific course_id from the courses table using the DELETE command. 

-- >-------------------------> 7   1
-- Insert 3 records into the courses table
INSERT INTO courses (course_id, course_name, course_duration)
VALUES
("C101", "Mathematics", "6 months"),
("C102", "Physics", "4 months"),
("C103", "Computer Science", "8 months");


-- >-------------------------> 7  2
-- Update the course_duration of course C102
UPDATE courses
SET course_duration = "5 months"
WHERE course_id = "C102";


-- >-------------------------> 7   3
-- Delete course with course_id C103
DELETE FROM courses
WHERE course_id = "C103";

SELECT * FROM courses;








--  **********************************************************
-- 8 Lab 1: Retrieve all courses from the courses table using the SELECT statement. 
-- 8 Lab 2: Sort the courses based on course_duration in descending order using ORDER BY. 
-- 8 Lab 3: Limit the results of the SELECT query to show only the top two courses using LIMIT. 

-- >-------------------------> 8   1
-- Retrieve all records from the courses table
SELECT * FROM courses;

-- >-------------------------> 8  2
-- Sort courses based on course_duration in descending order
SELECT * FROM courses
ORDER BY course_duration DESC;

-- >-------------------------> 83
-- Retrieve only the top 2 courses
SELECT * FROM courses LIMIT 2;







--  **********************************************************
 
-- 9 Lab 1: Create two new users user1 and user2 and grant user1 permission to SELECT from the courses table. 
-- 9 Lab 2: Revoke the INSERT permission from user1 and give it to user2. 


-- >-------------------------> 9   1

DROP USER IF EXISTS 'user1'@'localhost';
DROP USER IF EXISTS 'user2'@'localhost';
-- Create new users
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'password1';
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'password2';

-- Grant SELECT permission on courses table to user1
GRANT SELECT ON school_db.courses TO 'user1'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;

-- >-------------------------> 9   2

-- Revoke INSERT permission from user1 (if previously granted)
REVOKE INSERT ON school_db.courses FROM 'user1'@'localhost';

-- Grant INSERT permission on courses table to user2
GRANT INSERT ON school_db.courses TO 'user2'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;









--  **********************************************************
-- 10 Lab 1: Insert a few rows into the courses table and use COMMIT to save the changes. 
-- 10 Lab 2: Insert additional rows, then use ROLLBACK to undo the last insert operation. 
-- 10 Lab 3: Create a SAVEPOINT before updating the courses table, and use it to roll back specific changes. 

-- >-------------------------> 10 1
-- Start a transaction
START TRANSACTION;

-- Insert a few rows into courses table
INSERT INTO courses (course_id, course_name, course_duration) 
VALUES
("C104", "Chemistry", "6 months"),
("C105", "Biology", "5 months");

-- Commit the transaction to save changes
COMMIT;


-- >-------------------------> 10 2
-- Start a new transaction
START TRANSACTION;

-- Insert additional rows
INSERT INTO courses (course_id, course_name, course_duration) 
VALUES
("C106", "English", "4 months"),
("C107", "History", "3 months");

-- Rollback to undo the last insert operation
ROLLBACK;

SELECT * FROM courses;


-- >-------------------------> 10 3
-- Start a transaction
START TRANSACTION;

-- Update some courses
UPDATE courses
SET course_duration = "7 months"
WHERE course_id = "C104";

-- Create a savepoint
SAVEPOINT before_update;

-- Update another course
UPDATE courses
SET course_duration = "6 months"
WHERE course_id = "C105";

-- Rollback to savepoint (undo only the last update)
ROLLBACK TO SAVEPOINT before_update;

-- Commit the remaining changes
COMMIT;










--  **********************************************************
 
-- 11 Lab 1: Create two tables: departments and employees. Perform an INNER JOIN to 
-- display employees along with their respective departments. 
-- 11 Lab 2: Use a LEFT JOIN to show all departments, even those without employees. 


-- >-------------------------> 11 1
-- Create departments table
CREATE TABLE departments (
    dept_id   VARCHAR(10) PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- Create employees table
CREATE TABLE employees (
    emp_id    VARCHAR(10) PRIMARY KEY,
    emp_name  VARCHAR(50) NOT NULL,
    dept_id   VARCHAR(10),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Insert sample data into departments
INSERT INTO departments (dept_id, dept_name) VALUES
("D01", "HR"),
("D02", "Finance"),
("D03", "IT");

-- Insert sample data into employees
INSERT INTO employees (emp_id, emp_name, dept_id) VALUES
("E101", "Alice", "D01"),
("E102", "Bob", "D02"),
("E103", "Charlie", "D03");

-- Perform INNER JOIN to display employees with their departments
SELECT e.emp_id, e.emp_name, d.dept_name
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;




-- >-------------------------> 11 2
-- Perform LEFT JOIN to show all departments, even those without employees
SELECT d.dept_id, d.dept_name, e.emp_name
FROM departments d
LEFT JOIN employees e
ON d.dept_id = e.dept_id;









--  **********************************************************

-- 12 Lab 1: Group employees by department and count the number of employees in each 
-- department using GROUP BY. 
-- 12 Lab 2: Use the AVG aggregate function to find the average salary of employees in each 
-- department. 

-- >-------------------------> 12 1
-- Assuming the employees table has a dept_id column
SELECT d.dept_name, COUNT(e.emp_id) AS total_employees
FROM departments d
INNER JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;


-- >-------------------------> 12 2
SET SQL_SAFE_UPDATES = 0; 

-- First, add a salary column to employees table if not already present
ALTER TABLE employees
ADD salary DECIMAL(10,2);

-- Insert sample salary data (if not already present)
UPDATE employees
SET salary = CASE emp_id
    WHEN 'E101' THEN 50000
    WHEN 'E102' THEN 60000
    WHEN 'E103' THEN 55000
END;

-- Calculate average salary by department
SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM departments d
INNER JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;







--  **********************************************************
-- 13 Lab 1: Write a stored procedure to retrieve all employees from the employees table based 
-- on department. 
-- 13 Lab 2: Write a stored procedure that accepts course_id as input and returns the course 
-- details. 


-- >-------------------------> 13 1
-- Create a stored procedure to get employees based on department name
DELIMITER //

CREATE PROCEDURE GetEmployeesByDept(IN deptName VARCHAR(50))
BEGIN
    SELECT e.emp_id, e.emp_name, e.salary, d.dept_name
    FROM employees e
    INNER JOIN departments d ON e.dept_id = d.dept_id
    WHERE d.dept_name = deptName;
END //

DELIMITER ;

-- Example call:
CALL GetEmployeesByDept('IT');


-- >-------------------------> 13 2
-- Create a stored procedure to get course details based on course_id
DELIMITER //

CREATE PROCEDURE GetCourseDetails(IN c_id VARCHAR(10))
BEGIN
    SELECT * 
    FROM courses
    WHERE course_id = c_id;
END //

DELIMITER ;

-- Example call:
CALL GetCourseDetails('C101');








--  **********************************************************
 
-- 14 Lab 1: Create a view to show all employees along with their department names. 
-- 14 Lab 2: Modify the view to exclude employees whose salaries are below $50,000. 

-- >-------------------------> 14 1 
-- Create a view to display employees with their department names
CREATE VIEW EmployeeDeptView AS
SELECT e.emp_id, e.emp_name, e.salary, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

-- Query the view
SELECT * FROM EmployeeDeptView;



-- >-------------------------> 14 2
-- Drop the existing view first (MySQL does not allow direct modification)
DROP VIEW IF EXISTS EmployeeDeptView;

-- Recreate the view with the salary condition
CREATE VIEW EmployeeDeptView AS
SELECT e.emp_id, e.emp_name, e.salary, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary >= 50000;

-- Query the updated view
SELECT * FROM EmployeeDeptView;





--  **********************************************************

-- 15 Lab 1: Create a trigger to automatically log changes to the employees table when a new 
-- employee is added. 
-- 15 Lab 2: Create a trigger to update the last_modified timestamp whenever an employee 
-- record is updated. 


-- >-------------------------> 15 1
-- Create a log table for employee inserts
CREATE TABLE employee_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id VARCHAR(10),
    emp_name VARCHAR(50),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action_type VARCHAR(20)
);

-- Trigger to log when a new employee is added
DELIMITER //

CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_log (emp_id, emp_name, action_type)
    VALUES (NEW.emp_id, NEW.emp_name, 'INSERT');
END //

DELIMITER ;


-- >-------------------------> 15 2
ALTER TABLE employees
ADD last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- Trigger to update last_modified timestamp on employee update
DELIMITER //

CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    SET NEW.last_modified = CURRENT_TIMESTAMP;
END //

DELIMITER ;





--  **********************************************************
 
-- 16 Lab 1: Write a PL/SQL block to print the total number of employees from the employees 
-- table. 
-- 16 Lab 2: Create a PL/SQL block that calculates the total sales from an orders table. 

DROP PROCEDURE IF EXISTS GetTotalEmployees;
DROP PROCEDURE IF EXISTS GetTotalSales;
-- >-------------------------> 16 1
-- PL/SQL block to count total employees
-- Simple query (no procedure)
SELECT COUNT(*) AS total_employees
FROM employees;


DELIMITER //

CREATE PROCEDURE GetTotalEmployees()
BEGIN
    DECLARE total_employees INT DEFAULT 0;
    SELECT COUNT(*) INTO total_employees FROM employees;
    SELECT CONCAT('Total number of employees: ', total_employees) AS result;
END;
//

DELIMITER ;

-- Call it
CALL GetTotalEmployees();



-- >-------------------------> 16 2
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    order_amount DECIMAL(12,2) NOT NULL,
    order_date DATE
);

INSERT INTO orders (customer_name, order_amount, order_date) VALUES
('Dev',     1200.50, '2025-09-01'),
('Jainam',  850.00,  '2025-09-05'),
('Hardik',  430.75,  '2025-09-10');




DELIMITER //

CREATE PROCEDURE GetTotalSales()
BEGIN
    DECLARE total_sales DECIMAL(12,2) DEFAULT 0;
    SELECT SUM(order_amount) INTO total_sales FROM orders;
    SELECT CONCAT('Total sales amount: ', IFNULL(total_sales, 0)) AS result;
END;
//

DELIMITER ;

-- Call it
CALL GetTotalSales();






--  **********************************************************
-- 17 Lab 1: Write a PL/SQL block using an IF-THEN condition to check the department of an 
-- employee. 
-- 17 Lab 2: Use a FOR LOOP to iterate through employee records and display their names.

DROP PROCEDURE IF EXISTS CheckEmployeeDepartment;

-- >-------------------------> 17 1
DESC departments;

DESC employees;

DELIMITER $$

CREATE PROCEDURE CheckEmployeeDepartment(IN emp_id_input VARCHAR(10))
BEGIN
    DECLARE emp_dept VARCHAR(50);

    -- Fetch the department name for given employee
    SELECT d.dept_name INTO emp_dept
    FROM employees e
    JOIN departments d ON e.dept_id = d.dept_id
    WHERE e.emp_id = emp_id_input;

    -- IF-THEN condition
    IF emp_dept = 'HR' THEN
        SELECT 'Employee works in HR Department' AS result;
    ELSEIF emp_dept = 'IT' THEN
        SELECT 'Employee works in IT Department' AS result;
    ELSE
        SELECT CONCAT('Employee works in another Department: ', emp_dept) AS result;
    END IF;
END$$

DELIMITER ;

CALL CheckEmployeeDepartment('1');



-- >-------------------------> 17 2

DELIMITER $$

CREATE PROCEDURE DisplayEmployeeNames()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE emp_name_var VARCHAR(50);

    -- Cursor to fetch employee names
    DECLARE emp_cursor CURSOR FOR 
        SELECT emp_name FROM employees;

    -- Handle when cursor reaches end
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN emp_cursor;

    emp_loop: LOOP
        FETCH emp_cursor INTO emp_name_var;
        IF done = 1 THEN
            LEAVE emp_loop;
        END IF;

        -- Display employee name
        SELECT emp_name_var AS employee_name;
    END LOOP;

    CLOSE emp_cursor;
END$$

DELIMITER ;
CALL DisplayEmployeeNames();








--  **********************************************************
 
-- 18 Lab 1: Write a PL/SQL block using an explicit cursor to retrieve and display employee details. 
-- 18 Lab 2: Create a cursor to retrieve all courses and display them one by one. 


-- >-------------------------> 18 1
DELIMITER $$

CREATE PROCEDURE GetEmployeeDetails()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_emp_id VARCHAR(10);
    DECLARE v_emp_name VARCHAR(50);
    DECLARE v_dept_id VARCHAR(10);
    DECLARE v_salary DECIMAL(10,2);

    -- Cursor for employee details
    DECLARE emp_cursor CURSOR FOR
        SELECT emp_id, emp_name, dept_id, salary
        FROM employees;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN emp_cursor;

    emp_loop: LOOP
        FETCH emp_cursor INTO v_emp_id, v_emp_name, v_dept_id, v_salary;
        IF done = 1 THEN
            LEAVE emp_loop;
        END IF;

        -- Display each employee record
        SELECT v_emp_id AS emp_id,
               v_emp_name AS emp_name,
               v_dept_id AS dept_id,
               v_salary AS salary;
    END LOOP;

    CLOSE emp_cursor;
END$$

DELIMITER ;

CALL GetEmployeeDetails();


-- >-------------------------> 18 2
DESC courses;


DELIMITER $$

CREATE PROCEDURE DisplayCourses()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_course_id VARCHAR(10);
    DECLARE v_course_name VARCHAR(50);
    DECLARE v_course_duration VARCHAR(20);

    -- Cursor for courses
    DECLARE course_cursor CURSOR FOR
        SELECT course_id, course_name, course_duration
        FROM courses;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN course_cursor;

    course_loop: LOOP
        FETCH course_cursor INTO v_course_id, v_course_name, v_course_duration;
        IF done = 1 THEN
            LEAVE course_loop;
        END IF;

        -- Display each course
        SELECT v_course_id AS course_id,
               v_course_name AS course_name,
               v_course_duration AS course_duration;
    END LOOP;

    CLOSE course_cursor;
END$$

DELIMITER ;

CALL DisplayCourses();




--  **********************************************************
-- 19 Lab 1: Perform a transaction where you create a savepoint, insert records, then rollback to 
-- the savepoint. 
-- 19 Lab 2: Commit part of a transaction after using a savepoint and then rollback the remaining 
-- changes. 


-- >-------------------------> 19 1
START TRANSACTION;

-- Insert record 1
INSERT INTO courses (course_id, course_name, course_duration)
VALUES ('C111', 'Database Systems', '3 months');

-- Create a SAVEPOINT
SAVEPOINT sp1;

-- Insert record 2
INSERT INTO courses (course_id, course_name, course_duration)
VALUES ('C112', 'Cloud Computing', '4 months');

-- Insert record 3
INSERT INTO courses (course_id, course_name, course_duration)
VALUES ('C113', 'AI Fundamentals', '5 months');

-- Rollback to savepoint (C112 and C113 are undone, C111 remains)
ROLLBACK TO sp1;

-- Commit only C111
COMMIT;

-- Verify
SELECT * FROM courses;




-- >-------------------------> 19 2
START TRANSACTION;

-- Insert record 1
INSERT INTO courses (course_id, course_name, course_duration)
VALUES ('C201', 'Cyber Security', '6 months');

-- Create a SAVEPOINT
SAVEPOINT sp2;

-- Insert record 2
INSERT INTO courses (course_id, course_name, course_duration)
VALUES ('C202', 'Data Mining', '5 months');

-- Commit everything up to SAVEPOINT sp2 (C201 is committed)
RELEASE SAVEPOINT sp2;
COMMIT;

-- Start another transaction for the remaining inserts
START TRANSACTION;

-- Insert record 3
INSERT INTO courses (course_id, course_name, course_duration)
VALUES ('C203', 'IoT Basics', '3 months');

-- Rollback the last insert
ROLLBACK;

COMMIT;






--  **********************************************************

DROP DATABASE IF EXISTS  school_db ;

DROP DATABASE IF EXISTS  university_db ;
