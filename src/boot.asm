;* === === === NASM STUFF === === ===
[ORG 0]
[BITS 16]

;* === === === START === === ===
_start:
    mov ax, 0x7c0
    mov ds, ax
    mov ss, ax
    mov es, ax

    mov si, msg1
    call println
    mov si, msg2
    call println
    mov si, msg3
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
msg1: db 'Hello, World!', 0
msg2: db 'This is a TEST!', 0
msg3: db 'It works!!!', 0



;* === === === BOOTSIGNATURE === === ===
times 510 - ($-$$) db 0
dw 0xAA55