using JuMP
using HiGHS

# Cria o modelo usando HiGHS como solver
m = Model(HiGHS.Optimizer)

# Lembrar de sempre passar m
@variable(m, a >= 0)
@variable(m, b >= 0)
@variable(m, c >= 0)
@variable(m, d >= 0)
@variable(m, x >= 0)

@objective(m, Min, 16a + 14b + 22c + 24d + 33x)

@constraint(m, 30a + 35b + 45c + 50d - 62x >= 20)
@constraint(m, 60a + 50b + 35c + 28d - 33x >= 30)
@constraint(m, 10a + 15b + 20c + 22d - 5x >= 45)
@constraint(m, 30a + 35b + 45c + 50d - 62x + 60a + 50b + 35c + 28d - 33x + 10a + 15b + 20c + 22d - 5x == 100)

# Soluciona o modelo
optimize!(m)

# Mostra os valores encontrados
@show objective_value(m)
@show value(a)
@show value(b)
@show value(c)
@show value(d)
@show value(x)
