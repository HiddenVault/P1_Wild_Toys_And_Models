use toys_and_models;

drop table each_month_the_two_salespeople_with_the_highest_sales; 

-- Ressources Humaines : 
-- Chaque mois, les 2 vendeurs ayant le plus haut chiffre d'affaires.
create table each_month_the_two_salespeople_with_the_highest_sales as (
select
    month, salesperson_last_name, salesperson_first_name, monthly_sales
from (
    select 
        date_format(ord.orderdate, '%y-%m') as month,
        em.lastname as salesperson_last_name,  
        em.firstname as salesperson_first_name, 
        sum(od.priceeach * od.quantityordered) as monthly_sales,
	    row_number() over (partition by date_format(ord.orderdate, '%y-%m') order by sum(od.priceeach * od.quantityordered) desc) as sales_rank
    from orders ord
    inner join orderdetails od on ord.ordernumber = od.ordernumber 
    inner join customers cu on ord.customernumber = cu.customernumber 
    inner join employees em on cu.salesrepemployeenumber = em.employeenumber 
    where 1=1
    	and ord.orderdate is not null 
    group by
        date_format(ord.orderdate, '%y-%m'),
        em.lastname,
        em.firstname
) ranked_sales 
where 1=1
    and sales_rank <= 2
order by
 	month desc,
 	sales_rank
)
;

select * from each_month_the_two_salespeople_with_the_highest_sales; 
