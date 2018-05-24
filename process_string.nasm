        global      correct_string 
        extern      printf

        section     .data
format: db "%p:%c al:%c", 10, 0
format2:db "%s", 0
format3:db "Write in %p: %c ",10, 0
resmsg: db "Result:", 10, 0

        section     .bss
str_beg:resq 1                  ;store addr of string

        section     .text
correct_string:

        ;delete duplicate characters:
        ;from:  dellllette dupppliccate    cccharaccterss
        ;to:    delete duplicate characters

        ;save using registers
        ;3 registers pushed, stack aligment is fine
        push rdi
        push rsi
        push rax
        ;C sends parametr to asm using rdi, so it already contains addr of str
        mov [str_beg], rdi
        mov rsi, rdi            ;rsi used to rewrite string
        xor al, al              ;al stores previous symb [rdi-1]
        cld
cycle:               
        scasb                   ;rdi automaticly increments after scasb
        mov al, [rdi-1]
        je exept                ;jump if two same symbols

        push rdi
        push rsi
        push rax
        sub rsp, 8
        mov rdx, rax
        mov rdi, format3
        call printf
        add rsp, 8
        pop rax
        pop rsi
        pop rdi

        mov [rsi], al           ;write to string if symbols are different
        inc rsi
exept:  
        cmp al, 0
        je cont                 ;end of cycle

        ;parametrs send to printf through registers in order:
        ;rdi - first argument (format), rsi - second, rdx - 3, rcx - 4 

        push rsi
        push rdi
        push rax                ;we have to save this register, because printf destroys it
        sub rsp, 8              ;stack aligment
        mov cl, al
        mov rdx, [rdi]
        mov rsi, rdi
        mov rdi, format
        call printf
        add rsp, 8
        pop rax
        pop rdi
        pop rsi

        jmp cycle     
cont: 
        xor al, al
        mov [rsi], al           ;C string must ends with 0

        push rdi
        sub rsp, 8
        mov rdi, resmsg
        call printf
        add rsp, 8
        pop rdi

        push rdi
        push rsi
        mov rsi, [str_beg]
        mov rdi, format2
        call printf
        pop rsi
        pop rdi
        
        pop rax
        pop rsi
        pop rdi
