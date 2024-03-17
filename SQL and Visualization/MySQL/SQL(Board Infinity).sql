
-- 1.Data Definition queires(CREATE , READ , UPDATE & DELETE) 

select VERSION(), CURRENT_DATE();  -- to see the version installed and todays date 
                                   -- select works similar to print
 SHOW databases;  -- to explore all data bases in the MYSQL schemas
 
 /* CREATE operations */
 
 Create database test_schema;
 /* Syntax of create */
-- (create) (what_we_want_to_create_like_database_or_table_etc) (give_its_name)

 Drop DATABASE test_schema;
 /* Syntax of DROP */
-- DROP  what_we_want_to_drop_like_database_or_table_etc  its_name	
-- drop command deletes the entire database or table etc whichever is mentioned
-- name should exactly match that exist

-- Drop DATABASE test_schema; -- if this is excecuted it pops an error as test schemas is already dropped
Drop DATABASE IF EXISTS test_schema; -- if you execute this, this will show warrning if test_schemas database is not existing  

-- ----------------------------------------------------------------------------------------------------

 -- Creating database soes not select 	it for use; you must do it explicitly.
 -- to make classic_models current database, use this statement:
USE classicmodels;
     -- now the classic models database is highlighted and expanded 
     -- if i want to use a table from a particular data base which is present in other databases as well 
	 -- we can specify the table by mentioning it as database_name.tabel_name
-- if the tables from the same databse are to be used instead of mentioning datebase name everytime we can use 
-- USE command . this selects the particular database  
  
SHOW TABLES;  -- displays all the tables of classicmodel database

-- ------------------------------------------------------------------------------------------------------
drop database test_schema;
CREATE database test_schema;
use test_schema;

-- a table cant be created and left alone . column names needed to be specified at the time of creation 
-- columns cant be left empty , by using not null entries can be entered later and it will not show any error
CREATE TABLE Offices (
	 `officeCode`    varchar(10) NOT NULL,  -- one column can have many constrains 
     `city`          varchar(50) NOT NULL,  -- other constraints CHECK , UNIQUE , Primary KEY , Foreign Key
     `phone`         varchar(50) NOT NULL,
     `addressLine1`  varchar(50) NOT NULL,
     `addressLine2`  varchar(50) NOT NULL,
     `state`         varchar(50) NOT NULL,
     `country`       varchar(50) NOT NULL,
     `postalCode`    varchar(15) NOT NULL,
     `territory`     varchar(10) NOT NULL,
     PRIMARY KEY (`officeCode`)
     );
     
     SHOW TABLES; -- to check weather table created or not
     SELECT * FROM test_schema.offices; -- shows the columns of the table Offices
     
  /* Inserting Data into a Table created */
-- Inserting Data: We can insert some rows into the table using the INSERT INTO statement.  

INSERT INTO Offices

(`officeCode`,`city`,`phone`,`addressLine1`,`addressLine2`,`state`,`country`,`postalCode`,territory) VALUES 
-- We can skip writing this column name but you can enter in specific order for rows

("1",'BOston','9177445758','new street','old street','apt','USA','533232','NA'), -- Null can also be used as an enitity if NOT NLL is not specifed during creation 

('2','NYC','9842498259','kiochio','wentwort','Funstsa','Japan','75017','Japan');
 
  /*
  Insert Statement has the followinng general syntax:
  
INSERT INTO table_name(column1,column2...) VALUESV(value1,value2,...),(value2_1,value2_2...),....;

If you're inserting values for all the colums, you can skip the column names:
	
INSERT INTO table_name VALUES (value1,value2,...),(value2_1,value2_2...),....;
 
Viewing Data: The simplest way to view data from the table is using the SELECT Statement. It has following syntax:
 
 SELECT column1,column2	...... FROM table_name;
 
 You can also view data from all column using 
 
 SELECT * From `Offices`; -- From Statement always contains the Data source for this query
 */
 
 /* Read Operation:
The read operations are used to retreive th																																																																									e content of the table from a particular database. Read Operation is done by DDL Commands.
*/

 SELECT * From `Offices`;

select city, length(city)
FROM `offices`;

-- Here we observe that max length of city name is 6 so now we are changing varchar(50) to varchar(10)
DESCRIBE Offices;  --  To verify that your table was created the way you expected, use a DESRIBE statement:
                   -- gives a detailed description of table and its properties 

/*Update Operation :
Altering the content of the table o the structure of the table is  done with the help of Update Operations.
Two commands are mostly used for update operation - 

1. Alter Table command -
This is DDL(Data Defination Language) command used to change the structure of the table.

2.Update Table command -
This is DML command(Data Manipulating Language) used to alter the records.
*/

ALTER TABLE `offices`
 -- max length of city name is 6 so now we are changing varchar(50) to varchar(10)
MODIFY city varchar(10) NOT NULL ; -- Modify - overwrite the properties of a column   
-- there are three costrains ADD MODIFY DELETE -- IF  you Don't provide NOT NULL the new modfied doesn't have NOT NULL
-- ADD - add a column , use same previous syntax -- Delete - delete a column 

describe  offices;

select * From offices;

-- here we try to change the city name from fang to NEW YORK and territory to USA
Update `offices` set city = 'New York'
where city = 'Fang'; 

Update `offices` set territory = 'USA'
where territory = "Japan";

select * From `offices`;

 
/* Delete Operation :
Two command are mostly used for delete operation -

1.Delete command - (DML commnad) works on the records of the table 
2.Drop command   - (DDL command) works on the structure of the table
*/
use test_schemas;
delete from offices
where city = 'Boston';

SELECT * FROM `Offices`;

drop table Office;


