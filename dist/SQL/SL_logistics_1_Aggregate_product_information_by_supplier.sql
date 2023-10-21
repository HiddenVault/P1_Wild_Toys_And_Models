use toys_and_models;

drop table Aggregate_product_information_by_supplier; 

-- Agrégation des informations sur les produits en fonction de leur fournisseur
create table Aggregate_product_information_by_supplier as (
select
	productvendor, 
	count(productname) as Number_of_products, 
	avg(buyprice) as average_purchase_price, 
	avg(msrp) as average_selling_price, 
	sum(quantityinstock) as stock, 
	sum(buyprice * quantityinstock) as global_purchasing, 
	sum(msrp * quantityinstock) as global_sales, 
	avg(msrp / buyprice) as average_sales 
from
	products
group by
	productvendor 
)
;

select * from Aggregate_product_information_by_supplier; 