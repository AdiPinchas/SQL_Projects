--Using database-  SQL-Projects/databases/mssql_Sales_DWH_Database.sql 

---This procedure receives a product ID,counts how many products there are in the same category and what is the total price of
---all products in the same category.
--If there are more than 100 products and a total price of more than 1000 - the procedure will display Cat Strong
--If there are more than 40 products and a total price between 480 and 1000, the procedure will display Cat Medium
--If there are less than 40 products in the category or the category name is empty or NULL (it doesn't matter what the total price is
--the products) ,the procedure will displa yCat Weak 


create procedure spCatStatus 
@partid int
as
begin
select * from (

 select distinct Category,partid,
sum(ProductCost) over( partition by Category) as TotalCostCat,
count(partid) over (partition by Category) as CountOfPrudoct,
case 
when sum(ProductCost) over( partition by Category ) > 1000 and count(partid) over (partition by Category) >100 then 'Cat Strong'
when sum(ProductCost) over( partition by Category ) > 480 and count(partid) over (partition by Category) >40 then 'Cat Medium'
when count(partid) over (partition by Category) < 40 or Category='UnKnown' then 'Cat Weak'
else 'NoStatus'
end as CatStatus
from
Dim_Product as DP
join Fact_Sales as FS
on DP.PartSK=FS.PartSK
group by Category,partid,ProductCost
) as O
where PartID = @partid

end

exec spCatStatus '22755'



