use AdventureWorks2025

-- 1
select year(orderdate) as sales_year,
sum(totaldue) as total_sales
from sales.salesorderheader
group by year(orderdate)
order by sales_year

-- 2
select top 10 c.customerid,
sum(h.totaldue) as total_purchase
from sales.customer c
join sales.salesorderheader h
on c.customerid = h.customerid
group by c.customerid
order by total_purchase desc

--3
select t.name as territory_name,
sum(h.totaldue) as total_sales
from sales.salesorderheader h
join sales.salesterritory t
on h.territoryid = t.territoryid
group by t.name
order by total_sales desc

--4
select year(orderdate) as sales_year,
month(orderdate) as sales_month,
sum(totaldue) as total_sales
from sales.salesorderheader
group by year(orderdate), month(orderdate)
order by sales_year, sales_month

--5
select top 10 p.name as product_name,
sum(d.orderqty) as total_quantity
from sales.salesorderdetail d
join production.product p
on d.productid = p.productid
group by p.name
order by total_quantity desc

--7
select c.CustomerID 
from Sales.Customer c 
left join Sales.SalesOrderHeader h 
on c.CustomerID = h.CustomerID 
where h.SalesOrderID is null

--8
select avg(totaldue) as average_order_value
from sales.salesorderheader;

--10
select customerid,
count(salesorderid) as total_orders
from sales.salesorderheader
group by customerid
having count(salesorderid) > 5
order by total_orders desc

--Part 2 
--2 
select year(orderdate) as sales_year,
sum(totaldue) as total_sales
from sales.salesorderheader
group by year(orderdate)
order by sales_year

-- 5
select t.name as territory_name,
sum(h.totaldue) as total_sales
from sales.salesorderheader h
join sales.salesterritory t
on h.territoryid = t.territoryid
group by t.name
order by total_sales desc


-- 6
select customerid,
avg(totaldue) as average_order_value
from sales.salesorderheader
group by customerid
order by average_order_value desc
