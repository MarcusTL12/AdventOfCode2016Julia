using MD5
using Base.Iterators


input = "bwnlcvfs"


function part1()
    pos = (1, 1)
    
    dirs = [
        ('U', (0, -1)),
        ('D', (0, 1)),
        ('L', (-1, 0)),
        ('R', (1, 0)),
    ]
    
    doors_open(h) = ('b' <= c <= 'f' for c in take(h, 4))
    
    queue = [(pos, Char[])]
    
    while !isempty(queue)
        (pos, path) = popfirst!(queue)
        
        for ((c, d), door_open) in
            zip(dirs, doors_open(bytes2hex(md5(input * String(path)))))
            npos = pos .+ d
            if door_open && all(x -> 1 <= x <= 4, npos)
                npath = copy(path)
                push!(npath, c)
                if npos == (4, 4)
                    return String(npath)
                end
                
                push!(queue, (npos, npath))
            end
        end
    end
end


function part2()
    pos = (1, 1)
    
    dirs = [
        ('U', (0, -1)),
        ('D', (0, 1)),
        ('L', (-1, 0)),
        ('R', (1, 0)),
    ]
    
    doors_open(h) = ('b' <= c <= 'f' for c in take(h, 4))
    
    queue = [(pos, Char[])]
    maxlen = 0
    
    while !isempty(queue)
        (pos, path) = popfirst!(queue)
        
        for ((c, d), door_open) in
            zip(dirs, doors_open(bytes2hex(md5(input * String(path)))))
            npos = pos .+ d
            if door_open && all(x -> 1 <= x <= 4, npos)
                npath = copy(path)
                push!(npath, c)
                
                if npos == (4, 4)
                    maxlen = max(maxlen, length(npath))
                else
                    push!(queue, (npos, npath))
                end
            end
        end
    end
    maxlen
end
