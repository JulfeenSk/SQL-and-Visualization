
-- -------------------------------SQL-Advance-----------------------

/*
-- Rank Syntax
RANK() OVER (
  PARTITION BY <expression>[{,<expression>...}]
  ORDER BY <expression> [ASC|DESC], [{,<expression>...}]
)
*/

-- Rank Demo

USE market_star_schema;

SELECT  customer_name,
		ord_id,
		ROUND(sales) AS rounded_sales,
        RANK() OVER (ORDER BY sales DESC) AS sales_rank
FROM market_fact_full as m
INNER JOIN
cust_dimen as c
ON m.cust_id = c.cust_id
WHERE customer_name= 'RICK WILSON';

-- Top 10 sales orders from a customer

WITH rank_info AS -- Common table
(
SELECT  customer_name,
		ord_id,
		ROUND(sales) AS rounded_sales,
        RANK() OVER (ORDER BY sales DESC) AS sales_rank
FROM market_fact_full as m
INNER JOIN
cust_dimen as c
ON m.cust_id = c.cust_id
WHERE customer_name= 'RICK WILSON'
)
SELECT *
FROM rank_info
WHERE sales_rank<=10;

-- ------------------------------------------------------------------------------------
/*
--  types of rank functions:
RANK(): Rank of the current row within its partition, with gaps
DENSE_RANK(): Rank of the current row within its partition, without gaps
PERCENT_RANK(): Percentage rank value, which always lies between 0 and 1

-- Dense_rank()
DENSE_RANK() OVER (
  PARTITION BY <expression>[{,<expression>...}]
  ORDER BY <expression> [ASC|DESC], [{,<expression>...}]
)

-- Percent_rank()
PERCENT_RANK() OVER (
  PARTITION BY <expression>[{,<expression>...}]
  ORDER BY <expression> [ASC|DESC], [{,<expression>...}]
)
*/
-- Example for Dense Rank
SELECT ord_id,
		discount,
        customer_name,
        RANK() OVER (ORDER BY discount DESC) AS disc_rank,
        DENSE_RANK() OVER (ORDER BY discount DESC) AS disc_dense_rank        
FROM market_fact_full as m
INNER JOIN cust_dimen as c
ON m.cust_id=c.cust_id
WHERE customer_name= 'RICK WILSON';

-- Number of orders each customer has placed

SELECT customer_name,
		COUNT(DISTINCT ord_id) AS order_count,
        RANK() OVER (ORDER BY COUNT(DISTINCT ord_id) DESC) AS order_rank,
        DENSE_RANK() OVER (ORDER BY COUNT(DISTINCT ord_id) DESC) AS order_dense_rank,
        ROW_NUMBER() OVER (ORDER BY COUNT(DISTINCT ord_id) DESC) AS order_row_num
FROM market_fact_full AS m
INNER JOIN
cust_dimen AS c
ON m.cust_id=c.cust_id
GROUP BY customer_name;

-- Partitioning example
WITH shipping_summary AS
(
SELECT ship_mode,
		MONTH(ship_date) AS shipping_month,
        COUNT(*) as shipments
FROM 
shipping_dimen
GROUP BY ship_mode,month(ship_date)
)
	select *,
    rank() over (
    partition by ship_mode
    order by shipments desc) as shipping_rank
    from shipping_summary;

-- Names window example
select ord_id ,
       discount,
       customer_name,
       rank() over w as disc_rank,
       dense_rank() over w as disc_dense_rank,
       row_number() over w as disc_row_num,
       percent_rank() over w as disc_percent_rank
from market_fact_full as m 
inner join cust_dimen as c 
on m.cust_id = c.cust_id
window w as (partition by customer_name order by discount desc) ;     

-- Frames example
WITH daily_shipping_summary AS
(
SELECT ship_date,
		SUM(shipping_cost) AS daily_total
FROM
market_fact_full AS m
INNER JOIN
shipping_dimen AS s
ON m.ship_id=s.ship_id
GROUP BY ship_date
)
SELECT *,
		SUM(daily_total) OVER w1 AS running_total, -- running total 
        AVG(daily_total) OVER w2 AS moving_avg  -- moving average
FROM daily_shipping_summary
WINDOW w1 as (ORDER BY ship_date ROWS UNBOUNDED PRECEDING),
w2 AS (ORDER BY ship_date ROWS 6 PRECEDING);

-- -----------------------------------------------------------------
/*
The syntax for using the ‘lead’ and ‘lag’ functions are as follows:

LEAD(expr[, offset[, default]])
  OVER (Window_specification | Window_name) 
 

LAG(expr[, offset[, default]])
  OVER (Window_specification | Window_name)
*/

