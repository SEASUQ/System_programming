format ELF64

public _start
public exit
public print_symbl

section '.data' writable
    S db 'sJlJvpnqbTsHMRLDgPqJFpEblchrAjtUKcK'
    place db ?

section '.text' executable

_start:
    mov rcx, 35

.iter:
    dec rcx
    mov al, [S+rcx]
    call print_symbl
    cmp rcx, 0
    jne .iter

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
