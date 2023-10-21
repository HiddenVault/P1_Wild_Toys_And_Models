use toys_and_models;

drop table number_of_products_sold; -- Suppression de la table

-- Ventes : 
-- Nombre de produits vendus par catégorie et par mois, avec comparaison et taux de variation par rapport au même mois de l'année précédente.

create table number_of_products_sold as (
select
	month(orderdate) as mois, -- Mois de la date de commande
	productline, -- Ligne de produit
	-- Calcul de la quantité commandée en fonction de l'année précédente 'lastyear' et l'année en cours 'thisyear'
	-- Utilisation de CASE WHEN pour filtrer les données en fonction de l'année de la commande
	-- Le taux de variation 'variation' est calculé en soustrayant 
	-- les ventes de l'année en cours de celles de l'année précédente, 
	-- puis en divisant par les ventes de l'année précédente. 
	-- On obtient une indication du taux de croissance ou de décroissance par rapport à l'année précédente.
	sum(case when year(orderdate)= year(now())-1 then (quantityordered) end) lastyear,
	sum(case when year(orderdate)= year(now()) then (quantityordered) end) thisyear,
	(
	sum(case when year(orderdate)= year(now()) then (quantityordered)end)-
	sum(case when year(orderdate)= year(now())-1 then (quantityordered)  
	end)) /
	sum(case when year(orderdate)= year(now())-1 then (quantityordered)end) as variation
from products as pr
inner join orderdetails as ordd on -- Jointure entre les tables orderdetails et products
		pr.productcode = ordd.productcode -- avec le numéro de produits
inner join orders as ord on -- Jointure entre les tables orderdetails et orders 
		ordd.ordernumber = ord.ordernumber -- avec le numéro de commande
where 1=1 -- Filtrage des données
	-- en fonction de l'année de la commande pour inclure uniquement 
	-- les données de l'année précédente et de l'année en cours
	and year(orderdate) between year(now())-1 and year(now())
group by -- Regroupement des résultats
	productline, -- par ligne de produit
	month(orderdate) -- et par mois
order by -- Tri
	month(orderdate) -- par mois de commande
)
;
	
select * from number_of_products_sold; -- Affichage du contenu de la TABLE
