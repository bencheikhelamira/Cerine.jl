CERINEJULIA
===========

BENCHEIKH  El Amira Cerine
Master 2 – Statistics & Data Science

DESCRIPTION
-----------

Cerinejulia est un mini package Julia à vocation pédagogique.  
Il permet d'illustrer les bases de la modélisation statistique à travers :
- des datasets simulés,
- des modèles simples,
- une interface interactive minimale construite avec Bonito.

L'objectif principal du projet est de montrer :
- comment structurer un package Julia,
- comment appliquer différents modèles à des jeux de données,
- comment comparer leurs performances à l'aide d'une métrique,
- et comment proposer une interaction utilisateur simple.


STRUCTURE DU PROJET
-------------------
Cerinejulia/
│
├── src/
│   └── Cerinejulia.jl        : module principal et application Bonito
│
├── data/
│   └── datasets.jl          : génération des datasets simulés
│
├── model/
│   └── models.jl            : définition des modèles et de la métrique
│
├── test/
│   └── runtests.jl          : tests unitaires
│
├── Project.toml             : dépendances du projet
└── README.txt               : documentation


DATASETS
--------
Les datasets sont générés dynamiquement en mémoire (ils ne sont pas chargés depuis des fichiers).

1) Dataset linéaire
   - Relation : y = 3x + bruit
   - Bruit gaussien
   - Cas où la régression linéaire est bien adaptée

2) Dataset non linéaire
   - Relation : y = x² + bruit
   - Bruit gaussien
   - Sert à illustrer les limites d'un modèle linéaire

Chaque dataset contient :
- 200 observations
- 2 colonnes :
  - x : variable explicative
  - y : variable cible


MODELES
-------
Deux modèles sont implémentés :

1) Modèle constant (baseline)
   - Prédit la moyenne de la variable cible
   - Sert de référence simple

2) Régression linéaire
   - Ajustement par moindres carrés
   - Appliquée aux deux datasets afin de comparer les performances


METRIQUE
--------
La performance des modèles est évaluée à l'aide du RMSE (Root Mean Squared Error) :

RMSE = sqrt( (1/n) * somme( (y - y_hat)^2 ) )


INTERFACE INTERACTIVE
---------------------
Une interface minimale est proposée via Bonito.
Elle permet :
- de choisir le dataset,
- de choisir le modèle,
- de lancer l'évaluation,
- d'afficher la valeur du RMSE.

L'interface est volontairement simple et fonctionnelle.


LANCER LE PROJET
----------------
1) Se placer dans le dossier du projet :
   cd Cerinejulia

2) Lancer Julia :
   julia

3) Activer l'environnement du projet :
   ]
   activate .

4) Revenir en mode Julia (Backspace), puis :
   using Cerinejulia
   run_app()

Une interface Bonito s'ouvre automatiquement dans le navigateur.


TESTS
-----
Des tests unitaires sont fournis pour vérifier :
- la génération des datasets,
- l'application des modèles,
- le calcul de la métrique RMSE.

Pour lancer les tests :
]
test


OBJECTIFS PEDAGOGIQUES
----------------------
Ce projet permet de mettre en pratique :
- la structuration d'un package Julia,
- la séparation des responsabilités (données / modèles / interface),
- l'utilisation d'un environnement de projet,
- la comparaison de modèles simples,
- l'intégration d'une interface interactive légère.


