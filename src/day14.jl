using MD5


function n_inarow(h, n)
    for c in "0123456789abcdef"
        if contains(h, c^n)
            return c
        end
    end
end


function n_inarow(h, n, c)
    contains(h, c^n)
end


input = "yjdafjpo"


function part1()
    hashes = sizehint!(Tuple{Int,String}[], 1001)
    
    for i in 0:1000
        push!(hashes, (i, bytes2hex(md5(input * string(i)))))
    end
    
    amt_keys = 2
    prev_key = -1
    
    while amt_keys < 64
        i, curhash = popfirst!(hashes)
        c = n_inarow(curhash, 3)
        if !isnothing(c)
            if any(((_, h),) -> n_inarow(h, 5, c), hashes)
                amt_keys += 1
                prev_key = i
                println(i)
            end
        end
        
        i = hashes[end][1] + 1
        push!(hashes, (i, bytes2hex(md5(input * string(i)))))
    end
    prev_key
end
