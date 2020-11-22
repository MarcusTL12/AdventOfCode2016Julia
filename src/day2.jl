

function part1()
    open("inputfiles/day2/input.txt") do io
        keypad = reshape('1':'9', (3, 3))
        
        pos = (2, 2)
        
        String([begin
            for c in l
                pos = clamp.(pos .+ if c == 'R'
                    (1, 0)
                elseif c == 'L'
                    (-1, 0)
                elseif c == 'U'
                    (0, -1)
                else
                    (0, 1)
                end, 1, 3)
            end
            keypad[pos...]
        end for l in eachline(io)])
    end
end


function part2()
    keypad = Dict([
        (0, -2) => '1',
        (-1, -1) => '2',
        (0, -1) => '3',
        (1, -1) => '4',
        (-2, 0) => '5',
        (-1, 0) => '6',
        (0, 0) => '7',
        (1, 0) => '8',
        (2, 0) => '9',
        (-1, 1) => 'A',
        (0, 1) => 'B',
        (1, 1) => 'C',
        (0, 2) => 'D',
    ])
    
    open("inputfiles/day2/input.txt") do io
        pos = (-2, 0)
        
        String([begin
            for c in l
                npos = pos .+ if c == 'R'
                    (1, 0)
                elseif c == 'L'
                    (-1, 0)
                elseif c == 'U'
                    (0, -1)
                else
                    (0, 1)
                end
                
                if haskey(keypad, npos)
                    pos = npos
                end
            end
            keypad[pos...]
        end for l in eachline(io)])
    end
end
