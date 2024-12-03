-- 1️⃣ Création de la base de données `spa`
DROP DATABASE IF EXISTS spa; 
CREATE DATABASE spa;
USE spa;

-- 2️⃣ Création de la table `chat`
DROP TABLE IF EXISTS chat; 
CREATE TABLE chat (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    nom VARCHAR(30) NOT NULL,          
    age INT NOT NULL,                  
    couleur_id INT,                    
    region_id INT,                     
    CONSTRAINT fk_couleur FOREIGN KEY (couleur_id) REFERENCES couleur(id) 
) ENGINE=InnoDB;

-- 3️⃣ Création de la table `couleur`
DROP TABLE IF EXISTS couleur; 
CREATE TABLE couleur (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    nom VARCHAR(30) NOT NULL           
) ENGINE=InnoDB;

-- 4️⃣ Insertion des données
-- Insertion dans la table `couleur`
INSERT INTO couleur (id, nom)
VALUES 
    (1, 'marron'),
    (2, 'bleu'),
    (3, 'vert');

-- Insertion dans la table `chat`
INSERT INTO chat (id, nom, age, couleur_id, region_id)
VALUES
    (1, 'maine coon', 20, 1, 1),
    (2, 'siamois', 15, 2, 2),
    (3, 'bengal', 18, 1, 1),
    (4, 'scottish fold', 10, 1, 1),
    (5, 'domestique', 21, NULL, NULL);
