-- Create database pour créer une  base de donnée


CREATE DATABASE transport;

-- afficher database

SHOW DATABASES;

-- utiliser une table 

USE transport;

-- supprimer BDD

DROP DATABASE transport;

-- Nous allons créer une bdd entreprise

CREATE DATABASE entreprise;

-- pour avoir la liste complète des employés

SELECT * FROM employes; 
-- * permet de sélectionner tous les champs de la liste

-- pour afficher le nom et prenom

SELECT nom,prenom FROM employes;

-- afficher la liste des services en évitant les doublons

SELECT DISTINCT service FROM employes;

--CONDITION WHERE 

-- Nom, prénom et salaire des employes du service informatique

SELECT nom,prenom,salaire FROM employes WHERE service = "informatique";


-- Affichage des employés ayant été recrutés entre 2015 et aujourd'hui

SELECT nom,prenom,date_embauche FROM employes WHERE date_embauche BETWEEN '2015-01-01' AND NOW();


-- ou CURDATE() pour la date du jour sans l'heure

SELECT prenom FROM employes WHERE prenom LIKE 's%';
SELECT prenom FROM employes WHERE prenom LIKE '%s%';
SELECT prenom FROM employes WHERE prenom LIKE '%s';

-- LIKE permet d'avoir des valeurs approximatives
-- % est le délimiteur

SELECT prenom FROM employes WHERE service = 'commercial' AND prenom LIKE '%e%';

-- affichage de tous les employés (sauf les informaticiens)

SELECT prenom FROM employes WHERE service != 'informatique';

SELECT prenom,salaire FROM employes WHERE salaire >= 3000;

-- affichage des employes ds l'ordre alphabetique
-- ASC et DESC

SELECT nom,prenom FROM employes ORDER BY nom ASC;

SELECT prenom,salaire FROM employes ORDER BY salaire DESC,prenom ASC;

-- affichage des employés 3 par 3
-- LIMIT 

SELECT prenom FROM employes LIMIT 0,3;
SELECT prenom FROM employes LIMIT 3,3;

-- affichage des employés avec leur salaire annuel

SELECT prenom,salaire*12 AS 'Salaire annuel' FROM employes;

--affichage de la masse salariale sur 12 mois avec SUM()

SELECT SUM(salaire*12) AS "Masse salariale" FROM employes;

-- affichage du salaire moyen

SELECT AVG(salaire) AS "Salaire moyen" FROM employes;

SELECT AVG(salaire) FROM employes WHERE prenom != 'Jean-Pierre';


-- affichage du nombre de femme(s) ds l'entreprise 

SELECT COUNT(*) AS "Nombre de femme(s) dans l'entreprise de Jean-Pierre le Boss" FROM employes WHERE sexe = 'f';

-- affichage du salaire min et du salaire max

SELECT MAX(salaire) AS "le salaire le plus haut donc celui de JP le Boss qui tue" FROM employes;

SELECT prenom,salaire FROM employes WHERE salaire = (SELECT MIN(salaire) FROM employes);

-- liste des employés du service informatique et commercial
-- IN

SELECT prenom,nom,service FROM employes WHERE service IN ('informatique','commercial');

-- Liste des employes qui ne sont pas ds le service comptabilite et juridique

--NOT IN 
SELECT prenom,nom,service FROM employes WHERE service NOT IN ('juridique','comptabilite');


-- affichage des commerciaux gagnant un salaire inf ou egale à 200

SELECT prenom,nom,salaire FROM employes WHERE service IN('commercial') AND salaire <= 2000;

-- prénom et nom des employés du service commercial travaillant pour un salaire de 1500 ou 1800 

SELECT prenom,nom,salaire FROM employes WHERE service = 'commercial' AND salaire = 1500 OR salaire = 1800;

-- afficher les services où il y a plus d'un employé par service
-- GROUP BY permet de regroupement

SELECT COUNT(*) FROM employes GROUP BY service;



---HAVING ds le cas d'un GROUP BY pour appliquer une condition

SELECT service,COUNT(prenom) AS "Nombre d'employés" FROM employes GROUP BY service HAVING COUNT(prenom)>1;





-- REQUETE D'INSERTION

-- INSERT INTO nom-de-la-table(les colonnes de la tables) VALUES( les valeurs)

INSERT INTO employes(id_employes, prenom, nom, sexe, service, date_embauche, salaire) VALUES(425, 'Benjamin', 'Legrosnul','m','direction','2021-05-12', 152850);

INSERT INTO employes(id_employes, prenom, nom, sexe, service, date_embauche, salaire) VALUES(428, 'Cathy', 'Prout','f','direction','0001-05-12', 10);

INSERT INTO employes(id_employes, prenom, nom, sexe, service, date_embauche, salaire) VALUES(426, 'Thomas', 'Tomate','m','assistant','1939-05-12', 1);


-- Requ^te de modif

UPDATE employes SET salaire = 2 WHERE id_employes = 426;

UPDATE employes SET salaire = salaire + 100 WHERE service = 'informatique';

-- requete de suppression

DELETE FROM employes;

DELETE FROM employes WHERE id_employes = 426;

1- SELECT service FROM employes WHERE id_employes = 547;

2- SELECT date_embauche FROM employes WHERE prenom = "amandine";

3- SELECT nom FROM employes WHERE prenom = "guillaume";

4- SELECT COUNT(*) FROM employes WHERE prenom LIKE 'c%';

5- SELECT COUNT(*) FROM employes WHERE service = 'commercial';

6- SELECT ROUND(AVG(salaire)) FROM employes WHERE service = 'informatique';

7- SELECT nom FROM employes ORDER BY nom ASC LIMIT 0,5;

8- SELECT SUM(salaire*12)  FROM employes WHERE service = 'commercial';

9- SELECT service,AVG(salaire) FROM employes GROUP BY service;

10- SELECT COUNT(*) FROM employes WHERE date_embauche BETWEEN '2010-01-01' AND '2010-12-31';

11- SELECT AVG(salaire) FROM employes WHERE date_embauche BETWEEN '2010-01-01' AND '2017-12-31';

12- SELECT COUNT(DISTINCT service)  FROM employes ;

13- SELECT nom FROM employes WHERE service NOT IN ('production','secretariat');

14- SELECT COUNT(*) FROM employes GROUP BY sexe;

15- SELECT nom FROM employes WHERE service = 'commercial' AND salaire > 2500 AND date_embauche < '2017-01-01' AND sexe = 'm';

16- SELECT NOM FROM EMPLOYES ORDER BY date_embauche DESC LIMIT 1;

17- SELECT * FROM employes WHERE service = 'commercial' AND salaire = (SELECT MAX(salaire) FROM employes WHERE service = 'commercial');

18- SELECT prenom,nom FROM employes WHERE service = 'comptabilite' AND salaire = (SELECT MAX(salaire) FROM employes WHERE service = 'comptabilite');

19- SELECT prenom FROM employes WHERE service = 'informatique' ORDER BY date_embauche DESC LIMIT 1;

