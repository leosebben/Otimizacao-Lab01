using JuMP
using HiGHS

# Cria o modelo usando HiGHS como solver
m = Model(HiGHS.Optimizer)

# Lembrar de sempre passar m
@variable(m, ab >= 0)
@variable(m, ae >= 0)
@variable(m, af >= 0)

@variable(m, bc >= 0)
@variable(m, be >= 0)
@variable(m, bf >= 0)
@variable(m, bg >= 0)

@variable(m, cd >= 0)
@variable(m, cf >= 0)
@variable(m, cg >= 0)
@variable(m, ch >= 0)

@variable(m, dh >= 0)
@variable(m, dg >= 0)

@variable(m, ef >= 0)
@variable(m, fg >= 0)
@variable(m, gh >= 0)

@objective(m, Min, 10ab + 1ae + 15af + 2bc + 14be + 16bf + 5bg + 11cd + 13cf + 4cg + 12ch + 6dg + 7dh + 3ef + 8fg + 9gh)

@constraint(m, ab <= 4)
@constraint(m, ae <= 16)
@constraint(m, af <= 1)

@constraint(m, bc <= 7)
@constraint(m, be <= 8)
@constraint(m, bf <= 11)
@constraint(m, bg <= 12)

@constraint(m, cd <= 10)
@constraint(m, cf <= 6)
@constraint(m, cg <= 9)
@constraint(m, ch <= 14)

@constraint(m, dh <= 2)
@constraint(m, dg <= 15)

@constraint(m, ef <= 5)
@constraint(m, fg <= 3)
@constraint(m, gh <= 13)

# O valor deve ser 6, pois caso seja 12 o programa informará que não existe resposta válida
@constraint(m, ab + ae + af == 6)
@constraint(m, ch + dh + gh == 6)

@constraint(m, ab == bc + be + bf + bg)
@constraint(m, bc == cd + cf + cg + ch)
@constraint(m, cd == dh + dg)
@constraint(m, ae + be == ef)
@constraint(m, af + bf + cf + ef == fg)
@constraint(m, bg + cg + dg + fg == gh)

# Soluciona o modelo
optimize!(m)

# Mostra os valores encontrados
@show objective_value(m)