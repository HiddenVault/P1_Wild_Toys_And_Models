Projet 1 - SQL & BI - Toys & Models

# INTRODUCTION

Vous êtes mandaté par une entreprise qui vend des maquettes et des modèles réduits.

L'entreprise possède déjà une base de données qui répertorie les employés, les produits, les commandes et bien plus encore. 
Vous êtes invité à parcourir et découvrir cette base de données.

**Le directeur de l'entreprise souhaite disposer d'un tableau de bord qu'il pourrait actualiser chaque matin pour obtenir les dernières informations afin de gérer l'entreprise.**

------

# GOAL & OBJECTIVES

Votre tableau de bord devrait s'articuler autour de ces 4 principaux thèmes : ventes, finances, logistique et ressources humaines. Voici les indicateurs obligatoires qui devraient être présents dans votre tableau de bord.

**Il est recommandé de créer des KPIs supplémentaires.** 

**Cette partie est très importante afin de développer vos compétences/créativité en tant qu'analyste de données.**

**Ventes :** 

- Le nombre de produits vendus par catégorie et par mois, avec comparaison et taux de variation par rapport au même mois de l'année précédente.

**Finances :**

- Le chiffre d'affaires des commandes des deux derniers mois par pays.

- Les commandes qui n'ont pas encore été payées.

**Logistique :** 

- Le stock des 5 produits les plus commandés.

**Ressources Humaines :** 

- Chaque mois, les 2 vendeurs ayant le plus haut chiffre d'affaires.

**Nota bene :** 
parfois, les indicateurs d'affaires ne sont pas techniquement réalisables. 
Il vous incombe de l'expliquer et d'apporter vos propres idées pour répondre aux besoins de l'entreprise.

------

# RESOURCES

Voici le schéma de la base de données :

![](./img/logoSQL.png)

![](./img/schemaBDD.png)

------

# TOOLS

Le directeur ne souhaite pas faire de SQL, il veut pouvoir accéder aux données automatiquement et de manière graphique. Vous pouvez donc proposer un outil de votre choix (Power BI, Tableau...), tant que le tableau de bord est pertinent.

Pour information, la base de données est disponible sur un serveur de l'entreprise. Vous pouvez y accéder en mode lecture seule avec un utilisateur fourni.

L'entreprise vous fournit également le script que vous pouvez exécuter sur votre serveur MySQL local. Les données sont identiques, et s'arrêtent à la fin du mois précédent.

Durant la semaine de la démo, les données seront mises à jour avec des données nouvelles et fraîches (et vous pourrez recevoir le script de mise à jour si vous le faites localement). La démo devrait donc afficher les données les plus récentes disponibles.

------

# SQL DATABASE

Vous avez le choix entre vous connecter au serveur cloud ou déployer le script localement. Les données sont identiques dans les deux cas.

**Installation locale :**
Vous pouvez installer un serveur MySQL Community sur votre machine, ainsi que le client MySQL Workbench.
La base de données est prête à être chargée sur un serveur MySQL. 
Connectez-vous à votre serveur via Workbench, et [exécutez tout le code de ce fichier.](https://drive.google.com/file/d/103rMHcnpC70bx-5IHbKEdAY_OaQBdWVR/view?usp=sharing)

**Serveur Cloud :**
Vous pouvez vous connecter au serveur MariaDB (un dérivé de MySQL) de l'entreprise.

- Hostname : 000.000.000.000

- Port : 00000

- Username : xxxxxxx

- Password : xxxxxxxxxxx

------

# CONNECTION WITH MYSQL WORKBENCH

![](./img/connectionWorkbench.png)

------

# NOTES

Vous choisissez votre propre outil de reporting. Mais l'objectif est de pratiquer le SQL.  Vous devez donc obtenir les données via des requêtes SQL. 

Par exemple, pour les "2 vendeurs ayant le plus haut chiffre d'affaires pour chaque mois" :

- Ce que nous souhaitons : une requête SQL ne présentant que les "2 vendeurs ayant le plus haut chiffre d'affaires pour chaque mois", et une visualisation de données pour montrer cela.

- Ce que nous ne voulons pas : une requête SQL avec tous les vendeurs, puis des filtres dans votre outil de reporting.

------

# RÉSULTAT ATTENDU

Vous ferez une brève présentation de votre tableau de bord (demandez la durée à votre formateur). 

La présentation comprendra :

- Présentation du contexte, présentation de l'équipe et des outils utilisés.

- Démonstration de votre tableau de bord et interprétation commerciale des KPIs.

- Difficultés rencontrées, perspectives d'évolution.

- N'hésitez pas à créer des KPIs supplémentaires !

------

# ORGANISATION

- Durée de présentation :  entre 10 et 15 min

- Nombre de wilders par groupe :  3-4 personnes

- Les groupes sont faits aléatoirement

- Présentations : jeudi 12 octobre

- Outils : SQL + Power BI (ou Tableau)