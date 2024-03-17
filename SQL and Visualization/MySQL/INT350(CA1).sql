--                     Course Name : SQL And  Data Visualization 
--                           Course Code - INT350
--                          Continuous Assessment -1
--                                 SET - 5
               
  /*
  1. Write an SQL query to create the following tables with specific requirements and
insert 10 rows in each of the tables - [5 Marks]
a. Worker(worker_id primary key, first_name, last_name, salary, joining_date,
worker_mail)
b. Reward(worker_id, reward_date, reward_amt)
c. Sample(worker_id, worker_title)
Display the outline and the contents of all the above mentioned tables
  */
  
  -- 1st
  create database CA1;
  use CA1;
  
  -- Create a table 'Worker'
  create table Worker(
  worker_id int not null ,
  first_name varchar(50),
  last_name varchar(50),
  salary decimal(10,2) ,
  joining_date date ,
  worker_mail varchar(50),
  primary key (worker_id)
);

-- Insert 10 rows into the table Worker
insert into Worker
    (worker_id, first_name, last_name, salary, joining_date, worker_mail) values
    (1, 'John', 'Doe',       50000.00, '2023-01-01', 'john.doe@example.com'),
    (2, 'Jane', 'Smith',     55000.00, '2023-02-01', 'jane.smith@example.com'),
    (3, 'Bob', 'Johnson',    60000.00, '2023-03-01', 'bob.johnson@example.com'),
    (4, 'Alice', 'Williams', 52000.00, '2023-04-01', 'alice.williams@example.com'),
    (5, 'David', 'Brown',    48000.00, '2023-05-01', 'david.brown@example.com'),
    (6, 'Ella', 'Davis',     56000.00, '2023-06-01', 'ella.davis@example.com'),
    (7, 'Frank', 'Miller',   53000.00, '2023-07-01', 'frank.miller@example.com'),
    (8, 'Grace', 'Wilson',   58000.00, '2023-08-01', 'grace.wilson@example.com'),
    (9, 'Henry', 'Anderson', 54000.00, '2023-09-01', 'henry.anderson@example.com'),
    (10, 'Olivia','Martinez',59000.00, '2023-10-01', 'olivia.martinez@example.com');


-- Create a table Reward
create table Reward(
 worker_id int not null,
 reward_date date,
 reward_amt decimal(10,2) 
 );
 
 -- Insert 10 rows into the table Reward 
 insert into Reward
    (worker_id,reward_date,reward_amt) Values
	(1, '2023-02-02', 1000.00),
    (2, '2023-03-02', 800.00),
    (3, '2023-04-02', 1200.00),
    (4, '2023-05-02', 750.00),
    (5, '2023-06-02', 900.00),
    (6, '2023-07-02', 1100.00),
    (7, '2023-08-02', 950.00),
    (8, '2023-09-02', 1300.00),
    (9, '2023-10-02', 850.00),
    (10,'2023-11-02', 1050.00);
    
 -- Create a table Sample
  create table Sample(
  worker_id int not null,
  worker_title varchar(50)
  );

-- Insert 10 rows into the table Sample
insert into Sample 
    (worker_id, worker_title) values 
    (1, 'Manager'),
    (2, 'Supervisor'),
    (3, 'Engineer'),
    (4, 'Analyst'),
    (5, 'Technician'),
    (6, 'Supervisor'),
    (7, 'Engineer'),
    (8, 'Analyst'),
    (9, 'Technician'),
    (10, 'Manager');
    
-- Display contents of worker , Reward & Sample table 

select * from Worker; 
select * from Reward;
select * from Sample;    
-- ---------------------------------------------------------------------------------------------------------------------- 
/*
2. Manipulate the above created table – [5 Marks]
a. Create a new column named department in Worker table
b. Set worker_id as foreign key in Reward and Sample tables citingWorker table
c. Add values for department column in Worker table
d. Remove worker_mail column from Worker table
e. Display only the odd records from the table
*/
-- a
alter table Worker
add column department varchar(50) ;

-- b 
alter table Reward
add foreign key (worker_id) 
references Worker(worker_id);

alter table Sample 
add foreign key (worker_id) 
references Worker(worker_id);

-- c 
insert into Worker 
(worker_id, department) values
    (1, 'HR'),
    (2, 'HR'),
    (3, 'HR'),
    (4, 'IT'),
    (5, 'IT'),
    (6, 'IT'),
    (7, 'Finance'),
    (8, 'Finance'),
    (9, 'Finance'),
    (10,'Finance');

