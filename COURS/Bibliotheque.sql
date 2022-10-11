-- Création des tables de bdd wf3bibliotheque

CREATE TABLE abonne(
    id_abonne INT(3) NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_abonne)
) ENGINE= InnoDB;


CREATE TABLE livre(
    id_livre INT(3) NOT NULL AUTO_INCREMENT,
    auteur VARCHAR(60) NOT NULL,
    titre VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_livre)
    ) ENGINE= innoDB;

CREATE TABLE emprunt(
    id_emprunt INT(3) NOT NULL AUTO_INCREMENT,
    id_abonne INT(3) DEFAULT NULL,
    id_livre INT(3) DEFAULT NULL,
    date_sortie DATE,
    date_rendu DATE DEFAULT NULL,
    PRIMARY KEY (id_emprunt)
    ) ENGINE= innoDB;


-- Pour modifier une table on utilise ALTER TABLE 

-- Ajouter une clé étrangère 

ALTER TABLE emprunt ADD FOREIGN KEY (id_livre) REFERENCES wf3bibliotheque.livre(id_livre);

ALTER TABLE emprunt ADD FOREIGN KEY (id_abonne) REFERENCES wf3bibliotheque.abonne(id_abonne);



------------SOUS REQUETE OU REQUETE IMBRIQUEE

/* Une sous requête ou requête imbriquée est une requête avec la commande SELECT imbriquée
avec d'autres requête SELECT
*/

-- Afficher les  id_livre dont la date_rend est NULL

SELECT id_livre FROM emprunt WHERE date_rendu IS NULL;

--Titre des livres dans la nature(date_rend est NULL)

SELECT titre FROM livre Where id_livre IN (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL);

-- Liste des abonnés n'ayant pas rendu des livres à la bibliotheque.

SELECT prenom FROM abonne WHERE id_abonne IN 
            (SELECT id_abonne FROM emprunt WHERE date_rendu IS NULL);

-- Nous aimerions connaitre le n° de(s) livre(s) que Chloé a emprunté à la bibliothèque
SELECT id_livre FROM emprunt WHERE id_abonne IN 
            (SELECT id_abonne FROM abonne WHERE prenom = "Chloe");

-- Afficher les prénoms des abonnés ayant emprunté un livre le 11/12/2016


SELECT prenom FROM abonne WHERE id_abonne IN 
            (SELECT id_abonne FROM emprunt WHERE date_sortie='2016-12-11');

-- Combien de livre Guillaume a emprunté à la bibliotheque +(AS nombre de livre)?

SELECT COUNT(*) AS "nombre de livres" FROM emprunt WHERE id_abonne
            IN (SELECT id_abonne FROM abonne WHERE prenom = "Guillaume");

-- Afficher la liste des abonnés ayant déjà emprunté un livre d'Alphonse DAUDET

SELECT id_abonne FROM emprunt WHERE id_livre
            IN (SELECT id_livre FROM livre WHERE auteur = "ALPHONSE DAUDET");


-- Nous aimerions maintenant connaitre le titre de(s) livre(s) que Chloé a emprunté à la bibliothèque

SELECT titre FROM livre WHERE id_livre IN
    (SELECT id_livre FROM emprunt WHERE id_abonne IN
        (SELECT id_abonne FROM abonne WHERE prenom = 'Chloe' ));

-- Nous aimerions connaitre les titres de livre que Chloé na pas encore emprunté

SELECT titre FROM livre WHERE id_livre NOT IN 
    (SELECT id_livre FROM emprunt WHERE id_abonne IN
        (SELECT id_abonne FROM abonne WHERE prenom = 'Chloe' ));


-- Qui a emprunté le plus de livre à la bibliotheque ?

SELECT prenom FROM abonne WHERE id_abonne 
IN (SELECT id_abonne FROM emprunt WHERE id_emprunt IN
        (SELECT MAX(id_emprunt) FROM emprunt));





--------------------LES JOINTURES --------------------

