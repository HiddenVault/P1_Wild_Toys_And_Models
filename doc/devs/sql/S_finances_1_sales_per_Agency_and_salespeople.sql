use toys_and_models;

drop table Sales_per_Agency_and_salespeople; -- Suppression de la table

-- Chiffre d'affaire par Agence et Nb de vendeur par Agence
create table Sales_per_Agency_and_salespeople as ( 
-- TABLE TEMPORAIRE vendor_customer_paiement
with vendor_customer_paiement as ( -- utilisation de 'with as' pour créer une table temporaire appelée 'vendor_customer_paiement'
-- REQUETE SECONDAIRE
select 	salesrepemployeenumber, -- Numéro de l'employé rattaché au client
		count(cu.customernumber) as clients, -- Nombre de clients 
		sum(payments.amount) as paiement -- Montant total des paiements reçus par le vendeur
    from customers cu
    inner join payments on -- Jointure entre les tables payments et customers 
    		payments.customernumber = cu.customernumber -- avec le code du client
    group by salesrepemployeenumber -- 
)
-- REQUETE PRINCIPALE
select 	off.city, -- Ville
		off.country, -- Pays 
		count(em.employeenumber) as number_salespeople, -- Nombre de vendeurs
		sum(paiement) as agency_sales -- CA de l'agence
from offices off
inner join employees em on -- Jointure entre les tables employees et offices
		em.officecode = off.officecode -- avec le code d'agence 'officecode'
inner join vendor_customer_paiement on -- Jointure entre les tables employees et vendor_customer_paiement
		vendor_customer_paiement.salesrepemployeenumber = em.employeenumber -- avec le code de l'employé
group by off.officecode -- Regroupement par code d'agence 'officecode'
)
;

select * from Sales_per_Agency_and_salespeople; -- Affichage du contenu de la table 
