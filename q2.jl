using JuMP
using HiGHS

# Cria o modelo usando HiGHS como solver
m = Model(HiGHS.Optimizer)

# Lembrar de sempre passar m
@variable(m, pa >= 0)
@variable(m, pb >= 0)
@variable(m, pc >= 0)
@variable(m, va >= 0)
@variable(m, vb >= 0)
@variable(m, vc >= 0)
@variable(m, oa >= 0)
@variable(m, ob >= 0)
@variable(m, oc >= 0)

@objective(m, Max, 10pa + 20pb + 30pc + 40va + 50vb + 60vc + 70oa + 80ob + 90oc)

@constraint(m, pa + pb + pc <= 200)
@constraint(m, va + vb + vc <= 200 - (0.01pa + 0.08pb + 0.17pc))
@constraint(m, oa + ob + oc <= 200 - (0.01pa + 0.08pb + 0.17pc + 0.08va + 0.27vb + 0.33vc))
@constraint(m, 0.01pa + 0.08pb + 0.17pc + 0.08va + 0.27vb + 0.33vc + 0.12oa + 0.32ob + 0.51oc <= 0.5 * 200)

# Soluciona o modelo
optimize!(m)

# Mostra os valores encontrados
@show objective_value(m)
