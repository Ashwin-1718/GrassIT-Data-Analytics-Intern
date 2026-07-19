use AdventureWorks2025

select FirstName + ' ' + LastName as FullName,EmailAddress,PhoneNumber 
from person.Person as p
join person.EmailAddress as ea
on p.BusinessEntityID = ea.BusinessEntityID
join person.PersonPhone as ph
on p.BusinessEntityID = ph.BusinessEntityID;

-- Fullname, City, State, Country

select p.FirstName + ' ' + p.LastName as FullName,adr.City,sp.Name as State,cr.Name as Country
from Person.Person as p
join Person.BusinessEntityAddress as bea
on p.BusinessEntityID = bea.BusinessEntityID
join Person.Address as adr
on bea.AddressID = adr.AddressID
join Person.StateProvince as sp
on adr.StateProvinceID = sp.StateProvinceID
join Person.CountryRegion as cr
on sp.CountryRegionCode = cr.CountryRegionCode;

-- Top 5 City 
select top 5 adr.City,COUNT(p.BusinessEntityID) as TotalPerson
from Person.Person as p
join Person.BusinessEntityAddress as bea
on p.BusinessEntityID = bea.BusinessEntityID
join Person.Address as adr
on bea.AddressID = adr.AddressID
group by adr.City
order by TotalPerson desc;


-- Task Day 1

-- Total Orders
select count(*) as Total_Orders
from Sales.SalesOrderHeader;


--Average Sales Per Order
select avg(TotalDue) as Average_Sales
FROM Sales.SalesOrderHeader;


-- Average Quantity Sold
select avg(OrderQty) as Average_Quantity_Sold
from Sales.SalesOrderDetail;


-- Relationship Between Tables
select top 10 h.SalesOrderID,h.OrderDate, p.Name as ProductName, d.OrderQty, d.LineTotal
from Sales.SalesOrderHeader h
join Sales.SalesOrderDetail d
on h.SalesOrderID = d.SalesOrderID
join Production.Product p
on d.ProductID = p.ProductID;


-- Day 2
-- Total Revenue
select sum(LineTotal) as Total_Revenue
from Sales.SalesOrderDetail;

--Task 1: Total Sales by Product 
select p.ProductID,p.Name as ProductName,sum(d.LineTotal) as TotalSales
from Sales.SalesOrderDetail d
join Production.Product p
on d.ProductID = p.ProductID
group by p.ProductID, p.Name
order by TotalSales desc;

-- Task 2: Total Orders by Customer
select c.CustomerID,COUNT(h.SalesOrderID) as TotalOrders
from Sales.SalesOrderHeader h
join Sales.Customer c
on h.CustomerID = c.CustomerID
group by c.CustomerID
order by TotalOrders desc;


--Task 3: Total Sales by Year
select year(OrderDate) as year,sum(TotalDue) as TotalSales
from Sales.SalesOrderHeader
group by year(OrderDate)
order by year;


--Level 2: Intermediate JOIN + GROUP BY
--Task 4: Sales by Product Category
select pc.name as CategoryName,sum(d.LineTotal) as TotalSales
from Sales.SalesOrderDetail d
join Production.Product p
on d.ProductID = p.ProductID
join Production.ProductSubcategory ps
on p.ProductSubcategoryID = ps.ProductSubcategoryID
join Production.ProductCategory pc
on ps.ProductCategoryID = pc.ProductCategoryID
group by pc.Name
order by TotalSales desc;


--Task 5: Top Customers by Revenue
select top 10c.CustomerID,p.FirstName + ' ' + p.LastName as CustomerName,sum(h.TotalDue) as TotalSales
from Sales.SalesOrderHeader h
join Sales.Customer c
on h.CustomerID = c.CustomerID
join Person.Person p
on c.PersonID = p.BusinessEntityID
group by c.CustomerID, p.FirstName, p.LastName
order by TotalSales desc;

--Task 6: Sales by Territory
select t.Name as TerritoryName,sum(h.TotalDue) as TotalSales
from Sales.SalesOrderHeader h
join Sales.SalesTerritory t
on h.TerritoryID = t.TerritoryID
group by t.Name
order by TotalSales desc;


