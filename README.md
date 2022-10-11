# SQL EXERCICES JOUR 2 CREER LA BASE DE DONNEE SUR PHPMYADMINB ET FAIRE REQUETES

-- conducteur 
-- +---------------+----------+-----------+
-- | id_conducteur | prenom   | nom       |
-- +---------------+----------+-----------+
-- |             1 | Julien   | Avigny    |
-- |             2 | Morgane  | Alamia    |
-- |             3 | Philippe | Pandre    |
-- |             4 | Amelie   | Blondelle |
-- |             5 | Alex     | Richy     |
-- +---------------+----------+-----------+

-- association_vehicule_conducteur
-- +----------------+-------------+---------------+
-- | id_association | id_vehicule | id_conducteur |
-- +----------------+-------------+---------------+
-- |              1 |         501 |             1 |
-- |              2 |         502 |             2 |
-- |              3 |         503 |             3 |
-- |              4 |         504 |             4 |
-- |              5 |         501 |             3 |
-- +----------------+-------------+---------------+

-- vehicule
-- +-------------+---------------------+---------+---------+-----------------+
-- | id_vehicule | marque		   		| modele  | couleur | immatriculation |
-- +-------------+---------------------+---------+---------+-----------------+
-- |         501 | Peugeot             | 807     | noir    | AB-355-CA       |
-- |         502 | Citroen             | C8      | bleu    | CE-122-AE       |
-- |         503 | Mercedes            | Cls     | vert    | FG-953-HI       |
-- |         504 | Volkswagen          | Touran  | noir    | SO-322-NV       |
-- |         505 | Skoda               | Octavia | gris    | PB-631-TK       |
-- |         506 | Volkswagen          | Passat  | gris    | XN-973-MM       |
-- +-------------+---------------------+---------+---------+-----------------+

------------------------------------------------------------------------------------------
A- Faites le MCD

1- Pour éviter les erreurs, la société de taxis aimerait que l’on ne puisse pas faire une mauvaise association lors de la saisie.
Exemple : conducteur 58 avec le véhicule 900 (car ils n’existent pas). Faites le test

2- La société de taxis peut modifier leurs conducteurs via leur logiciel, lorsqu’un conducteur est modifié (dans la table conducteur - changement d’id par exemple), la société aimerait que la modification soit répercutée dans la table « association_vehicule_conducteur ». 

3- La société de taxis peut supprimer des conducteurs via leur logiciel, ils aimeraient bloquer la possibilité de supprimer un conducteur (dans la table conducteur) tant que celui-ci conduit un véhicule.

4- La société de taxis peut modifier un véhicule via leur logiciel. Lorsqu’un véhicule est modifié (dans la table véhicule - changement d’id par exemple), la société aimerait que la modification soit répercutée dans la table « association_vehicule_conducteur ». 

5- Si un véhicule est supprimé alors qu’un ou plusieurs conducteurs le conduisaient, la société aimerait garder la présence de ces conducteurs dans la table « association_vehicule_conducteur » en précisant « null » comme valeur dans le champ correspondant puisque le véhicule aura été supprimé.

------------------------------------------------------------------------------------------
-- 6/	Qui conduit la voiture 503 ?
-- +----------+
-- | prenom   |
-- +----------+
-- | Philippe |
-- +----------+
------------------------------------------------------------------------------------------
-- 7/	Qui conduit quoi ?
-- +--------+----------+
-- | modele | prenom   |
-- +--------+----------+
-- | 807    | Julien   |
-- | C8     | Morgane  |
-- | Cls    | Philippe |
-- | Touran | Amelie   |
-- | 807    | Philippe |
-- +--------+----------+
------------------------------------------------------------------------------------------
-- 8/	Ajoutez vous dans la liste des conducteurs.
-- 8/	Afficher les conducteurs (meme ceux qui n'ont pas de correspondance avec les vehicules)
-- +--------+----------+
-- | modele | prenom   |
-- +--------+----------+
-- | 807    | Julien   |
-- | C8     | Morgane  |
-- | Cls    | Philippe |
-- | 807    | Philippe |
-- | Touran | Amelie   |
-- | NULL   | Alex     |
-- +--------+----------+
------------------------------------------------------------------------------------------
-- 9/	Ajoutez un nouvel enregistrement dans la table des véhicules.
-- 9/	Afficher les vehicules (meme ceux qui n'ont pas de correspondance avec les conducteurs)
-- +---------+----------+
-- | modele  | prenom   |
-- +---------+----------+
-- | 807     | Julien   |
-- | 807     | Philippe |
-- | C8      | Morgane  |
-- | Cls     | Philippe |
-- | Touran  | Amelie   |
-- | Octavia | NULL     |
-- +---------+----------+
------------------------------------------------------------------------------------------
-- 10/	Afficher tous les conducteurs et tous les vehicules, peut importe les correspondances.(Utiliser UNION cf doc : https://sql.sh/cours/union)
-- +---------+----------+
-- | modele  | prenom   |
-- +---------+----------+
-- | 807     | Julien   |
-- | C8      | Morgane  |
-- | Cls     | Philippe |
-- | 807     | Philippe |
-- | Touran  | Amelie   |
-- | NULL    | Alex     |
-- | Octavia | NULL     |
-- +---------+----------+


Solution des restrictions :

![Restriction sql](https://user-images.githubusercontent.com/110043081/195116814-aeb511dd-3fd4-4e48-8537-4e6e0186a2fe.png)


