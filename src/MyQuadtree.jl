module Quadtree

export  Rectangle,
        Shape,
        Quadtree,
        Point,

        insert!,
        #get_trace_index_shape,
        #split,
        #get_index,
        retrieve!,
        list_of_objects

include("types.jl")
include("functions/insert.jl")
include("functions/get_trace_index_shape.jl")
include("functions/split.jl")
include("functions/get_index.jl")
include("functions/retrieve.jl")

#list_of_objects = Set{Shape}()
trace_index_fake_object = Int64[]
trace_index = Int64[]
level = 0
max_level_quadtree = [0]
cont = 1

end