--Day 3
-- find the product which price is greater than avg price

select ProductID,Name as ProductName,ListPrice
from Production.Product
where ListPrice > (select avg(ListPrice) 
from Production.Product)
order by ListPrice desc;


--Day 4 Final Task
--1 Category Contribution Analysis

use adventureworks2025;
select pc.name as categoryname,
sum(d.linetotal) as categorysales
from sales.salesorderdetail d
join production.product p
on d.productid = p.productid
join production.productsubcategory ps
on p.productsubcategoryid = ps.productsubcategoryid
join production.productcategory pc
on ps.productcategoryid = pc.productcategoryid
group by pc.name
order by categorysales desc;


--2 Best Selling Product per Category
select pc.name as categoryname,
p.productid,
p.name as productname,
sum(d.linetotal) as totalsales
from sales.salesorderdetail d
join production.product p
on d.productid = p.productid
join production.productsubcategory ps
on p.productsubcategoryid = ps.productsubcategoryid
join production.productcategory pc
on ps.productcategoryid = pc.productcategoryid
group by pc.name, p.productid, p.name
order by pc.name, totalsales desc;


with productsales as
(
    select 
        pc.name as categoryname,
        p.productid,
        p.name as productname,
        sum(d.linetotal) as totalsales,
        row_number() over (
            partition by pc.name 
            order by sum(d.linetotal) desc
        ) as rn
    from sales.salesorderdetail d
    join production.product p
    on d.productid = p.productid
    join production.productsubcategory ps
    on p.productsubcategoryid = ps.productsubcategoryid
    join production.productcategory pc
    on ps.productcategoryid = pc.productcategoryid
    group by pc.name, p.productid, p.name)

select 
categoryname,
productname,
totalsales
from productsales
where rn = 1
order by totalsales desc;


--3 Monthly Sales Trend
select 
year(orderdate) as year,
month(orderdate) as month,
sum(totaldue) as totalsales
from sales.salesorderheader
group by year(orderdate), month(orderdate)
order by year, month;


--4 Year-over-year growth
select 
year(orderdate) as year,
sum(totaldue) as totalsales
from sales.salesorderheader
group by year(orderdate)
order by year;


--5 Top 10 Customers
select top 10 c.customerid, p.firstname + ' ' + p.lastname as customername,
sum(h.totaldue) as totalsales
from sales.salesorderheader h
join sales.customer c
on h.customerid = c.customerid
join person.person p
on c.personid = p.businessentityid
group by c.customerid, p.firstname, p.lastname
order by totalsales desc;


--6 Customer Segmentation (High / Medium / Low)
select c.customerid,
sum(h.totaldue) as totalsales
from sales.salesorderheader h
join sales.customer c
on h.customerid = c.customerid
group by c.customerid
order by totalsales desc;


--7 Sales by Territory / Region
select t.name as territoryname,
sum(h.totaldue) as totalsales
from sales.salesorderheader h
join sales.salesterritory t
on h.territoryid = t.territoryid
group by t.name
order by totalsales desc;


--8 Average Order Value (AOV)
select 
sum(totaldue) as totalrevenue,
count(salesorderid) as totalorders,
sum(totaldue) / count(salesorderid) as averageordervalue
from sales.salesorderheader;


select customerid,
count(salesorderid) as totalorders,
sum(totaldue) as totalsales,
sum(totaldue) / count(salesorderid) as aov
from sales.salesorderheader
group by customerid
order by aov desc;


--9 Product Performance Analysis
select p.productid, p.name as productname,
sum(d.linetotal) as totalsales
from sales.salesorderdetail d
join production.product p
on d.productid = p.productid
group by p.productid, p.name
order by totalsales asc;


select top 10 p.productid,
p.name as productname,
sum(d.linetotal) as totalsales
from sales.salesorderdetail d
join production.product p
on d.productid = p.productid
group by p.productid, p.name
order by totalsales asc;


--10 Pareto Analysis (80/20 Rule)

select p.productid,
p.name as productname,
sum(d.linetotal) as totalsales
from sales.salesorderdetail d
join production.product p
on d.productid = p.productid
group by p.productid, p.name
order by totalsales desc;