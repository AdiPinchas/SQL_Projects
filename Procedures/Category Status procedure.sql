alter procedure spCatStatus 
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



