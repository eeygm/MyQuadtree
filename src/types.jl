export Rectangle,
        Shape,
        Quadtree,
        Point

type Shape
    ##Use UNION to make Float and Int together if necessary
    bounds::Array{Float64, 2}
    #rect::Rectangle
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
    x0
    y0
    x1
    y1
    shape::Shape
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
            Shape(bounds[1],bounds[2],bounds[3],bounds[4]),
            objects)
    end

    function Quadtree(x0::Int64, y0::Int64, x1::Int64, y1::Int64)
        objects = Shape[]
        new(x0,
            y0,
            x1,
            y1,
            Shape(x0, y0, x1-x0, y1-y0),
            objects)
    end

    function Quadtree(bounds::(Int64,Int64,Int64,Int64),
                        ne1::Quadtree,
                        nw1::Quadtree,
                        sw1::Quadtree,
                        se1::Quadtree)
        objects = Shape[]
        new(bounds[1],
            bounds[2],
            bounds[3],
            bounds[4],
            Shape(bounds[1], bounds[2], bounds[3], bounds[4]),
            objects,
            ne1,
            nw1,
            sw1,
            se1)
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
