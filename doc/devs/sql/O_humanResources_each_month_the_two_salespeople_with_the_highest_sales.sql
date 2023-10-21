use toys_and_models;

-- Ressources Humaines : 
-- Chaque mois, les 2 vendeurs ayant le plus haut chiffre d'affaires.
drop table each_month_the_two_salespeople_with_the_highest_sales; -- Suppression de la table

create table each_month_the_two_salespeople_with_the_highest_sales as (
-- REQUETE PRINCIPALE
select
	 -- Sélection des colonnes (mois, nom, prénom du vendeur, CA mensuel) à afficher
    month, salesperson_last_name, salesperson_first_name, monthly_sales
from (
 -- REQUETE SECONDAIRE
    select
     -- Extraction du mois au format 'yy-mm' à partir de la colonne "orderdate" de la table "orders" en utilisant la fonction DATE_FORMAT
        date_format(ord.orderdate, '%y-%m') as month,
     -- Sélection des nom, prénom du vendeur à partir de la table employees
        em.lastname as salesperson_last_name,  -- Utilisation d'alias pour le renommage
        em.firstname as salesperson_first_name, -- Utilisation d'alias pour le renommage
     -- Calcul du CA mensuel pour chaque produit (prix unitaire (priceeach) * quantité commandée (quantityordered)) en faisant la somme pour chaque vendeur
        sum(od.priceeach * od.quantityordered) as monthly_sales,
	 -- Attribution d'un numéro de rang aux vendeurs en partitionnant les données par mois (`PARTITION BY DATE_FORMAT(ord.orderdate, '%y-%m')`) 
	 -- Classement par CA mensuel décroissant (`ORDER BY SUM(od.priceeach * od.quantityordered) DESC`). 
	 -- Le numéro de rang permet de déterminer les deux vendeurs ayant le chiffre d'affaires le plus élevé.
        row_number() over (partition by date_format(ord.orderdate, '%y-%m') order by sum(od.priceeach * od.quantityordered) desc) as sales_rank
    from orders ord
    inner join orderdetails od on ord.ordernumber = od.ordernumber -- Requête de jointure entre orderdetails & orders
    inner join customers cu on ord.customernumber = cu.customernumber -- Requête de jointure entre customers & orders
    inner join employees em on cu.salesrepemployeenumber = em.employeenumber -- Requête de jointure entre customers & employees 
    where 1=1
    	and ord.orderdate is not null -- Où la date est connue
    group by
        date_format(ord.orderdate, '%y-%m'),
        em.lastname,
        em.firstname
) ranked_sales -- Attribution d'un alias ranked_sales à la requête secondaire
where 1=1
 -- Filtrage des résultats pour n'inclure que les lignes où le numéro de rang (`sales_rank`) est inférieur ou égal à 2
 -- Seuls les deux vendeurs avec le CA le plus élevé pour chaque mois seront inclus
    and sales_rank <= 2
order by
 -- Les résultats sont triés par mois en ordre décroissant (`DESC`)
	month desc,
 -- Puis par rang de ventes (`sales_rank`) pour chaque mois
	sales_rank
)
;

select * from each_month_the_two_salespeople_with_the_highest_sales; -- Affichage du contenu de la TABLE