-- -----------------------------------------------------2.WHERE, ORDER BY, LIMIT ------------------------------------------------------------
 
 /*
 
 1.WHERE - use a conditional clause called the WHERE clause to filter out the results. Using the WHERE clause,
   we can specify a selecction criteria to selct the required records from a table.
   
   You can use one are more tables seperated by a comma to include various conditions using a WHERE clause, 
   but the WHERE clause is an Optional part of the SELECT command
 
   You can specify any conditon using the WHERE command 
 
   You can specify more than one action or condition using the AND or the  OR Operation
   
   A WHERE clause can be used along with DELETE or UPDATE SQL commands also to specify a condition

 2.ORDER BY order the results of the query
 
 3.LIMIT restricts the result set to a fixed number of rows
 */
 use sakila;
 SELECT * FROM `actor`;
 SELECT first_name , last_name
 FROM actor
 WHERE first_name = 'penelope';
 
  SELECT first_name , last_name
 FROM actor
 WHERE first_name <> 'penelope';  -- NOT equals to --> "<>"

SELECT actor_id , first_name , last_name
FROM actor
WHERE actor_id > 5 and actor_id<20;
 
SELECT actor_id , first_name , last_name
FROM actor 
WHERE first_name = 'penelope' and actor_id<20;

SELECT actor_id , first_name , last_name
FROM actor 
WHERE first_name = 'penelope' or first_name = 'nick';

SELECT actor_id , first_name , last_name
FROM actor 
WHERE first_name = 'penelope' or actor_id <20 or first_name = 'ed';
 
SELECT actor_id , first_name , last_name
FROM actor 
WHERE first_name IN ('penelope','nick','ed');

SELECT * FROM actor
WHERE actor_id between 5 and 20 ;
 
SELECT * FROM actor
WHERE actor_id not between 5 and 20 ;
 
 SELECT actor_id , first_name , last_name
FROM actor 
WHERE first_name NOT IN ('penelope','nick','ed');

use sakila;
SELECT actor_id
from actor 
ORDER BY actor_ID desc;  -- order by ascending order

SELECT actor_id , first_name , last_name
FROM actor 
WHERE (first_name = 'penelope' or first_name  = 'johnny') and Actor_id<100 
order by first_name ASC; -- ordered by ascending order 

SELECT actor_id , first_name , last_name
From actor
WHERE (first_name = 'penelope' or first_name  = 'johnny') and Actor_id<100 
order by first_name desc; -- Ordered by Descending order 

SELECT first_name, last_name,actor_id
From actor
where actor_id != 5
order by actor_id
limit 7;

-- -------------------------------------------------------3.DISTINCT , COUNT -----------------------------------------------------------------
use world;
 
SELECT * FROM city;

SELECT distinct CountryCode FROM city;

SELECT count( distinct CountryCode) From city;

 SELECT count(CountryCode), count( distinct CountryCode) From city;

SELECT count(*) From city; -- count all number of records or rows ( "*" --> Asterisk)
 
 
 -- -----------------------------------------------------4. COMMIT and Rollback----------------------------------------------------------------
 /* 
 A transaction is a sequential group of Database manipulation operations, which is performed as if it were one single work unit.
 In other words, a transaction will never be completed unless each individual operation within the group is successful.
 If any operations within the trasaction fails, the entire traction will fail.
 
 Praccticallly you will club many SQL queries into a group and will execute all of them together as a part of a trasaction.
 
 
 ** Properties of Transaction **
 
 Trasaction has the following four standard properties, usually reffered to by the acronym ACID -

     1.Atomicity - This ensure that all operations within the work unit are completed successfully;
     otherwise the transaction is aborted at the point of failure and previous operations are rolled back to their formar state
     
     2.consistence - This ensures that the database changes states upon a successfully commited transaction.
	
     3.Isolation - This enables transaction to operate independently on and transparent to each other
     
     4.Durability 
     
In MYSQL, the transactionas begin with in the statement BEGIN WORK and ends with either a COMMIT or a ROLLBACK statement. 
The SQL commands between the beginnings and ending statements form a bulk of the trasaction.

******************************************************** COMMIT and ROLLBACK ****************************************************************************

These two keywords are mainly used for MYSQL transactions.

You can control the behaviour of a transaction by setting session variable called AUTOCOMMIT. IF AUTOCOMMIT is set to 1(the default)
then each SQL statement (within transactionn or not) is considered as complete trasaction and commited by default when it finishes. 

When AUTOCOMMIT is set to  0, by issuing 	the SET AUTOCOMMIT = 0 command, the subsequent series of statements acts like transaction 
and no activities are comitted until and explicit COMMIT statement is issued. 

      Begin transaction by issuing the SQL command BEGIN WORK.
      
      Issue one or more SQL commands like SELECT , INSERT , UPDATE or DELETE.
      
      Check if there is no error and everything is according to your requirement 
		
	  If there is any error, then issue a ROLLBACK command , otherwise issue a COMMIT command.
      
*/

CREATE database Sports;

Use sports;

  -- MySQL saves the changes after the execution of each statement. To save changes automatically
  
SET AUTOCOMMIT = 0;

select * FROM Players;
CREATE Table Players (
ID INT ,
First_name varchar(225),
last_name varchar(225),
Date_Of_Birth date,
Place_Of_Birth varchar(225),
County varchar(225),
PRIMARY KEY (ID)
);

-- Do a transation with autocommit on. 
START transaction; 

insert into Players  values (1, 'shika' , 'dawan' , date('1970-12-2'),'Delhi','india');
insert into Players  values (2, 'Jonathan' , 'trott' , date('1997-8-2'),'Mumbai','South Africa');
insert into Players  values (3, 'kumar' , 'Sangarkkar' , date('1998-2-2'),'Matale','Srilanka');

-- Followwing query saves the changes
COMMIT;
SELECT * FROM players;

