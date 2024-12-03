-- 1️⃣ Création de la base de données `netflix`
DROP DATABASE IF EXISTS netflix; 
CREATE DATABASE netflix;
USE netflix;

-- 2️⃣ Création de la table `film`
DROP TABLE IF EXISTS film; 
CREATE TABLE film (
    id INT AUTO_INCREMENT PRIMARY KEY,     
    titre VARCHAR(255) NOT NULL,           
    sortie DATE NOT NULL,                  
    categ_id INT,                          
    CONSTRAINT fk_categ FOREIGN KEY (categ_id) REFERENCES categ(id) 
) ENGINE=InnoDB;

-- 3️⃣ Création de la table `categ`
DROP TABLE IF EXISTS categ; 
CREATE TABLE categ (
    id INT AUTO_INCREMENT PRIMARY KEY,     
    nom VARCHAR(30) NOT NULL               
) ENGINE=InnoDB;

-- 4️⃣ Insertion des données
-- Insertion dans la table `categ`
INSERT INTO categ (id, nom)
VALUES 
    (1, 'Sciences Fiction'),
    (2, 'Thriller');

-- Insertion dans la table `film`
INSERT INTO film (id, titre, sortie, categ_id)
VALUES
    (1, 'STAR WARS', '1977-05-25', 1),
    (2, 'THE MATRIX', '1999-06-23', 1),
    (3, 'PULP FICTION', '1994-10-26', 2);
