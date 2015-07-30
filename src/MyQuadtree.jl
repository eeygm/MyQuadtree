module MyQuadtree

export  insertOn!,
        retrieve!

include("types.jl")
include("functions/insertOn.jl")
include("functions/split.jl")
include("functions/get_index.jl")
include("functions/retrieve.jl")

trace_index_fake_object = Int64[]
trace_index = Int64[]
level = 0::Int64
max_level_quadtree = [0]
cont = 1

end
