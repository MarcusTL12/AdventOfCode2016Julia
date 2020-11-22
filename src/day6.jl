

function max_by(by, itr)
    maxel = nothing
    maxsize = nothing
    
    for element in itr
        s = by(element)
        if isnothing(maxel)
            maxel = element
            maxsize = s
        elseif s > maxsize
            maxel = element
            maxsize = s
        end
    end
    
    maxel
end


function part1()
    open("inputfiles/day6/input.txt") do io
        counters = nothing
        
        for l in eachline(io)
            if isnothing(counters)
                counters = [Dict{Char,Int}() for _ in 1:length(l)]
            end
            for (counter, c) in zip(counters, l)
                if haskey(counter, c)
                    counter[c] += 1
                else
                    counter[c] = 1
                end
            end
        end
        
        String(collect(max_by(x -> x.second, counter).first
        for counter in counters))
    end
end


function part2()
    open("inputfiles/day6/input.txt") do io
        counters = nothing
        
        for l in eachline(io)
            if isnothing(counters)
                counters = [Dict{Char,Int}() for _ in 1:length(l)]
            end
            for (counter, c) in zip(counters, l)
                if haskey(counter, c)
                    counter[c] += 1
                else
                    counter[c] = 1
                end
            end
        end
        
        String(collect(max_by(x -> -x.second, counter).first
        for counter in counters))
    end
end
