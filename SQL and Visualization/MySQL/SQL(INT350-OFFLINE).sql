-- Aug 4
Create database db1;
use db1;
drop database if exists db1;
-- Aug 11
create database UG;
use ug;
/* DDL - Data Definition Language (CADT)
   -Create - create a table / database
   -Alter - modify a structure 
   -Drop - delete a structure (table/database)
   -Truncate - delete the values 
   */
    -- varchar - variable length , utilises only required charecter size
    -- char - fixed length , utilises full size assigned 
create table Information(
  id int NOT NULL primary key ,
  student_name varchar(50) not null,             
  marks int
  );
  
  /* DML - Data Manipulation Language
	- Insert 
    - Update 
    - Delete */
    
 insert into Information (id , student_name , marks) Values
 (12110554, 'name1', 92),
 (12113102, 'name2', 90);
 select * from Information;
 
 update Informaation
 set student_name = 'User1' where id=12110554;
 select * from Information;
 
 delete from information 
 where id = 12113102;
 select * from INformation ;  -- deletes a row from tables
 
 truncate information ; -- empties the table
 drop table information; -- removes table from database
 drop database ug; -- deletes database
 
 -- alter table Information
 -- add   Information (12110549, 'name3', 99);
 
 /* TCL - Transaction Control Language 
  -Commit - changes cannot be undone
  -Roll back - going tp previous transaction/querie
  -Savepoint - used to save progress till a particular point*/
  
/* DCL - Data Control Language
   - Grant 
   - Revoke */  
-- TCl Dcl managed by DBA - data base administrator
-- ---------------------------------------------------------------------------------------------
-- 18th Aug
-- DQL - Data Query Language
-- Imported sakila database

use  sakila;
select * from city;
select city_id from city;

select * from actor;
select count(actor_id) from actor;
describe actor;

-- Serach Clauses - WHere - perfrom a simple search
--                - Having - 

select * from country 
where country = 'India'; -- displays particular row of table country  if India exits in column country 

select * from country 
where country = 'Usa'; -- if the value doesnt exist it returns  a null values

select * from country 
where country = 'India' or country ='China' ; -- when used a and returns null value 

select * from country 
where country != 'India';

select * from country 
where country_id in (1,2,3,4,5,6,7,8,9,10);

select * from country 
where country_id <= 10;

select * from customer;
select * from customer
where store_id = 1 or active =1 ;

select * from customer
where store_id in (1,2) or active =1 ;

select count(customer_id) from customer
where store_id = 1 and active =1 ;

select count(customer_id) from customer;
describe customer;

select * from customer
where first_name in ('Erica','Sandra') and last_name in ('Martin','Matthews');

select * from customer 
where first_name like'A%'; -- first name starting with A

-- Aug 21st 
-- Group by , order by , limit , offset

-- Aug 25
-- 2 clauses for searching -> Where - simple searching 
--                         -> Having - used for aggrigate searching

-- #Aggrigate - summarize entire rows of column into 1 values
-- Aggrigate includes sum , count , average , standard deviation , median 

-- having always comes with group by

use sakila ; 

select * from payment;

select customer_id,avg(amount) 
from payment
group by customer_id
having avg(amount)>5
order by avg(amount) desc;

select customer_id,avg(amount) 
from payment
where customer_id between 100 and 400
group by customer_id
having avg(amount)>5
order by avg(amount) desc
limit 2
offset 5;

-- Joints

-- # Condition for joints -> presence of similar columns  
--                        -> have similar data strcture and same data repository

-- 6 types of joints 
-- Inner  
-- Outer 
-- Right 
-- Left 
-- Cross
-- Self

-- basic structure of joints 
/*
slect column_name from
from table_t1
type_join
table_t2
on table1.col1 = table2.col3
*/

select * 
from customer c1
inner join 
payment p1 
on c1.customer_id =p1.customer_id;
-- group by customer_id;

select * 
from customer c1
left join 
payment p1 
on c1.customer_id =p1.customer_id;

-- Aug 28
create database test ;

use test ;

create table Person(
person_id int Not null ,
person_name varchar(20) ,
Address varchar(50) ,
primary key (person_id)
); 

create table Orders (
Order_id int Not null ,
product varchar(50) Not Null,
person_id int Not Null  ,
amount int 

) ;

alter table Orders
add foreign key (person_id) references
person(person_id) ;

insert  into person (person_id , person_name , address) values
(1,'User1','Mumbai') ,
(2,'User2','Chennai'),
(3,'User3','Delhi'),
(4,'User4','Pune'),
(5,'User5','Goa'),
(6,'User6','Kolkata');

select * from person;

insert  into orders () values
(101,'ORD101',1,999),
(102,'ORD102',2,1999),
(103,'ORD103',3,2999),
(104,'ORD104',4,999),
(105,'ORD105',5,499);

select * from orders;
 

-- Inner join 
select *
 from orders o
inner join person p
on o.person_id = p.person_id;

-- left join 
select *
from orders o 
left join person p 
on p.person_id = o.person_id;

-- right join 

select *
from orders o 
right join person p 
on p.person_id = o.person_id;

-- full join 
((select *
from orders o 
left join person p 
on p.person_id = o.person_id)
 union 
(select *
from orders o 
right join person p 
on p.person_id = o.person_id
));

-- self join 

select *
from orders o 
inner join orders ord
on ord.order_id = o.order_id;

-- cross join 

select * 
from orders 
cross join person;

-- Sep 1

-- Insersection : does contain duplicate values unlike inner join


-- Views -- created for query optimization

/*create view v1
as (Query)
*/
 
-- Query optimization -- reduce memory and time 


-- Sep 4

/*
-- Function - set of reusable code used to perform a specific set of instructions

1.Aggrigate Function
2.String Function -- concat() , left(), right() ,substr() , lower(), Upper(), Lcase(), Ucase() , Length(), Trim() ,LTrim() Rtrim() , Replace(), Locate()
3.Date & Time function

*/

/*
-- Sub Query - query inside  a query 

*/


-- 8th Sep
-- ------------------------------------------------------------Data Modeling---------------------------------------------------

/*
# Data Modelling is picturising the data. it helps us in understanding the relationshiop amongst entities 
# 3 types of layers 
-- > Conceptual layer - description of the tables 
-- > Logical layer - describe relationship among data in the data
-- > Physical layer - how tables look like

*/

/*  
Schemas 
-- Snowflake Schema - a single fact table connected to many dimension tables 
-- Star Schema - a single fact table connected to dimension tables in which dimesion tables are further connected to other dimension tables 
*/

-- 11th Sep

-- Functions 

/*
window() function 
-- sub clauses 
  over()
  group by ()
  partition by ()
  order by()

-- Ranings()
   rank
   dense rank 
   row no 
   percentile rank
*/

-- Sep 15

/*
-->  CASE.....When........
-Syntax
CASE
    WHEN expression1 THEN resulti
    WHEN expression2 THEN result2
    ""
    [ELSE else_result]
END

-- > UDF 

-->Cursor , INdex
*/
use sakila;

SELECT 
     film_id,title,release_year,rating,
(CASE

     WHEN rating ='G' THEN 'General'
     WHEN rating IN ('PG','PG-13','R') then 'Guided'
     ELSE 'Adults'
End) AS category 
FROM     film;