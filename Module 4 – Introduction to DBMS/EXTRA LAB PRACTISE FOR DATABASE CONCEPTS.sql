--  **********************************************************
-- EXTRA LAB PRACTISE FOR DATABASE CONCEPTS 


-- 1 Lab 3: Create a database called library_db and a table books with columns: book_id, 
-- title, author, publisher, year_of_publication, and price. Insert five records into 
-- the table. 
--  
-- 1 Lab 4: Create a table members in library_db with columns: member_id, member_name, 
-- date_of_membership, and email. Insert five records into this table. 

-- >-------------------------> 1   3
CREATE DATABASE IF NOT EXISTS library_db;

USE library_db;

-- Create the books table
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    publisher VARCHAR(100),
    year_of_publication YEAR,
    price DECIMAL(10,2)
);

-- Insert 5 records into books table
INSERT INTO books (book_id, title, author, publisher, year_of_publication, price) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Scribner', 1925, 350.00),
(2, 'To Kill a Mockingbird', 'Harper Lee', 'J.B. Lippincott & Co.', 1960, 400.50),
(3, '1984', 'George Orwell', 'Secker & Warburg', 1949, 299.99),
(4, 'The Hobbit', 'J.R.R. Tolkien', 'George Allen & Unwin', 1937, 450.75),
(5, 'Pride and Prejudice', 'Jane Austen', 'T. Egerton', 1913, 275.25);

SELECT * FROM books;

-- >-------------------------> 1   4 
-- Create the members table
CREATE TABLE members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100),
    date_of_membership DATE,
    email VARCHAR(100)
);

-- Insert 5 records into members table
INSERT INTO members (member_id, member_name, date_of_membership, email) VALUES
(1, 'Amit Sharma', '2022-01-15', 'amit.sharma@example.com'),
(2, 'Neha Patel', '2021-11-03', 'neha.patel@example.com'),
(3, 'Rohan Verma', '2023-02-20', 'rohan.verma@example.com'),
(4, 'Priya Singh', '2022-05-10', 'priya.singh@example.com'),
(5, 'Vikas Kumar', '2021-09-27', 'vikas.kumar@example.com');




--  **********************************************************

-- 2 Lab 3: Retrieve all members who joined the library before 2022. Use appropriate SQL syntax 
-- with WHERE and ORDER BY. 
-- 2 Lab 4: Write SQL queries to display the titles of books published by a specific author. Sort the 
-- results by year_of_publication in descending order. 


-- >-------------------------> 2   3
-- Retrieve all members who joined before 2022, sorted by date_of_membership
SELECT *
FROM members
WHERE date_of_membership < '2022-01-01'
ORDER BY date_of_membership;


-- >-------------------------> 2   4

-- Replace 'Author Name' with the actual author you want to search
SELECT title
FROM books
WHERE author = 'Harper Lee'
ORDER BY year_of_publication DESC;




--  **********************************************************
 
-- 3 Lab 3: Add a CHECK constraint to ensure that the price of books in the books table is 
-- greater than 0. 
-- 3Lab 4: Modify the members table to add a UNIQUE constraint on the email column, 
-- ensuring that each member has a unique email address. 


-- >-------------------------> 3   3
-- Add CHECK constraint to ensure book price is greater than 0
ALTER TABLE books
ADD CONSTRAINT chk_price_positive
CHECK (price > 0);
 
SELECT * FROM books;


-- >-------------------------> 3   4
-- Add UNIQUE constraint to ensure each member has a unique email
ALTER TABLE members
ADD CONSTRAINT unique_email
UNIQUE (email);











--  **********************************************************
-- 4 Lab 3: Create a table authors with the following columns: author_id, first_name, 
-- last_name, and country. Set author_id as the primary key. 
-- 4 Lab 4: Create a table publishers with columns: publisher_id, publisher_name, 
-- contact_number, and address. Set publisher_id as the primary key and 
-- contact_number as unique. 


