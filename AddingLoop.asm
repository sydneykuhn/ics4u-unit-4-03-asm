; --------------------------------------------------------------
; Writes a loop to the console using only system calls.
; Runs on 64-bit x86 Linux only.
; --------------------------------------------------------------

section .bss
     some_number: RESD 1

section .data

    ;  constants here
     done: db 10, "Done.", 10      ; Done
     doneLen: equ $-done           ;  length of string
     newLine: db 10

section .text
    global _start                  ; entry point for linker

    _start:                        ; start here
        mov r8, 48

        LoopIncrement:
            ; reassigns some_number to another value
            mov [some_number], r8
            
            ; prints some_number
            mov rax, 4                 ; system call for write
            mov rdi, 1                 ; file handle 1 is stdout
            mov rcx, some_number       ; address of string to output
            mov rdx, 1                 ; number of bytes
            int 0x80                   ; cal the kernel

            ; prints a newLine
            mov rax, 1
            mov rdi, 1
            mov rsi, newLine
            mov rdx, 1
            syscall

            inc r8
            cmp r8, 57
            jle LoopIncrement

        ; prints "Done."
        mov rax, 1
        mov rdi, 1
        mov rsi, done
        mov rdx, doneLen
        syscall

        mov rax, 60                ; system call for exit 
        mov rdi, 0                 ; exit code 0 
        syscall                    ; invoke operating system to exit 