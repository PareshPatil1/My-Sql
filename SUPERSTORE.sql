/* Description of the dataset  
1. cust_dimen: having all data of customers 
		  a) Customer_Name (TEXT): Name of the customer
          b) Province (TEXT): Province of the customer
          c) Region (TEXT): Region from where the customer belongs
          d) Customer_Segment (TEXT): Segment from where the customer buy products
          e) Cust_id (TEXT): Unique Customer ID
	
2. market_fact: Details of every order sold ,(i.e delivered,profit,shipping id etc)
	    a) Ord_id (TEXT): unique id of order  
        b) Prod_id (TEXT): unique id of product
        c) Ship_id (TEXT): unique id of shipment
        d) Cust_id (TEXT): unique id of the Customer 
        e) Sales (DOUBLE): Sales from the Item sold
        f) Discount (DOUBLE): Discount on the Item sold
        g) Order_Quantity (INT):  Quantity of the Item ordered
        h) Profit (DOUBLE): Profit gained from the Item sold
        i) Shipping_Cost (DOUBLE): Shipping Cost of the Item sold
        j) Product_Base_Margin (DOUBLE): Profit margin on the base of manufacturing cost Item sold
        
3. orders_dimen: Details of every order placed
		
        a) Order_ID (INT): Unque id of the Order 
        b) Order_Date (TEXT): Date of order
        c) Order_Priority (TEXT): Priority of the Order
        d) Ord_id (TEXT): Unique Order ID
	
4. prod_dimen: Details of product category and sub category
		
       a)  Product_Category (TEXT): Category of the product
	   b) Product_Sub_Category (TEXT): Sub Category of the product
	   c) Prod_id (TEXT): Unique Product ID
	
5. shipping_dimen: Details of shipping of orders
		
       a)  Order_ID (INT):  Unique Order ID
	   b)  Ship_Mode (TEXT): Mode of shipping
	   c)  Ship_Date (TEXT): Date of shipping
	   d)  Ship_id (TEXT): Unique Shipment ID
 -------PRIMARY KEY AND FOREIGN KEYS FOR THE DATASET-------
	
1. cust_dimen
		A)Primary Key: Cust_id
        B) Foreign Key: NA
	
2. market_fact
		A) Primary Key: NA
        B) Foreign Key: Ord_id, Prod_id, Ship_id, Cust_id
	
3. orders_dimen
		A) Primary Key: Ord_id
        B) Foreign Key: NA
	
4. prod_dimen
		A) Primary Key: Prod_id, Product_Sub_Category
        B) Foreign Key: NA
        
	
5. shipping_dimen
		A) Primary Key: Ship_id
        B) Foreign Key: NA  
*/

use superstore;
/*1. Write a query to display the Customer_Name and Customer Segment using alias 
name “Customer Name", "Customer Segment" from table Cust_dimen*/
select customer_name,customer_segment
from cust_dimen;

/* 2. Write a query to find all the details of the customer from the table cust_dimen 
order by desc.*/
select *
from cust_dimen
order by Customer_Name desc;

/*3. Write a query to get the Order ID, Order date from table orders_dimen where 
‘Order Priority’ is high.*/
select order_id,order_date
from orders_dimen
where Order_Priority like '%high%';

/*4. Find the total and the average sales (display total_sales and avg_sales)*/
select sum(sales) as 'total_sales',
		avg(sales) as 'avg sales'
	from market_fact;

/*5. Write a query to get the maximum and minimum sales from maket_fact table.*/
select max(sales) as 'maximun',
		min(sales) as 'minimum'
from market_fact;

/*6. Display the number of customers in each region in decreasing order of 
no_of_customers. The result should contain columns Region, no_of_customers.*/
select region,count(customer_name) as 'no_of_customer'
from cust_dimen
group by region
order by no_of_customer desc;


/*7. Find the region having maximum customers (display the region name and 
max(no_of_customers)*/
select region,max(customer_name) as 'no_of_customer'
from cust_dimen
group by region
order by no_of_customer desc;

