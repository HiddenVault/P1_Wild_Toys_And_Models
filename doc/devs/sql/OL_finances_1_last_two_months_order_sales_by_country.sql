use toys_and_models;

drop table last_two_months_order_sales_by_country; 

-- Finances :
-- Le chiffre d'affaires des commandes des deux derniers mois par pays.
create table last_two_months_order_sales_by_country as(
with final as ( 
select 	orders.ordernumber, 
		orderdate, 
		status, 
		country, 
		sum(priceeach*quantityordered) as totalprice 
from orders
inner join customers on  
	orders.customernumber = customers.customernumber 
inner join orderdetails on 
	orderdetails.ordernumber = orders.ordernumber 
where 1=1
	and status != 'cancelled' 
	and ( 
	12*year(orderdate) + month(orderdate) = (12*year(current_timestamp) + month(current_timestamp) - 1)
    or 
    12*year(orderdate) + month(orderdate) = (12*year(current_timestamp) + month(current_timestamp) - 2))
group by ordernumber) 
select final.country, month(final.orderdate), sum(final.totalprice) as turnover 
from final 
group by month(final.orderdate), final.country 
order by month(final.orderdate), final.country 
)
;

select * from last_two_months_order_sales_by_country; 
