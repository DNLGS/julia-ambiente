include("entidade.jl")

using Random

function mover!(h::Herbivoro, mapa)
    direcoes = [(0,1), (0,-1), (1,0), (-1,0)]
    dl, dc = rand(direcoes)
    nova_linha = h.linha + dl
    nova_col   = h.col   + dc
    l, c = size(mapa)
    if 1 <= nova_linha <= l && 1 <= nova_col <= c
        alvo = mapa[nova_linha, nova_col]
        if isa(alvo, Vazio) || isa(alvo, Planta)
            mapa[h.linha, h.col] = Vazio()
            h.linha = nova_linha
            h.col   = nova_col
            return alvo
        end
    end
    return nothing
end

function morrer!(h::Herbivoro, mapa, lista::Vector{Herbivoro})
    mapa[h.linha, h.col] = Morto()
    filter!(x -> x !== h, lista)
end

function interagir!(h::Herbivoro, alvo::Planta, mapa, lista::Vector{Herbivoro})
    h.energia += alvo.energia
end

function interagir!(h::Herbivoro, alvo::Vazio, mapa, lista::Vector{Herbivoro})
    h.energia += alvo.energia
    if h.energia <= 0
        morrer!(h, mapa, lista)
    end
end

function interagir!(h::Herbivoro, alvo::Entidade, mapa, lista::Vector{Herbivoro})
    # fallback: não faz nada
end

function novo_herbivoro!(mapa)
    l, c = size(mapa)
    linha  = rand(1:l)
    coluna = rand(1:c)
    h = Herbivoro(linha, coluna)
    mapa[linha, coluna] = h
    return h
end

function nova_planta!(mapa, intervalo::Float64)
    while true
        l, c = size(mapa)
        linha  = rand(1:l)
        coluna = rand(1:c)
        if isa(mapa[linha, coluna], Vazio)
            mapa[linha, coluna] = Planta()
        end
        sleep(intervalo)
    end
end

function acao!(mapa, lista::Vector{Herbivoro})
    for h in copy(lista)
        alvo = mover!(h, mapa)
        if alvo !== nothing
            interagir!(h, alvo, mapa, lista)
            if any(x -> x === h, lista)
                mapa[h.linha, h.col] = h
            end
        end
    end
end