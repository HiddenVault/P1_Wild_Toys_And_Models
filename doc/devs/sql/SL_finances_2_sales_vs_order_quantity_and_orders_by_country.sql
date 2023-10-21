use toys_and_models;

drop table sales_vs_order_quantity_and__orders_by_country; 

-- Chiffre d'affaire par Agence et Nb de vendeur par Agence
create table sales_vs_order_quantity_and__orders_by_country as (
with sales_vs_order as (    
select
    cu.country as country, 
    sum(ordd.quantityordered) as sumquantityordered, 
    count(distinct orde.ordernumber) as distinctcountordernumber, 
    sum(distinct pa.amount) as sumamount 
from customers cu
inner join orders orde on 
		cu.customernumber = orde.customernumber 
inner join orderdetails ordd on 
		orde.ordernumber = ordd.ordernumber 
inner join payments pa on 
		cu.customernumber = pa.customernumber 
group by cu.country 
)
select 	country, 
    	sumquantityordered, 
    	distinctcountordernumber, 
    	sumamount 
from sales_vs_order
)
;

select * from sales_vs_order_quantity_and__orders_by_country; 