
format ELF64 executable 3
entry start

segment readable writeable
buffer rb 32

segment readable executable

start:
    mov rax, [rsp]
    cmp rax, 2
    jne error

    mov rsi, [rsp+16]
    movzx rax, byte [rsi]

    call print_number

    mov rax, 60
    xor rdi, rdi
    syscall

error:
    mov rax, 60
    mov rdi, 1
    syscall

print_number:
    lea rdi, [buffer+31]
    mov byte [rdi], 10
    mov r8, rdi
    mov rbx, 10

convert:
    xor rdx, rdx
    div rbx
    add dl, '0'
    dec rdi
    mov [rdi], dl
    test rax, rax
    jnz convert

    mov rax, 1
    mov rsi, rdi
    mov rdx, r8
    sub rdx, rdi
    inc rdx
    mov rdi, 1
    syscall
    ret
