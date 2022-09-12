use classicmodels;
select firstname
from employees
where officecode = (select officecode from employees where employeenumber = 1002);

select contactlastname 
from customers
where city = (select city from customers where contactlastname = 'Martin');

select empname
from emp
where salary >any (select salary from emp where deptno = 50);

select customername
from customers
where creditlimit > (select creditlimit from customers where customername = 'Land of Toys inc.');

select lastname
from employees e
where exists (select * from offices where officecode = e.officecode);

-- 3.1 64130500083 List the customer name of all customers who live in the same country of customer named “Mini Classics”. Sort the results in ascending order by customer name.
select customername
from customers
where country = (select country from customers where customername = 'Mini Classics');

-- 3.2 64130500083 List the customer name of all customers who live in the same country of customer named “Mini Classics” and their customer names start with “Mini”.
select customername
from customers c
where country in (select country from customers where customername = ('Mini Classics'))
and customername like 'Mini%';

-- 3.3 64130500083 List the product name and quantity in stock of the product that has the maximum quantities in stock.
select productname,quantityinstock
from products
where quantityinstock = (select max(quantityinstock) from products);

-- 3.4 64130500083 List the order number and the total amount of sales of all orders that their total amount of sales is more than the total amount of sales order number 10103. 
-- Name the total amount of sales column to “total_amount”.
select ordernumber, sum(quantityordered * priceeach) as total_amount
from orderdetails
group by ordernumber
having total_amount > (select sum(quantityordered * priceeach) from orderdetails where ordernumber = 10103);

-- 3.5 64130500083 List the customer name and the employee last name of all customers that their sales rep employee worked in the office located in London city. 
-- nested 
select c.customername, e.lastname 
from customers c join employees e on c.salesrepemployeenumber = e.employeenumber
where e.officecode in (select officecode from offices where city = 'London');

-- correlated
select c.customername, e.lastname 
from customers c join employees e on c.salesrepemployeenumber = e.employeenumber
where exists (select officecode from offices where city = 'London' and e.officecode = officecode);

-- 3.6 64130500083 List all cities that are both an office location and a customer location. Remove the duplicate answer
-- nested
select distinct city
from offices o
where o.city in (select city from customers where city = city);

-- correlated
select distinct city
from offices o 
where city in (select city from customers where o.city = city);
-- 3.7 64130500083 