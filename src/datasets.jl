# Liste des datasets disponibles
const AVAILABLE_DATASETS = [
    "Dataset 1 (linéaire)",
    "Dataset 2 (non linéaire)"
]

"""
    load_dataset(name) -> (df, target_symbol)

Retourne un DataFrame `df` et le nom de la colonne cible `target_symbol`.

Ici on génère 2 jeux de données simulés simples.
"""
function load_dataset(name::AbstractString)
    if name == "Dataset 1 (linéaire)"
        # y = 3x + bruit
        n  = 200
        x  = randn(n)
        y  = 3 .* x .+ 0.5 .* randn(n)
        df = DataFrame(x = x, y = y)
        return df, :y

    elseif name == "Dataset 2 (non linéaire)"
        # y = x^2 + bruit (plus dur pour un modèle linéaire)
        n  = 200
        x  = randn(n)
        y  = x .^ 2 .+ 0.5 .* randn(n)
        df = DataFrame(x = x, y = y)
        return df, :y

    else
        error("Dataset inconnu : $name")
    end
end
