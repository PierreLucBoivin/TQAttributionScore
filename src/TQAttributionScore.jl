# SPDX-License-Identifier: MIT

module TQAttributionScore
using Revise
# Write your package code here.
include("attribution_score.jl")
include("kdri.jl")

export score
end
