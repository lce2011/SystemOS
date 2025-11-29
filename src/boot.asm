;* === === === NASM STUFF === === ===
[ORG 0]
[BITS 16]

;* === === === START === === ===
_start:
    mov ax, 0x7c0
    mov ds, ax
    mov ss, ax
    mov es, ax

    mov si, boot_msg
    call println

    ; offset 50
    ; 0x7c0 * 16 = 0x7c00 + 50d

    jmp $

;* === === === IO === === ===

;* === === PRINT === ===
print:
.con:
    lodsb   ; DS * 16 + SI
    cmp al, 0
    je .done
    mov ah, 0eh
    int 0x10
    jmp .con

.done:
    ret

;* === === PRINTLN === ===
println:
.con:
    lodsb   ; DS * 16 + SI
    cmp al, 0
    je .done
    mov ah, 0eh
    int 0x10
    jmp .con

.done:
    call newline
    ret

;* === === NEWLINE === ===
newline:
    nl: db 13, 10, 0
    mov si, nl
    call print
    ret

;* === === === DATA === === ===
boot_msg: db 'Booting SystemOS...', 13, 10, \
             'Starting SystemOS...', 13, 10, \
             'Hello, World!', 0

;* === === === BOOTSIGNATURE === === ===
times 510 - ($-$$) db 0
dw 0xAA55