/*
Une jointure est une opération qui permet de chercher des lignes ou enregistrements 
à partir de 2 ou plusieurs tables disposant d'un ensemble de valeur commune (la clé primaire)

Jointure simple ou INNER JOIN: C'est une jointure entre 2 ou pls tables qui retourne uniquement les
éléments de la table A qui ont une correspondance ds la table B

LEFT OUTER JOIN : Retourne les enregistrements ds la table A qui st ds la table B. Pour les enregistrements 
qui n'ont pas de valeur correspondante la valeur sera NULL

RIGHT OUTER JOIN : Retourne les enregistrements ds la table B qui st ds la table B. Pour les enregistrements
qui n'ont pas de valeur correspondante la valeur sera NULL

*/

SELECT prenom, date_sortie, date_rendu
FROM abonne A
INNER JOIN emprunt E
ON A.id_abonne= E.id_abonne
AND A.prenom = "Guillaume";

SELECT a.prenom, e.date_sortie, e.date_rendu
FROM abonne a, emprunt e
WHERE a.id_abonne = e.id_abonne
AND a.prenom = "Guillaume";


-- Nous aimerions connaitre les mouvements des livres (date de sortie et de rendu) écrit par  Alphonse Daudet

SELECT l.auteur,e.date_sortie, e.date_rendu 
FROM livre l
INNER JOIN emprunt e
ON l.id_livre = e.id_livre
AND l.auteur= "ALPHONSE DAUDET";

SELECT e.date_sortie, e.date_rendu
FROM livre l, emprunt e 
WHERE l.id_livre = e.id_livre
AND l.auteur = "ALPHONSE DAUDET";