insert into Players  values (4, 'Ravindhra' , 'dwan' , date('1980-12-2'),'Deli','idia');
insert into Players  values (5, 'Dhoni' , 'trott' , date('1997-8-2'),'Mumbai','South Africa');
insert into Players  values (6, 'rohit' , 'Sangarkkar' , date('1998-2-2'),'Matale','Srilanka');

SELECT * FROM players;

-- Following statement reverts the changes after the last commit

ROLLBACK;

SELECT * FROM players;


-- ----------------------------------------------------5.WILDCARD and REGEXP -----------------------------------------------------------------------------------
/*

WILDCARD

'%' --> n no of chars
'like'
" _ " or "?" --> any single char
' s% ' --> starts with s ( s is not fixed )
' %s ; --> ends with 's'  ( s is not fixed )
' %s% ' --> contains 's'  ( s is not fixed )
' _s% ' --> 2nd char as 's' ( s is not fixed )

Typically you will use LIKE operator in the WHERE clause of the SELECT , DELETE and UPDATE statement.


*/

USE sakila;

SELECT actor_id , first_name , last_name
FROM actor
WHERE First_name LIKE 'N%' ; -- starting with N

SELECT actor_id , first_name , last_name
FROM actor
WHERE First_name LIKE 'NA%' ; -- starting with NA

SELECT actor_id , first_name , last_name
FROM actor
WHERE First_name LIKE 'joh%y'; 

 /*
 
 REGEXP  -- Regular expression
 
MySQL supports anotherr type of pattern mathching operations based on the regular expression and the REGEXP operator . 
Pattern 	              What the pattern matches 
*                Zero or more instance of string preceding it
+                One or more instance of string preceding it
.                Any single character 
?                Match zero or one instances of the Strings preceding it.
^                caret(^) matches Begining of string 
$                End of string
[abc]            Any Character listed between the Square brackets
[^abc]           Any Character  Not listed between the Square brackets
[A - Z]          Match any upper case letter 
[a - z]          Match any lower case letter
[0-9]            Match any digit from 0 throught to 9. 
[[:<:]]          match begining of Words
[[:>:]]          match end of Words
[:class:]        Matches a charcter class i.e [:alpha:] to matche letters, [:space:] to match white space,
                 [:punct:] is match punctuations and [:upper:] for upper class letters. 
p1|p2|p3         Alteration; matches any of the patterns p1,p2 or p3
{n}              n instances of preceding  element
{m,n}            m through n instances of preceding elements
			
*/

use sakila ; 
select * from actor;

select first_name
 From actor
 where first_name REGEXP '^sa' ; 

-- Match ending of string($): Gives all the first_name ending with 'on'. Example- norton,merton.
select first_name From actor where first_name REGEXP 'on$';

-- Match zero or one instance of the strings preceding it(?): Give all the first_name containing 'JE' .Example - Jennifer , Joe, Jim. 
select first_name From actor where first_name REGEXP 'JE?'; -- contain j or e

-- Match any of the patterns p1,p2,p3(p1|p2|p3): Gives all the first_name containing 'be' or 'ae' .Example - Abel ,Baer. 
select first_name From actor where first_name REGEXP 'be|ae';

-- Matches any character listed between the square bracket([abc]): Give all the first_name containing 'j' or 'z'. Example - Lorentz,
Select first_name From Actor where first_name REGEXP '[JZ]';

/* Matches any lower case letters between 'a' to 'z' - ([a-z]) ([a-z] and (.)): 
Retrive all names that starts with a letter in the range of 'b' and 'g' , followed by any character,
followed by letter 'a'. Example - GRACE , CHARLIZE. 
Matches any single character (.)
*/

select first_name From actor where first_name REGEXP '^[b-g].[a]';  -- first letter b/w b- g and followed by a in 3rd place
select first_name From actor where first_name REGEXP '^[b-g]..[a]'; -- . represents a single character just like _ or ? in wildcard

-- Matches any character not listed between the square bracket([^abc]): Give all the first_names not containing 'j' or 'z'. Example - nick,ed. 
select first_name From actor where first_name REGEXP '[^J|Z]'; -- ^  inside a bracket means it contains 

-- Matches the end of words '\\b':Give all the titiels ending with character "ack". Example - Black. 
Select title FROM film WHERE title REGEXP 'ack\\b'; -- ends with ack

-- Matches the begining of words '\\b':Give all the titiels begining with character "for". Example - Forgetting sarah Marshal. 
Select title FROM film WHERE title REGEXP '\\bfor'; -- starts with for
7
/*
Matches a character class[:class:]:
i.e [:lower:]- lowercase character, [:digit:] digit characters etc.
Gives all the titles containing alphabetic character only. Example - stranger things, Avengers.
*/

Select title FROM film WHERE title REGEXP '[:alpha:]';

Select title FROM film WHERE title REGEXP '[:digit:]';

Select title FROM film WHERE title REGEXP '[:alnum:]'; -- either alphabetic or numeric

Select title FROM film WHERE title REGEXP '[:lower:]'; -- sql is not case sensitive


/* -----------------------------------------------------Session 3: Functions & Operatoins------------------------------------------------------------------
1. AGGREGATION SUM, MIN, MAX, AVG, COUNT
2. Comparison Operators --, 1-,<, >,<,>=, <-
3. LOGICAL AND, OR, NOT, IN, NOT IN, BETWEEN, EXISTS, ANY, ALL, SOME
4. STRING CONCAT, UPPER, LOWER, LEFT, RIGHT, LCASE, LOCATE, MATCH, MID, LENGTH, REPLACE, REVERSE, SUBSTRING, SUBSTR, SUBSTRING INDEX(), TRIM,LTRIM,
*/

-- -----------------------------------------------1.AGGREGATION - SUN, MIN, MAX, AVG, COUNT------------------------------------------------------

