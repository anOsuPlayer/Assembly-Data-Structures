.section .text
.global create_list
create_list:
    pushq %rbp
    movq %rsp, %rbp
    subq $24, %rsp

    movl %ecx, -20(%rbp)

    call create_node
    movq %rax, -8(%rbp)
    call create_node
    movq %rax, -16(%rbp)

    movq -8(%rbp), %rcx
    movq %rcx, (%rax)
    movq %rcx, 8(%rax)

    movq %rax, (%rcx)
    movq %rax, 8(%rcx)

    movq $20, %rcx
    call malloc
    movq -8(%rbp), %rcx
    movq %rcx, (%rax)
    movq -16(%rbp), %rcx
    movq %rcx, 8(%rax)
    movl -20(%rbp), %ecx
    movl %ecx, 16(%rax)

    addq $24, %rsp
    popq %rbp
    ret
.global delete_list
delete_list:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp

    movq %rcx, -8(%rbp)

    movq (%rcx), %rsi
    movq 8(%rcx), %rdi
    delete_list0:
        movq %rsi, %rcx
        movq (%rsi), %rsi
        call delete_node

        cmpq %rsi, %rdi
        jne delete_list0
    
    movq %rdi, %rcx
    call delete_node

    movq -8(%rbp), %rcx
    call free

    addq $16, %rsp
    popq %rbp
    ret

.global create_node
create_node:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp

    call malloc
    movq %rax, -8(%rbp)

    movq $24, %rcx
    call malloc

    movq %rax, (%rax)
    movq %rax, 8(%rax)

    movq -8(%rbp), %rdx
    movq %rdx, 16(%rax)

    addq $16, %rsp
    popq %rbp
    ret
.global delete_node
delete_node:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp

    movq %rcx, %rbx

    addq $16, %rcx
    movq (%rcx), %rcx
    call free
    movq %rbx, %rcx
    call free

    addq $16, %rsp
    popq %rbp
    ret

.global next
next:
    movq (%rcx), %rax
    ret
.global prev
prev:
    movq 8(%rcx), %rax
    ret

.global data
data:
    movq 16(%rcx), %rax
    ret
.global set_data
set_data:
    movq 16(%rcx), %rcx
    call memcpy
    ret

.global begin
begin:
    movq (%rcx), %rax
    ret
.global at
at:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp

    movq (%rcx), %rax

    movl $0, -4(%rbp)
    at0:
        incl -4(%rbp)
        cmpl %edx, -4(%rbp)
        jg at1

        movq (%rax), %rax
        jmp at0
    at1:

    addq $16, %rsp
    popq %rbp
    ret
.global end
end:
    movq 8(%rcx), %rax
    ret

.global emplace
emplace:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp

    movq %rcx, %rbx
    movq %rdx, -8(%rbp)

    movl 16(%rcx), %ecx
    call create_node

    movq -8(%rbp), %rdx
    movq (%rdx), %rcx

    movq %rax, (%rdx)
    movq %rax, 8(%rcx)

    movq %rdx, 8(%rax)
    movq %rcx, (%rax)

    cmpq %rdx, 8(%rbx)
    jne emplace0

        movq %rax, 8(%rbx)

    emplace0:

    addq $16, %rsp
    popq %rbp
    ret
    