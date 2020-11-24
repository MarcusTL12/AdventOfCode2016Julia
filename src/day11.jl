# using DataStructures: CircularDeque
using Base.Iterators
using Combinatorics


function load_input(filename)
    reg = r"a (\w+)(?:-compatible)? (\w+)"
    
    chips = Dict{String,Int}()
    gens = Dict{String,Int}()
    
    open(filename) do io
        for (i, l) in enumerate(eachline(io))
            for m in eachmatch(reg, l)
                c, t = m.captures
                if t == "microchip"
                    chips[c] = i
                else
                    gens[c] = i
                end
            end
        end
    end
    
    compounds = collect(keys(chips))
    
    chips = [chips[c] for c in compounds]
    gens = [gens[c] for c in compounds]
    
    chips, gens
end


function valid_conf(chips, gens)
    for i in 1:length(chips)
        has_own_gen = gens[i] == chips[i]
        has_other_gen = any(i != j && gens[j] == chips[i]
        for j in 1:length(chips))
        if has_other_gen && !has_own_gen
            return false
        end
    end
    true
end


function bfs(floor, chips, gens)
    conf = (floor, chips, gens)
    queue = [(conf, 0)]
    
    visited = Set(((floor, chips, gens),))
    
    while !isempty(queue)
        (floor, chips, gens), len = popfirst!(queue)
        
        floor_items = Tuple{Bool,Int}[]
        
        for (i, chip) in enumerate(chips)
            if chip == floor
                push!(floor_items, (false, i))
            end
        end
        
        for (i, gen) in enumerate(gens)
            if gen == floor
                push!(floor_items, (true, i))
            end
        end
        
        for comb in flatten((combinations(floor_items, 1),
            combinations(floor_items, 2)),)
            for nfloor in (floor - 1, floor + 1)
                if 1 <= nfloor <= 4
                    nchips = copy(chips)
                    ngens = copy(gens)
                    for (is_gen, id) in comb
                        if is_gen
                            ngens[id] = nfloor
                        else
                            nchips[id] = nfloor
                        end
                    end
                    
                    if all(x -> x == 4, flatten((nchips, ngens), ))
                        return len + 1
                    end
                    
                    nconf = (nfloor, nchips, ngens)
                    
                    if valid_conf(nchips, ngens)
                        if !(nconf in visited)
                            push!(visited, nconf)
                            push!(queue, (nconf, len + 1))
                        end
                    end
                end
            end
        end
    end
end


function part1()
    chips, gens = load_input("inputfiles/day11/input.txt")
    
    bfs(1, chips, gens)
end


function part2()
    chips, gens = load_input("inputfiles/day11/input.txt")
    
    append!(chips, (1, 1))
    append!(gens, (1, 1))
    
    bfs(1, chips, gens)
end
