abstract type Entidade end

struct Vazio <: Entidade
    energia::Int
    Vazio() = new(-1)
end

struct Morto <: Entidade
    energia::Int
    Morto() = new(0)
end

mutable struct Herbivoro <: Entidade
    energia::Int
    linha::Int
    col::Int
    Herbivoro(l, c) = new(10, l, c)
end

mutable struct Planta <: Entidade
    energia::Int
    Planta() = new(1)
end