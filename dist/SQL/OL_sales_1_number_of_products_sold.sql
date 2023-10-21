use toys_and_models;

drop table number_of_products_sold; 

-- Ventes : 
-- Nombre de produits vendus par catégorie et par mois, avec comparaison et taux de variation par rapport au même mois de l'année précédente.
create table number_of_products_sold as (
select
	month(orderdate) as mois, 
	productline, 
	sum(case when year(orderdate)= year(now())-1 then (quantityordered) end) lastyear,
	sum(case when year(orderdate)= year(now()) then (quantityordered) end) thisyear,
	(
	sum(case when year(orderdate)= year(now()) then (quantityordered)end)-
	sum(case when year(orderdate)= year(now())-1 then (quantityordered)  
	end)) /
	sum(case when year(orderdate)= year(now())-1 then (quantityordered)end) as variation
from products as pr
inner join orderdetails as ordd on 
		pr.productcode = ordd.productcode 
inner join orders as ord on 
		ordd.ordernumber = ord.ordernumber 
where 1=1 
	and year(orderdate) between year(now())-1 and year(now())
group by 
	productline, 
	month(orderdate) 
order by 
	month(orderdate) 
)
;
	
select * from number_of_products_sold; 
