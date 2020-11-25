using Base.Iterators


input = "01111010110010011"


function expand_dragon(dragon)
    push!(dragon, false)
    append!(dragon, (!b for b in drop(Iterators.reverse(dragon), 1)))
end


function make_checksum(disk)
    dragon = BitArray(c == '1' for c in input)
    
    while length(dragon) < disk
        expand_dragon(dragon)
    end
    
    resize!(dragon, disk)
    
    while length(dragon) % 2 == 0
        for (i, (a, b)) in enumerate(partition(dragon, 2))
            dragon[i] = (a == b)
        end
        
        resize!(dragon, length(dragon) ÷ 2)
    end
    
    String([b ? '1' : '0' for b in dragon])
end


function part1()
    make_checksum(272)
end


function part2()
    make_checksum(35651584)
end
