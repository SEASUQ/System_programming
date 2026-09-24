.intel_syntax noprefix

.section .data

str: .ascii "AMVtdiYVETHnNhuYwnWDVBqL"
len = . - str

.section .text

.global _start

_start:
    # RSI указывает на последний символ строки
    lea rsi, str + len - 1

    # RCX содержит количество символов
    mov rcx, len

print_loop:
    # Вывод одного символа
    mov rax, 1          # syscall write
    mov rdi, 1          # stdout
    mov rdx, 1          # количество байт
    syscall

    # Переходим к предыдущему символу
    dec rsi

    # Повторяем, пока не выведем всю строку
    loop print_loop

    # Завершение программы
    mov rax, 60         # syscall exit
    xor rdi, rdi
    syscall
