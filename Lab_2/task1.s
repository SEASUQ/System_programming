.intel_syntax noprefix

.section .data

str: .ascii "AMVtdiYVETHnNhuYwnWDVBqL"
len = . - str

.section .text

.global _start

_start:
    # RSI указывает на последний символ строки
    lea rsi, str + len - 1

    # R8 = количество символов
    mov r8, len

print_loop:
    # Системный вызов write
    mov rax, 1          # номер системного вызова write
    mov rdi, 1          # stdout
    mov rdx, 1          # количество выводимых байт
    syscall

    # Переходим к предыдущему символу
    dec rsi

    # Уменьшаем счётчик
    dec r8
    jnz print_loop

    # Завершаем программу
    mov rax, 60         # номер системного вызова exit
    xor rdi, rdi        # код возврата 0
    syscall
