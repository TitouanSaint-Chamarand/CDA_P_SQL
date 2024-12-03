-- 1️⃣ Création de la base de données
DROP DATABASE IF EXISTS crm;
CREATE DATABASE crm;
USE crm;

-- 2️⃣ Création des tables
CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE projets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    nom VARCHAR(100) NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(id)
) ENGINE=InnoDB;

CREATE TABLE devis (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ref VARCHAR(20) NOT NULL UNIQUE,
    projet_id INT NOT NULL,
    montant DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (projet_id) REFERENCES projets(id)
) ENGINE=InnoDB;

CREATE TABLE factures (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ref VARCHAR(20) NOT NULL UNIQUE,
    devis_ref VARCHAR(20) NOT NULL,
    info VARCHAR(255),
    total DECIMAL(10, 2) NOT NULL,
    client_id INT NOT NULL,
    date_facture DATE NOT NULL,
    date_paiement DATE,
    FOREIGN KEY (devis_ref) REFERENCES devis(ref),
    FOREIGN KEY (client_id) REFERENCES clients(id)
) ENGINE=InnoDB;

-- 3️⃣ Insertion des données
INSERT INTO clients (nom) VALUES
('Mairie de Rennes'),
('Neo Soft'),
('Sopra'),
('Accenture'),
('Amazon');

INSERT INTO projets (client_id, nom) VALUES
(1, 'Creation de site internet'),
(2, 'Logiciel CRM'),
(3, 'Logiciel de devis'),
(4, 'Site internet ecommerce'),
(2, 'Logiciel ERP'),
(5, 'Logiciel Gestion de Stock');

INSERT INTO devis (ref, projet_id, montant) VALUES
('DEV2100A', 1, 3000),
('DEV2100B', 1, 5000),
('DEV2100C', 2, 5000),
('DEV2100D', 3, 3000),
('DEV2100E', 4, 5000),
('DEV2100F', 5, 2000),
('DEV2100G', 6, 1000);

INSERT INTO factures (ref, devis_ref, info, total, client_id, date_facture, date_paiement) VALUES
('FA001', 'DEV2100A', 'Site internet partie 1', 1500, 1, '2023-09-01', '2023-10-01'),
('FA002', 'DEV2100A', 'Site internet partie 2', 1500, 1, '2023-09-20', NULL),
('FA003', 'DEV2100C', 'Logiciel CRM', 5000, 2, '2024-02-01', NULL),
('FA004', 'DEV2100D', 'Logiciel devis', 3000, 3, '2024-03-03', '2024-04-03'),
('FA005', 'DEV2100E', 'Site internet ecommerce', 5000, 4, '2023-03-01', NULL),
('FA006', 'DEV2100F', 'Logiciel ERP', 2000, 2, '2023-03-01', NULL);

-- 4️⃣ Requêtes demandées

-- 1️⃣ Afficher toutes les factures avec le nom des clients
SELECT f.ref, c.nom AS client, f.info, f.total, f.date_facture, f.date_paiement
FROM factures f
JOIN clients c ON f.client_id = c.id;

-- 2️⃣ Afficher le nombre de factures par client
SELECT c.nom AS client, COUNT(f.id) AS nb_factures
FROM clients c
LEFT JOIN factures f ON c.id = f.client_id
GROUP BY c.nom;

-- 3️⃣ Afficher le chiffre d'affaire par client
SELECT c.nom AS client, SUM(f.total) AS chiffre_affaire
FROM clients c
LEFT JOIN factures f ON c.id = f.client_id
GROUP BY c.nom;

-- 4️⃣ Afficher le CA total
SELECT SUM(total) AS ca_total
FROM factures;

-- 5️⃣ Afficher la somme des factures en attente de paiement
SELECT SUM(total) AS total_factures
FROM factures
WHERE date_paiement IS NULL;

-- 6️⃣ Afficher les factures en retard de paiement (30 jours max)
SELECT f.ref AS facture, DATEDIFF(NOW(), f.date_facture) - 30 AS nb_jour
FROM factures f
WHERE f.date_paiement IS NULL
  AND DATEDIFF(NOW(), f.date_facture) > 30;

-- 7️⃣ Ajouter une pénalité de 2 euros par jours de retard
SELECT f.ref AS facture, 
       DATEDIFF(NOW(), f.date_facture) - 30 AS nb_jour,
       (DATEDIFF(NOW(), f.date_facture) - 30) * 2 AS penalite
FROM factures f
WHERE f.date_paiement IS NULL
  AND DATEDIFF(NOW(), f.date_facture) > 30;
