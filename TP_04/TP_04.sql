
1️⃣ - Ajouter les données
-- SELECTIONNER La base de données
USE invitation;
-- vider la table de ses données
TRUNCATE inv_personne;
-- inserer DATA données
INSERT INTO inv_personne 
    (prenom,nom,age,inscription,etat,statut,cv,salaire)  
VALUES
('Brad','PITT',	60,'1970-01-01',1,'non membre','lorem ipsum', 2000000),
('George','CLONEY',62,'1999-01-01',1,'membre','juste beau',4000000),
('Jean','DUJARDIN',51,'1994-01-01',0,'membre','brice de nice',1000000);

2️⃣ - Afficher le plus gros salaire
USE invitation;
SELECT 
    MAX(salaire) AS plus_gros_salaire 
FROM inv_personne;

3️⃣ - Afficher le plus petit salaire
USE invitation;
SELECT 
    MIN(salaire) AS plus_petit_salaire 
FROM inv_personne;

4️⃣ - Afficher le nom de l'acteur (et son salaire) qui a le plus petit salaire avec LIMIT & ORDER BY
USE invitation;
SELECT 
prenom,nom,salaire
FROM inv_personne 
ORDER BY salaire ASC
LIMIT 1;

5️⃣ - Afficher le nom de l'acteur (et son salaire) qui a le plus gros salaire avec LIMIT & ORDER BY
USE invitation;
SELECT 
prenom,nom,salaire
FROM inv_personne 
ORDER BY salaire DESC
LIMIT 1;

6️⃣ - Afficher le salaire moyen
USE invitation;
SELECT 
AVG(salaire) AS salaire_moyen 
FROM inv_personne

7️⃣ - Afficher le nombre de personnes
USE invitation;
SELECT 
COUNT(id) AS nb_personnes
FROM inv_personne

8️⃣ - Afficher les acteurs avec un salaire entre 1 000 000 et 4 000 000 avec BETWEEN
USE invitation;
SELECT
prenom,nom,salaire
FROM inv_personne
WHERE salaire BETWEEN 1000001 AND 3999999;

9️⃣ Proposer une requete avec UPPER() & LOWER()
USE invitation;
SELECT
    id,
    prenom,
    LOWER(nom) AS nom
FROM inv_personne
WHERE id=1;


10 - Afficher les personnes dont le prenom contient 'bra'
SELECT nom, prenom ,salaire
FROM personne
WHERE prenom LIKE '%bra%'

12 - Trier par age les membres
SELECT 
prenom,nom,age
FROM inv_personne
WHERE type='membre'
ORDER BY age,nom ASC; # du plus petit au plus grand

13 - Afficher le nombre d'acteurs "membre"
USE invitation;
SELECT
    COUNT(id) AS nb_membres
FROM inv_personne
WHERE statut ='membre'
GROUP BY statut

14 - Afficher le nombre des membres et d'acteur "non membre"
USE invitation;
SELECT
    statut, COUNT(id)
FROM inv_personne
GROUP BY statut