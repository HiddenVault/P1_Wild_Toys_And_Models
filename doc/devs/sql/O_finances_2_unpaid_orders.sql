use toys_and_models;

drop table unpaid_orders; -- Suppression de la table

-- Finance
-- Commandes non encore payées

-- TABLE TEMPORAIRE total_commande
create table unpaid_orders as (
with total_commande as(
-- Sous requête total_commande
-- Elle calcule le montant total dû pour chaque commande passée par un client.
-- Les calculs sont effectués en joignant les tables orders, orderdetails, et customers 
-- pour obtenir le montant total des commandes (quantityOrdered * priceEach) pour chaque client.
-- Les résultats sont regroupés par le numéro de client (customerNumber). 
select
	ord.customerNumber, -- Numéro du client
	cu.customerName, -- Nom du client
	SUM(ordd.quantityOrdered * ordd.priceEach) as total_due -- Montant total dû (quantité commandé * prix unitaire) pour chaque client
	from orders ord
	inner join orderdetails ordd on -- Jointure entre les tables orderdetails et orders
			ordd.orderNumber = ord.orderNumber -- avec le numéro de commande
	inner join customers cu on -- Jointure entre les tables customers et orders 
			ord.customerNumber = cu.customerNumber -- avec le numéro de commande
	group by
		ord.customerNumber), -- Regroupement par numéro de client
-- Sous requête total_paiement
-- Elle calcule le montant total payé par chaque client 
-- en agrègeant les paiements dans la table `payments` en utilisant 
-- la fonction `SUM` pour obtenir le total des paiements pour chaque client.	
		total_paiement as (
		select
			pa.customerNumber, -- Numéro de client
			sum(pa.amount) as total_paid -- Montant total des paiements pour chaque client
		from payments pa
		group by
			customerNumber) -- Regroupement par numéro de client
-- REQUETE PRINCIPALE  
select
	tc.customerName, -- Nom du client
	total_due, -- Montant total dû pour chaque client
	total_paid, -- Montant total des paiements pour chaque client
	(total_due - total_paid) as rest_to_pay -- Calcul du reste à payer
	from total_commande tc
-- La clause FROM combine les résultats des sous-requêtes `total_commande` et `total_paiement`
-- En utilisant LEFT JOIN sur le numéro de client 'customerNumber', 
-- On obtient la totalité des clients (y compris ceux qui n'ont pas encore payé).
left join total_paiement tp on -- Jointure entre total_paiement et total_commande 
	tp.customerNumber = tc.customerNumber -- avec le numéro de client
where 1=1
	-- Affichage des clients dont le montant total du est différent du montant payé (cela doit inclure les paiements en attente).
	and total_due <> total_paid
order by
	-- Affichage des clients dont le reste à payer est le plus important
	rest_to_pay desc
)
	;

select * from unpaid_orders; -- Affichage du contenu de la table