-- Lead and Lag example
WITH cust_order as
(
	SELECT c.customer_name,
			m.ord_id,
			o.order_date
	FROM
	market_fact_full as m
	LEFT JOIN
	orders_dimen as o
	ON m.ord_id=o.ord_id
	LEFT JOIN
	cust_dimen as c
	ON m.cust_id=c.cust_id
	WHERE customer_name='RICK WILSON'
	GROUP BY 
			c.customer_name,
			m.ord_id,
			o.order_date
),
next_date_summary AS 
(
SELECT *,
		LEAD(order_date,1,'2015-01-01') OVER (ORDER BY order_date, ord_id) AS next_order_date
FROM cust_order
ORDER BY customer_name,
		 order_date,
         ord_id
)
SELECT *, DATEDIFF(next_order_date, order_date) as days_diff
FROM next_date_summary;
-- -----------------------------------------------------------------------------
/*
-CASE STATEMENT
CASE
  WHEN condition1 THEN result1
  WHEN condition2 THEN result2
  .
  .
  WHEN conditionN THEN resultN
  ELSE result
END AS column_name;
*/
-- Case when example
/*  profit < -500 -> huge loss
	profit -500 to 0 ->bearable loss
    profit 0 to 500 -> decent profit
    profit >500 -> great profit
*/
SELECT 
	market_fact_id,
    profit,
	CASE
		WHEN profit <-500 THEN 'Huge Loss'
        WHEN profit BETWEEN -500 AND 0 THEN 'Bearable Loss'
        WHEN profit BETWEEN 0 AND 500 THEN 'Decent Profit'
		ELSE 'Great Profit'
    END AS Profit_type
FROM
    market_fact_full;
    
-- Classify customers on the following criteria
-- Top 10 % of customers as Gold
-- Next 40% of customers as Silver
-- Rest 50% of customers as Bronze

WITH cust_summary AS
(
	SELECT m.cust_id, 
			c.customer_name, 
			ROUND(SUM(m.sales)) as total_sales,
			PERCENT_RANK() OVER( ORDER BY ROUND(SUM(m.sales)) DESC) as perc_rank
	FROM
		market_fact_full as m
		LEFT JOIN 
		cust_dimen as c
	ON
		m.cust_id=c.cust_id
	GROUP BY cust_id
)
SELECT *,
		CASE 
			WHEN perc_rank<0.1 THEN 'Gold'
            WHEN perc_rank<0.5 THEN 'Silver'
            ELSE 'Bronze'
		END AS customer_category
FROM cust_summary;

-- --------------------------------------------------------------------
/*
-- User Defined Functions
DELIMITER $$

CREATE FUNCTION function_name(func_parameter1, func_parameter2, ...)
  RETURN datatype [characteristics]
/      func_body      /
  BEGIN
    <SQL Statements>
    RETURN expression;
END $$

DELIMITER ;
 
-- to Use function in any other queries
CALL function_name;

-- Remember the following points:

The CREATE FUNCTION is also a DDL statement.
The function body must contain one RETURN statement.
*/
-- UDFs
DELIMITER $$

CREATE FUNCTION profitType(profit int)
RETURNS VARCHAR(30) DETERMINISTIC

BEGIN

DECLARE message VARCHAR(30);
IF profit<-500 THEN
	SET message = 'Huge Loss';
ELSEIF profit BETWEEN -500 AND 0 THEN 
	SET message = 'Bearable Loss';
ELSEIF profit BETWEEN 0 AND 500 THEN
	SET message = 'Decent Profit';
ELSE
	SET message = 'Great Profit';
END IF;

RETURN message;

END;
$$
DELIMITER ;

SELECT profitType(-20) as Function_output;

/*
--Stored procedures
DELIMITER $$

CREATE PROCEDURE Procedure_name (<Parameter List>)
BEGIN
  <SQL Statements>
END $$

DELIMITER ;
 

CALL Procedure_name;
*/

-- Stored Procedures

DELIMITER $$

CREATE PROCEDURE get_sales_customers (sales_input INT)
BEGIN
	SELECT DISTINCT cust_id,
					ROUND(sales) AS sales_amount
	FROM
		market_fact_full
	WHERE ROUND(sales)>sales_input
    ORDER BY sales;
    
END $$

DELIMITER ;

CALL get_sales_customers(300);

DROP PROCEDURE get_sales_customers;

-- ------------------
/*
Cursor: It is used to individually process each row that is returned in a query.
*/
-- ----------------------------------------------------
-- Query Optimization  best practices 

