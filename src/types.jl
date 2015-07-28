export Rectangle,
        Shape,
        Quadtree,
        Point

immutable Rectangle
    x0::Real
    y0::Real
    width::Real
    height::Real
    x1::Real
    y1::Real

    function Rectangle(x0::Real, y0::Real, width::Real, height::Real)
        new(x0, y0, width, height, x0+width, y0+height)
    end
end

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
    function Shape(bounds::Rectangle)
        new([bounds.x0 bounds.y0; bounds.x0 bounds.y1; bounds.x1 bounds.y1; bounds.x1 bounds.y0])
    end
end

## Implement == (isequal) function for Shapes
==(a::Shape, b::Shape) = a.bounds == b.bounds

type Quadtree
    x0
    y0
    x1
    y1
    rect::Rectangle
    shape::Shape
    objects::Vector{Shape}
    ne::Quadtree
    nw::Quadtree
    sw::Quadtree
    se::Quadtree

    local objects

    function Quadtree(bounds::Rectangle)
        objects = Shape[]
        new(bounds.x0, bounds.y0, bounds.x0 + bounds.width, bounds.y0 + bounds.height, bounds, Shape(bounds), objects)
    end

    function Quadtree(x0::Int64, y0::Int64, x1::Int64, y1::Int64)
        objects = Shape[]
        new(x0,y0,x1,y1,Rectangle(x0,y0,x1-x0,y1-y0),Shape(Rectangle(x0,y0,x1-x0,y1-y0)), objects)
    end

    function Quadtree(bounds::Rectangle,
                        ne1::Quadtree,
                        nw1::Quadtree,
                        sw1::Quadtree,
                        se1::Quadtree)
        objects = Shape[]
        new(bounds.x0, bounds.y0, bounds.x0 + bounds.width, bounds.y0 + bounds.height, bounds, Shape(rect), objects, ne1, nw1, sw1, se1)
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
