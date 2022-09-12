USE `classicmodels`;

select * from employees;
select * from customers;
select * from offices;
select * from orders;
/* 2.1 64130500083 List the product name and quantity in stock of all products that classified in the “Classic Cars” product line (กลุ่มของสินค้า/ผลิตภัณฑ์) 
and their buy prices are more than 80.*/
select productname, quantityinstock
from products
where productline = 'Classic Cars' and buyprice > 80;

/*2.2 64130500083 List the customer name, city and country of all customers who live in the country named: Japan, Germany or Canada. 
Sort the results in descending order by country and ascending order by customer name.*/
select customername, city, country
from customers
where country in ('Japan','Germany','Canada')
order by country desc , customername asc; 

/*2.3 64130500083 List the order number and the total amount of sales for all orders. Name the total amount of sales column to “total_amount”.*/
select ordernumber, sum(quantityordered*priceEach) as total_amount
from orderdetails
group by ordernumber;

/*2.4 64130500083 List the order number and the total amount of sales of all orders that their total amount of sales is more than 55000. 
Name the total amount of sales column to “total_amount”.*/
select ordernumber, sum(quantityordered*priceEach) as total_amount 
from orderdetails
group by ordernumber
having total_amount > 55000;

/*2.5 64130500083 List the customer name and the number of sales orders of all customers whose name start with the letter ‘D’. 
Name the number of sales orders column to “num_orders”.*/
select c.customername, count(o.ordernumber) as num_orders
from customers c, orders o
where c.customername like 'D%' and c.customerNumber = o.customernumber
group by c.customernumber;

/*2.6 64130500083 List the customer name, the sales rep employee last name, and the check number of all customers who made the payment in year 2005. 
Name the sales rep employee last name column to “salesempname”.*/
select c.customername, e.lastname as saleempname, p.checknumber
from employees e, customers c, payments p
where c.salesRepEmployeeNumber = e.employeenumber and c.customerNumber = p.customernumber and p.paymentdate like '%2005%';

/*2.7 List the manager last name (the employee who were reported to) and the number of employees of all managers. 
Name the manager last name and the number of employees columns to “mgrname” and “num_emp”, respectively.*/

select e1.lastname as mgrname , count(e1.reportsTo) as num_emp
from employees e1, employees e2
where e1.jobtitle like '%Manager%' and e1.employeeNumber = e2.reportsTo
group by e1.lastname;

/*2.8 Create your own question and the answered SQL statement should have SELECT, 
       FROM, WHERE, GROUP BY and HAVING clauses.*/
select customerName, creditLimit, country
from customers
where country = 'USA'
group by customerName
having creditLimit > 50000;

/*2.9 Create your own question and the answered SQL statement should have SELECT, 
       FROM 3 tables, WHERE and ORDER BY clauses.*/
select c.customerName, p.paymentdate, count(o.orderNumber)
from customers c, payments p, orders o
where country = 'France' and c.customerNumber = o.customerNumber and c.customerNumber = p.customerNumber
group by c.customerName
order by c.customerName asc;

/*2.10 Create your own question and the answered SQL statement should have SELECT, 
       FROM 3 tables, WHERE, GROUP BY, HAVING and ORDER BY clauses.*/
select concat(e.lastName,e.firstName) as Name_emp, count(reportsTo), o.phone
from employees e, customers c, offices o
where e.employeeNumber = c.salesRepEmployeeNumber and e.officecode = o.officecode
group by Name_emp
having count(reportsTo) > 5
order by count(reportsTo) desc;