-- >-------------------------> 4   3
-- Create authors table
CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    country VARCHAR(50)
);



-- >-------------------------> 4   4
-- Create publishers table
CREATE TABLE publishers (
    publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15) UNIQUE,
    address VARCHAR(200)
);









--  **********************************************************
-- 5 Lab 3: Add a new column genre to the books table. Update the genre for all existing 
-- records. 
-- 5 Lab 4: Modify the members table to increase the length of the email column to 100 
-- characters. 

SET SQL_SAFE_UPDATES = 0; 

-- >-------------------------> 5   3
-- Add a new column 'genre' to books table
ALTER TABLE books
ADD COLUMN genre VARCHAR(50);

-- Update genre for existing records
UPDATE books
SET genre = CASE 
    WHEN book_id = 1 THEN 'Database'
    WHEN book_id = 2 THEN 'Operating System'
    WHEN book_id = 3 THEN 'Networking'
    WHEN book_id = 4 THEN 'Programming'
    WHEN book_id = 5 THEN 'Artificial Intelligence'
END;




-- >-------------------------> 5   4
-- Modify email column length without adding a duplicate UNIQUE constraint
ALTER TABLE members
MODIFY COLUMN email VARCHAR(100);







--  **********************************************************
 
-- 6 Lab 3: Drop the publishers table from the database after verifying its structure. 
-- 6 Lab 4: Create a backup of the members table and then drop the original members table. 


-- >-------------------------> 6   3
-- Verify structure of publishers table
DESCRIBE publishers;

-- Drop the publishers table
DROP TABLE publishers;




-- >-------------------------> 6   4
-- Create a backup of members table
CREATE TABLE members_backup AS
SELECT * FROM members;

-- Drop the original members table
DROP TABLE members;





--  **********************************************************
 
-- 7 Lab 4: Insert three new authors into the authors table, then update the last name of one of 
-- the authors. 
-- 7 Lab 5: Delete a book from the books table where the price is higher than $100. 


-- >-------------------------> 7   4
-- Insert three new authors
INSERT INTO authors (author_id, first_name, last_name, country) VALUES
(1, 'C.J.', 'Date', 'USA'),
(2, 'Andrew', 'Tanenbaum', 'Netherlands'),
(3, 'Robert', 'Martin', 'USA');

-- Update the last name of one author (example: change 'Martin' to 'Martin Jr.')
UPDATE authors
SET last_name = 'Martin Jr.'
WHERE author_id = 3;


-- >-------------------------> 7   5
DELETE FROM books
WHERE price > 100
LIMIT 1;

SELECT * FROM books;

-- Delete book(s) with price greater than $100
-- DELETE FROM books
-- WHERE price > 100;





--  **********************************************************
 
-- 8 Lab 3: Update the year_of_publication of a book with a specific book_id. 
-- 8 Lab 4: Increase the price of all books published before 2015 by 10%. 


-- >-------------------------> 8   3
-- Example: Update the year_of_publication for book_id = 2
UPDATE books
SET year_of_publication = 2023
WHERE book_id = 2;


-- >-------------------------> 8   4
-- Increase price by 10% and round to 2 decimal places
UPDATE books
SET price = ROUND(price * 1.10, 2)
WHERE year_of_publication < 2015;







--  **********************************************************
-- 9 Lab 3: Remove all members who joined before 2020 from the members table. 
-- 9 Lab 4: Delete all books that have a NULL value in the author column. 


CREATE TABLE members AS
SELECT * FROM members_backup;

-- >-------------------------> 9   3
-- Delete members with date_of_membership before 2020
DELETE FROM members
WHERE date_of_membership < '2020-01-01';


-- >-------------------------> 9   4

-- Delete books where author is NULL
DELETE FROM books
WHERE author IS NULL;






--  **********************************************************
-- 10 Lab 4: Write a query to retrieve all books with price between $50 and $100. 
-- 10 Lab 5: Retrieve the list of books sorted by author in ascending order and limit the results 
-- to the top 3 entries. 