use classicmodels;
show tables;
Select max(amount) from payments;
select min(amount) from payments;

select sum(amount), max(amount),min(amount),avg(amount),count(amount) from payments;

-- -----------------------------------------------2. Comparison Operators -  =,!=,<>, >,<,>=,<= --------------------------------------------------

SELECT * FROM payments
WHERE costomerNumber = 114;

SELECT AVG(amount) FROM payments;

select city, count(city)  as cnt from customers
group by city
having cnt>3;

SELECT * from employees
where JobTitle = 'Sales Rep';

SELECT * from employees
where JobTitle != 'Sales Rep';

SELECT * from employees
where JobTitle <> 'Sales Rep';

SELECT * from employees
where JobTitle <= 'Sales Rep';

SELECT * from employees
where JobTitle >= 'Sales Rep';

-- -------------------------------------------------------4. STRING OPERATIONS-----------------------------------------------------------------------------
-- CONCAT, UPPER, LOWER, LEFT, RIGHT, LCASE, LOCATE, MATCH, MID, LENGTH, REPLACE, REVERSE, SUBSTRING, SUBSTR, SUBSTRING_INDEX(), TRIM() , LTRIM() , RTRIM(), 
-- LOCATE() , REPLACE()
-- Find out the lengths of the first names

Use sakila;
SELECT first_name, LENGTH(first_name)
FROM actor;

-- Join the first name and the last name also find the total length of the full name 
-- The CONCAT() function adds two or more expressions together.
SELECT first_name, last_name, CONCAT(last_name, ' ' ,first_name) full_name, length(CONCAT(last_name, ' ' ,first_name)) len_Full_name
From actor;

-- Join the first name and the last name also find the total length of the full name and arrange acording to full name length
SELECT first_name, last_name, CONCAT(last_name, ' ' ,first_name) full_name, length(CONCAT(last_name, ' ',first_name)) len_Full_name
From actor;

-- Join the first name and the last name also convert in to upper and lower case
-- The LOWER() function converts a string tp lower-case. 
-- The LCASE() function is equal to the LOWER() function. 
-- The UPPER() function converts a string tp upper-case. 
-- The function is equal to the UCASE() function. 
SELECT first_name , last_name , lOWER(CONCAT(last_name, ' ' ,first_name)) as lower_name,
                                UPPER(CONCAT(last_name, ' ' ,first_name)) as upper_name 
FROM actor ;

SELECT first_name , last_name , LCASE(CONCAT(last_name, ' ' ,first_name)) as lower_name, 
                                UCASE(CONCAT(last_name, ' ' ,first_name)) as upper_name 
FROM actor ;

-- The LEFT() function extract a number of character from a string (starting from left)
-- The RIGHT() function extract a number of character from a string (starting from right)
SELECT first_name, LEFT(FIRST_NAME,3) , RIGHT(first_name,3)
FROM actor;

-- The SUBSTR() and MID() function equals to the SUNSTRING() function. 
-- The SUBSTR() function extracts a substring from a string (starting at any position). 
use sakila;
-- Substr(str, starting_element , count)
SELECt first_name , SUBSTR(first_name ,2,5) ,SUBSTRING(first_name,1,5) , MID(first_natme,1,5)
FROM actor;  

/* The SUBSTRING_INDEX() function returns a substring of a string efore a specified number of delimiter occurs. 

Syntax
SUBSTRING_INDEX(string,delimiter,number)

string -- original string
delimiter -- The delimiter to search for
number -- The number of times to scearch for the delimiter. Can be both a positive or negitive number. 
If it is a positive number , this functions returns all to the left of the deliiter
If it is a negative number, this functions returns all to the right  of the deliiter
*/

select *, 
Substring_index(title, ' ' ,1) as first_half, 
Substring_index(title, ' ' ,-1) as second_half
from film_text; -- Substring_index(str,delim,count) 

-- Write a Query to Capitalize only the first letter of the First_name
SELECT first_name, CONCAT(LEFT(first_name,1), lcase(substr(first_name,2))) as `first name`
from actor; 

/*
TRIM() function in MySQL is used to clean up data . It is alsso used to remove the umwanted leading and trailing characters in string

Syntax :
TRIM([{BOTH | LEADING| TRAILING }[removed_str] FROM ] str)

Parameter : This method accepts three-parameater as mentioned above described below :

    BOTH | LEADING| TRAILING : LEADING ,TRAILING, or BOTH option to explicitly instruct the TRIM() function to
    remove leading , trailing, or both leading and trailing and trailing unwanted characters from a string .
    By default , the TRIM() function uses the BOTH option. 
    removed_str : IT is a string which we want to remove. If not given , spaces will be removed. 
    str : It identifies the string from which we want to remove removed_str.
    
Returns : It returns a string that has unwanted characters removed. 
 */

 SELECT first_name , TRIM(first_name) 
 From actor;

SELECT first_name, last_name
FROM actor
WHERE TRIM(first_name) = 'GRACE';


SELECT description , TRIM(LEADING 'A ' from description)
from film_text;   
SELECT description , TRIM(TRAILING 'A ' from description)
from film_text;  -- if it doesnt exist it removes nothing but never return a error
SELECT description , TRIM(BOTH 'A ' from description)
from film_text;  

-- LTRIM() is used to remove the leading spaces (spaces on the left side ) from a string. 
-- RTRIM() is used to remove the trailing spaces (spaces on the right side ) from a string.

SELECT TRIM(' SQL Tutorial ') AS TrimmedString; 
SELECT LTRIM(' SQL Tutorial ') AS TrimmedString, length(LTRIM(' SQL Tutorial ')), length((' SQL Tutorial ')); 
SELECT RTRIM(' SQL Tutorial ') AS TrimmedString, length(RTRIM(' SQL Tutorial ')), length((' SQL Tutorial '));

