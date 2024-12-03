-- Création de la base de données
DROP DATABASE IF EXISTS location_ski;
CREATE DATABASE location_ski;
USE location_ski;

-- Insertion des données dans `clients`
INSERT INTO clients (noCli, nom, prenom, adresse, cpo, ville) VALUES 
    (1, 'Albert', 'Anatole', 'Rue des accacias', '61000', 'Amiens'),
    (2, 'Bernard', 'Barnabé', 'Rue du bar', '1000', 'Bourg en Bresse'),
    (3, 'Dupond', 'Camille', 'Rue Crébillon', '44000', 'Nantes'),
    (4, 'Desmoulin', 'Daniel', 'Rue descendante', '21000', 'Dijon'),
    (5, 'Ferdinand', 'François', 'Rue de la convention', '44100', 'Nantes'),
    (6, 'Albert', 'Anatole', 'Rue des accacias', '61000', 'Amiens'),
    (9, 'Dupond', 'Jean', 'Rue des mimosas', '75018', 'Paris'),
    (14, 'Boutaud', 'Sabine', 'Rue des platanes', '75002', 'Paris');

-- Insertion des données dans `fiches`
INSERT INTO fiches (noFic, noCli, dateCrea, datePaiement, etat) VALUES 
    (1001, 14, DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 13 DAY), 'SO'),
    (1002, 4, DATE_SUB(NOW(), INTERVAL 13 DAY), NULL, 'EC'),
    (1003, 1, DATE_SUB(NOW(), INTERVAL 12 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY), 'SO'),
    (1004, 6, DATE_SUB(NOW(), INTERVAL 11 DAY), NULL, 'EC'),
    (1005, 3, DATE_SUB(NOW(), INTERVAL 10 DAY), NULL, 'EC'),
    (1006, 9, DATE_SUB(NOW(), INTERVAL 10 DAY), NULL, 'RE'),
    (1007, 1, DATE_SUB(NOW(), INTERVAL 3 DAY), NULL, 'EC'),
    (1008, 2, DATE_SUB(NOW(), INTERVAL 0 DAY), NULL, 'EC');

-- Insertion des données dans `tarifs`
INSERT INTO tarifs (codeTarif, libelle, prixJour) VALUES
    ('T1', 'Base', 10),
    ('T2', 'Chocolat', 15),
    ('T3', 'Bronze', 20),
    ('T4', 'Argent', 30),
    ('T5', 'Or', 50),
    ('T6', 'Platine', 90);

-- Insertion des données dans `gammes`
INSERT INTO gammes (codeGam, libelle) VALUES
    ('PR', 'Matériel Professionnel'),
    ('HG', 'Haut de gamme'),
    ('MG', 'Moyenne gamme'),
    ('EG', 'Entrée de gamme');

-- Insertion des données dans `categories`
INSERT INTO categories (codeCate, libelle) VALUES
    ('MONO', 'Monoski'),
    ('SURF', 'Surf'),
    ('PA', 'Patinette'),
    ('FOA', 'Ski de fond alternatif'),
    ('FOP', 'Ski de fond patineur'),
    ('SA', 'Ski alpin');

-- Insertion des données dans `grilleTarifs`
INSERT INTO grilleTarifs (codeGam, codeCate, codeTarif) VALUES
    ('EG', 'MONO', 'T1'),
    ('MG', 'MONO', 'T2'),
    ('EG', 'SURF', 'T1'),
    ('MG', 'SURF', 'T2'),
    ('HG', 'SURF', 'T3'),
    ('PR', 'SURF', 'T5'),
    ('EG', 'PA', 'T1'),
    ('MG', 'PA', 'T2'),
    ('EG', 'FOA', 'T1'),
    ('MG', 'FOA', 'T2'),
    ('HG', 'FOA', 'T4'),
    ('PR', 'FOA', 'T6'),
    ('EG', 'FOP', 'T2'),
    ('MG', 'FOP', 'T3'),
    ('HG', 'FOP', 'T4'),
    ('PR', 'FOP', 'T6'),
    ('EG', 'SA', 'T1'),
    ('MG', 'SA', 'T2'),
    ('HG', 'SA', 'T4'),
    ('PR', 'SA', 'T6');

