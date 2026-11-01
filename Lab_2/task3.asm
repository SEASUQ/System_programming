format ELF64

public _start
public exit
public print_symbl

section '.data' writable
    symbol db '-'
    place db ?

section '.text' executable

_start:
    mov rcx, 1
    mov rbx, 1

.row:
    mov rdx, rbx

.print:
    mov al, [symbol]
    call print_symbl
    dec rdx
    cmp rdx, 0
    jne .print

    mov rax, 0xA
    call print_symbl

    inc rbx
    cmp rbx, 12
    jne .row

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