/*
LOCATE() function in MySQL is used for finding the location of a substring in a string.
It will return the location of the first occurrence of the substring in the string.
If the substring is not present in the string then it will return 0.
When searching for the location of a substring in a string it does not perform a case-sensitive search.

Syntax :
LOCATE(subtring,string,start)

Parameters : This method accepts three parameters. 

     substring - The string whose position is to be retrived.
     string - The string within which the position of the substring is to be retrived.
     start - The starting position for the search. It is optional. position 1 is default.
*/
SELECT first_name, LOCATE('LOPE',first_name)
From actor;

SELECT first_name, LOCATE('E',first_name,3)
From actor;

/*
The REPLACE() function replaces all occurrences of a substring within a string, with a new substring. 

Syntax :
   REPLACE(string, from_string, new_string)
   
string -- The original string
from_string -- The substring to be replaced 
new_string --the newreplacement substring
*/

SELECT REPLACE("SQL Tutorial" , "SQL" , "HTML");
SELECT REPLACE("XYZ FGH XYZ" , "X" , "M");
 
Select Reverse("Sql Tutorial"); 

-- _________________________________________  2.Join left join , right join , outer join , cross join , self join_________________________________________________
/*
A relational database consist of multiple related tables linking together using common columns,
which are known as foregin key column, Because of this , data in each table is incomplete from the business perspective.

A join is a method of linking data between one ( self-join) or more tables based on values of the common column between the tables. 

MySQL supports the follwing type of  joins:
     Inner join
     Left join
     Right join
     Full join 
     cross join
     
1. Inner join

The inner join clause joins two tables based on a condition which is known as a join predicate.
The Inner join clause compares each row from the first table with every row from the second table.
If values from both rows satisfy the join condition, the inner join clause creates a new row whose column contains all  columns
of the two rows from both tables and includes this new row in the result set. In other words, the inner join clause includes
only matching rows from both tables.

If the join condition uses the equality operator (-) and the column names in both tables used for watching are the same,
and you can use the USING clause instead:

Syntax:
SELECT column_list
FROM table_1
INNER JOIN table_2
On common_column in table_1 = common_column in table_2;
*/

-- Find the first name and last name and address of a customer who is resides in 'Buenos Aires' district
Use sakila;
SELECT  c.first_name , c.last_name , a.address , a.address_id , a.district
FROM address a
INNER JOIN customer c
On c.address_id = a.address_id
WHERE a.district = 'BUENOS AIRES';

Use sakila;
SELECT  c.first_name , c.last_name , a.address , a.address_id , a.district
FROM customer c
JOIN address a                          -- We can directly use join in place of inner join 
On c.address_id = a.address_id
WHERE a.district = 'BUENOS AIRES';

# 2 or more tables can also be joined using joints
use classicmodels;
-- find customer Number , customerName , orderDate,requiredDate,shippedDate,checkNulmber,paymentDate,amount
SELECT c.customerNumber, c.customerName , o.orderDate,o.requiredDate,o.shippedDate,
p.checkNumber,p.paymentDate,p.amount
from customers c
join orders o
on c.customerNumber = o.customerNumber
join payments p
on o.customerNumber = p.customerNumber;

/*
Left Join
This join returns all the rows of the table on the left side of the join and matches rows for the table on the right side of the join 
For the rows for which there is no matching row on the right side, the result-set will contain null. LEFT JOIN is also known as LEFT.........

Syntax
SELECT table1.column1,table1.column2,table2.column1,..... 
FROM table1
LEFT JOIN table2
ON table1.matching_colummn = table2.matching_column;

*/

-- find customer Number , customerName , orderDate,requiredDate,shippedDate,checkNulmber,paymentDate,amount where paymennt is recived but item is not shipped
SELECT c.customerNumber, c.customerName , o.orderDate,o.requiredDate,o.shippedDate,
p.checkNumber,p.paymentDate,p.amount
from customers c
join orders o
on c.customerNumber = o.customerNumber
LEFT join payments p
on o.customerNumber = p.customerNumber
WHERE o.shippedDate IS  NULL AND p.checkNumber IS NOT NULL;

/*
Right Join 
This join returns all the rows of the table on the right side of the join and matches rows for the table on the left side of the join 
For the rows for which there is no matching row on the left side, the result-set will contain null. 

Syntax
SELECT table1.column1,table1.column2,table2.column1,..... 
FROM table1
Right JOIN table2
ON table1.matching_colummn = table2.matching_column;

*/
-- find top 5 customers as per the amount spend by them using right join
SELECT c.customerNumber , c.customerName,sum(p.amount)
FROM customers c
RIGHT JOIN payments p
on c.customerNumber = p.customerNumber
GROUP BY c.customerNumber
ORDER BY sum(p.amount) desc
limit 5;

/*
Cross Join
The CROSS JOIN keyword returns all records from both tables (tables1 and table2)
CROSS JOIN syntax
SELECT column_name(s)
FROM table1
CROSS JOIN table2;

Note : CROSS JOIN can potentially return very large result-sets!
*/

SELECT customers.customerName,orders.shippedDate
FROM Customers
CROSS JOIN orders;

/* 
Self Join
The self join is often used to query hirarchical data or to compare a row with other rows within the same table. 
*/
select * 
from employees e1
inner join employees e2
on e1.officecode=e2.officecode;

/*
To get the whole organization structure , you can join the employees table to itself using the emloyeeNumber and reports to column
The table employees has two rules : one is Manager and the other  is Direct Reports
*/
select 
   concat(m.lastName, ',',m.firstName) as Manager,
   concat(e.lastname, ',',e.firstname) as 'Direct report'
from 
   employees  e
inner join employees m  
  on m.employeeNumber=e.reportsTo
