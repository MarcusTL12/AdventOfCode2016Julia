using Base.Iterators


function next_row(current, next)
    for i in 1 : length(current)
        a = get(current, i - 1, false)
        c = get(current, i + 1, false)
        next[i] = (a & !c) | (!a & c)
    end
end


function part1()
    a = BitArray(c == '^'
    for c in open(first ∘ eachline, "inputfiles/day18/input.txt"))
    b = falses(length(a))
    
    sum(begin
        next_row(a, b)
        a, b = b, a
        count(x->!x, b)::Int
    end for _ in 1:40)
end


function part2()
    a = BitArray(c == '^'
    for c in open(first ∘ eachline, "inputfiles/day18/input.txt"))
    b = falses(length(a))
    
    sum(begin
        next_row(a, b)
        a, b = b, a
        count(x->!x, b)::Int
    end for _ in 1:400_000)
end

