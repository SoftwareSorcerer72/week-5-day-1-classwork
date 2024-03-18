-- Hello World SQL Query, Select all records from a table
-- Syntax: SELECT column_name FROM table_name
SELECT *
FROM actor;

-- To query specific columns, add them in the SELECT statment
SELECT first_name, last_name
FROM actor;


-- Filter rowsby using WHERE clause
SELECT first_name, last_name
FROM actor 
WHERE first_name = 'Nick';


-- The "LIKE" keyword allows us to add wildcards to the string
SELECT first_name, last_name
FROM actor 
WHERE first_name LIKE 'Nick';

-- With LIKE keyword, '%' represents any number of characters
SELECT first_name, last_name
FROM actor 
WHERE first_name LIKE 'J%';

-- With a LIKE keyword, '_' represents one character
SELECT first_name, last_name
FROM actor 
WHERE first_name LIKE 'K__';

SELECT first_name, last_name
FROM actor 
WHERE first_name = 'J%'; -- will literally look FOR 'J%'

-- using AND or OR in the where clause
-- OR - only one needs to be true
SELECT *
FROM actor a WHERE first_name LIKE 'N%' OR last_name like'W%';

-- AND - all conditions need to be true
SELECT *
FROM actor a WHERE first_name LIKE 'N%' AND last_name LIKE 'W%';

-- Comparrison Operators in SQL:
--Greater Than >
-- Less Than <
-- Greater Than or Equal To >=
-- Less Than or Equal To >=
-- EQUALS =
-- Not Equals <> or !=

SELECT *
FROM payment;

-- Query all of the payments of more than $7.00
SELECT *
FROM payment 
WHERE amount > 7;

-- Query for all >7
SELECT *
FROM payment 
WHERE amount <= '6.99'; -- Can have '' 

-- Not Equals
SELECT *
FROM staff
WHERE staff_id <> 1;

SELECT *
FROM staff 
WHERE staff_id != 2;

SELECT *
FROM film  
WHERE title NOT LIKE 'F%';

-- Get all of the payments between $3.00 and $$8.00
SELECT *
FROM payment 
WHERE amount >= 3 AND amount <= 8;

--BETWEEN/AND clause
SELECT *
FROM payment
WHERE amount BETWEEN 3 AND 8;

SELECT *
FROM film
WHERE film_id BETWEEN 10 AND 20;

-- Order the rows of data using the ORDER BY clause
-- default is Ascending Order(add DESC for descending)
-- Syntax: ORDER BY column_name

SELECT *
FROM film
ORDER BY rental_duration;

SELECT *
FROM film
ORDER BY title DESC;

-- ORDER BY comes after the WHERE clause (if present)
SELECT *
FROM payment
WHERE customer_id = 123
ORDER BY amount;

-- Exercise 1 - Write a query that will return all of the films that have an 'h' in the title
-- and order it by rental duration (in ascending order)

SELECT *
FROM film 
WHERE title LIKE '%h%' OR title like '%H%'
ORDER BY rental_duration;

-- can also use ILIKE to be case insensitive or 


-- SQL Aggregations -> SUM(), AVG(), COUNT(), MIN() MAX()
-- take in a column name and return a single value

-- SUM - find the sum of a column

SELECT SUM(amount)
FROM payment;

SELECT SUM(amount)
FROM payment
WHERE customer_id = 123;

-- AVG - find the average of a column
SELECT AVG(amount)
FROM payment;

-- MIN/MAX - find the smallest/largest value in a column
-- alias column names using "as" - col_name AS alians_name
SELECT MIN(amount)AS smallest_amount, MAX(amount)AS largest_amount
FROM payment;

-- also works with strings (varchar)
SELECT MIN(first_name), MAX(last_name)
FROM actor;

-- Count() - Takes in either a column_name OR * for all columns
-- If column_name, will count as any NON-NULL rows in that column
-- If *, will count as all rows
SELECT *
FROM staff; 

SELECT COUNT(*)
FROM staff; -- will RETURN 2 because there ARE 2 ROWS

SELECT COUNT(picture)
FROM staff; -- will RETURN 1 because ONLY 1 staff MEMBER has a pocture, the other IS NULL

-- to count unique values, use the distinct keyword
SELECT *
FROM actor
WHERE first_name like'A%'
order by first_name;

SELECT COUNT(first_name)
FROM actor 
WHERE first_name LIKE 'A%'; -- 13

SELECT COUNT(DISTINCT first_name)
FROM actor
WHERE first_name LIKE 'A%'; -- 9


-- GROUP BY clause
-- used with aggregations
SELECT *
FROM payment
ORDER BY amount;

SELECT COUNT(*)
FROM PAYMENT
WHERE AMOUNT = 0; -- 24

SELECT COUNT(*)
FROM PAYMENT
WHERE AMOUNT = 0.99; -- 2720

SELECT COUNT(*)
FROM PAYMENT
WHERE AMOUNT = 1.99; --580


SELECT amount, count(*), sum(amount), avg(amount)
FROM payment
GROUP BY amount 
ORDER BY amount;

-- columns selected from the table must also be in the GROUP BY
SELECT amount, customer_id, COUNT(*)
FROM payment
GROUP BY payment; -- column "payment.customer_id" must appear in the GROUP BY clause or be used in an aggregate FUNCTION
-- if you get an error always look at the line above

SELECT amount, customer_id, COUNT(*)
FROM payment 
GROUP BY amount, customer_id 
ORDER BY customer_id;

SELECT customer_id, COUNT(*) 
FROM payment 
GROUP BY customer_id 
ORDER BY customer_id;

SELECT customer_id, SUM(amount) 
FROM payment 
GROUP BY customer_id 
ORDER BY customer_id;



-- Use aggregations in the ORDEER BY clause
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id 
ORDER BY sum(amount) DESC;

-- we can use aliased column names in the order by clause
SELECT customer_id, SUM(amount) AS total_spend 
FROM payment
GROUP BY customer_id 
ORDER BY total_spend DESC; 

-- HVING Clause - Having is to GROUP BY/Aggregrations as WHERE is to select
SELECT *
FROM payment
WHERE amount > 10;

SELECT customer_id, SUM(amount) AS total_spend 
FROM payment
GROUP BY customer_id 
HAVING SUM(amount) > 200
ORDER BY total_spend DESC; 

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id 
HAVING SUM(amount) BETWEEN 75 AND 100;


-- LIMMIT and OFFSET clauses

-- LIMIT -- limit the number of rows that are returned
SELECT *
FROM city
LIMIT 10;

SELECT *
FROM film
ORDER BY title
LIMIT 10;

-- OFFSET - start your rows after a certain name
SELECT * 
FROM city
OFFSET 5;

-- Can be used together
SELECT *
FROM city
OFFSET 20
LIMIT 10;

-- Syntax Order -- (SELECT and FROM are the only mandatory clauses)

-- SELECT (column_names)
-- FROM (table_name)
-- WHERE (row filter)
-- GROUP BY (aggregations)
-- HAVING (filter aggregations)
-- ORDER BY (column_value ASC or DESC)
-- OFFSET (number of rows to skip)
-- LIMIT (max number of rows to display)

SELECT first_name
FROM actor
WHERE actor_id > 10
GROUP BY first_name 
HAVING first_name LIKE '%t%'
ORDER BY first_name 
OFFSET 5
LIMIT 5;
