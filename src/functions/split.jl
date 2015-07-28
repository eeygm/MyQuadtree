function split!(quad::Quadtree, index::Int64)
    global level

    if index == 1
        output = [
                    ((quad.x1 + quad.x0) / 2),
                    (quad.y0),
                    (quad.x1 - quad.x0) / 2,
                    (quad.y1 - quad.y0) / 2
                ]*1.0
    end
    if index == 2
        output = [
                    (quad.x0),
                    (quad.y0),
                    (quad.x1 - quad.x0) / 2,
                    (quad.y1 - quad.y0) / 2
                ]*1.0
    end
    if index == 3
        output = [
                    (quad.x0),
                    (quad.y1 + quad.y0) / 2,
                    (quad.x1 - quad.x0) / 2,
                    (quad.y1 - quad.y0) / 2
                ]*1.0
    end
    if index == 4
        output = [
                    (quad.x1 + quad.x0) / 2,
                    (quad.y1 + quad.y0) / 2,
                    (quad.x1 - quad.x0) / 2,
                    (quad.y1 - quad.y0) / 2
                ]*1.0
    end

    if index == -1
        return
    end

    return output
end