/*8. Find all the customers from Atlantic region who have ever purchased ‘TABLES’ 
and the number of tables purchased (display the customer name, no_of_tables 
purchased) */
select customer_name,count(*) as 'no_of_table'
from cust_dimen,market_fact,prod_dimen
where 
		Cust_id = Cust_id 
and 	Prod_id = Prod_id
and  	Product_Sub_Category = 'tables'
and		Region = 'atlantic'
		group by Customer_Name
        order by no_of_tables desc;
	

/*9. Find all the customers from Ontario province who own Small Business. (display 
the customer name, no of small business owners)*/
SELECT DISTINCT
    Customer_Name
FROM
    cust_dimen
WHERE
    region LIKE '%ONTARIO%'
        AND Customer_Segment LIKE '%SMALL BUSINESS%';
        
/*10. Find the number and id of products sold in decreasing order of products sold 
(display product id, no_of_products sold)*/ 

select
prod_id as product_id,count(*) as no_of_product_sold
from market_fact
 order by no_of_product_sold desc;
 
 /*11. Display product Id and product sub category whose produt category belongs to 
Furniture and Technlogy. The result should contain columns product id, product 
sub category.*/

select
 Prod_id,Product_sub_Category,Product_Category
from prod_dimen
where
product_category in('FURNITURE''TECHNOLOGY');

/*12. Display the product categories in descending order of profits (display the product 
category wise profits i.e. product_category, profits)?*/

select Product_Category,profit
from prod_dimen,market_fact
order by Profit desc;

/*13. Display the product category, product sub-category and the profit within each 
subcategory in three columns. */

select product_category,product_sub_category,profit
 from prod_dimen,market_fact;
 
 /*14. Display the order date, order quantity and the sales for the order.*/

select order_date,order_quantity,sales
from orders_dimen,market_fact;

/*15. Display the names of the customers whose name contains the 
 i) Second letter as ‘R’
 ii) Fourth letter as ‘D’*/

SELECT 
    Customer_name
FROM
    cust_dimen
WHERE
    customer_name LIKE '_R%';
select 
customer_name
from
cust_dimen
where
Customer_Name like '___D';


/*16. Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and 
their region where sales are between 1000 and 5000.*/

SELECT 
    c.cust_id, SUM(M.sales) AS Sales, c.customer_name, c.region
FROM
    cust_dimen AS c
        JOIN
    market_fact AS M ON c.cust_id = M.cust_id
GROUP BY c.cust_id
HAVING Sales BETWEEN 1000 AND 5000;

/*17. Write a SQL query to find the 3rd highest sales.*/

SELECT 
    *
FROM
    market_fact
WHERE
    sales < (SELECT 
            MAX(sales)
FROM
            market_fact
ORDER BY sales DESC)
LIMIT 3;

/*18. Where is the least profitable product subcategory shipped the most? For the least 
profitable product sub-category, display the region-wise no_of_shipments and the profit made in each region in decreasing order of profits (i.e. region, 
no_of_shipments, profit_in_each_region)
 → Note: You can hardcode the name of the least profitable product subcategory*/
 
 SELECT 
    c.region,
    COUNT(DISTINCT s.ship_id) AS no_of_shipments,
    SUM(m.profit) AS profit_in_each_region
FROM
    market_fact m
        INNER JOIN
    cust_dimen c ON m.cust_id = c.cust_id
        INNER JOIN
    shipping_dimen s ON m.ship_id = s.ship_id
        INNER JOIN
    prod_dimen p ON m.prod_id = p.prod_id
WHERE
    p.product_sub_category IN (SELECT 
            p.product_sub_category
        FROM
            market_fact m
                INNER JOIN
            prod_dimen p ON m.prod_id = p.prod_id
        GROUP BY p.product_sub_category
        HAVING SUM(m.profit) <= ALL (SELECT 
                SUM(m.profit) AS profits
            FROM
                market_fact m
                    INNER JOIN
                prod_dimen p ON m.prod_id = p.prod_id
            GROUP BY p.product_sub_category))
GROUP BY c.region
ORDER BY profit_in_each_region DESC
