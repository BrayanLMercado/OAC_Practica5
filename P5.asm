section .data ; Datos inicializados (constantes)
NL: db 13, 10
NL_L: equ $-NL
section .bss ; Datos no inicializados (variables)
N resb 4
M resb 4
cad resb 16
array resb 256 ;Inciso E crear una variable llamada array
section .text

global _start:
_start: mov eax,0C2966271h
    mov esi, cad
    call printHex
    call salto_linea

    ;Inciso A1 guardar la Matricula en M con dir Inmediato
    mov ebx, M 
    mov dWord [ebx],1280838h
    mov eax, [ebx]
    call printHex
    call salto_linea

    ;Inciso A2 Guardar ACF2359A en ebx como bin
    mov ebx,1010110011110010001101011010B
    mov eax,ebx
    call printHex
    call salto_linea

    mov cx,bx     ;Inciso B pasar bx a cx
    mov ax,cx
    call printHex
    call salto_linea

    ;Inciso C guardar en M un 524h por medio de dir. Indirecto
    mov ebx, M
    mov dWord [ebx],524h
    mov eax,[ebx]
    call printHex
    call salto_linea

    mov ebx,M  ;Inciso D guardar M en ebx
    mov eax,[ebx]
    call printHex
    call salto_linea

    ;Inciso f: cargar en array los sig. valores de 32
    ; bits: 0,1,2,3,4

    mov edx,array
    mov dWord [edx],0h
    mov eax,[edx]
    call printHex
    call salto_linea
    mov dWord [edx+32],1h
    mov eax,[edx+32]
    call printHex
    call salto_linea
    mov dWord [edx+32],2h
    mov eax,[edx+32]
    call printHex
    call salto_linea
    mov dWord [edx+32],3h
    mov eax,[edx+32]
    call printHex
    call salto_linea
    mov dWord [edx+32],4h
    mov eax,[edx+32]
    call printHex
    call salto_linea

    mov eax, 1
    mov ebx,0
    int 80h

; Subrutina  

printHex:
    pushad
    mov edx, eax
    mov ebx, 0fh
    mov cl, 28
    .nxt: shr eax,cl
    .msk: and eax,ebx
    cmp al, 9
    jbe .menor
    add al,7
    .menor:add al,'0'
    mov byte [esi],al
    inc esi
    mov eax, edx
    cmp cl, 0
    je .print
    sub cl, 4
    cmp cl, 0
    ja .nxt
    je .msk
    .print: mov eax, 4
    mov ebx, 1
    sub esi, 8
    mov ecx, esi
    mov edx, 8
    int 80h
    popad
    ret

salto_linea:
    pushad
    mov eax,4
    mov ebx,1
    mov ecx, NL
    mov edx, NL_L
    int 80h
    popad
    ret