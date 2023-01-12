# Evaluate score given for candidate's wait time
function score_wait_time(wait_time::Int)
    scores = [0, 0.5, 1, 2, 4, 6, 8, 10, 12, 14, 18]
    if wait_time < 0
        throw(DomainError(wait_time))
    end
    if wait_time > length(scores) -1
        wait_time = length(scores) -1
    end
    return scores[wait_time+1]
end

# Evaluate score given for donor and candidate mismatch
function score_mis_dr(mis_dr::Int, hetero::Bool, identical_ABDR::Bool)
    # Special case when the donor and the candidate's A, B and DR aleles are identical
    if identical_ABDR
        return 8    
    end
    if mis_dr in [0,1,2] && hetero in [true, false]
        scores = [[4, 1, 0], [4, 4, 0]]
        score_idx = mis_dr+1
        type_idx = hetero ? 1 : 2
        return scores[type_idx][score_idx]
    else
        throw(DomainError([mis_dr, hetero]))
    end
end

# Evaluate score given for candidate's cPRA
function score_cPRA(cPRA::Number)
    if 0 <= cPRA < 20
        return 0
    elseif 20 <= cPRA < 80
        return 3
    elseif 80 <= cPRA <= 100
        return 8
    else
        throw(DomainError(cPRA))
    end
end

# Evaluate score given for the age difference between candidate and donor
function score_age_gap(don_age::Number, can_age::Number)
    if don_age < 0 || can_age < 0
        throw(DomainError([don_age, can_age]))
    end
    gap = floor(abs(don_age - can_age))
    if gap <= 10
        return 4
    elseif 10 < gap <= 20
        return 2
    else #if gap > 20
        return 0
    end
end

# Evaluate score given for the candidate's age
function score_age(can_age::Number)
    if can_age < 1
        can_age = 1
    end
    return round(50.0 / can_age, digits=2)
end

# Evaluate total attribution score of donor and candidate for given information
function score(don_age::Number, can_age::Number, cPRA::Number, wait_time::Int, mis_dr::Int, hetero::Bool, identical_ABDR::Bool)
    # pointage attribué en fonction du temps d'attente du candidat
    score = 0.0
    # print(wait_time, "\n")
    score += score_wait_time(wait_time)
    # print(score,"\n")
    
    score += score_mis_dr(mis_dr, hetero, identical_ABDR)
    # print(score,"\n")
    
    score += score_cPRA(cPRA)
    # print(score,"\n")
    
    score += score_age_gap(don_age, can_age)
    # print(score,"\n")
    
    score += score_age(can_age)
    # print(score,"\n")

    return round(score, digits=2)
end