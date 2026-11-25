
format ELF64 executable 3
entry start

segment readable writeable
a rq 1
b rq 1
c rq 1
buffer rb 32

segment readable executable

start:
    mov rax, [rsp]
    cmp rax, 4
    jne error

    ; Получаем a
    mov rsi, [rsp+16]
    call parse_number
    cmp rax, -1
    je error
    mov [a], rax

    ; Получаем b
    mov rsi, [rsp+24]
    call parse_number
    cmp rax, -1
    je error
    mov [b], rax

    ; Получаем c
    mov rsi, [rsp+32]
    call parse_number
    cmp rax, -1
    je error
    mov [c], rax

    ; Проверяем деление на ноль
    cmp qword [a], 0
    je error

    ; Вычисляем (b * a)
    mov rax, [b]
    imul rax, [a]

    ; Делим на a
    xor rdx, rdx
    div qword [a]

    ; Умножаем на b
    imul rax, [b]

    ; Умножаем на c
    imul rax, [c]

    ; Выводим результат
    call print_number

    mov rax, 60
    xor rdi, rdi
    syscall

; Преобразование строки в число
parse_number:
    xor rax, rax

parse_loop:
    movzx rdx, byte [rsi]
    test dl, dl
    jz parse_done

    cmp dl, '0'
    jb parse_error
    cmp dl, '9'
    ja parse_error

    imul rax, 10
    sub dl, '0'
    add rax, rdx

    inc rsi
    jmp parse_loop

parse_done:
    ret

parse_error:
    mov rax, -1
    ret

; Вывод числа на экран
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

error:
    mov rax, 60
    mov rdi, 1
    syscall
