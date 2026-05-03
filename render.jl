desenhar(io::IO, ent::Vazio)     = print(io, ".")
desenhar(io::IO, ent::Morto)     = print(io, "\e[31m+\e[0m")
desenhar(io::IO, ent::Planta)    = print(io, "\e[32m*\e[0m")
desenhar(io::IO, ent::Herbivoro) = print(io, "\e[31mH\e[0m")


function renderizar_mapa!(mapa)
    print("\e[?25l")
    print("\e[H")
    linhas, colunas = size(mapa)
    buf = IOBuffer()
    for i in 1:linhas
        for j in 1:colunas
            desenhar(buf, mapa[i, j])
        end
        println(buf)
    end
    print(String(take!(buf)))
    print("\e[?25h")
end