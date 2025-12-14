module Cerinejulia

using DataFrames
using Statistics
using Bonito
using Bonito.DOM
using Observables

include(joinpath(@__DIR__, "..", "data", "datasets.jl"))
include(joinpath(@__DIR__, "..", "model", "models.jl"))

export run_app

function run_app()
    dataset_choice = Observable(AVAILABLE_DATASETS[1])
    model_choice   = Observable(AVAILABLE_MODELS[1])
    result_text    = Observable("Clique sur Lancer")

    btn_ds1 = Button("Dataset linéaire")
    btn_ds2 = Button("Dataset non linéaire")

    on(btn_ds1) do _
        dataset_choice[] = AVAILABLE_DATASETS[1]
    end
    on(btn_ds2) do _
        dataset_choice[] = AVAILABLE_DATASETS[2]
    end

    btn_m1 = Button("Modèle constant")
    btn_m2 = Button("Régression linéaire")

    on(btn_m1) do _
        model_choice[] = AVAILABLE_MODELS[1]
    end
    on(btn_m2) do _
        model_choice[] = AVAILABLE_MODELS[2]
    end

    btn_run = Button("Lancer")

    on(btn_run) do _
        df, target = load_dataset(dataset_choice[])
        ŷ, y = apply_model(model_choice[], df, target)
        r = rmse(ŷ, y)
        result_text[] = "RMSE = $(round(r, digits=4))"
    end

    app = App() do
        DOM.div()(
            btn_ds1,
            btn_ds2,
            btn_m1,
            btn_m2,
            btn_run,
            DOM.div()(result_text)
        )
    end

    display(app)
end

end
