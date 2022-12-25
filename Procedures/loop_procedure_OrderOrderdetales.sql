create procedure spNewOreders (@numofrows int =0)
as
declare @I int
declare @orderid int
declare @Empid int
declare @custid nvarchar (10)
declare @orderdate date
declare @startdate date = '1997-01-01'
declare @enddate date = '2001-12-31'
declare @reqday date
declare @shipday date
declare @shipaddr nvarchar (60)

set @I=0

while @I<@numofrows
begin
 set @orderid= (select( max(OrderID)+1) from OrdersNew)
 set @Empid = (select top 1 EmployeeID from Employees order by NEWID())
 set @custid = (select top 1 CustomerID from Customers order by NEWID())
 set @orderdate= (select dateadd(day,(rand()*(1+datediff(day,@startdate, @enddate))),@startdate))
 set @reqday= (select dateadd(day,(rand()*(5-3)+3),@orderdate))
 set @shipday = (select dateadd(day,(rand()*(15-3)+3),@orderdate))
 set @shipaddr= (select Address from Customers where CustomerID=@custid )

  insert into OrdersNew (OrderID, EmployeeID, CustomerID, OrderDate, RequiredDate, ShippedDate, ShipAddress)
  values (@orderid, @Empid, @custid, @orderdate, @reqday, @shipday, @shipaddr)

	declare @Q int
	declare @numofroesoreders int
	declare @orderidod int
	declare @prodid int
	declare @unitp money 
	declare @qty int
	declare @disc real

	set @Q = 0
	set @numofroesoreders = (select floor (rand() * (15-3)+3))
	set @orderidod= (select max(orderid) from OrdersNew )

	while @Q<@numofroesoreders
	begin

	set @prodid = (select top 1 productid from [Order Details] order by NEWID())
	set @unitp = (select max(UnitPrice) from [Order Details] where productid=@prodid)
	set @qty = (select floor (rand() * (50-1)+1))
	set @disc = (select cast ((select(rand() * (0.25))) as decimal(3,2)))

	insert into [OrderDetails New] (OrderID,ProductID,UnitPrice,Quantity,Discount)
	values (@orderidod, @prodid, @unitp, @qty, @disc)

	set @Q +=1
	 end

 set @I+=1
 end
 


 exec spNewOreders @numofrows= 2

select * from OrdersNew
select * from [OrderDetails new]