-- >-------------------------> 10   4
-- Select books with price between 50 and 100
SELECT *
FROM books
WHERE price BETWEEN 50 AND 100;


-- >-------------------------> 10   5
-- Select top 3 books sorted by author in ascending order
SELECT *
FROM books
ORDER BY author ASC
LIMIT 3;



--  **********************************************************
-- 11 Lab 3: Grant SELECT permission to a user named librarian on the books table. 
-- 11 Lab 4: Grant INSERT and UPDATE permissions to the user admin on the members table. 
	


-- >-------------------------> 11   3
-- >-------------------------> 11   4
-- Create user 'librarian' with a password
CREATE USER 'librarian'@'localhost' IDENTIFIED BY '1234';

-- Create user 'admin' with a password
CREATE USER 'admin'@'localhost' IDENTIFIED BY '1234';

-- Grant SELECT permission on books table to librarian
GRANT SELECT ON library_db.books TO 'librarian'@'localhost';

-- Grant INSERT and UPDATE permissions on members table to admin
GRANT INSERT, UPDATE ON library_db.members TO 'admin'@'localhost';

FLUSH PRIVILEGES;








--  **********************************************************
 
-- 12 Lab 3: Revoke the INSERT privilege from the user librarian on the books table. 
-- 12 Lab 4: Revoke all permissions from user admin on the members table. 

-- >-------------------------> 12   3
-- Revoke INSERT privilege from librarian
REVOKE INSERT ON library_db.books FROM 'librarian'@'localhost';


-- >-------------------------> 12   4
-- Revoke all privileges from admin on members table
REVOKE ALL PRIVILEGES ON library_db.members FROM 'admin'@'localhost';

FLUSH PRIVILEGES;




--  **********************************************************
 
-- 13 Lab 3: Use COMMIT after inserting multiple records into the books table, then make another 
-- insertion and perform a ROLLBACK. 
-- 13 Lab 4: Set a SAVEPOINT before making updates to the members table, perform some 
-- updates, and then roll back to the SAVEPOINT. 

-- >-------------------------> 13   3
-- Start a transaction
START TRANSACTION;

-- Insert multiple records into books table
INSERT INTO books (book_id, title, author, publisher, year_of_publication, price, genre) VALUES
(6, 'Data Mining Concepts', 'Jiawei Han', 'Morgan Kaufmann', 2018, 700.00, 'Data Mining'),
(7, 'Deep Learning', 'Ian Goodfellow', 'MIT Press', 2016, 1200.00, 'AI');

-- Commit the transaction to save changes
COMMIT;

-- Start another transaction
START TRANSACTION;

-- Insert another record
INSERT INTO books (book_id, title, author, publisher, year_of_publication, price, genre) VALUES
(8, 'Network Security', 'William Stallings', 'Pearson', 2015, 900.00, 'Networking');

-- Rollback this insertion
ROLLBACK;

-- >-------------------------> 13   4
-- Start a transaction
START TRANSACTION;

-- Set a SAVEPOINT before updates
SAVEPOINT before_updates;

-- Perform some updates
UPDATE members
SET member_name = 'Rahul Sharma Jr.'
WHERE member_id = 1;

UPDATE members
SET email = 'priya.new@example.com'
WHERE member_id = 2;

-- Rollback to the SAVEPOINT
ROLLBACK TO SAVEPOINT before_updates;

-- Commit the transaction (optional, nothing changed due to rollback)
COMMIT;





--  **********************************************************

-- 14 Lab 3: Perform an INNER JOIN between books and authors tables to display the title 
-- of books and their respective authors' names. 
-- 14 Lab 4: Use a FULL OUTER JOIN to retrieve all records from the books and authors 
-- tables, including those with no matching entries in the other table. 


