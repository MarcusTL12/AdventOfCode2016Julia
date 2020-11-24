

input = 1350


function iswall(x, y)
    isodd(count_ones(x^2 + 3x + 2x * y + y + y^2 + input)) ||
    x < 0 || y < 0
end



function part1()
    dirs = [
        (1, 0),
        (0, 1),
        (-1, 0),
        (0, -1)
    ]
    
    start = (1, 1)
    target = (31, 39)
    
    queue = [(start, 0)]
    
    visited = Set((start,))
    
    while !isempty(queue)
        pos, len = popfirst!(queue)
        
        for d in dirs
            npos = pos .+ d
            
            if npos == target
                return len + 1
            end
            
            if !(npos in visited) && !iswall(npos...)
                push!(visited, npos)
                push!(queue, (npos, len + 1))
            end
        end
    end
end


function part2()
    dirs = [
        (1, 0),
        (0, 1),
        (-1, 0),
        (0, -1)
    ]
    
    start = (1, 1)
    
    queue = [(start, 0)]
    
    visited = Set((start,))
    
    while !isempty(queue)
        pos, len = popfirst!(queue)
        
        for d in dirs
            npos = pos .+ d
            
            if len < 50 && !(npos in visited) && !iswall(npos...)
                push!(visited, npos)
                push!(queue, (npos, len + 1))
            end
        end
    end
    
    length(visited)
end
