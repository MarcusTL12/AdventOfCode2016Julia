using Base.Iterators


function part1()
    inp = open(first ∘ eachline, "inputfiles/day9/input.txt")
    
    it = Iterators.Stateful(inp)
    
    l = 0
    
    buf = Char[]
    
    while !isempty(it)
        while !isempty(it) && first(it) != '('
            l += 1
        end
        
        if isempty(it)
            break
        end
        
        resize!(buf, 0)
        
        while (c = first(it)) != ')'
            push!(buf, c)
        end
        
        a, b = parse.(Int, split(String(buf), 'x'))
        
        l += a * b
        for _ in 1 : a
            first(it)
        end
    end
    
    l
end


function part2()
    function multipass_len(s)
        it = Iterators.Stateful(s)
        
        buf = Char[]
        
        l = 0
        
        while !isempty(it)
            while !isempty(it) && first(it) != '('
                l += 1
            end
            
            if isempty(it)
                break
            end
            
            resize!(buf, 0)
            
            while (c = first(it)) != ')'
                push!(buf, c)
            end
            
            a, b = parse.(Int, split(String(buf), 'x'))
            
            resize!(buf, 0)
            
            for _ in 1 : a
                push!(buf, first(it))
            end
            l += multipass_len(buf) * b
        end
        l
    end
    
    open(multipass_len ∘ first ∘ eachline, "inputfiles/day9/input.txt")
end
