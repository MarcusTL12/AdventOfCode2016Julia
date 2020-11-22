using Base.Iterators
using MD5


input = "ffykfhsq"
# input = "abc"


function part1()
    String(collect(take((h[6] for h in (bytes2hex(md5(input * string(i)))
    for i in countfrom(0)) if all(c -> c == '0', h[1:5])), 8)))
end


function part2()
    password = ['\0' for _ in 1:8]
    amt_found = 0
    
    for (i, c) in (h[6:7] for h in (bytes2hex(md5(input * string(i)))
    for i in takewhile(_ -> amt_found < 8, countfrom(0)))
    if all(c -> c == '0', h[1:5]) && h[6] in "01234567")
        i_n = Int(i - '0') + 1
        if password[i_n] == '\0'
            amt_found += 1
            password[i_n] = c
        end
    end
    
    String(password)
end
