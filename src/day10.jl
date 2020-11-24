

struct EntityVal
    # 0 is immediate, 1 is bot low, 2 is bot high
    bot::Int
    # value if immediate, bot id if not
    val::Int
end


function load_input(filename)
    outputs = Dict{Int,EntityVal}()
    bots = Dict{Int,Tuple{EntityVal,Union{Nothing,EntityVal}}}()
    
    open(filename) do io
        for l in eachline(io)
            parts = split(l)
            
            if length(parts) == 6
                v = parse(Int, parts[2])
                b = parse(Int, parts[end])
                
                if !haskey(bots, b)
                    bots[b] = (EntityVal(0, v), nothing)
                else
                    other_val, _ = bots[b]
                    bots[b] = (other_val, EntityVal(0, v))
                end
            elseif length(parts) == 12
                giver = parse(Int, parts[2])
                low = parse(Int, parts[7])
                if parts[6] == "bot"
                    if !haskey(bots, low)
                        bots[low] = (EntityVal(1, giver), nothing)
                    else
                        other_val, _ = bots[low]
                        bots[low] = (other_val, EntityVal(1, giver))
                    end
                else
                    outputs[low] = EntityVal(1, giver)
                end
                high = parse(Int, parts[end])
                if parts[end - 1] == "bot"
                    if !haskey(bots, high)
                        bots[high] = (EntityVal(2, giver), nothing)
                    else
                        other_val, _ = bots[high]
                        bots[high] = (other_val, EntityVal(2, giver))
                    end
                else
                    outputs[high] = EntityVal(2, giver)
                end
            end
        end
    end
    
    bots, outputs
end


function eval_bot(bots, bot_ind)
    a, b = bots[bot_ind]
    changed = false
    
    if a.bot != 0
        bot = eval_bot(bots, a.val)
        a = EntityVal(0, bot[a.bot])
        changed = true
    end
    
    if b.bot != 0
        bot = eval_bot(bots, b.val)
        b = EntityVal(0, bot[b.bot])
        changed = true
    end
    
    if changed
        bots[bot_ind] = (a, b)
    end
    
    vals = (a.val, b.val)
    
    min(vals...), max(vals...)
end


function eval_output(bots, outputs, output_ind)
    a = outputs[output_ind]
    if a != 0
        v = eval_bot(bots, a.val)[a.bot]
        outputs[output_ind] = EntityVal(0, v)
        v
    else
        a.val
    end
end


function part1()
    bots, outputs = load_input("inputfiles/day10/input.txt")
    
    for i in keys(bots)
        a, b = eval_bot(bots, i)
        
        if a == 17 && b == 61
            println(i)
            break
        end
    end
end


function part2()
    bots, outputs = load_input("inputfiles/day10/input.txt")
    
    prod(eval_output(bots, outputs, i) for i in 0:2)
end
