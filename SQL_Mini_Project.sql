
use AdventureWorks

-- Display the names of all employees (table [Person]. [Person)] who changed Department (table [EmployeeDepartmentHistory].[HumanResources)]

SELECT P.BusinessEntityID, P.FirstName,P.LastName, count (*) as TotalDep
FROM HumanResources.EmployeeDepartmentHistory as H 
inner join Person.Person as P
on H.BusinessEntityID = P.BusinessEntityID
group by P.BusinessEntityID, P.FirstName,P.LastName
having count(*) > 1;

--Display the names of all employees who changed departments, and show the name of the last department they worked on

SELECT P.BusinessEntityID, P.FirstName,P.LastName, H.EndDate,H.DepartmentID
FROM HumanResources.EmployeeDepartmentHistory as H 
inner join Person.Person as P
on H.BusinessEntityID = P.BusinessEntityID
where EndDate is not null 
group by P.BusinessEntityID, P.FirstName,P.LastName, H.EndDate , H.DepartmentID;

--Show product name with the highest number of orders

SELECT top 1 S.ProductID, P.Name , count (P.name) as NumOfOrders
FROM Sales.SalesOrderDetail as S 
inner join Production.Product as P 
on S.ProductID = P.ProductID
group by S.ProductID, P.Name
order by count (P.name) desc;

--Show the name of the product that sold in the highest quantity

SELECT top 1 S.ProductID, P.Name, sum (S.OrderQty) as SumOfOrders
FROM Sales.SalesOrderDetail as S
inner join Production.Product as P
on S.ProductID = P.ProductID
group by P.Name, S.ProductID
order by sum (S.OrderQty) desc;

--Show customer details without orders

select SC. *
from sales.Customer as SC
left join Sales.SalesOrderHeader as SSO
on SC.CustomerID = SSO.CustomerID
where salesorderID is null; 

--Show products without orders

select PP.*
from Purchasing.ProductVendor as PP
left join Sales.SalesOrderDetail as SS
on PP.productID = SS.productID
where SalesOrderID is null;

--Display the 3 orders with the highest total value for each month

select *
from(
select 
SOD.SalesOrderID,
SUM(LineTotal) as total,
datename(month,SSO.OrderDate) as monthdate,
datename(year,SSO.OrderDate) as yeardate,
row_number() over (partition by datename(month,SSO.OrderDate),datename(year,SSO.OrderDate)
order by datename(month,SSO.OrderDate), datename(year,SSO.OrderDate), SUM(linetotal) desc) as Trank
from Sales.SalesOrderDetail as SOD
inner join Sales.SalesOrderHeader as SSO
on SOD.SalesOrderID = SSO.SalesOrderID
group by SOD.SalesOrderID,datename(month,orderdate), datename(year,orderdate)
) as O
where Trank <4;


--Show the list of SalesPersons according to the total number of orders placed by them, in descending order. Display the results by month and year

select SSO.SalesPersonID, 
count (*) as countorders,
year (SSO.orderdate) as year,
month (SSO.orderdate) as month
from sales.SalesPerson as SSP
inner join Sales.SalesOrderHeader as SSO
on BusinessEntityID = SSO.SalesPersonID
inner join Sales.SalesOrderDetail as SSD
on SSO.SalesOrderID = SSD.SalesOrderID
group by SSO.SalesPersonID, year (SSO.orderdate), month (SSO.orderdate)
order by year (SSO.orderdate),month (SSO.orderdate),SSO.SalesPersonID;
--------------------------------------
select SSO.SalesPersonID, 
count (*) as countorders,
year (SSO.orderdate) as year,
month (SSO.orderdate) as month
from sales.SalesPerson as SSP
inner join Sales.SalesOrderHeader as SSO
on BusinessEntityID = SalesPersonID
group by SSO.SalesPersonID, year (SSO.orderdate), month (SSO.orderdate)
order by year (SSO.orderdate),month (SSO.orderdate),SSO.SalesPersonID;

--Display the total sales by salesperson (including first and last name). Show the results by month and year

select FirstName, LastName, SalesPersonID,
sum (subtotal) as Total,
month (orderdate) as M,
year (orderdate)as Y
from Person.Person
inner join Sales.SalesOrderHeader
on BusinessEntityID = SalesPersonID
group by FirstName, LastName,SalesPersonID,month (orderdate),year (orderdate)
order by year (orderdate), month (orderdate);

--Following the previous query, add another column to the results that shows the previous month in sales also

select SalesPersonID,FirstName, LastName,Total,M,Y,
lag (Total,1,0) over (partition by  FirstName, Y
order by M,Y) as lastmonth
from(
select SalesPersonID,FirstName, LastName,
sum (subtotal) as Total,
month (orderdate) as M,
year (orderdate)as Y,
row_number () over (partition by FirstName , year (orderdate)
order by FirstName, month (orderdate), year (orderdate)) as rowrank
from Person.Person
inner join Sales.SalesOrderHeader
on BusinessEntityID = SalesPersonID
group by FirstName, LastName,SalesPersonID,month (orderdate),year (orderdate)
) as O
