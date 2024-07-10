section .data
    askNameMsg db 'What is your first name? ', 0
    askAgeMsg db 'What is your age? ', 0
    askGradYearMsg db 'When will you graduate? ', 0
    outputMsg db 'Hi %s, when you graduate, your age will be %d', 10, 0
    nameFormat db '%s', 0    ; Format string for reading the name
    intFormat db '%d', 0     ; Integer format string for reading age and graduation year
    currentYear dd 2023      ; Current year

section .bss
    nameSpace resb 100       ; Reserve 100 bytes for the name
    age resd 1
    gradYear resd 1
    futureAge resd 1

section .text
    extern printf, scanf
    global main

main:
    ; Ask and read the first name
    push askNameMsg
    call printf
    add esp, 4
    lea eax, [nameSpace]
    push eax
    lea eax, [nameFormat]
    push eax
    call scanf
    add esp, 8

    ; Ask and read the age
    push askAgeMsg
    call printf
    add esp, 4
    push age
    lea eax, [intFormat]
    push eax
    call scanf
    add esp, 8

    ; Ask and read the graduation year
    push askGradYearMsg
    call printf
    add esp, 4
    push gradYear
    lea eax, [intFormat]
    push eax
    call scanf
    add esp, 8

    ; Calculate future age
    mov eax, [gradYear]
    sub eax, [currentYear]
    add eax, dword [age]
    mov [futureAge], eax

    ; Output the final message
    push dword [futureAge]
    push nameSpace
    push outputMsg
    call printf
    add esp, 12

    ; Exit program
    mov esp, ebp
    pop ebp
    ret
