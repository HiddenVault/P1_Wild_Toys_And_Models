use toys_and_models;

drop table last_two_months_order_sales_by_country; -- Suppression de la table

-- Finances :
-- Le chiffre d'affaires des commandes des deux derniers mois par pays.

create table last_two_months_order_sales_by_country as(
-- TABLE TEMPORAIRE final
with final as ( -- utilisation de 'with as' pour créer une table temporaire appelée 'final'
-- REQUETE SECONDAIRE
select 	orders.ordernumber, -- numéro de la commande
		orderdate, -- date de la commande
		status, -- statut de la commande (shipped, resolved, cancelled)
		country, -- le pays
		sum(priceeach*quantityordered) as totalprice -- chiffre d'affaire total pour chaque commande
from orders
inner join customers on  -- Jointure entre les tables orders et customers
	orders.customernumber = customers.customernumber -- avec le numéro de client
inner join orderdetails on -- Jointure entre les tables orders et orderdetails
	orderdetails.ordernumber = orders.ordernumber -- avec le numéro de commande
where 1=1
	and status != 'cancelled' -- filtre les commandes dont le statut n'est pas "cancelled"
	and ( -- filtrage des commandes dont la date (année et mois) correspond au mois précédent par rapport à la date actuelle 
	12*year(orderdate) + month(orderdate) = (12*year(current_timestamp) + month(current_timestamp) - 1)
    or -- filtrage des commandes dont la date correspond à deux mois avant la date actuelle
    12*year(orderdate) + month(orderdate) = (12*year(current_timestamp) + month(current_timestamp) - 2))
group by ordernumber) -- regroupe les résultats par numéro de commande et calcule le montant total de chaque commande.
-- REQUETE PRINCIPALE
-- La requête principale sélectionne les données de la table temporaire "final"
select final.country, month(final.orderdate), sum(final.totalprice) as turnover 
from final 
group by month(final.orderdate), final.country -- regroupe les résultats par mois et par pays
order by month(final.orderdate), final.country -- trie les résultats par mois et par pays
)
;

select * from last_two_months_order_sales_by_country; -- Affichage du contenu de la table
