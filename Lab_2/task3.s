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

    # R8 = количество символов в текущей строке
    mov r8, 1

    # R9 = адрес текущего символа в буфере
    lea r9, buffer

print_row:
    # Выводим нужное количество символов
    mov rax, 1
    mov rdi, 1
    mov rsi, r9
    mov rdx, r8
    syscall

    # Переходим к следующей позиции в буфере
    add r9, r8

    # Выводим перевод строки
    mov rax, 1
    mov rdi, 1
    lea rsi, newline
    mov rdx, 1
    syscall

    # Увеличиваем длину следующей строки
    inc r8

    # Всего должно быть 11 строк
    cmp r8, 12
    jne print_row

    # Завершение программы
    mov rax, 60
    xor rdi, rdi
    syscall
