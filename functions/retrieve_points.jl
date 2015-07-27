function retrieve!(quad::Quadtree, shape::Shape, number_of_points::Int64)

    global points = get_points_from_shape(shape, number_of_points)

    for pt in points

        trace_index_fake_object = get_trace_index_shape(quad.rect, pt)

        cont = 1
        function retrieve_inside!(quad::Quadtree, shape::Shape)

            for i = 1:length(quad.objects)
                push!(list_of_objects, quad.objects[i])
            end

            if(cont <= max_level_quadtree[1] && isdefined(trace_index_fake_object, cont))

                if(isdefined(quad, :ne) && trace_index_fake_object[cont] == 1)
                    cont += 1
                    retrieve_inside!(quad.ne, shape)
                    cont -= 1
                end
                if(isdefined(quad, :nw) && trace_index_fake_object[cont] == 2)
                    cont += 1
                    retrieve_inside!(quad.nw, shape)
                    cont -= 1
                end
                if(isdefined(quad, :sw) && trace_index_fake_object[cont] == 3)
                    cont += 1
                    retrieve_inside!(quad.sw, shape)
                    cont -= 1
                end
                if(isdefined(quad, :se) && trace_index_fake_object[cont] == 4)
                    cont += 1
                    retrieve_inside!(quad.se, shape)
                    cont -= 1
                end

            end

            return nothing

        end
        retrieve_inside!(quad, shape)

    end

    return nothing
end
