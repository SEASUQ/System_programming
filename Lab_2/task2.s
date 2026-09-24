.intel_syntax noprefix

.section .data

symbol: .byte '+'
newline: .byte 10

.section .bss

buffer: .skip 66

.section .text

.global _start

_start:
    # Заполняем буфер 66 символами '+'
    lea rdi, buffer
    mov rcx, 66
    mov al, byte ptr [symbol]

fill_buffer:
    mov byte ptr [rdi], al
    inc rdi
    loop fill_buffer

    # R8 = количество строк
    mov r8, 11

    # R9 = адрес текущей строки
    lea r9, buffer

print_row:
    # Выводим 6 символов
    mov rax, 1
    mov rdi, 1
    mov rsi, r9
    mov rdx, 6
    syscall

    # Переходим к следующей строке
    add r9, 6

    # Выводим перевод строки
    mov rax, 1
    mov rdi, 1
    lea rsi, newline
    mov rdx, 1
    syscall

    # Следующая строка
    dec r8
    jnz print_row

    # Завершение программы
    mov rax, 60
    xor rdi, rdi
    syscall
