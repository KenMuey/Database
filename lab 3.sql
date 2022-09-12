
/*1. 64130500083 Create a view named "mini_customer_view" to display the customer name of 
all customers whose names start with the word “Mini”. Please verify by querying data from this view.*/
create view mini_customer_view
as select customername from customers where customername like 'Mini%';
select * from mini_customer_view;

/*2. 64130500083 Create a view named "prod_minstock_view" to display the product name and quantity in stock 
of the product that has the minimum quantities in stock. Please verify by querying data from this view. */
create view prod_minstock_view as select productName , quantityInStock 
from products
where quantityInStock = (select min(quantityInStock) from products);
select * from prod_minstock_view;
    
/*3. 64130500083 Create a view named "totalamount_orders_view" to display the order number, order date and 
the total amount of sales of all orders and sort the results in descending order by 
the total amount of sales. Name three columns of the view to orderno, orderdate and total_amount, 
respectively. Please verify by querying data from this view.*/
create or replace view  totalamount_orders_view (orderno, orderdate, total_amount) as select od.orderNumber , o.orderDate , sum(od.quantityordered*od.priceeach)
from orderdetails od , orders o
where od.ordernumber = o.ordernumber
group by od.ordernumber , o.orderdate
order by sum(od.quantityordered*od.priceeach) desc;
select * from totalamount_orders_view;

/*4. 64130500083 Create a view named "customer_samecity_view" to display the customer name and city of all customers who live in the same city of their sales rep 
employee’s office city. Name two view columns to cust_name and cust_city, respectively. Please verify by querying data from this view.*/
create or replace view customer_samecity_view as select customername, city
from customers c 
where exists (select o.city from offices o where o.city = c.city);
select * from customer_samecity_view;

/*5. 64130500083 Create a view named "maxcredit_city_view" to display the city and the maximum credit limit of all customers in each city. 
Please verify by querying data from this view*/
create view maxcredit_city_view as select city , max(creditlimit) as max_creditlimit
from customers
group by city;
select * from maxcredit_city_view;

/* 6. 64130500083 Create a view named "maxcredit_london_view" to display the city and the maximum credit limit of all customers who live in London city. 
You should create this view from the "maxcredit_city_view" view in Question 5. Please verify by querying data from this view.  */   
create or replace view maxcredit_london_view as select city, max(creditlimit) 
from customers 
where city = 'London'
group by city;
select * from maxcredit_london_view;

/* 7 64130500083 Create a table named "offices_copy" with copying the structure and data from the "offices" table using the following commands:
create table offices_copy
as select * from offices; */
create or replace view office_copy
as select * from offices;

/* Create a view named "usa_office_view" to display office code, city and state of the country "USA" 
from the "offices_copy" table. Please verify by querying data from this view.*/
create or replace view usa_office_view 
as select officecode, city, state 
from office_copy 
where country = 'USA';
select * from usa_office_view;
 
/*8. 64130500083 Try to insert a new row through the "usa_office_view"  view created in Question 7. What happens about the data insertion into the "offices_copy" table? Please explain.
Hint: You can create a new data by yourself.*/
insert into usa_office_view
values ('9','Bangkok','+55 12 3456 7890','123 ken',null,'BK','USA','25100','TH'); 
select * from offices;

/*9. 64130500083 To resolve the problem found in Question 8, Please modify the "usa_office_view" view  to 
ensure that you can insert a new row through this view (an updatable view). Please show the data insertion of the "offices_copy" table.*/
create or replace view usa_office_view
as select * from office_copy;


/*10. 64130500083  Please delete both the structure and data of the "offices_copy" table. What happens to an 
existing view that references the "offices_copy" table? Please explain.*/
delete from usa_office_view;
drop table offices_copy;
select * from usa_office_view;