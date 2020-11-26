using DataStructures: MutableLinkedList


input = 3014387
# input = 5


function delete_node!(node)
    node.prev.next = node.next
    node.next.prev = node.prev
end


function part1()
    v = MutableLinkedList{Int}()
    
    for i in 1:input
        push!(v, i)
    end
    
    curelf = v.node.next
    delete_node!(v.node)
    
    while length(v) > 1
        # println(curelf)
        # println(v)
        delete_node!(curelf.next)
        v.len -= 1
        curelf = curelf.next
    end
    
    curelf.data
end


function part2()
    v = MutableLinkedList{Int}()
    
    for i in 1:input
        push!(v, i)
    end
    
    curelf = v.node.next
    delete_node!(v.node)
    
    oppelf = curelf
    for _ in 1:input ÷ 2
        oppelf = oppelf.next
    end
    
    while length(v) > 1
        # println("cur: $(curelf.data), opp: $(oppelf.data)")
        n_oppelf = oppelf
        for _ in 1:length(v) % 2 + 1
            n_oppelf = n_oppelf.next
        end
        delete_node!(oppelf)
        v.len -= 1
        oppelf = n_oppelf
        curelf = curelf.next
    end
    
    curelf.data
end
