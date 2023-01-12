using TQAttributionScore
using Test

@testset "TQAttributionScore.jl" begin
    @test func(2,3) == 13
    @test func(3,2) == 12
end
