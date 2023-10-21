use toys_and_models;

drop table Sales_per_Agency_and_salespeople; 

-- Chiffre d'affaire par Agence et Nb de vendeur par Agence
create table Sales_per_Agency_and_salespeople as ( 
with vendor_customer_paiement as ( 
select 	salesrepemployeenumber, 
		count(cu.customernumber) as clients, 
		sum(payments.amount) as paiement 
    from customers cu
    inner join payments on 
    		payments.customernumber = cu.customernumber 
    group by salesrepemployeenumber 
)
select 	off.city, 
		off.country, 
		count(em.employeenumber) as number_salespeople, 
		sum(paiement) as agency_sales 
from offices off
inner join employees em on 
		em.officecode = off.officecode 
inner join vendor_customer_paiement on 
		vendor_customer_paiement.salesrepemployeenumber = em.employeenumber 
group by off.officecode 
)
;

select * from Sales_per_Agency_and_salespeople; 