-- d 
alter table Worker 
drop column worker_mail;

-- e
select * 
from Worker
where  (woker_id%2) != 0;
-- ------------------------------------------------------------------------------------------------------------------------
/*
3. Write an SQL query to perform the following – [5 Marks]
a. To fetch first_name from Worker table in block letters using the alias name as
“WORKER_NAME”
b. To display unique values from department in Worker table
c. To print the first three characters of first_name from Worker table
d. To print the first_name and last_name from Worker table into a single column
complete_name, separated by a space character
e. To print all the details from Reward table arranging reward_date in ascending
order
*/
-- a 
select UPPER(first_name) as WORKER_NAME 
from Worker;

-- b 
select distinct department 
from Worker;

-- c 
select left(first_name , 3) 
from Worker;

-- d 
select concat(first_name , ' ' ,last_name) as complte_name 
from Worker;

-- e
select * 
from Reward
order by reward_date asc;
-- ----------------------------------------------------------------------------------------------------------------------
/*
4. Perform Functions and retrieve the following information from the table – [5 Marks]
a. To count the number of employees working in a particular department
( dept = “CSE” )
b. To fetch number of workers for each department in descending order
c. Display the current date and time
d. To show the top n (say 5) records of a table
e. Display the number of workers in each department and segregate them into
groups
*/

-- a
select count(*) 
from Worker
where department = 'Finance' ;

-- b 
select department,count(*) as num_of_workers
from Workers
group by department 
order by number_of_works desc;

-- c
select current_date();
select now() as current_date_time;

-- d
select * from Worker
limit 5;

-- e
select department,count(*) as num_of_workers
from Workers
group by department ;
-- ------------------------------------------------------------------------------------------------------------------------
/*
5. Create two different tables Employee and Salary independent of each other [5 Marks]
Employee(emp_id, emp_name, emp_dept)
Salary(emp_id, emp_salary)
a. Fetch all the records of employee whose salary is greater than 25000
b. Create a replica of Employee table named “Employee_Bkp” and store all the
information of employees whose salary is greater than 30000
c. Change employee name to “Sharma” whose salary is 18000
d. Remove the data from Employee table where salary is 18000
*/

-- Create a table Employee
create table Employee(
 emp_id int ,
 emp_name varchar(50),
 emp_dept varchar(50)
);
 
-- Create a table Salary  
create table Salary(
 emp_id int ,
 emp_salary decimal(10,2)
 );
 
 -- a
  select * from Employee
  where emp_id in
    (select emp_id 
     from Salary
     where emp_salary > 25000);
     
-- b 
create table Employee_Bkp 
as   select * from Employee
     where emp_id in
       (select emp_id 
        from Salary
        where emp_salary > 30000);
        
-- c        
update Employee
set emp_name = 'Sharma' 
where emp_id in 
     (select emp_id 
	  from Salary
	  where emp_salary = 18000);
      
-- d 
delete  from Employee
where emp_id in 
     (select emp_id 
	  from Salary
	  where emp_salary = 18000); 
-- ------------------------------------------------------------------------------------------------------------      
/*
6. Create any table of your choice and perform at least two functions in each of the
following categories: [5 Marks]
a. Aggregate
b. In-built
c. Date-Time
d. String
e. Eliminate the created table from database
*/      

-- create a random table Employee
create table Employee(
 emp_id int ,
 emp_name varchar(50),
 emp_dept varchar(50),
 emp_salary decimal(10,2),
 join_date date
);

-- a. Aggrigate ( Avg , Sum , Max , Min ....)
-- 1.Count
select emp_id,Count(*) 
from Employee;

-- 2.Sum
select SUM(emp_salary) as total_sum
from Employee;

-- b.In-Built
-- Upper
select Upper(emp_name)
from Employee;

-- Concat
select Concat(emp_name,'-',emp_dept) as Name_Dept
from Employee;

-- c.Date-Time
-- 1.Current_Date()
select current_date();

-- 2.Now()
select now() as current_date_time;

-- d.String
-- 1.char_length
select char_length(emp_name)
from employee 
where emp_id =3;

-- 2.left()
select left(emp_name,5) as first_5letetrs
from Employee;

-- e
drop table employee;

  
-- ----------------------------------------The End--------------------------------------                           