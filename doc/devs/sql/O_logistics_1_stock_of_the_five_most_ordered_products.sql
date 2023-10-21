use toys_and_models;

drop table stock_of_the_five_most_ordered_products; -- Suppression de la table

-- Logistique : 
-- Le stock des 5 produits les plus commandés.

-- TABLE TEMPORAIRE top_products_sold
create table stock_of_the_five_most_ordered_products as (
with top_products_sold as ( -- utilisation de 'with as' pour créer une table temporaire appelée 'top_products_sold' 
    select 	pr.productname, -- Nom du produit
    		pr.productcode, -- Numéro du produit
    		sum(ordd.quantityordered) as total_quantity_ordered,  -- Total des quantités commandé 
    		pr.quantityinstock -- Quantité en stock
    from products pr
    inner join orderdetails ordd on -- Jointure entre les tables orderdetails et products 
    		pr.productcode = ordd.productcode -- avec le code du produit
    inner join orders ord on -- Jointure entre les tables orderdetails et orders 
    		ordd.ordernumber = ord.ordernumber -- avec le numéro de commande
    where 1=1
    	and ord.orderdate between '2021-01-01' and '2021-12-31' -- Filtrage des commandes passées entre le 1er janvier 2021 et le 31 décembre 2021
    	and ord.status != 'cancelled' -- Exclusion des commandes annulées de la sélection
    group by pr.productcode -- Regroupement des résultats par numéro de produit
    order by total_quantity_ordered desc -- Total des quantités commandé trié ar ordre décroissant 
    limit 5 -- Affichage des résultats limité à 5 lignes
    )
-- REQUETE PRINCIPALE    
select 	productcode, -- Numéro de produit
		productname, -- Libellé du produit
		quantityinstock, -- Quantité en stock 
		total_quantity_ordered -- Total des quantités commandé
from top_products_sold top
)
;

select * from stock_of_the_five_most_ordered_products; -- Affichage du contenu de la table
