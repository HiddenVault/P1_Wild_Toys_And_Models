use toys_and_models;

drop table sales_vs_order_quantity_and__orders_by_country; -- Suppression de la table

-- Chiffre d'affaire par Agence et Nb de vendeur par Agence
create table sales_vs_order_quantity_and__orders_by_country as (
-- TABLE TEMPORAIRE sales_vs_order
with sales_vs_order as (    
select
    cu.country as country, -- Nom du pays
    sum(ordd.quantityordered) as sumquantityordered, -- Somme des articles commandés par pays
    count(distinct orde.ordernumber) as distinctcountordernumber, -- Compte le nombre de commandes distinctes
    sum(distinct pa.amount) as sumamount -- Somme des montants des paiements distincts
from customers cu
inner join orders orde on -- Jointure entre les tables customers et orders  
		cu.customernumber = orde.customernumber -- avec le numéro de client
inner join orderdetails ordd on -- Jointure entre les tables orderdetails et orders  
		orde.ordernumber = ordd.ordernumber -- avec le numéro de commande
inner join payments pa on -- Jointure entre les tables payments et customer  
		cu.customernumber = pa.customernumber -- avec le numéro de client
group by cu.country -- Regroupement des résultats par pays
)
-- REQUETE PRINCIPALE
select 	country, -- Nom du pays
    	sumquantityordered, -- Somme des quantités commandées
    	distinctcountordernumber, -- Nombre de commandes distinctes 
    	sumamount -- Somme des montants des paiements distincts
from sales_vs_order
)
;

select * from sales_vs_order_quantity_and__orders_by_country; -- Affichage du contenu de la table