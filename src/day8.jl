

function show_screen(screen)
    for row in eachrow(screen)
        for cell in row
            print(cell ? '█' : ' ')
        end
        println()
    end
end


function make_screen()
    w, h = 50, 6
    
    screen = falses(h, w)
    
    open("inputfiles/day8/input.txt") do io
        for l in eachline(io)
            parts = split(l)
            
            if length(parts) == 2
                coords = parse.(Int, split(parts[2], 'x'))
                screen[1:coords[2], 1:coords[1]] .= true
            elseif length(parts) == 5
                axis = parse(Int, split(parts[3], '=')[2]) + 1
                amt = parse(Int, parts[end])
                
                if parts[2] == "row"
                    screen[axis, :] .= circshift(screen[axis, :], amt)
                else
                    screen[:, axis] .= circshift(screen[:, axis], amt)
                end
            end
        end
    end
    
    screen
end


function part1()
    count(make_screen())
end


function part2()
    show_screen(make_screen())
end
