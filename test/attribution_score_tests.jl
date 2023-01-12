include("../src/attribution_score.jl")
@testset "Score age" begin
    @test score_age(50) == 1.0
    @test score_age(25) == 2.0
    @test score_age(75) == 0.67
    @test score_age(0.2) == 50.0
    @test score_age(10) == 5.0
    @test score_age(65) == 0.77
end

@testset "Score age gap" begin
    @test score_age_gap(50, 52) == 4
    @test score_age_gap(25, 37) == 2
    @test score_age_gap(15, 55) == 0
    @test_throws DomainError score_age_gap(-5, 10)
    @test_throws DomainError score_age_gap(10, -5)
end

@testset "Score cPRA" begin
    @test score_cPRA(0) == 0
    @test score_cPRA(19) == 0
    @test score_cPRA(20) == 3
    @test score_cPRA(79) == 3
    @test score_cPRA(80) == 8
    @test score_cPRA(100) == 8
    @test_throws DomainError score_cPRA(101)
    @test_throws DomainError score_cPRA(-1)
end

@testset "Score mismach DR" begin
    @test score_mis_dr(0, true, false) == 4
    @test score_mis_dr(0, false, false) == 4
    @test score_mis_dr(1, true, false) == 1
    @test score_mis_dr(1, false, false) == 4
    @test score_mis_dr(2, true, false) == 0
    @test score_mis_dr(2, false, false) == 0
    @test score_mis_dr(0, false, true) == 8

    @test_throws DomainError score_mis_dr(-1, true, false)
    @test_throws DomainError score_mis_dr(3, true, false)
    @test_throws MethodError score_mis_dr(0, 1, false)
    @test_throws MethodError score_mis_dr(0, "hi", false)
    @test_throws MethodError score_mis_dr(0, "hi", false)
    @test_throws MethodError score_mis_dr(0, true, 2)
end

@testset "Score wait time" begin
    @test score_wait_time(0) == 0
    @test score_wait_time(1) == 0.5
    @test score_wait_time(2) == 1
    @test score_wait_time(3) == 2
    @test score_wait_time(4) == 4
    @test score_wait_time(5) == 6
    @test score_wait_time(6) == 8
    @test score_wait_time(7) == 10
    @test score_wait_time(8) == 12
    @test score_wait_time(9) == 14
    @test score_wait_time(10) == 18
    @test score_wait_time(11) == 18

    @test_throws DomainError score_wait_time(-1)
    @test_throws MethodError score_wait_time(1.2)
end