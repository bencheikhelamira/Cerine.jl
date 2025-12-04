module Cerinejulia

using DataFrames
using Statistics
using Bonito
using Bonito.DOM
using Observables

# on inclut les fichiers auxiliaires
include("datasets.jl")
include("models.jl")
# ici export c'est pour rendre les fonctions accessible depuis l'éxterieur du module
export AVAILABLE_DATASETS, AVAILABLE_MODELS,
       load_dataset, apply_model, rmse,
       run_app

"""
    run_app() 

Lance l'application interactive Bonito :
- choix du dataset
- choix du modèle
- affichage du RMSE
"""
function run_app()
    # observables (valeurs réactives)
    dataset_choice   = Observable(AVAILABLE_DATASETS[1])
    model_choice     = Observable(AVAILABLE_MODELS[1])
    status_text      = Observable("Prête. Choisis un dataset, un modèle, puis clique sur \"Lancer\".")
    metric_text      = Observable("")
    details_text     = Observable("")

    # boutons pour choisir le dataset
    btn_ds1 = Button("Dataset 1 : linéaire")
    btn_ds2 = Button("Dataset 2 : non linéaire")

    on(btn_ds1.clicks) do _
        dataset_choice[] = AVAILABLE_DATASETS[1]
    end

    on(btn_ds2.clicks) do _
        dataset_choice[] = AVAILABLE_DATASETS[2]
    end

    # boutons pour choisir le modèle
    btn_m1 = Button("Modèle 1 : constante (baseline)")
    btn_m2 = Button("Modèle 2 : régression linéaire")

    on(btn_m1.clicks) do _
        model_choice[] = AVAILABLE_MODELS[1]
    end

    on(btn_m2.clicks) do _
        model_choice[] = AVAILABLE_MODELS[2]
    end

    # bouton pour lancer l'entraînement
    run_button = Button("Lancer l'entraînement & l'évaluation")

    on(run_button.clicks) do _
        try
            status_text[]  = "En cours de calcul..."
            metric_text[]  = ""
            details_text[] = ""

            df, target = load_dataset(dataset_choice[])
            ŷ, y      = apply_model(model_choice[], df, target)
            r          = rmse(ŷ, y)

            status_text[] = "Succès ✅"
            metric_text[] = "RMSE = $(round(r, digits = 4))"
            details_text[] = "Dataset: $(dataset_choice[]) | Modèle: $(model_choice[]) | n = $(length(y))"
        catch e
            status_text[] = "Erreur ❌ : $(e)"
            metric_text[] = ""
            details_text[] = ""
        end
    end

    # définition de l'interface Bonito
    app = App() do
        vbox(
            h1("Cerinejulia - Mini app de modèles"),
            h3("Choix du dataset"),
            p("Dataset sélectionné : ", dataset_choice),
            div(style = "display:flex; gap:10px; margin-bottom:10px;")(btn_ds1, btn_ds2),

            h3("Choix du modèle"),
            p("Modèle sélectionné : ", model_choice),
            div(style = "display:flex; gap:10px; margin-bottom:20px;")(btn_m1, btn_m2),

            run_button,

            hr(),

            h2("Résultats"),
            p("Statut : ", status_text),
            h3(metric_text),
            p(details_text)
        )
    end

    display(app)
    return app
end

end 
