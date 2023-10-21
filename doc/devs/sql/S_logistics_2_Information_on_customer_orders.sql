use toys_and_models;

drop table Information_on_customer_orders; -- Suppression de la table

-- Chiffre d'affaires par rapport à la quantité commandée et le nombre de commandes par pays
create table Information_on_customer_orders as (
SELECT
    cu.customername AS customer_name, -- Nom du client
    ord.orderdate AS ordered_on, -- Date de la commande
    AVG(DATEDIFF(ord.shippeddate, ord.orderdate)) AS shipped_in, -- Durée moyenne de livraison en jours    
    CONCAT(em.lastname, em.firstname) AS shipped_by -- Employé responsable de l'expédition
from customers cu
INNER join orders ord ON -- Jointure entre les tables customers et orders   
	cu.customernumber = ord.customernumber -- avec le numéro de client 
LEFT join employees em ON 
	cu.salesrepemployeenumber = em.employeenumber  -- Jointure avec les employés
GROUP by -- Regroupement des résultats par
    cu.customername, -- nom de client
    ord.orderdate, -- Date de commande
    em.lastname, -- Nom de famille de l'employé
    em.firstname -- Prénom de l'employé
ORDER by -- Tri par
    cu.customername, -- Nom de client
    ord.orderdate -- Trier par date de commande
)
;

select * from Information_on_customer_orders; -- Affichage du contenu de la table