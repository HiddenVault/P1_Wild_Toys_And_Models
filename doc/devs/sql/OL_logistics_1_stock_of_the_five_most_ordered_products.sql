use toys_and_models;

drop table stock_of_the_five_most_ordered_products; 

-- Logistique : 
-- Le stock des 5 produits les plus commandés.
create table stock_of_the_five_most_ordered_products as (
with top_products_sold as ( 
    select 	pr.productname, 
    		pr.productcode, 
    		sum(ordd.quantityordered) as total_quantity_ordered,  
    		pr.quantityinstock 
    from products pr
    inner join orderdetails ordd on 
    		pr.productcode = ordd.productcode 
    inner join orders ord on 
    		ordd.ordernumber = ord.ordernumber 
    where 1=1
    	and ord.orderdate between '2021-01-01' and '2021-12-31' 
    	and ord.status != 'cancelled' 
    group by pr.productcode 
    order by total_quantity_ordered desc 
    limit 5 
    )
select 	productcode, 
		productname, 
		quantityinstock, 
		total_quantity_ordered 
from top_products_sold top
)
;

select * from stock_of_the_five_most_ordered_products; 
