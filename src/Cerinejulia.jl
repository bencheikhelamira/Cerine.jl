module Cerinejulia

# ==========================================
# Imports / dépendances (ce que j'utilise)
# ==========================================
using DataFrames
using Statistics
using Bonito
using Bonito.DOM
using Observables

# ==========================================
# J'inclus mes fichiers de code "hors src/"
# - data/datasets.jl : génération des datasets + load_dataset(...)
# - model/models.jl  : modèles + apply_model(...) + rmse(...)
# ==========================================
include(joinpath(@__DIR__, "..", "data", "datasets.jl"))
include(joinpath(@__DIR__, "..", "model", "models.jl"))

# Je n'expose que la fonction principale de l'app
export run_app


function run_app()

    # ==========================================
    # 1) Variables réactives (Observables)
    # - dataset_choice : mémorise le dataset sélectionné
    # - model_choice   : mémorise le modèle sélectionné
    # - result_text    : texte affiché dans la zone résultat (RMSE ou message)
    # ==========================================
    dataset_choice = Observable(AVAILABLE_DATASETS[1])
    model_choice   = Observable(AVAILABLE_MODELS[1])
    result_text    = Observable("Clique sur « Lancer » pour calculer le RMSE.")

    # ==========================================
    # 2) Boutons pour choisir le dataset
    # ==========================================
    btn_ds1 = Button("Dataset linéaire")
    btn_ds2 = Button("Dataset non linéaire")

    # au clic, je mets à jour la sélection
    on(btn_ds1) do _
        dataset_choice[] = AVAILABLE_DATASETS[1]
    end

    on(btn_ds2) do _
        dataset_choice[] = AVAILABLE_DATASETS[2]
    end

    # ==========================================
    # 3) Boutons pour choisir le modèle
    # ==========================================
    btn_m1 = Button("Modèle constant")
    btn_m2 = Button("Régression linéaire")

    on(btn_m1) do _
        model_choice[] = AVAILABLE_MODELS[1]
    end

    on(btn_m2) do _
        model_choice[] = AVAILABLE_MODELS[2]
    end

    # ==========================================
    # 4) Bouton "Lancer" : calcul RMSE + gestion d'erreurs propre
    # ==========================================
    btn_run = Button("Lancer")

    on(btn_run) do _
        try
            # je génère / charge le dataset choisi
            df, target = load_dataset(dataset_choice[])

            # j'applique le modèle choisi
            ŷ, y = apply_model(model_choice[], df, target)

            # je calcule la métrique RMSE
            r = rmse(ŷ, y)

            # je récupère les choix pour afficher un résultat contextualisé
            ds = dataset_choice[]
            md = model_choice[]

            # message propre : on voit direct la config + la valeur
            result_text[] =
                "RMSE (dataset : « $(ds) », modèle : « $(md) ») = $(round(r, digits=4))"

        catch e
            # ------------------------------------------
            # Ici je gère les cas "compatibilité dataset/modèle"
            # (ça ne veut pas dire que l'application est fausse,
            # ça veut juste dire que certains modèles supposent
            # une structure de données précise)
            # ------------------------------------------
            msg = string(e)
            ds  = dataset_choice[]
            md  = model_choice[]

            # cas 1 : régression linéaire mais pas de colonne :x
            if occursin("Pas de colonne :x", msg)
                result_text[] =
                    "Configuration non compatible : la régression linéaire attend une colonne « x » " *
                    "dans le dataset. Vérifie la structure du dataset sélectionné (dataset : « $(ds) »)."

            # cas 2 : autre erreur (générique, mais propre)
            else
                result_text[] =
                    "Le calcul n’a pas pu être effectué avec la configuration actuelle " *
                    "(dataset : « $(ds) », modèle : « $(md) »). " *
                    "Essaie une autre combinaison ou vérifie le dataset."
            end
        end
    end

    # ==========================================
    # 5) Interface Bonito (mise en page)
    # - j'utilise DOM.* pour éviter les conflits (ex: div vs Base.div)
    # - j'affiche les Observables via DOM.span(...)
    # ==========================================
    app = App() do
        DOM.div(style="font-family:Arial; padding:16px; max-width:900px; margin:auto;")(
            # titre
            DOM.h2("Cerinejulia — Mini application"),

            # résumé de la sélection courante (mis à jour automatiquement)
            DOM.div(style="margin-bottom:12px; font-size:14px;")(
                "Sélection actuelle : ",
                DOM.b()(dataset_choice),
                " + ",
                DOM.b()(model_choice)
            ),

            # bloc dataset
            DOM.div(style="border:1px solid #ddd; border-radius:8px; padding:12px; margin-bottom:12px;")(
                DOM.h3("1) Choisir un dataset"),
                DOM.div(style="display:flex; gap:10px; flex-wrap:wrap;")(btn_ds1, btn_ds2)
            ),

            # bloc modèle
            DOM.div(style="border:1px solid #ddd; border-radius:8px; padding:12px; margin-bottom:12px;")(
                DOM.h3("2) Choisir un modèle"),
                DOM.div(style="display:flex; gap:10px; flex-wrap:wrap;")(btn_m1, btn_m2)
            ),

            # bouton run centré
            DOM.div(style="display:flex; justify-content:center; margin:12px 0;")(
                btn_run
            ),

            # bloc résultat
            DOM.div(style="border:1px solid #ddd; border-radius:8px; padding:12px; background:#fafafa;")(
                DOM.h3("Résultat"),
                DOM.div(style="font-size:16px; font-weight:bold;")(
                    DOM.span(result_text)
                )
            )
        )
    end

    # j'affiche l'app (Bonito ouvre le navigateur)
    display(app)
end

end
