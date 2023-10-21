use toys_and_models;

drop table Aggregate_product_information_by_supplier; -- Suppression de la table

-- Agrégation des informations sur les produits en fonction de leur fournisseur
create table Aggregate_product_information_by_supplier as (
select
	productvendor, -- Nom du fournisseur de produit
	-- Utilisation de fonctions d'agrégation pour regrouper les donnéers par fournisseur
	count(productname) as Number_of_products, -- Nombre de ce produits fournis
	avg(buyprice) as average_purchase_price, -- Prix d'achat moyen de tous les produits
	avg(msrp) as average_selling_price, -- Prix de vente moyen de tous les produits
	sum(quantityinstock) as stock, -- Quantité totale en stock de tous les produits
	sum(buyprice * quantityinstock) as global_purchasing, -- Coût total d'achat de tous les produits (prix d'achat * quantité en stock)
	sum(msrp * quantityinstock) as global_sales, -- CA total généré par la vente de tous les produits (prix de vente * quantité en stock)
	avg(msrp / buyprice) as average_sales -- Rapport moyen entre le prix de vente et le prix d'achat pour tous les produits
from
	products
group by
	productvendor -- Regroupement des données par fournisseurs
)
;

select * from Aggregate_product_information_by_supplier; -- Affichage du contenu de la table