%include 'in_out.asm'

section .data
    msg2 db "Наименьшее число: ",0h
    A db '83',0
    B db '73',0
    C db '30',0

section .bss
    min resb 10

section .text
    global _start

_start:
    ; 1. Берем число 'A' и пока считаем его минимумом
    mov eax, A
    call atoi      	; Переводим строку '83' в число
    mov [min], eax 	; Записываем его в переменную min
    ; 2. Сравниваем 'B' с текущим минимумом
    mov eax, B
    call atoi 		; Переводим строку '73' в число
    
    mov ecx, [min] 	; В ecx лежит текущий минимум (83)
    cmp eax, ecx 	; Сравниваем B (eax) и min (ecx)

    jge check_C 	; Если B >= min, то ничего не меняем и прыгаем к проверке C
    			; (jge = Jump if Greater or Equal)

    mov [min], eax 	; Иначе (если B < min), обновляем минимум

check_C:
    ; 3. Сравниваем 'C' с текущим минимумом
    mov eax, C
    call atoi ; Переводим строку '30' в число

    mov ecx, [min] ; В ecx лежит текущий минимум
    cmp eax, ecx ; Сравниваем C и min

    jge fin ; Если C >= min, прыгаем на выход
    mov [min], eax ; Иначе обновляем минимум

fin:
    ; Вывод результата
    mov eax, msg2
    call sprint 	; Печатаем текст "Наименьшее число: "

    mov eax, [min]
    call iprintLF 	; Печатаем само число (должно быть 83)

    call quit 		; Выход

