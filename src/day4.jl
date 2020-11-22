using Base.Iterators


function code_valid(code)
    s = split(code, '-')
    table = Dict{Char,Int}()
    
    for c in flatten(@view s[1:end - 1])
        if haskey(table, c)
            table[c] += 1
        else
            table[c] = 1
        end
    end
    
    table = collect(table)
    sort!(table; by=x -> x.first)
    sort!(table; by=x -> x.second, rev=true)
    
    [x.first for x in take(table, 5)] ==
    @view Vector{Char}(code)[end - 5:end - 1]
end


function part1()
    open("inputfiles/day4/input.txt") do io
        sum(begin
            v = Vector{Char}(l)
            s = String(@view v[end - 9:end - 7])
            parse(Int, s)
        end for l in eachline(io) if code_valid(l))
    end
end


function part2()
    function decrypt(code)
        v = Vector{Char}(code)
        key = parse(Int, String(@view v[end-9:end-7]))
        
        function unrotate(c)
            if c == '-'
                ' '
            else
                a = Int(c - 'a')
                a += key
                'a' + (a % 26)
            end
        end
        
        String(unrotate.(@view v[1:end-11]))
    end
    
    open("inputfiles/day4/input.txt") do io
        for l in Iterators.filter(code_valid, eachline(io))
            if contains(decrypt(l), "north")
                println(String(@view Vector{Char}(l)[end-9:end-7]))
            end
        end
    end
end
