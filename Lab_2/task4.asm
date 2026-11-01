format ELF64

public _start
public exit
public print_symbl

section '.data' writable
    number dq 3618218374
    place db ?

section '.text' executable

_start:
    mov rax, [number]
    xor r8, r8
    mov rbx, 10

.sum:
    xor rdx, rdx
    div rbx
    add r8, rdx
    cmp rax, 0
    jne .sum

    mov rax, r8
    xor rdx, rdx
    div rbx

    add al, '0'
    mov r9b, dl
    call print_symbl

    mov al, r9b
    add al, '0'
    call print_symbl

    mov rax, 0xA
    call print_symbl

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