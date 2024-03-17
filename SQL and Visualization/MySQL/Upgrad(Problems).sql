-- PROBLEM SALVING USING SQL

-- PROFITABILITY ANAYSIS
/*
Problem statement: Identify the sustainable (profitable) product categories so that the growth team can capitalise on them to increase sales.

 
Metrics: Some of the metrics that can be used for performing the profitability analysis are as follows:

Profits per product category
Profits per product subcategory
Average profit per order
Average profit percentage per order
 
Tables: The tables that are required for solving this problem are as follows:

‘market_fact_full’
‘prod_dimen’
‘orders_dimen’
*/
use market_star_schema;
SELECT 
    p.product_category ,
  p.Product_Sub_category,
   SUM(m.profit) as Profits
FROM 
   market_fact_full as m 
INNER JOIN 
   prod_dimen as p
ON m.prod_id = p.prod_id  
GROUP BY 
	 p.product_category,
    p.product_sub_category
ORDER BY 
         p.product_category,
         Profits
    ;
    
-- exploring order table
SELECT ord_id,
       order_number
From 
	orders_dimen
GROUP BY 
	   ord_id,
       order_number
ORDER BY 
      ord_id,
	  order_number
       ;
       
SELECT COUNT(*) AS rec_count,
       COUNT(DISTINCT ord_id) AS ord_id_count,
       COUNT(DISTINCT order_number) as ord_number_count
FROM
   orders_dimen;       

SELECT * 
FROM orders_dimen
WHERE order_number in 
(     
SELECT 
	order_number
FROM
	orders_dimen
GROUP BY order_number
HAVING  COUNT(ORD_ID)>1  
);    

-- Average orofit per order
SELECT 
    p.product_category ,
   SUM(m.profit) as Profits,
   ROUND ( SUM(m.Profit) / COUNT(distinct o.order_number) ,2) as Avg_profit_per_order
FROM 
   market_fact_full as m 
INNER JOIN 
   prod_dimen as p
   ON m.prod_id = p.prod_id
     INNER JOIN 
     orders_dimen as o 
     ON m.ord_id = o.ord_id
GROUP BY 
	 p.product_category
ORDER BY 
         p.product_category,
         Profits
    ;
    
-- 
SELECT 
    p.product_category ,
   SUM(m.profit) as Profits,
    COUNT(distinct o.order_number) as total_orders,
   ROUND ( SUM(m.Profit) / COUNT(distinct o.order_number) ,2) as Avg_profit_per_order,
   ROUND ( SUM(m.Sales) / COUNT(distinct o.order_number) ,2) as Avg_sales_per_order,
   ROUND ( SUM(m.Sales) /SUM(m.Sales) ,2) AS Profit_percentage
FROM 
   market_fact_full as m 
INNER JOIN 
   prod_dimen as p
   ON m.prod_id = p.prod_id
     INNER JOIN 
     orders_dimen as o 
     ON m.ord_id = o.ord_id
GROUP BY 
	 p.product_category
ORDER BY 
         p.product_category,
         Profits
    ; 
    
-- ------------------------------------------------

-- Profitable Customers
/*
Problem statement: Extract the details of the top ten customers in the expected output format.
expected format :
cust_id
rank
customer_name
profit
customer_city
customer_staTE
sales 

Tables: The tables that are required for solving this problem are as follows:
‘cust_dimen’
‘market_fact_full’  

  */  

-- Exploring cust_dimen  
SELECT   
     cust_id,
     customer_name,
     city as customer_cuity,
     state as customer_state
FROM
		cust_dimen;

-- ranking 
WITH cust_summary as 
(
SELECT   
     c.cust_id,
     RANK() OVER(ORDER BY SUM(profit) DESC) AS CUSTOMER_RANK,
     customer_name,
     ROUND(SUM(profit),2) as profit,
     city as customer_cuity,
     state as customer_state,
     ROUND(SUM(sales),2) as sales
FROM
		cust_dimen  AS c
        INNER JOIN 
           market_fact_full as m
           on m.cust_id = c.cust_id
           
GROUP BY    cust_id        
)    
select * from cust_summary
-- To select top 10 
WHERE customer_rank<= 10   ;

-- ---------------------------------------------------------
-- Orders Placed

/*
Problem statement: Extract the required details of the customers who have not placed an order yet.

 

Expected columns: The columns that are required as the output are as follows:

‘cust_id’
‘cust_name’
‘city’
‘state’
‘customer_segment’
A flag to indicate that there is another customer with the exact same name and city but a different customer ID.
 

Tables: The tables that are required for solving this problem are as follows:

‘cust_dimen’
‘market_fact_full’
*/

-- exploring cus_dimen

select * 
from cust_dimen;

-- list all customers who havent placed any order 

SELECT c.* 
FROM
    cust_dimen AS c
LEFT JOIN 
    market_fact_full AS m
    ON m.cust_id = c.cust_id
WHERE m.ord_id   IS NULL ;  

-- Checking is no such cust exist

select count(cust_id) from cust_dimen;
-- 1832
select count(distinct cust_id) from market_facct_full;
-- 1832
 
-- people who placed only 1 order 

-- Exploring orders by user
SELECT c.* ,
		count(DISTINCT ord_id) as order_count 
FROM
    cust_dimen AS c
LEFT JOIN 
    market_fact_full AS m
    ON m.cust_id = c.cust_id
GROUP BY CUST_ID
HAVING  ORDER_COUNT <> 1;  

-- -------------------------------------------------------------

-- FRAUD DETECTION
 -- WEATHER USER HAS same NAME AND CITY FOR UNIQUE CUST ID
 
-- UNIQUE CUST NAME AND CITY CHECK 
SELECT customer_name , city , 
		count(cust_id) as cust_id_count
from cust_dimen
group by customer_name ,city  
having count(cust_id)>1; 

-- Final output
With cust_details as(
SELECT c.* ,
		count(DISTINCT ord_id) as order_count 
FROM
    cust_dimen AS c
LEFT JOIN 
    market_fact_full AS m
    ON m.cust_id = c.cust_id
GROUP BY CUST_ID
HAVING  ORDER_COUNT <> 1 
),
fraud_cust_list as
(SELECT customer_name , city , 
		count(cust_id) as cust_id_count
from cust_dimen
group by customer_name ,city  
having count(cust_id)>1 )

Select cd.*,
       case when fc.cust_id_count  is not null 
       then  "fraud"
       else "normal"
       end as fraud_flag
from 
   cust_details as cd
   left join 
   fraud_cust_list as fc
   on cd.customer_name = fc.customer_name and 
   cd.city = fc.city;
   

