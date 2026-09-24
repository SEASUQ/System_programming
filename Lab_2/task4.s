.intel_syntax noprefix

.section .data

number: .quad 5277616985
message: .ascii "Sum = "
message_len = . - message
newline: .byte 10

.section .bss

buffer: .skip 32

.section .text

.global _start

_start:
    # Загружаем исходное число в RAX
    mov rax, qword ptr [number]

    # RBX будет хранить сумму цифр
    xor rbx, rbx

    # Делитель = 10
    mov r8, 10

sum_loop:
    # Деление числа на 10
    # RAX = частное
    # RDX = остаток (последняя цифра)
    xor rdx, rdx
    div r8

    # Добавляем последнюю цифру к сумме
    add rbx, rdx

    # Проверяем, осталось ли что-нибудь
    test rax, rax
    jnz sum_loop

    # Выводим "Sum = "
    mov rax, 1
    mov rdi, 1
    lea rsi, message
    mov rdx, message_len
    syscall

    # Переводим сумму из числа в символ
    mov rax, rbx
    lea rsi, buffer + 32
    mov rcx, 10
    xor r9, r9

convert_loop:
    xor rdx, rdx
    div rcx

    # Превращаем цифру в ASCII
    add dl, '0'

    # Записываем цифру справа налево
    dec rsi
    mov byte ptr [rsi], dl

    inc r9

    test rax, rax
    jnz convert_loop

    # Выводим получившееся число
    mov rax, 1
    mov rdi, 1
    mov rdx, r9
    syscall

    # Перевод строки
    mov rax, 1
    mov rdi, 1
    lea rsi, newline
    mov rdx, 1
    syscall

    # Завершение программы
    mov rax, 60
    xor rdi, rdi
    syscall