order by 
  Manager desc;

/*
To get the whole organization structure , you can join the employees table to itself using the emloyeeNumber and reports to column
The following statement uses the LEFT JOIN clause insted of Inner join to include the president 
*/
select 
   IFNULL(concat(m.lastName, ',',m.firstName) ,
     'Top Manager') as 'Manager',
   concat(e.lastname, ',',e.firstname) as 'Direct report'
from 
   employees  e
left join employees m  
  on m.employeeNumber=e.reportsTo
order by
   Manager desc;

-- without ifnull
select 
   concat(m.lastName, ',',m.firstName) as Manager,
   concat(e.lastname, ',',e.firstname) as 'Direct report'
from 
   employees  e
left join employees m  
  on m.employeeNumber=e.reportsTo
order by 
  Manager desc;

-- ------------------------------------------------------------- 3.UNION , UNION ALL. Expert -------------------------------------------------------------
/*
UNION operator

MySQL UNION operator allows you to combine two are  more result set of queries into single result set. 
The following illustrates the syntax of the UNION operator :

SELECT column_list
UNION [DISTINCT | ALL ]
SELECT column_list
UNION [DISTINCT | ALL ]
SELECT column_list
...

To combine  result set of two are more queries using UNION operator these are basic rules that you must follow:
    
         First the number and the order of columns that appears in all SELECT statement must be the same. 
         Second the data type of respective columns should be same
         thirdly the columns should be in the same sequence
         
By default, the UNION operator removes duplicates rows even if you don't specify the DISTINCT operator expicitly. 

*/
use classicmodels;
SELECT 
  firstName,
  lastName
FROM
  employees
UNION 
SELECT 
  contactFirstName, 
  contactLastName
FROM
  customers;

/*
As you can see from the output, the MySQL uses the column name of the first SELECT statement for the column headings of the output

If you want to use another column heading, you need use column aliases explicitly in 
the first selected statement as shown in following example
*/

SELECT 
CONCAT(firstName, ' ' ,lastName) fullname
FROM
employees
UNION 
SELECT CONCAT(contactFirstName,' ' , contactLastName)
FROM
customers;

SELECT 
CONCAT(firstName, ' ' ,lastName) fullname,
'Employee' as contactType -- 'employee' here is a string assigned to full-name column from employees table .					
FROM                      -- This is used to differentiate rows from both the tables
employees
UNION 
SELECT CONCAT(contactFirstName,' ' , contactLastName),
'customer' as contactType
FROM
customers
order by
contactType DESC;

-- combine  rows with UNION
use sakila;
SELECT * FROM sakila.actor;
SELECT * FROM sakila.address;
SELECT 'actor' as tbl, DATE(Last_update) FROM actor
UNION
SELECT 'address' as tbl, DATE(Last_update) FROM address;

/*
If you use UNION ALL explicitly, the duplicate rows, if avaliable, remains in the result. 
Because UNION ALL does not  need to handle dupplicates SELECT 'actor' as tbl, DATE(Last_update) FROM actor
*/ 
SELECT 'actor' as tbl, DATE(Last_update) FROM actor
UNION ALL 
SELECT 'address' as tbl, DATE(Last_update) FROM address;

-- data base not available to excecute 
select city from customers 
where city = 'Berlin'
Union
select city from suppliers 
where city = 'Berlin';

select city from customers 
where city = 'Berlin'
Union all
select city from suppliers 
where city = 'Berlin';

-- ---------------------------------------------------------------4.GROUP BY and HAVING --------------------------------------------------------------
/*
The GROUP BY clause groups a set of rows into a set of summary  rows by values of  columns are expressions.The GROUP BY clause returns

The GROUP BY clause is an optional clause of the SELECT statement. The following illustrates the GROUP BY clause Syntax:

SELECT
        c1,c2,c3........cn, aggregate_function(ci)
FROM
     table
WHERE 
    where_conditions
GROUP BY c1,c2,............cn;
*/

use classicmodels;

select status , count(status)
from orders 
group by status;
-- get the total amount of all orders by status, you join the orders table with the order details table and
-- use the SUM function to calsulate the total amount

SELECT 
  status,
  SUM(quantityOrdered * priceEach) AS amount
FROM 
  orders 
INNER JOIN orderdetails
  using (OrderNumber) 
GROUP BY 
  status;

select year(orderdate) as year,SUM(quantityOrdered * priceEach) AS total
from orders
inner join orderdetails
using(ordernumber)
where status = 'shipped'
group by year 
having year > 2003;
-- where excecutes before group by so if we want to excecute after group by we follow having

/*
The HAVING clause is used in the SELECT statement to specify filter conditions for a group of rows or aggregates.

The HAVING clause is often used with the GROUP BY clause to filter groups based on a specified condition.
If you omit the GROUP BY clause, the HAVING clause behaves like the WHERE clause.

The following illustrates the syntax of the HAVING clause:

SELECT
     select_list
FROM
    table_name
WHERE 
     search_condition
GROUP BY 
     group_by_expression
HAVING
   group_condition;
   

In this syntax, you specify a condition in the HAVING clause.

The having clause evaluates each group returned by GROUP BY clause. If the condition is true the row is included in result set 

Notice HAVING clause applies a  filer condition to each group of rows ,
while the WHERE clause applies the filer condition to each induvidual row.

*/

-- find which order has total sales than 50000

SELECT 
    ordernumber,
    SUM(quantityOrdered) AS itemsCount,
    SUM(priceeach*quantityOrdered) AS total
FROM 
orderdetails
GROUP BY 
ordernumber
HAVING 
total > 50000;

-- find which order has total sales than 50000 and contain more than 600 items

SELECT 
    ordernumber,
    SUM(quantityOrdered) AS itemsCount,
    SUM(priceeach*quantityOrdered) AS total
