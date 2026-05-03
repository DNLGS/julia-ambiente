
include("sistema.jl")
include("render.jl")

tam_mapa = 10

mapa = Matrix{Entidade}([Vazio() for _ in 1:tam_mapa, _ in 1:tam_mapa])

lista_herbivoro = Herbivoro[]

for _ in 1:5
    push!(lista_herbivoro, novo_herbivoro!(mapa))
end

print("\e[2J")
@async nova_planta!(mapa, 100.0)
while true
    renderizar_mapa!(mapa)
    acao!(mapa, lista_herbivoro)
    sleep(0.5)
end