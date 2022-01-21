.MODEL SMALL
.STACK 100H

.DATA
ln DW ?
wd DB ?
a  DB ' $'

.CODE    

MAIN PROC
    mov ax,@data
    mov ds,ax 
    
    ;input for length
    mov ah,1
    int 21h
    sub al,30h
    
    mov bl,1
    mul bl
    mov ln,ax
    
    mov ah,2
    mov dl,0DH
    int 21h
    mov dl,0AH
    int 21h
    
    
    ;input for width
    mov ah,1
    int 21h
    sub al,30H
    
    mov wd,al
    
    mov ah,2
    mov dl,0DH
    int 21h
    mov dl,0AH
    int 21h    
    
    
    mov cx,ln   ;row iterator
                        
    row_itr:
    cmp cx,ln
    je row_print
    cmp cx, 1
    je row_print
    jmp hollow
    
    ;printing the first and last line
    row_print: 
    mov bl,1
    
    row_loop:
    cmp bl,wd
    jg next_row
    mov dl,bl
    add dl,30h
    mov ah,2
    int 21h
    add bl,1
    jmp row_loop:
    
    
    next_row:
    mov ah,2
    mov dl,0DH
    int 21h
    mov dl,0AH
    int 21h
    
    loop row_itr
    jmp exit
    
    ;print the hollow part
    hollow:
    mov bl,1
    
    hollow_loop:
    cmp bl,1
    je num_print
    cmp bl, wd
    je num_print
    cmp bl, wd
    jg next_row
    
    lea dx,a
    mov ah,9
    int 21h
    add bl,1
    
    jmp hollow_loop
    
    num_print:
    mov dl,bl
    add dl,30h
    mov ah,2
    int 21h
    add bl,1
    jmp hollow_loop
    
    
    
exit:

MAIN ENDP

MOV AX, 4C00H
INT 21H

END MAIN


