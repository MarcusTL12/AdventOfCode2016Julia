
reg = r"(\w)(\d+)"


function part1()
    pos = 0im
    dir = 1im
    
    for m in eachmatch(reg, open(String ∘ read, "inputfiles/day1/input.txt"))
        dir *= if m.captures[1] == "L"
            1im
        else
            -1im
        end
        
        pos += dir * parse(Int, m.captures[2])
    end
    
    abs(real(pos)) + abs(imag(pos))
end


function part2()
    pos = 0im
    dir = 1im
    
    visited = Set(pos)
    
    for m in eachmatch(reg, open(String ∘ read, "inputfiles/day1/input.txt"))
        dir *= if m.captures[1] == "L"
            1im
        else
            -1im
        end
        
        for _ in 1 : parse(Int, m.captures[2])
            pos += dir
            if pos in visited
                return abs(real(pos)) + abs(imag(pos))
                break
            else
                push!(visited, pos)
            end
        end
    end
end