FROM 
orderdetails
GROUP BY 
ordernumber
HAVING 
total > 50000 AND 
itemscount >600
order by total DESC;

-- ----------------- Any & All Operators -----------------------------------------
/*
The MySQL ANY and ALL Operators

The ANY and ALL operators allow you to perform a comparison between a single column value and a range of other values.

The ANY operator:

           returns a boolean value as a result
           returns TRUE if ANY of the subquery values meet the condition

ANY means that the condition will be true if the operatio is true for any of the values in the range.

ANY Syntax:
SELECT column_name(s)
FROM table_name
WHERE column_name operator ANY 
 (SELECT column_name 
  FROM table_name 
  WHERE condition);
  */
  
SELECT * FROM orderdetails
WHERE orderNumber = ANY 
  (SELECT orderNumber
    FROM orderdetails
    WHERE quantityOrdered =10);
    
/*
The ALL operator: returns a boooleans value as a result 
returns TRUE if ALL of the subquery values meet the condition used with SELECT, WHERE and HAVING statements


all means that thr condition will be true only if the operation is true for all values in the range 

*All Syntax with Select 
Select  All column_name(s)
from table_name 
where condition;

*All syntax with Where or Having 
Select  All column_name(s)
from table_name 
where column_name operator All 
 ( Select column_name
   from table_name
   where condition; 
*/

select all orderNumber
from orderdetails
where true;
 
select * from orderdetails
where ordernumber = all 
( select orderNumber 
  from orderdetails 
  where quantityordered = 30);
  
 --  the above sql statement lists the all data if all the records in the orderdetails table has quantity=30
 -- This will of course return false because the quantity column has many different values (not only 30)
 
 /*
  Some must match atleast one row in the subquery and must be preceded by comparisoon operators
  The some and any comparison conditions are similar to each other and are completely interchangable
 */
select * from orderdetails
where ordernumber = some 
( select orderNumber 
  from orderdetails 
  where quantityordered = 30);
  
/* --------------------------------------------------Session 5: Sub-Queries and Nested Queries -------------------------------------------------
1: Introduction to subquery
2.Single-Row, Multiple-Row Subqueries, Subqueries with ANY and ALL operators , Correalted subqueries
3.Temporary Table
4. Conditional Expressions using CASE WHEN Clause. If else
*/

-- -------------------------- 1. Indtroduction to SubQuery
/* 
A MySQL subquery is a query nested within another query such as SELECT, INSERT, UPDATE or DELETE.
Also, a subquery can be nested within another subquery.
A MySQL subquery is called an inner query while the query that contains the subquery is called an outer query.
A subquery can be used anywhere that expression is used and must be closed in parentheses.
*/

-- Return Data from Multiple tables within IN
Use sakila;
SELECT * FROM 
customer;

SELECT * FROM 
rental;

-- get rental information from 'jennifer'
SELECT * 
FROM rental
WHERE customer_id
in
 (SELECT customer_id 
  FROM customer 
  WHERE first_name = 'Jennifer');

-- sub query used when the output of a table is dependent on another table column 

-- Single-Row Subqueries
/*
A Single-row subquery is used when the outer query's results are based on a single, unknown value. 
Although this query type is formally called "single-row," the name implies that the query returns multiple columns-but only one row of results.
However, a single-row subquery can return only one row of results consisting of only one column to the outer query.

In the below SELECT query, inner MySQL returns only one row i.e. the minimum salary for the company. 
It, in turn, uses this value to compare the salary of all the employees and displays only those, whose salary is equal to minimum salary. 
*/

Use hr;
SELECT first_name,salary, department_id
FROM employees
WHERE salary = (SELECT MIN(salary)
				FROM employees);


-- write a query to find the name (first_name, last_name) and salary of employees
-- who have higher salary than the employee whose last_name= 'FOX' and First_name = 'tyler'
SELECT first_name, salary, Last_name
From employees
WHERE salary > 
         (Select AVG(salary) 
          FROM employees
          where 
            first_name ='Tayler' and last_name='Fox');

-- -- write a query to find the name (first_name, last_name) and salary of employees whose salary is greather than average salary 
SELECT first_name, salary, Last_name
From employees
WHERE salary > 
         (Select AVG(salary) 
          FROM employees);

-- write a query to find the 5th max salary in the employees table
-- First approach
SELECT 
DISTINCT salary
FROM
employees e1
WHERE 5 = (SELECT count(DISTINCT salary) 
           FROM employees e2 
           WHERE e2.salary>= e1.salary);

-- Second approach
SELECT first_name, salary, Last_name From employees AS emp1
WHERE 5-1 = (SELECT COUNT(distinct salary) FROM employees AS emp2 
             WHERE emp2.salary>emp1.salary);

-- Third approach 
SELECT first_name, salary, Last_name 
From employees 
Order by salary DESC
LIMIT 5,1;


-- Multiple-Row subqueries
/*
Multiple-Row subqueries are nested queries that can return more than one row of result to the parent query 
Multiple-Row subqueries are used most commonly in WHERE and HAVING clauses. Since it return multiple rows,
it must be handeled by set of comparison operators (IN, ALL, ANY). While IN operator holds the same meaning disscused in the earlier chapter
ANY operator compares a specified  value  to each value returned by subquery while ALL compares a value to every value returned by a subquery.
the below query shows the error because single-row sub query returns multiple rows.
*/

SELECT first_name, department_ID FROM employees WHERE department_ID =(SELECT department_ID FROm employees WHERE manager_id  = 124);
-- = takes single value so gives an error whenmultiple rows are returned in the sub query
SELECT first_name, department_ID FROM employees WHERE department_ID  IN (SELECT department_ID FROm employees WHERE manager_id  = 124);