-- >-------------------------> 14   3
-- Retrieve book titles and corresponding authors
SELECT b.title, a.first_name, a.last_name
FROM books b
INNER JOIN authors a
ON b.author = CONCAT(a.first_name, ' ', a.last_name);



-- >-------------------------> 14   4
-- Simulate FULL OUTER JOIN in MySQL
SELECT b.title, a.first_name, a.last_name
FROM books b
LEFT JOIN authors a
ON b.author = CONCAT(a.first_name, ' ', a.last_name)

UNION

SELECT b.title, a.first_name, a.last_name
FROM books b
RIGHT JOIN authors a
ON b.author = CONCAT(a.first_name, ' ', a.last_name);








--  **********************************************************

-- 15 Lab 3: Group books by genre and display the total number of books in each genre. 
-- 15 Lab 4: Group members by the year they joined and find the number of members who joined 
-- each year. 


-- >-------------------------> 15   3
-- Count total number of books in each genre
SELECT genre, COUNT(*) AS total_books
FROM books
GROUP BY genre;




-- >-------------------------> 15   4
-- Count number of members who joined each year
SELECT YEAR(date_of_membership) AS joining_year, COUNT(*) AS total_members
FROM members
GROUP BY YEAR(date_of_membership);







--  **********************************************************
 
-- 16 Lab 3: Write a stored procedure to retrieve all books by a particular author. 
-- 16 Lab 4: Write a stored procedure that takes book_id as an argument and returns the price 
-- of the book. 
SELECT * FROM BOOKS;
-- >-------------------------> 16   3
DELIMITER $$

CREATE PROCEDURE GetBooksByAuthor(IN author_name VARCHAR(100))
BEGIN
    SELECT *
    FROM books
    WHERE author = author_name;
END $$

DELIMITER ;


CALL GetBooksByAuthor('Harper Lee');



-- >-------------------------> 16   4
DELIMITER $$

CREATE PROCEDURE GetBookPrice(IN b_id INT)
BEGIN
    SELECT title, price
    FROM books
    WHERE book_id = b_id;
END $$

DELIMITER ;

CALL GetBookPrice(2);







--  **********************************************************
-- 17 Lab 3: Create a view to show only the title, author, and price of books from the books 
-- table. 
-- 17 Lab 4: Create a view to display members who joined before 2020. 



-- >-------------------------> 17   3
-- Create view for selected columns of books
CREATE VIEW view_books_summary AS
SELECT title, author, price
FROM books;

SELECT * FROM view_books_summary;

-- >-------------------------> 17   4

-- Create view for members joined before 2020
CREATE VIEW view_members_pre2020 AS
SELECT *
FROM members
WHERE date_of_membership < '2020-01-01';

SELECT * FROM view_members_pre2020;








--  **********************************************************
 
-- 18 Lab 3: Create a trigger to automatically update the last_modified timestamp of the 
-- books table whenever a record is updated. 
-- 18 Lab 4: Create a trigger that inserts a log entry into a log_changes table whenever a 
-- DELETE operation is performed on the books table. 


-- >-------------------------> 18   3
ALTER TABLE books
ADD COLUMN last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;


DELIMITER $$

CREATE TRIGGER trg_update_books_timestamp
BEFORE UPDATE ON books
FOR EACH ROW
BEGIN
    SET NEW.last_modified = CURRENT_TIMESTAMP;
END $$

DELIMITER ;


-- >-------------------------> 18   4
CREATE TABLE log_changes (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_by VARCHAR(50)
);

DELIMITER $$

CREATE TRIGGER trg_books_delete_log
AFTER DELETE ON books
FOR EACH ROW
BEGIN
    INSERT INTO log_changes (book_id, deleted_by)
    VALUES (OLD.book_id, USER());
END $$

DELIMITER ;








--  **********************************************************
 
-- 19 Lab 3: Write a PL/SQL block to insert a new book into the books table and display a 
-- confirmation message. 
-- 19 Lab 4: Write a PL/SQL block to display the total number of books in the books table. 


