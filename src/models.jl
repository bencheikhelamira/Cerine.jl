# Liste des modèles disponibles
const AVAILABLE_MODELS = [
    "Constante (moyenne)",
    "Régression linéaire"
]

"""
    rmse(ŷ, y)

Calcule le Root Mean Squared Error.
"""
rmse(ŷ, y) = sqrt(mean((ŷ .- y).^2))

"""
    apply_model(model_name, df, target_sym) -> (ŷ, y)

Applique un modèle au dataset fourni.

- `model_name` : nom du modèle (voir AVAILABLE_MODELS)
- `df` : DataFrame
- `target_sym` : symbole de la colonne cible
"""
function apply_model(model_name::AbstractString, df::DataFrame, target_sym::Symbol)
    y = df[!, target_sym]

    if model_name == "Constante (moyenne)"
        # modèle naïf : prédit la moyenne de y
        ŷ = fill(mean(y), length(y))
        return ŷ, y

    elseif model_name == "Régression linéaire"
        # On prend une seule variable explicative x pour rester simple
        if :x ∉ names(df)
            error("Pas de colonne :x trouvée dans le DataFrame pour la régression linéaire.")
        end

        x = df[!, :x]
        n = length(x)

        # matrice avec intercept
        X = [ones(n) x]       # colonne de 1 (intercept) + x
        β = X \ y             # moindres carrés
        ŷ = X * β             # prédictions

        return ŷ, y

    else
        error("Modèle inconnu : $model_name")
    end
end
