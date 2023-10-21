use toys_and_models;

drop table unpaid_orders; 

-- Finance
-- Commandes non encore payées
create table unpaid_orders as (
with total_commande as(
select
	ord.customerNumber, 
	cu.customerName, 
	SUM(ordd.quantityOrdered * ordd.priceEach) as total_due 
	from orders ord
	inner join orderdetails ordd on 
			ordd.orderNumber = ord.orderNumber 
	inner join customers cu on 
			ord.customerNumber = cu.customerNumber 
	group by
		ord.customerNumber), 
		total_paiement as (
		select
			pa.customerNumber, 
			sum(pa.amount) as total_paid 
		from payments pa
		group by
			customerNumber) 
select
	tc.customerName, 
	total_due, 
	total_paid, 
	(total_due - total_paid) as rest_to_pay 
	from total_commande tc
left join total_paiement tp on 
	tp.customerNumber = tc.customerNumber 
where 1=1
	and total_due <> total_paid
order by
	rest_to_pay desc
)
;

select * from unpaid_orders; 
