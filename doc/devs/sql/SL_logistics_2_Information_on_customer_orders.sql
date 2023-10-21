use toys_and_models;

drop table Information_on_customer_orders; 

-- Chiffre d'affaires par rapport à la quantité commandée et le nombre de commandes par pays
create table Information_on_customer_orders as (
SELECT
    cu.country, 
    SUM(ordd.quantityordered) as quantity_ordered, 
    COUNT(DISTINCT ordd.ordernumber) as number_of_orders, 
    COUNT(DISTINCT ord.customernumber) as number_of_customers, 
    SUM(DISTINCT pa.amount) as payment_amounts
from orders ord
INNER join orderdetails ordd ON 
	ordd.ordernumber = ord.ordernumber  
INNER join customers cu ON 
    cu.customerNumber = ord.customernumber  
INNER join payments pa ON 
	pa.customernumber = ord.customernumber  
GROUP by cu.country 
)
;

select * from Information_on_customer_orders; 