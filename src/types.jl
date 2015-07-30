import  Base: ==
export  Shape,
        Quadtree,
        Point

immutable Shape
    ##Use UNION to make Float and Int together if necessary
    bounds::Array{Float64, 2}
    function Shape(bounds::Array{Int64, 2})
        new(convert(Array{Float64,2}, bounds))
    end
    function Shape(bounds::Array{Float64, 2})
        new(convert(Array{Float64,2}, bounds))
    end
    function Shape(x0::Real, y0::Real, x1::Real, y1::Real)
        new([x0 y0; x0 y1; x1 y1; x1 y0])
    end
end

## Implement == (isequal) function for Shapes
==(a::Shape, b::Shape) = a.bounds == b.bounds

type Quadtree
    x0::Real
    y0::Real
    x1::Real
    y1::Real
    objects::Vector{Shape}
    ne::Quadtree
    nw::Quadtree
    sw::Quadtree
    se::Quadtree

    local objects

    function Quadtree(bounds::Vector{Float64})
        objects = Shape[]
        new(bounds[1],
            bounds[2],
            bounds[3],
            bounds[4],
            objects)
    end

    function Quadtree(x0::Int64, y0::Int64, x1::Int64, y1::Int64)
        objects = Shape[]
        new(x0,
            y0,
            x1,
            y1,
            objects)
    end

end

type Point
    x
    y
    function Point(b::Array{Float64, 2})
        x = b[1]
        y = b[2]
        new(x,y)
    end
end
