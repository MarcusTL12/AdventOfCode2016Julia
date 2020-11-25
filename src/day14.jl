using MD5
using IterTools: iterated
using Base.Iterators


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
# input = "abc"


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
            end
        end
        
        i = hashes[end][1] + 1
        push!(hashes, (i, bytes2hex(md5(input * string(i)))))
    end
    prev_key
end


function stretched_hash(s)
    first(drop(iterated(bytes2hex ∘ md5, s), 2017))
end


function part2()
    hashes = sizehint!(Tuple{Int,String}[], 1001)
    
    for i in 0:1000
        push!(hashes, (i, stretched_hash(input * string(i))))
    end
    
    amt_keys = 1
    prev_key = -1
    
    while amt_keys < 64
        i, curhash = popfirst!(hashes)
        c = n_inarow(curhash, 3)
        if !isnothing(c)
            if any(((_, h),) -> n_inarow(h, 5, c), hashes)
                amt_keys += 1
                prev_key = i
            end
        end
        
        i = hashes[end][1] + 1
        push!(hashes, (i, stretched_hash(input * string(i))))
    end
    prev_key
end
