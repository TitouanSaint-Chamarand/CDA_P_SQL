-- 1️⃣ Création de la base de données `cinema`
DROP DATABASE IF EXISTS cinema;
CREATE DATABASE cinema;
USE cinema;

-- 2️⃣ Création de la table `film`
DROP TABLE IF EXISTS film;
CREATE TABLE film (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- 3️⃣ Création de la table `acteur`
DROP TABLE IF EXISTS acteur;
CREATE TABLE acteur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    prenom VARCHAR(100) NOT NULL,
    nom VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- 4️⃣ Création de la table `film_has_acteur`
DROP TABLE IF EXISTS film_has_acteur;
CREATE TABLE film_has_acteur (
    film_id INT NOT NULL,
    acteur_id INT NOT NULL,
    PRIMARY KEY (film_id, acteur_id),
    CONSTRAINT fk_film FOREIGN KEY (film_id) REFERENCES film(id),
    CONSTRAINT fk_acteur FOREIGN KEY (acteur_id) REFERENCES acteur(id)
) ENGINE=InnoDB;

-- 5️⃣ Insertion des données dans la table `film`
INSERT INTO film (id, nom)
VALUES
    (1, 'Fight Club'),
    (2, 'One Upon the time');

-- 6️⃣ Insertion des données dans la table `acteur`
INSERT INTO acteur (id, prenom, nom)
VALUES
    (1, 'Brad', 'PITT'),
    (2, 'Léonardo', 'DICAPRIO');

-- 7️⃣ Insertion des données dans la table `film_has_acteur`
INSERT INTO film_has_acteur (film_id, acteur_id)
VALUES
    (1, 1), -- Fight Club avec Brad PITT
    (2, 1), -- Once Upon the time avec Brad PITT
    (2, 2); -- Once Upon the time avec Léonardo DICAPRIO

-- 8️⃣ Afficher tous les films de Léonardo DI CAPRIO
SELECT f.nom AS film, a.prenom AS acteur_prenom, a.nom AS acteur_nom
FROM film f
JOIN film_has_acteur fha ON f.id = fha.film_id
JOIN acteur a ON fha.acteur_id = a.id
WHERE a.nom = 'DICAPRIO' AND a.prenom = 'Léonardo';

-- 9️⃣ Afficher le nombre de films par acteur
SELECT a.prenom AS acteur_prenom, a.nom AS acteur_nom, COUNT(fha.film_id) AS nb_films
FROM acteur a
LEFT JOIN film_has_acteur fha ON a.id = fha.acteur_id
GROUP BY a.id;

-- 🔟 Ajouter un film : TITANIC
INSERT INTO film (nom)
VALUES ('TITANIC');

-- 1️⃣1️⃣ Trouver le film qui n'a pas d'acteur
SELECT f.nom AS film
FROM film f
LEFT JOIN film_has_acteur fha ON f.id = fha.film_id
WHERE fha.film_id IS NULL;