/*  
1.Comment your code by using a hyphen (-) for a single line and (/* ... * /) for multiple lines of code.

2.Always use table aliases when your query involves more than one source table.

3.Assign simple and descriptive names to columns and tables.

4.Write SQL keywords in upper case and the names of columns, tables and variables in lower case.

5.Always use column names in the ‘order by’ clause, instead of numbers.

6.Maintain the right indentation for different sections of a query.

7.Use new lines for different sections of a query.

8.Use a new line for each column name.

9.Use the SQL Formatter or the MySQL Workbench beautification tool (Ctrl+B).

*/
   -- Query best practises
      -- Comment Section

/*
Comment Section with
multiple lines
*/

-- use table alias
SELECT fact.ord_id, order_date
FROM market_fact_full AS fact INNER JOIN orders_dimen AS ord ON fact.ord_id = ord.ord_id
ORDER BY fact.ord_id , order_date;

-- with indentation (use ctrl + B for sql beautification tool) 
SELECT fact.ord_id,
       order_date
FROM   market_fact_full AS fact
       INNER JOIN orders_dimen AS ord
               ON fact.ord_id = ord.ord_id
ORDER  BY fact.ord_id,
          order_date;  
          
-- -----------------------------------------------------------------------------------------

-- Index Demo
/*
The command for creating an index is as follows:

CREATE INDEX index_name
ON table_name (column_1, column_2, ...);
 

The command for adding an index is as follows:

ALTER TABLE table_name
ADD INDEX index_name(column_1, column_2, ...);
 

The command for dropping an index is as follows:

ALTER TABLE table_name
DROP INDEX index_name;
 
*/
CREATE TABLE market_fact_temp AS
SELECT * 
FROM
	market_fact_full;

CREATE INDEX filter_index ON market_fact_temp (cust_id, ship_id, prod_id);

ALTER TABLE market_fact_temp DROP INDEX filter_index;

-- ------------
SELECT * FROM market_fact_full;
/*
-- Types of Indexes

Clustered Index                              	Non-Clustered Index
This is mostly the primary key of the table.	This is a combination of one or more columns of the table.
It is present within the table.               	The unique list of keys is present outside the table.
It does not require a separate mapping.      	The external table points to different sections of the main table.
It is relatively faster.	                   It is relatively slower.

*/
-- ----------------------------------------------------------------------------

-- Query Optimisation with understanding of Order of Query execution
/*
-- Order of apperance
SELECT
FROM
[JOIN]
WHERE
GROUP BY
HAVING
WINDOW
ORDER BY
  
-- Order of Excecution
 FROM
[JOIN]
WHERE
GROUP BY
HAVING
WINDOW
SELECT
DISTINCT
ORDER BY
LIMIT 
OFFSET

*/

/*
-- Some of the important points that you should keep in mind while writing a query are as follows:

Use inner joins wherever possible to avoid having unnecessary rows in the resultant table.

Apply all the required filters to get only the required data values from multiple tables.

Index the columns that are frequently used in the WHERE clause.

Avoid using DISTINCT while using the GROUP BY clause, as it slows down query processing.

Avoid using SELECT * as much as possible. Select only the required columns.

Use the ORDER BY clause only if it is absolutely necessary, as it is processed late in a query.

Avoid using LIMIT and OFFSET as much as possible. Instead, apply appropriate filters using the WHERE clause.
*/

-- Problem: Top 10 order ids and the customers who did them

SELECT ord_id,
		customer_name 
FROM
(
SELECT  m.*,c.customer_name,
        RANK() OVER (ORDER BY sales DESC) AS sales_rank,
        DENSE_RANK() OVER (ORDER BY sales DESC) AS sales_dense_rank,
        ROW_NUMBER() OVER (ORDER BY sales DESC) AS sales_row_num
FROM 
market_fact_full as m
LEFT JOIN
cust_dimen as c
ON m.cust_id = c.cust_id
ORDER BY sales desc
) as a
LIMIT 10;



SELECT ord_id,
		customer_name 
FROM
(
SELECT  ord_id,c.customer_name,
        ROW_NUMBER() OVER (ORDER BY sales DESC) AS sales_row_num
FROM 
market_fact_full as m
INNER JOIN
cust_dimen as c
ON m.cust_id = c.cust_id
) as a
WHERE sales_row_num<=10;

/*
Joins vs nested queries: \
Executing a statement with the ‘join’ clause creates a join index,
which is an internal indexing structure. 
This makes it more efficient than a nested query.
However, a nested query would perform better than a join while querying data from a distributed database.
*/









