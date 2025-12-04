using Test
using Cerinejulia

@testset "Cerinejulia basique" begin
    for ds in AVAILABLE_DATASETS
        df, target = load_dataset(ds)
        @test !isempty(df)

        for m in AVAILABLE_MODELS
            ŷ, y = apply_model(m, df, target)
            @test length(ŷ) == length(y)
            @test isfinite(rmse(ŷ, y))
        end
    end
end