-- >-------------------------> 19   3
-- Create a stored procedure to insert a book and display message
DELIMITER $$

CREATE PROCEDURE InsertNewBook()
BEGIN
    INSERT INTO books (book_id, title, author, publisher, year_of_publication, price, genre)
    VALUES (9, 'Python Programming', 'Guido van Rossum', 'O''Reilly', 2021, 650, 'Programming');

    SELECT 'New book inserted successfully!' AS message;
END $$

DELIMITER ;

-- Call the procedure
CALL InsertNewBook();




-- >-------------------------> 19   4
-- Simple query to count books
SELECT COUNT(*) AS total_books FROM books;

DELIMITER $$

CREATE PROCEDURE CountBooks()
BEGIN
    DECLARE total_books INT;
    SELECT COUNT(*) INTO total_books FROM books;
    SELECT CONCAT('Total number of books: ', total_books) AS message;
END $$

DELIMITER ;

-- Call the procedure
CALL CountBooks();







--  **********************************************************
-- 20 Lab 3: Write a PL/SQL block to declare variables for book_id and price, assign values, and 
-- display the results. 
-- 20 Lab 4: Write a PL/SQL block using constants and perform arithmetic operations on book 
-- prices. 




-- >-------------------------> 20   3
DELIMITER $$

CREATE PROCEDURE DisplayBookInfo()
BEGIN
    DECLARE v_book_id INT;
    DECLARE v_price DECIMAL(8,2);

    -- Assign values
    SET v_book_id = 10;
    SET v_price = 750.50;

    -- Display results
    SELECT v_book_id AS book_id, v_price AS price;
END $$

DELIMITER ;

-- Call the procedure
CALL DisplayBookInfo();



-- >-------------------------> 20   4
DELIMITER $$

