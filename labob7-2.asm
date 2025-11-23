%include 'in_out.asm'

section .data
    msg1 db 'Введите x: ',0h
    msg2 db 'Введите a: ',0h
    msg3 db 'Результат: ',0h

section .bss
    x   resb 10
    a   resb 10
    res resb 10

section .text
    global _start

_start:
    ; ----------------------------
    ; Ввод переменной 'x'
    ; ----------------------------
    mov eax, msg1
    call sprint     
    mov ecx, x
    mov edx, 10
    call sread      
    mov eax, x
    call atoi       
    mov [x], eax    

    ; ----------------------------
    ; Ввод переменной 'a'
    ; ----------------------------
    mov eax, msg2
    call sprint     
    mov ecx, a
    mov edx, 10
    call sread      
    mov eax, a
    call atoi       
    mov [a], eax    

    ; ----------------------------
    ; ПРОВЕРКА УСЛОВИЯ: a = 1 ?
    ; ----------------------------
    mov ecx, [a]    ; Кладем 'a' в регистр
    cmp ecx, 1      ; Сравниваем 'a' с единицей
    je a_is_one     ; Если равно (Jump Equal), прыгаем на метку a_is_one

    ; ----------------------------
    ; Ветка 1: Если a != 1 (Формула: a^2)
    ; ----------------------------
    mov eax, [a]    ; Берем a
    mul eax         ; Умножаем eax на самого себя (a * a)
    mov [res], eax  ; Сохраняем результат
    jmp print_res   ; Прыгаем на вывод

a_is_one:
    ; ----------------------------
    ; Ветка 2: Если a = 1 (Формула: 10 + x)
    ; ----------------------------
    mov eax, [x]    ; Берем x
    add eax, 10     ; Прибавляем 10
    mov [res], eax  ; Сохраняем результат

print_res:
    ; ----------------------------
    ; Вывод результата
    ; ----------------------------
    mov eax, msg3
    call sprint     
    mov eax, [res]
    call iprintLF   
    call quit       