SELECT first_name, department_ID FROM employees WHERE department_ID = ANY (SELECT department_ID FROm employees WHERE manager_id  = 124);

SELECT first_name, department_ID FROM employees WHERE department_ID = ALL (SELECT department_ID FROm employees WHERE manager_id  = 124);

-- Multiple rows can directly be written inside FROM clause

-- Correlated Subqueries
/*
Correlated subqueries are used for row by row processing. Each subquery is  executed once for every row of outer query. 
Syntax:
   SELECT 
        colun1,column2,...... 
	table
        table1 t1 
	Where 
		column1 operator 
        (SELECT 
            column1,column2
		 FROM 
             table2 t2 
		 WHERE 
             t2.expr1 = t1.expr2);
			
*/

-- find all the employees who earns more than the average salary  in their department. 
SELECT last_name,salary, department_id
FROM employees e1
Where salary > 
              (SELECT AVG(Salary)
               FROM employees e2 
               WHERE e2.department_id = e1.department_id);

-- ------------------------------------------------- 6. Conditional Expressions using CASE WHEN Clause, if else ------------------------------------------------

/*
MySQL CASE expression is a control flow structure that allows you to add if-else logic to a query.
Generally speaking, you can use the CASE expression anywhere that allows a valid expression e.g., SELECT, WHERE and ORDER BY clauses.

The CASE expression has two forms: simple CASE and searched CASE.

Syntax:
CASE
    WHEN expression1 THEN resulti
    WHEN expression2 THEN result2
    ""
    [ELSE else_result]

END
COde language: SQL (Structured Query Language) (sql)

In this syntax, the CASE evaluates expressions specified in the WHEN clauses. If an expression evaluates to true. 
CASE returns the corresponding result in the THEN clause. Otherwise, it returns the result specified in the ELSE clause.
*/

Use sakila;

SELECT * FROM film;

select distinct rating from film;

/* Rating 
G - General Audience
PG - Parental Guidance
PG-13 - Parental Guidance below 13 years
R- Restricted, Parental Guidance under 17 years
NC-17 - Adult only, above 17 years
*/

SELECT 
    film_id,
    title,
    release_year,
    rating,
    (CASE
        WHEN rating = 'G' THEN 'General'
        WHEN rating IN ('PG' , 'PG-13', 'R') THEN 'Guided'
        ELSE 'Adults'
    END) AS category
FROM
    film;


use book;

-- The status of language is English Book for pub_lang English other wise it returns 'Other Language'.

SELECT book_name, pub_lang
FROM book_mast;

SELECT book_name, pub_lang,
IF(pub_lang='English', 'English Book', "Other Language") 
-- If book name is english then give english book else give other language  
AS Language
FROM book_mast;

 select book_name , isbn_no,
 IF(
 
(Select count(*) from book_mast where pub_lang='English') < (Select count(*) from book_mast where pub_lang <> 'English'),
							(concat('Pages : ',no_page)) , (concat('Price : ',book_price)))
As 'Page / Price'
From book_mast;
      
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------

/* Index :
MySQL uses indexes to quickly find rows with specific column values. Without an index, 
MySQL must scan the whole table to locate the relevant rows. The larger table, the slower it searches.

To add an index for a column or a set of columns, you use the CREATE INDEX statement as follows:

CREATE INDEX index_name ON table_name (column_list)

By default, MySQL creates the B-Tree index if you don't specify the index type. 
The following shows the permissible index-type based on the storage engine of the table:

------------------------------------------------
Storage Engine      |      Allowed Index Types |
--------------------|--------------------------|
InnoDB              |         BTREE            |
MyISAM              |         BTREE            |
MEMORY/HEAP         |         HASH, BTREE      |
------------------------------------------------

*/

-- find employees whose job title is Sales Rep:

SELECT
employeeNumber,
lastname,
firstName
FROM 
   employees
WHERE 
  jobTitle = 'sales Rep';
  
/*
We have 17 rows indicating that 17 employees whose job title is the Sales Rep.

To see how MySQL internally performed this query, you add the EXPLAIN clause at the beginning of the SELECT statement as follows:
*/
EXPLAIN SELECT
employeeNumber,
lastName,
firstName
FROM
employees
WHERE
jobTitle ='Sales Rep';

-- As you can see, MySQL had to scan the whole table which consists of 23 rows to find the employees with the Sales Rep job title.

-- Npow  , lets create an index for the jobTitle column by using the Create Index statement ;

Create Index jobTitle1 on employees(jobTitle);

/* ----------------------------------------------Common Table Expression or CTE--------------------------------------------------------------

common table expression is a named temporary result set that exists only within the execution scope of a single SQL statement 
e.g.,SELECT, INSERT, UPDATE, or DELETE.
Similar to a derived table, a CTE is not stored as an object and last only during the execution of a query.
Unlike a derived table, a CTE can be self-referencing (a recursive CTE) or can be referenced multiple times in the same query.
In addition, a CTE provides better readability and performance in comparison with a derived table.

The structure of a CTE includes the name, an optional column list, and a query that defines the CTE. 
After the CTE is defined, you can use it as a view in a SELECT, INSERT, UPDATE, DELETE, or CREATE VIEW statement.


The following illustrates the basic syntax of a CTE:

WITH cte_name (column_list) AS (
							   query
							   )
SELECT FROM cte_name;

Notice that the number of columns in the query must be the same as the number of columns in the column_list.
If you omit the column_list, CTE will use the column list of the query that defines the CTE
*/

-- list out the names of the customers from country = USA and state = CA
use classicmodels;
WITH customers_in_usa AS (
SELECT 
      customerName, state 
FROM 
      customers
WHERE 
      country = 'USA'
) SELECT 
	  customerName
FROM 
      customers_in_usa
WHERE
      state = 'CA'
Order by
      customerName;
