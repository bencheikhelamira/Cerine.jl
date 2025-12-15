RAPPORT DE PROJET — CERINEJULIA
==============================

Nom et prénom :
---------------
BENCHEIKH El Amira Cerine


Introduction
------------
Ce projet, intitulé « Cerinejulia », est un mini-projet pédagogique développé en Julia.
L’objectif principal est de comprendre et de mettre en pratique :

- la structuration d’un package Julia,
- la génération et la manipulation de jeux de données,
- l’application de modèles statistiques simples,
- l’évaluation des performances via une métrique (RMSE),
- et la création d’une application interactive minimale à l’aide du package Bonito.

Ce projet n’a pas pour but de construire un modèle complexe, mais plutôt de bien comprendre
la relation entre les données, les modèles et leurs hypothèses, tout en respectant de bonnes
pratiques de développement en Julia.


Packages utilisés
-----------------
Les principaux packages utilisés dans ce projet sont :

- DataFrames : pour stocker et manipuler les jeux de données sous forme de tableaux.
- Statistics : pour les calculs statistiques de base (moyenne, etc.).
- Observables : pour gérer les valeurs réactives dans l’application.
- Bonito et Bonito.DOM : pour créer une interface utilisateur interactive dans le navigateur.

Ces packages sont déclarés dans le fichier Project.toml afin d’assurer la reproductibilité
de l’environnement.


Structure du projet
-------------------
Le projet est organisé de la manière suivante :

- Cerinejulia/
- src/
  - Cerinejulia.jl
    - Fichier principal du projet.
    - Contient le module Cerinejulia ainsi que l’application interactive développée avec Bonito.
    - Gère la logique globale : sélection du dataset, sélection du modèle, calcul du RMSE et affichage des résultats.

- data/
  - datasets.jl
    - Génération des jeux de données simulés.
    - Contient les datasets linéaire et non linéaire.
    - Chaque dataset est généré dynamiquement et retourne un DataFrame avec les colonnes nécessaires.

- model/
  - models.jl
    - Définition des modèles utilisés dans l’application.
    - Modèle constant (baseline).
    - Modèle de régression linéaire.
    - Implémentation de la métrique RMSE (Root Mean Squared Error).

- test/
  - runtests.jl
    - Tests unitaires du package.
    - Vérifie la génération correcte des datasets.
    - Vérifie l’application des modèles et le calcul du RMSE.

- Project.toml
  - Fichier de configuration du projet Julia.
  - Liste les dépendances nécessaires au bon fonctionnement du package (Bonito, DataFrames, Observables, etc.).

- README.txt
  - Document de présentation du projet.
  - Explique les objectifs, la structure, le fonctionnement de l’application et les étapes pour l’exécuter.

Description des datasets
------------------------
Deux jeux de données sont générés dynamiquement (ils ne sont pas chargés depuis des fichiers).

1) Dataset linéaire
   - Relation sous-jacente : y = 3x + bruit
   - Le bruit est gaussien
   - Ce dataset est compatible avec une régression linéaire

2) Dataset non linéaire
   - Relation sous-jacente : y = x² + bruit
   - Le bruit est gaussien
   - Ce dataset ne respecte pas l’hypothèse de linéarité

Chaque dataset contient :
- 200 observations
- 2 colonnes :
  - x : variable explicative
  - y : variable cible


Description des modèles
-----------------------
Deux modèles simples sont implémentés :

1) Modèle constant (baseline)
   - Prédit la moyenne de la variable cible y
   - Sert de référence minimale

2) Régression linéaire
   - Ajustement par moindres carrés
   - Suppose une relation linéaire entre x et y
   - Nécessite la présence d’une colonne explicative x


Métrique utilisée
-----------------
La performance des modèles est évaluée à l’aide du RMSE (Root Mean Squared Error) :

RMSE = sqrt( (1/n) * somme( (y - ŷ)² ) )

Cette métrique permet de mesurer l’erreur moyenne entre les valeurs réelles et les prédictions.


Fonctionnement de l’application
--------------------------------
L’application interactive permet :

- de sélectionner un dataset (linéaire ou non linéaire),
- de sélectionner un modèle (constant ou régression linéaire),
- de lancer le calcul,
- d’afficher le RMSE avec le contexte (dataset + modèle).

Exemple de résultat :
- Dataset linéaire + modèle constant → RMSE ≈ 3.751
- Dataset linéaire + régression linéaire → RMSE plus faible
- Dataset non linéaire + régression linéaire → message de non-compatibilité


Gestion des cas d’erreur
------------------------
Lorsque la configuration choisie n’est pas compatible avec les hypothèses du modèle
(par exemple : dataset non linéaire avec régression linéaire), l’application n’affiche
pas une erreur brute.

À la place, un message explicite est affiché, indiquant que la configuration
dataset / modèle n’est pas compatible.

Cela montre que l’application est robuste et que le problème ne vient pas d’un bug,
mais des hypothèses statistiques du modèle choisi.


Étapes pour lancer le projet
-----------------------------
1) Se placer dans le dossier du projet :
   cd Cerinejulia

2) Lancer Julia :
   julia

3) Passer en mode package :
   ]

4) Activer l’environnement du projet :
   activate .

5) Précompiler (optionnel mais recommandé) :
   precompile

6) Revenir au mode Julia (touche Backspace)

7) Charger le package :
   using Cerinejulia

8) Lancer l’application :
   run_app()


Mise à jour du code
-------------------
À chaque modification du code :
- je quitte Julia avec exit()
- je relance Julia
- j’active à nouveau l’environnement
- je recharge le package avec using Cerinejulia

Cela garantit que la version exécutée est bien la version mise à jour du code.


Conclusion
----------
Ce projet m’a permis de mieux comprendre :

- la logique des packages Julia,
- la gestion des environnements avec Project.toml,
- la relation entre hypothèses statistiques et données,
- et la création d’une application interactive simple mais robuste.

J’ai particulièrement apprécié le côté expérimental de Julia et la possibilité
de combiner calcul statistique et interface utilisateur de manière fluide.


Remerciements
-------------
Je tiens à remercier sincèrement Rémi, notre enseignant, pour cette belle expérience
autour du langage Julia. Ce projet m’a permis de découvrir Julia de manière concrète
et ludique, et j’ai réellement pris plaisir à expérimenter et à construire cette application.