-- Nous aimerions connaitre les mouvements des livres (date de sortie et de rendu, l'auteur et le titre des livres) écrit par  Alphonse Daudet

SELECT auteur, titre, date_sortie, date_rendu
FROM livre 
INNER JOIN emprunt
ON livre.id_livre=emprunt.id_livre
AND livre.auteur= "ALPHONSE DAUDET";

-- Nous aimerions connaitre le nombre de livre(s) emprunté(s) par chaque abonné

SELECT prenom, COUNT(*) 
AS 'livres empruntés' 
FROM abonne A 
INNER JOIN emprunt E 
ON A.id_abonne = E.id_abonne 
GROUP BY A.prenom ;


--Nous aimerions connaitre le nombre de livre(s) a rendre pour chaque abonné

SELECT prenom, COUNT(*) 
AS "Livres à rendre"
FROM abonne A
INNER JOIN emprunt E
ON A.id_abonne = E.id_abonne
AND E.date_rendu IS NULL
GROUP BY A.Prenom;


--Qui a emprunté Quoi ? et Quand ? (Titre des livres emprunté, à quel date, et savoir par qui)

SELECT prenom, titre, date_sortie
FROM abonne A
INNER JOIN emprunt E
INNER JOIN livre L
ON A.id_abonne = E.id_abonne
AND L.id_livre = E.id_livre;


-- Afficher les prenoms des abonnés avec les no des livres quils ont emprunté.

SELECT a.prenom, e.id_livre
FROM abonne a 
INNER JOIN emprunt e
INNER JOIN livre l
ON a.id_abonne = e.id_abonne
AND e.id_livre = l.id_livre;


--Ajoutez un nouvel abonné dans la table abonne

INSERT INTO abonne(prenom) VALUES ('Nicolas');


-- Affichez tous les prénom avec les id des livres empruntés

SELECT prenom, id_livre
FROM abonne
LEFT JOIN emprunt
ON abonne.id_abonne = emprunt.id_abonne;





--------------FONCTIONS PREDEFINIES ----------------------

SELECT DATABSE ();  -- Indique la bdd qui est actuellement sélectionné

SELECT VERSION(); -- Indique la versionb de mySQL

SELECT LAST_INSERT_ID ();  -- Indique le dernier id créer

---DATE_ADD() permet d'ajouter un interval de temps à une date 

SELECT DATE_ADD(CURDATE(); INTERVAL 20 DAY);

SELECT DATE_ADD("2022-01-02", INTERVAL 28 DAY);

-- DATE_FORMAT() qui permet de formater une date ds un ofrmat donné

SELECT DATE_FORMAT(CURDATE(),'%d/%m/%Y');

SELECT DATE_FORMAT(CURTIME(),'%H:%i:%s');

-- DAYNAME : donne le jour d'une date

SELECT DAYNAME(CURDATE());

-- DAYOFTHEYEAR : donne le num du jour de l'année

SELECT DAYOFTHEYEAR("2022-01-02");

SELECT NOW(); -- Indique la date eet l'heure;

-- PASSWORD() : permet de hasher(crypter) un mdp à partir d'une chaine de caracteres

SELECT PASSWORD('MonMotDePasse');

-- CONCAT() : permet de concatener des chaines ensembles

SELECT CONCAT('Julien ','COTTET ', '2 rue de la république ', 75001 , 'Paris');

--CONCAT_WS() : permet de concatener en utilisant un separateur (with separator)

SELECT CONCAT(":", id_abonne, prenom) AS 'info user' FROM abonne;

--Locate()

SELECT LOCATE('o','Bonjour');

SELECT LOCATE('tout', 'Bonjour tout le monde'); --9

-- REPLACE() : remplace ttes les occurences d'une sous chaine dans une chaine

SELECT REPLACE('www.google.fr', 'google', 'wf3'); 




----------- Les tables virtuelles ou vues(view)
-- Une table virtuelle est une table qui se construit à partir d'une requête
--et de colone de tables existantes
-- Pratique pour isoler des résultats
-- Une table virtuelle est constamment à jour. On dit qu'on stock la requpete dans la table virtuelle



CREATE view liste_homme AS
        SELECT prenom, nom,sexe
        FROM employes
        WHERE sexe='m';

SELECT * FROM liste_homme WHERE prenom LIKE %e%;


-- Les tables temporaires
-- Dans la table temp on stock le résultat de la requete
-- la table temporaire sera supprimé automatiquement dès que je ferme ma console

SELECT * FROM employes WHERE date_embauche BETWEEN '2010-01-01' AND '2013-12-31';

CREATE TEMPORARY TABLE embauche AS
        SELECT *
        FROM employes 
        WHERE date_embauche
        BETWEEN '2010-01-01' 
        AND '2013-12-31';




-------- LES TRANSACTIONS

-- Une transaction permet de passer ma bdd d'un état cohérent à un état cohérent
-- C'est à dire spoit la transaction est validée par COMMIT soit elle est annulée par ROLLBACK



START TRANSACTION;
UPDATE employes set salaire = 100;
UPDATE employes SET salaire = 50;
ROLLBACK;

START TRANSACTION; -- démarre une transaction
SELECT * FROM employes; -- mes requetes 
UPDATE employes SET salaire = salaire+1000;
UPDATE employes SET prenom = 'Audrey' WHERE id_employes = 388;
SELECT * FROM employes;
ROLLBACK; -- termine et annule la transaction

COMMIT; -- termine et valide la transaction



--------- TRANSACTION AVEC SAVEPOINT


START TRANSACTION;
    SELECT * FROM employes;
    SAVEPOINT point1;

    UPDATE employes SET salaire = 2500 WHERE id_employes = 388;
    SELECT * FROM employes;
    SAVEPOINT point2;

    UPDATE employes SET prenom = 'Julien' WHERE id_employes = 388;
    SELECT * FROM employes;
    SAVEPOINT point3;

    UPDATE employes SET salaire = 5000 WHERE id_employes = 388;
    SELECT * FROM employes;
    SAVEPOINT point4;

    UPDATE employes SET salaire = 5000 WHERE id_employes = 388;
    SELECT * FROM employes;
    SAVEPOINT point5;

    ROLLBACK to point3;




-----DIAGRAMME


0 1 et n 



0,1 ===> au plus 1

1,1 ==> au moins 1 et au plus 1

1, n ==> au moins 1 et au plus n 

0, n ==> de 0 à n 


