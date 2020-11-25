using Mods


function load_input(filename)
    reg = r"Disc #\d+ has (\d+) positions; at time=0, it is at position (\d+)."
    
    open(filename) do io
        [begin
            m = match(reg, l)
            
            n, r = parse.(Int, m.captures)
            
            Mod{n}(-(r + i))
        end for (i, l) in enumerate(eachline(io))]
    end
end


function part1()
    CRT(load_input("inputfiles/day13/input.txt")...).val
end


function part2()
    inp = load_input("inputfiles/day13/input.txt")
    push!(inp, Mod{11}(-(length(inp) + 1)))
    CRT(inp...).val
end