CREATE PROCEDURE PriceArithmetic()
BEGIN
    -- Declare constants using variables (MySQL doesn't have true constants)
    DECLARE base_price DECIMAL(8,2) DEFAULT 500.00;
    DECLARE discount DECIMAL(8,2) DEFAULT 50.00;
    DECLARE final_price DECIMAL(8,2);

    -- Perform arithmetic
    SET final_price = base_price - discount;

    -- Display results
    SELECT base_price AS BasePrice, discount AS Discount, final_price AS FinalPrice;
END $$

DELIMITER ;

-- Call the procedure
CALL PriceArithmetic();





--  **********************************************************

-- 21 Lab 3: Write a PL/SQL block using IF-THEN-ELSE to check if a book's price is above $100 
-- and print a message accordingly. 
-- 21 Lab 4: Use a FOR LOOP in PL/SQL to display the details of all books one by one. 


-- >-------------------------> 21   3
DELIMITER $$

CREATE PROCEDURE CheckBookPrice(IN b_id INT)
BEGIN
    DECLARE v_price DECIMAL(8,2);

    -- Get the price of the book
    SELECT price INTO v_price FROM books WHERE book_id = b_id;

    -- Check price using IF-ELSE
    IF v_price > 100 THEN
        SELECT CONCAT('Book ID ', b_id, ' is expensive: $', v_price) AS message;
    ELSE
        SELECT CONCAT('Book ID ', b_id, ' is affordable: $', v_price) AS message;
    END IF;
END $$

DELIMITER ;

-- Example call
CALL CheckBookPrice(2);

-- >-------------------------> 21   4

DELIMITER $$

CREATE PROCEDURE DisplayAllBooks()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_book_id INT;
    DECLARE v_title VARCHAR(100);
    DECLARE v_author VARCHAR(100);
    DECLARE v_price DECIMAL(8,2);

    -- Declare cursor
    DECLARE cur_books CURSOR FOR SELECT book_id, title, author, price FROM books;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur_books;

    read_loop: LOOP
        FETCH cur_books INTO v_book_id, v_title, v_author, v_price;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Display book details
        SELECT v_book_id AS BookID, v_title AS Title, v_author AS Author, v_price AS Price;
    END LOOP;

    CLOSE cur_books;
END $$

DELIMITER ;

-- Call the procedure
CALL DisplayAllBooks();






--  **********************************************************

-- 22 Lab 3: Write a PL/SQL block using an explicit cursor to fetch and display all records from the 
-- members table. 
-- 22 Lab 4: Create a cursor to retrieve books by a particular author and display their titles. 


-- >-------------------------> 22   3
DELIMITER $$

CREATE PROCEDURE FetchAllMembers()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_member_id INT;
    DECLARE v_member_name VARCHAR(100);
    DECLARE v_date_of_membership DATE;
    DECLARE v_email VARCHAR(100);

    -- Declare cursor
    DECLARE cur_members CURSOR FOR 
        SELECT member_id, member_name, date_of_membership, email FROM members;

    -- Handler for end of cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur_members;

    read_loop: LOOP
        FETCH cur_members INTO v_member_id, v_member_name, v_date_of_membership, v_email;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Display member details
        SELECT v_member_id AS MemberID, v_member_name AS Name, v_date_of_membership AS MembershipDate, v_email AS Email;
    END LOOP;

    CLOSE cur_members;
END $$

DELIMITER ;

-- Call the procedure
CALL FetchAllMembers();


-- >-------------------------> 22   4

DELIMITER $$

CREATE PROCEDURE FetchBooksByAuthor(IN author_name VARCHAR(100))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_title VARCHAR(100);

    -- Declare cursor
    DECLARE cur_books CURSOR FOR 
        SELECT title FROM books WHERE author = author_name;

    -- Handler for end of cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur_books;

    read_loop: LOOP
        FETCH cur_books INTO v_title;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Display book title
        SELECT v_title AS Title;
    END LOOP;

    CLOSE cur_books;
END $$

DELIMITER ;

-- Example call
CALL FetchBooksByAuthor('Guido van Rossum');





--  **********************************************************
 
-- 23 Lab 3: Perform a transaction that includes inserting a new member, setting a SAVEPOINT, 
-- and rolling back to the savepoint after making updates. 
-- 23 Lab 4: Use COMMIT after successfully inserting multiple books into the books table, then use 
-- ROLLBACK to undo a set of changes made after a savepoint. 



-- >-------------------------> 23   3
-- Start a transaction
START TRANSACTION;

-- Insert a new member
INSERT INTO members (member_id, member_name, date_of_membership, email)
VALUES (6, 'Anita Patel', '2025-09-27', 'anita.patel@example.com');

-- Set a SAVEPOINT
SAVEPOINT before_updates;

-- Perform some updates
UPDATE members
SET email = 'anita.updated@example.com'
WHERE member_id = 6;

-- Rollback to the SAVEPOINT (undo the update, keep the insert)
ROLLBACK TO SAVEPOINT before_updates;

-- Commit the transaction (finalize the insert)
COMMIT;



-- >-------------------------> 23   4
DESCRIBE books;

-- Start a transaction
START TRANSACTION;

-- Insert multiple books
INSERT INTO books (book_id, title, author, publisher, year_of_publication, price, genre)
VALUES
(10, 'AI Fundamentals', 'Stuart Russell', 'Pearson', 2019, 800, 'AI'),
(11, 'Data Analytics', 'Tom White', 'O''Reilly', 2018, 600, 'Data Science');

-- Commit these inserts
COMMIT;

-- Start another transaction
START TRANSACTION;

-- Set a SAVEPOINT before making further changes
SAVEPOINT before_more_changes;

-- Make some updates
UPDATE books
SET price = price * 1.10
WHERE year_of_publication < 2018;

-- Rollback to the savepoint (undo the price updates)
ROLLBACK TO SAVEPOINT before_more_changes;

-- Commit to finalize the transaction
COMMIT;








--  **********************************************************




DROP DATABASE IF EXISTS library_db;