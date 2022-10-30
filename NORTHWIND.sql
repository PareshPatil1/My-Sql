USE northwind;


select *
from products;

/*1. Write a query to get Product name and quantity/unit*/
SELECT productname,quantityperunit
from products;

/*2. Write a query to get current Product list (Product ID and name)*/
SELECT ProductID,ProductName
from products;

/*3. Write a query to get discontinued Product list (Product ID and name)*/
select productid ,productname 
from products
WHERE DISCONTINUED = 1 ;

/*4. Write a query to get most expense and least expensive Product list (name and unit price)*/
select productID,unitprice,productname
FROM products
order by unitprice;

/*5. Write a query to get Product list (id, name, unit price) where current products cost less than $20*/
select productID,unitprice,productname
FROM products
where (unitprice < 20) and (Discontinued = false) 
order by UnitPrice desc;

/*6. Write a query to get Product list (id, name, unit price) where products cost between $15 and $25*/
select productID,unitprice,productname
FROM products
where unitprice between 15 and 25
order by unitprice desc;

/*7. Write a query to get Product list (name, unit price) of above average price*/
select distinct productname,unitprice
from products
where UnitPrice > (select avg(UnitPrice) from products)
order by unitprice;

/*8. Write a query to get Product list (name, unit price) of ten most expensive products*/
sELECT DISTINCT ProductName as Twenty_Most_Expensive_Products, UnitPrice
FROM Products AS a
WHERE 20 >= (SELECT COUNT(DISTINCT UnitPrice)
                    FROM Products AS b
                    WHERE b.UnitPrice >= a.UnitPrice)
ORDER BY UnitPrice desc;


/*9. Write a query to count current and discontinued products*/
select count(productname)
from products
group by Discontinued;

/*10. Write a query to get Product list (name, units on order , units in stock) of stock is less than the quantity 
on order*/
select productname,UnitsOnOrder,UnitsInStock
from products
where (UnitsInStock < UnitsOnOrder) and (Discontinued=false);
