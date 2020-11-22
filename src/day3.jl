using Base.Iterators


function part1()
    open("inputfiles/day3/input.txt") do io
        count(l -> begin
            sides = parse.(Int, split(l))
            s = sum(sides)
            all(x -> 2x < s, sides)
        end, eachline(io))
    end
end


function part2()
    open("inputfiles/day3/input.txt") do io
        count(sides -> begin
            s = sum(sides)
            all(x -> 2x < s, sides)
        end, flatten(eachrow(hcat((parse.(Int, split(l)) for l in ls)...))
        for ls in partition(eachline(io), 3)))
    end
end
