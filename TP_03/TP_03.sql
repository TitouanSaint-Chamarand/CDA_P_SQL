-- 1️⃣ Sélection de la base et gestion des données de la table

USE zoo;

TRUNCATE chat;

INSERT INTO chat (nom, yeux, age)
VALUES
    ('maine coon', 'marron', 20),
    ('siamois', 'bleu', 15),
    ('bengal', 'marron', 18),
    ('scottish Fold', 'marron', 10);

-- 2️⃣ Afficher un chat spécifique selon son identifiant

USE zoo;
SELECT 
    id, nom, yeux, age 
FROM chat 
WHERE id = 2;

-- 3️⃣ Trier les chats par nom et par âge

USE zoo;
SELECT
    id, nom, yeux, age
FROM chat
ORDER BY nom, age;

-- 4️⃣ Afficher les chats vivant entre 11 et 19 ans

USE zoo;
SELECT 
    nom, age 
FROM chat 
WHERE age >= 11
AND age <= 19;

-- 5️⃣ Afficher les chats dont le nom commence par 'sia'

USE zoo; 
SELECT 
    nom, age 
FROM chat  
WHERE nom LIKE 'sia%';

-- 6️⃣ Afficher les chats dont le nom contient la lettre 'a'

USE zoo; 
SELECT 
    nom, age 
FROM chat  
WHERE nom LIKE '%a%';

-- 7️⃣ Calculer et afficher l'âge moyen des chats

USE zoo;
SELECT 
    AVG(age) AS age_moyen
FROM chat; 

-- 8️⃣ Compter le nombre total de chats dans la table

USE zoo;
SELECT 
    COUNT(id) AS nb_chat
FROM chat; 

-- 9️⃣ Compter les chats avec des yeux marron

USE zoo;
SELECT
    yeux AS couleur,
    COUNT(id) AS nb_chat
FROM chat
WHERE yeux = 'marron'
GROUP BY yeux;

-- 🔟 Compter les chats par couleur d'yeux

USE zoo;
SELECT
    yeux AS couleur,
    COUNT(id) AS nb_chat
FROM chat
GROUP BY yeux;
