function retrieve!(quad::Quadtree, shape::Shape)
    global points_shape = Point[]
    level::Int64 = 0
    list_of_objects = Set{Shape}()

    for i = 1:length(shape.bounds[:,1])
        push!(points_shape, Point(shape.bounds[i,:]))
    end
    push!(points_shape, Point(shape.bounds[1,:]))

    function retrieve_inside!(quad::Quadtree, shape::Shape)
        Area = Float64
        s = Float64
        t = Float64

        ## Get all the objects in that level
        for i = 1:length(quad.objects)
            push!(list_of_objects, quad.objects[i])
        end

        ## Center of quadtree
        xx = (quad.x0 + quad.x1) / 2
        yy = (quad.y0 + quad.y1) / 2
        ## Test whether the half-quad is inside the shape
        for i = 0:length(shape.bounds[:,1])-3
            Area = 1/2*(-points_shape[2+i].y*points_shape[3+i].x + points_shape[1].y*(-points_shape[2+i].x + points_shape[3+i].x) + points_shape[1].x*(points_shape[2+i].y - points_shape[3+i].y) + points_shape[2+i].x*points_shape[3+i].y)

            s = 1/(2*Area)*(points_shape[1].y*points_shape[3+i].x - points_shape[1].x*points_shape[3+i].y + (points_shape[3+i].y - points_shape[1].y)*xx + (points_shape[1].x - points_shape[3+i].x)*yy)

            t = 1/(2*Area)*(points_shape[1].x*points_shape[2+i].y - points_shape[1].y*points_shape[2+i].x + (points_shape[1].y - points_shape[2+i].y)*xx + (points_shape[2+i].x - points_shape[1].x)*yy);

            # Test whether half-quad is inside the shape_test
            # if [ s>=0 && t>=0 && 1-s-t>=0 ] then it is inside
            if s>=0 && t>=0 && 1-s-t>=0
                if level <= max_level_quadtree[1]
                    if isdefined(quad, :ne)
                        level += 1
                        retrieve_inside!(quad.ne, shape)
                        level -= 1
                    end
                    if isdefined(quad, :nw)
                        level += 1
                        retrieve_inside!(quad.nw, shape)
                        level -= 1
                    end
                    if isdefined(quad, :sw)
                        level += 1
                        retrieve_inside!(quad.sw, shape)
                        level -= 1
                    end
                    if isdefined(quad, :se)
                        level += 1
                        retrieve_inside!(quad.se, shape)
                        level -= 1
                    end
                end
            end
        end

        ## Test whether the shape has points inside the quad
        if isdefined(quad, :ne)
            if isinside(quad.ne, points_shape)
                level += 1
                retrieve_inside!(quad.ne, shape)
                level -= 1
            end
        end
        if isdefined(quad, :nw)
            if isinside(quad.nw, points_shape)
                level += 1
                retrieve_inside!(quad.nw, shape)
                level -= 1
            end
        end
        if isdefined(quad, :sw)
            if isinside(quad.sw, points_shape)
                level += 1
                retrieve_inside!(quad.sw, shape)
                level -= 1
            end
        end
        if isdefined(quad, :se)
            if isinside(quad.se, points_shape)
                level += 1
                retrieve_inside!(quad.se, shape)
                level -= 1
            end
        end

        return

    end

    retrieve_inside!(quad, shape)
    return list_of_objects
end

function isinside(quad::Quadtree, points::Vector{Point})
    ## Test whether the shape has points inside the quad
    for i=1:length(points)
        xxx = points[i].x > quad.x0 && points[i].x < quad.x1
        yyy = points[i].y > quad.y0 && points[i].y < quad.y1

        if xxx && yyy
            return true
        end
    end

    ## Test line intersections
    l = quad.x0
    r = quad.x1
    t = quad.y0
    b = quad.y1
    for i=1:length(points)-1
        x1 = points_shape[i].x
        y1 = points_shape[i].y
        x2 = points_shape[i+1].x
        y2 = points_shape[i+1].y

        m = (x2-x1) != 0 ? (y2-y1)/(x2-x1) : pi
        c = y1 - (m*x1)

        if m>0 && m!=pi
            top_intersection = (m*l  + c)
            bottom_intersection = (m*r  + c)
        else
            top_intersection = (m*r  + c)
            bottom_intersection = (m*l  + c)
        end

        if y1 < y2
            toptrianglepoint = y1
            bottomtrianglepoint = y2
        else
            toptrianglepoint = y2
            bottomtrianglepoint = y1
        end

        topoverlap = top_intersection > toptrianglepoint ? top_intersection : toptrianglepoint
        botoverlap = bottom_intersection < bottomtrianglepoint ? bottom_intersection : bottomtrianglepoint

        isinside2 = (topoverlap < botoverlap) && (!((botoverlap<t)||(topoverlap>b)))
        if isinside2
            return true
        end
    end

    return false
end
