format ELF64

public _start
public exit
public print_symbl

section '.data' writable
    N = 406
    M = 14
    array rb N
    place db ?

section '.text' executable

_start:
    mov rcx, N

.fill:
    mov byte [array+rcx-1], '*'
    dec rcx
    cmp rcx, 0
    jne .fill

    xor rcx, rcx
    xor rbx, rbx

.print:
    mov al, [array+rcx]
    call print_symbl
    inc rcx
    inc rbx
    cmp rbx, M
    jne .check

    mov rax, 0xA
    call print_symbl
    xor rbx, rbx

.check:
    cmp rcx, N
    jne .print

    call exit

section '.print_symbl' executable

print_symbl:
    push rbx
    push rdx
    push rcx
    push rax
    push rax
    mov eax, 4
    mov ebx, 1
    pop rdx
    mov [place], dl
    mov ecx, place
    mov edx, 1
    int 0x80
    pop rax
    pop rcx
    pop rdx
    pop rbx
    ret

section '.exit' executable

exit:
    mov eax, 1
    mov ebx, 0
    int 0x80