-- Insertion des données dans `articles`
INSERT INTO articles (refart, designation, codeGam, codeCate) VALUES 
    ('F01', 'Fischer Cruiser', 'EG', 'FOA'),
    ('F02', 'Fischer Cruiser', 'EG', 'FOA'),
    ('F03', 'Fischer Cruiser', 'EG', 'FOA'),
    ('F04', 'Fischer Cruiser', 'EG', 'FOA'),
    ('F05', 'Fischer Cruiser', 'EG', 'FOA'),
    ('F10', 'Fischer Sporty Crown', 'MG', 'FOA'),
    ('F20', 'Fischer RCS Classic GOLD', 'PR', 'FOA'),
    ('F50', 'Fischer SOSSkating VASA', 'HG', 'FOP'),
    ('P01', 'Décathlon Allegre junior 150', 'EG', 'PA'),
    ('S01', 'Décathlon Apparition', 'EG', 'SURF'),
    ('A01', 'Salomon 24X+Z12', 'EG', 'SA');

-- Insertion des données dans `lignesFic`
INSERT INTO lignesFic (noFic, noLig, refart, depart, retour) VALUES 
    (1001, 1, 'F05', DATE_SUB(NOW(), INTERVAL 15 DAY), DATE_SUB(NOW(), INTERVAL 13 DAY)),
    (1002, 1, 'A03', DATE_SUB(NOW(), INTERVAL 13 DAY), DATE_SUB(NOW(), INTERVAL 9 DAY)),
    (1005, 1, 'F05', DATE_SUB(NOW(), INTERVAL 9 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY));


-- 1️⃣ Liste des clients dont le nom commence par un D
SELECT * FROM clients
WHERE nom LIKE 'D%';

-- 2️⃣ Nom et prénom de tous les clients
SELECT prenom, nom FROM clients;

-- 3️⃣ Liste des fiches pour les clients en Loire Atlantique (44)
SELECT f.noFic, f.etat, c.nom, c.prenom
FROM fiches f
JOIN clients c ON f.noCli = c.noCli
WHERE c.cpo LIKE '44%';

-- 4️⃣ Détail de la fiche n°1002
SELECT f.noFic, c.nom, c.prenom, l.refart, a.designation, l.depart, l.retour, t.prixJour,
       DATEDIFF(IFNULL(l.retour, NOW()), l.depart) * t.prixJour AS montant
FROM fiches f
JOIN clients c ON f.noCli = c.noCli
JOIN lignesFic l ON f.noFic = l.noFic
JOIN articles a ON l.refart = a.refart
JOIN grilleTarifs g ON a.codeGam = g.codeGam AND a.codeCate = g.codeCate
JOIN tarifs t ON g.codeTarif = t.codeTarif
WHERE f.noFic = 1002;

-- 5️⃣ Prix journalier moyen de location par gamme
SELECT g.libelle AS gamme, AVG(t.prixJour) AS tarif_journalier_moyen
FROM grilleTarifs gt
JOIN gammes g ON gt.codeGam = g.codeGam
JOIN tarifs t ON gt.codeTarif = t.codeTarif
GROUP BY g.libelle;

-- 6️⃣ Détail de la fiche n°1002 avec le total
SELECT f.noFic, c.nom, c.prenom, l.refart, a.designation, l.depart, l.retour, t.prixJour,
       DATEDIFF(IFNULL(l.retour, NOW()), l.depart) * t.prixJour AS Montant,
       SUM(DATEDIFF(IFNULL(l.retour, NOW()), l.depart) * t.prixJour) OVER() AS Total
FROM fiches f
JOIN clients c ON f.noCli = c.noCli
JOIN lignesFic l ON f.noFic = l.noFic
JOIN articles a ON l.refart = a.refart
JOIN grilleTarifs g ON a.codeGam = g.codeGam AND a.codeCate = g.codeCate
JOIN tarifs t ON g.codeTarif = t.codeTarif
WHERE f.noFic = 1002;
