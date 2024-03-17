-- SQL CA2
/*
1. Suppose you're given the following tables called 'orders' and 'order_info'. The table
'orders' shows revenue values for unique orders along with the associated channel ('online'
or 'in_store') while the table 'order_info' shows the order's ID along with its location.
Table: Orders 							Table: Order_info
order_id channel date month revenue     order_id location
1 online 01-09-2020 00:00 9 100			 1		 NYC
2 online 03-09-2020 00:00 9 125			 2		 NYC
3 in_store 11-10-2020 00:00 10 208 		 3		 LAX
4 in_store 21-08-2020 00:00 8 80 		 4		 LAX
5 online 13-08-2020 00:00 8 200 		 5		 SEA
6 online 16-08-2020 00:00 8 210 		 6 		 AUS
7 in_store 16-08-2020 00:00 8 205 		 7 		 LON
8 online 11-10-2020 00:00 10 215 		 8		 LAX
9 online 16-08-2020 00:00 8 203 		 9 		 BLD
10 in_store 01-09-2020 00:00 9 400 		 10 	 SEA
11 online 01-08-2020 00:00 8 107 		 11		 AUS
Using these tables, write a SQL query to return the top 3 'online' orders and their
associated locations based on revenue generated. [5
marks]

*/
select o.order_id , o.channel , i.location 
from Orders o 
inner join order_info i 
on o.order_id = i.order_id
where channel = 'online'
order by revenue desc
limit 3; 

/*
2. Consider the following table, annual_sale, shown below:
year total_sale
2015 23000
2016 25000
2017 34000
2018 32000
2019 33000
Use lag() and lead() function to compare annual sale amounts across years
*/
select year,total_sale ,
       lag(total_sale) over (order by year) as previous_year_sale,
       lead(total_sale) over (order by year) as next_year_sale
from annual_sale
order by year;

/*
3. What is the difference between Stored Procedures and UDFs. 
*/

/*
			UDF	Stored													 Procedure
 It supports only the input parameter, not the output.	 It supports input, output and input-output parameters.
 It cannot call a stored procedure.	 					 It can call a UDF.
 It can be called using any SELECT statement.	 		 It can be called using only a CALL statement.
 It must return a value.	 							 It need not return a value.
 Only the ‘select’ operation is allowed.	  			 All database operations are allowed.
*/
       