
abstract type Param end

struct Immediate <: Param val::Int end
struct Register <: Param r::Int end


abstract type Ins end

struct Cpy <: Ins
    x::Param
    y::Register
end

struct Inc <: Ins
    r::Register
end

struct Dec <: Ins
    r::Register
end

struct Jnz <: Ins
    x::Param
    y::Immediate
end



function load_input(filename)
    open(filename) do io
        registers = Dict{String, Register}()
        
        function make_register(s)::Register
            if !haskey(registers, s)
                registers[s] = Register(length(registers) + 1)
            end
            registers[s]
        end
        
        function imm_or_reg(s)::Param
            n = tryparse(Int, s)
            if !isnothing(n)
                Immediate(n)
            else
                make_register(s)
            end
        end
        
        [begin
            parts = split(l)
            
            if parts[1] == "cpy"
                Cpy(imm_or_reg(parts[2]), make_register(parts[3]))
            elseif parts[1] == "inc"
                Inc(make_register(parts[2]))
            elseif parts[1] == "dec"
                Dec(make_register(parts[2]))
            else
                Jnz(imm_or_reg(parts[2]), imm_or_reg(parts[3]))
            end
        end for l in eachline(io)], registers
    end
end


function run_program(program, registers)
    i = 1
    
    ior(x::Register) = registers[x.r]
    ior(x::Immediate) = x.val
    
    do_ins(x::Cpy) = registers[x.y.r] = ior(x.x)
    do_ins(x::Inc) = registers[x.r.r] += 1
    do_ins(x::Dec) = registers[x.r.r] -= 1
    do_ins(x::Jnz) = if ior(x.x) != 0 i += x.y.val - 1 end
    
    while 1 <= i <= length(program)
        do_ins(program[i])
        
        i += 1
    end
end


function part1()
    program, reg_names = load_input("inputfiles/day12/input.txt")
    
    registers = [0, 0, 0, 0]
    
    run_program(program, registers)
    
    registers[reg_names["a"].r]
end


function part2()
    program, reg_names = load_input("inputfiles/day12/input.txt")
    
    registers = [0, 0, 0, 0]
    
    registers[reg_names["c"].r] = 1
    
    run_program(program, registers)
    
    registers[reg_names["a"].r]
end
