create DATABASE STUDENT;

USE student;

create TABLE MARKS (

 REG_NO INT(8) UNIQUE  NOT NULL,
 NAME VARCHAR(30),
 SUBJECT_NAME VARCHAR(20),
 MARKS INT(3),
 PRIMARY KEY (REG_NO) 
 );
 
 INSERT INTO MARKS (REG_NO , NAME , SUBJECT_NAME, MARKS) VALUES 
 ( 12110554 , 'jULFEEN' , 'INT350' , 95);
 
 SELECT * FROM MARKS;
 
 drop database student;
 
 -- Aug 14 
 
 create database Employee;
 use employee;
 
 create table personnel (
 EMP_id int not null unique,
EMp_NAme char(50) ,
designation char(20),
department int(10),
phone_no int(10),
aadhar_no int(12) Unique not null,

primary key(emp_id) 
 );
 -- Candidate keys ( keys which have possibility of becoming a primary key)
 -- alternate keys - those candidate keys whicha re not slected as primary key
 
 select * from personnel;
 
 insert into personnel ( emp_id, emp_name ,designation,department , phone_no , aadhar_no) Values
 
 (10001, 'ABC' , 'SDE' ,03 , 951236847, 1234567890);
 
 select * 
 from personnel;
 
 use sakila;
  
  -- fine no of coulumns in table actor having null values
 select count(*) as Null_count 
 from actor
 where actor_id is null;
 
 -- Aug 28
 
 -- Inheritence 
  use imdb;
  
  
  -- parent table 
  drop table if exists employees;
  create table employees (
   employee_id int primary key,
   first_name varchar(50),
   last_name varchar(50),
   hore_date date
   );
   
   alter table employees 
    rename column hore_date to hire_date;
   
-- Create the child tables inheriting from employees
create table salary (
 employee_id int primary key ,
 anual_salary decimal(10,2),
 foreign key (employee_id) references employees(EMployee_id)
 );
 
 -- hr table
 create table dept (
 employee_id int primary key ,
 department varchar(15),
 foreign key (employee_id) references employees(EMployee_id)
 );
   
   
--  Insert data 

insert into employees (employee_id , first_name , last_name , hire_date ) values 
(1,'Aman','Varma','2023-01-01');
delete  from employees where employee_id=1;
insert into employees (employee_id , first_name , last_name , hire_date ) values 
(2,'Ajay','Varma','2023-01-02');
insert into employees (employee_id , first_name , last_name , hire_date ) values 
(3,'Akash','Varma','2023-01-03');

select * from employees;

insert into salary (employee_id , anual_salary ) values 
(1,75000.00),
(2,95000.00),
(3,85000.00);

insert into dept (employee_id , department ) values 
(1,'IT'),
(2,'HR'),
(3,'FI');

-- Query the data

select *
from employees e 
join salary s 
on e.employee_id = s.employee_id;

select *
from employees ,salary ; -- cross join or cartesian product 

drop tables employees , salary , dept;

-- Sep 11
/*
-- Rank()
contains order by always within the structure 
-- partion by is optional 
*/
create table t (
 val int );
 
 insert into t(val) values
 (1),(2), (2),(3),(4), (4),(5),(6), (7),(8);

-- rank() 
select val , rank() over (
            order by val
            ) as my_rank
from t;            

-- dense rank()
select val , dense_rank() over (
            order by val
            ) as my_rank
from t;      

-- percent_rank()
select val , percent_rank() over (
            order by val
            ) as my_rank
from t;      

-- row_number()
select val , row_number() over (
            order by val
            ) as my_rank
from t;      

-- partion() split the rows of the table into multiple tables
-- it can be horizotal or vertical

-- in horizontal column wll be same and rows differ
-- MYSQl works on horizontal partitioning 

-- in vertical partitioning rows remain same columns differ

alter table t1 
partition  by range(val) ( -- range partitioning
  partition p1 values less than (5) ,
  partition p2 values less than maxvalue 
  );
  
select   * from t1 partition(p1);


-- Frames

create table stationery ( 
category varchar(20) ,
brand varchar(20),
product_name varchar(20),
price int , 
primary key (product_name )
);

insert into stationery values ('Pen' ,'Alpha', 'Alpen' ,280);
insert into stationery values ('Pen' ,'Fabre', 'Fapen',250);
insert into stationery values ('Pen' ,'Camel', 'Capen',220);
insert into stationery values ('Board' ,'Alpha', 'Alord', 550);
insert into stationery values ('Board' ,'Fabre', 'Faord',400);
insert into stationery values ('Board' ,'Camel', 'Carod',250);
insert into stationery values ('NOtebook' ,'Alpha', 'Albook' ,250);
insert into stationery values ('NOtebook' ,'Fabre', 'Fabook',230);
insert into stationery values ('NOtebook' ,'Camel', 'Cabook',210);


select price, category,brand,
first_value(prdouct_name) over 
                ( partition by category 
                  order by price desc )  as expesive_product 
from stationery;

select price, category,brand,
last_value(product_name) over 
             (partition by category 
              order by price desc) as cheap_product
from stationery;

-- case 

select product-name , price,
case
   when price > 400 then 'Expensive'
   when price > 249 then 'Moderate'
   else 'cheap'
 end 
 from stationery;
 
 
 -- --------------UDF 
 /*
 -- User Define Functions (udfs) - returns void
 -- part of pl sql in oracle
 
 create functon function_nme 9func_parameter1 , func_parameter2, .....)
 return datatype [charecteristics]
 -----       func_body 
 begin 
 <Sql Statement >
 return expression;
 end $$
 
 delimeter;
 */
 
 -- Stored Procedure 
  -- used to carry out statements which are often repeated 
  -- returns null
  
  
-- Indexing 
  -- necesary for querying large data  