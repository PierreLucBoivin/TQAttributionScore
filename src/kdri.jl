### Function to evaluate the KDRI of given donor
# age in years
# height in centimeters
# weight in kilograms
# race = 6 if African American, any other integer otherwise
# htn = 1 if has history of hypertension, 0 otherwise
# diab = 1 if has history of diabetes, 0 otherwise
# cod in [16,4] if cause of death cardiovascular arrest, any other integer otherwise
# creatine level in μmol / L
# anti_hcv == 1 if history of hepatitis C virus infection, 0 otherwise
# status == 1 if follow dcd criteria
function kdri(age, height_cm, weight_kg, race, htn, diab, cod, creat, anti_hcv, status)
    _age = (0.0128*(age - 40) 
        - ifelse(age < 18, 0.0194 * (age - 18), 0) 
        + ifelse(age > 50, 0.0107 * (age - 50), 0))
    _hgt = -0.0464 * (height_cm - 170) / 10
    _wgt = ifelse(weight_kg < 80, - 0.0199 * (weight_kg - 80) / 5, 0)
    _race = ifelse(race == 6, 0.179, 0)
    _htn = ifelse(htn == 1, 0.126, 0)
    _diab = ifelse(diab == 1, 0.13, 0)
    _cod = ifelse(cod in [16, 4], 0.0881, 0)
    converted_creat = creat / 88.4
    _creat = 0.22 * (converted_creat - 1) - ifelse(converted_creat > 1.5, 0.209 * (converted_creat - 1.5), 0)
    _hcv = ifelse(anti_hcv == 1, 0.24, 0)
    _dcd = ifelse(status == 1, 0.133, 0)
    # hla = 
    xbeta = _age + _hgt + _wgt + _race + _htn + _diab + _cod + _creat + _hcv + _dcd
    kdri = exp(xbeta)
    return kdri
end
