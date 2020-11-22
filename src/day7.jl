using Base.Iterators


function part1()
    function has_tls(s)
        inside = false
        abba_outside = false
        abba_inside = false
        
        for (a, b, c, d) in zip(s, drop(s, 1), drop(s, 2), drop(s, 3))
            a == '[' && (inside = true)
            a == ']' && (inside = false)
            
            abba = ((a == d) && (b == c) && (a != b))
            
            if inside
                abba_inside |= abba
            else
                abba_outside |= abba
            end
        end
        
        abba_outside && !abba_inside
    end
    
    open("inputfiles/day7/input.txt") do io
        count(has_tls, eachline(io))
    end
end


function part2()
    function has_ssl(s)
        abas = Set{Tuple{Char,Char}}()
        babs = Set{Tuple{Char,Char}}()
        
        inside = false
        
        for (a, b, c) in zip(s, drop(s, 1), drop(s, 2))
            a == '[' && (inside = true)
            a == ']' && (inside = false)
            
            if (a == c) && (a != b)
                if inside
                    push!(babs, (b, a))
                else
                    push!(abas, (a, b))
                end
            end
        end
        
        length(abas ∩ babs) > 0
    end
    
    open("inputfiles/day7/input.txt") do io
        count(has_ssl, eachline(io))
    end
end
