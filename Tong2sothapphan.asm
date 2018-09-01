

.Model Small
.stack 100h
.data
    m1 db 10,13, "a=$"
    m2 db 10,13,"b=$"
    m3 db 10,13,"ket qua=$"
    m4 db '.5$'
    so dw 0
    a dw 0
    b dw 0
    du dw 0
.code
 Main Proc
    mov ax,data
    mov ds,ax
    
    ; Nhap so thu nhat 
    
    mov ah,9
    lea dx,m1
    int 21h  
    call nhap 
    mov bx,so
    mov a,bx 
    
    ;Nhap so thu 2 
    
    mov ah,9
    lea dx,m2
    int 21h
    call nhap
    mov bx,so
    mov b,bx  
    
    ;Tong 
    
    mov ah,9
    lea dx,m3
    int 21h
    call tong
    call in10
    mov ah,1
    int 21h
    mov ah,4ch
    int 21h
 nhap:  
 ;luu cac gia tri vao stack
    push ax
    push bx
    push cx
    push dx
    
    mov bx,10
    xor cx,cx
    mov si,0 
    
    l1:     
        mov ah,1
        int 21h
        cmp al,13  ;so sanh voi enter 
        je het
        cmp al,8
        jnz so_am   ;neu <0 nhay sang so_am
        and cx,cx
        jz nodiv     ;neu = 1 nhay sang nodiv
        xor dx,dx
        mov ax,cx
        jmp ctro
    nodiv:
        xor si,si
    ctro:
        push cx
        mov cx,1
        mov ah,10
        mov dl,20h
        int 10h
        pop cx
        jmp l1
    so_am:
        cmp al,'-'
        jne nap
        mov si,1
        jmp l1
    nap:
        cmp al,'0'
        jl l1
        cmp al,'9'
        jg l1
        and al,0fh
        xor ah,ah
        xchg ax,cx ;trao doi noi dung cua ax voi cx
        mul bx
        add cx,ax
        jmp l1
    het:
        and si,si
        jz soduong
        neg cx
    soduong:
        mov so,cx 
        
        ;lay ra khoi stack
        
        pop dx    
        pop cx
        pop bx
        pop ax
        ret
        jmp nhap
 tong:
    push ax
    push bx
    push cx
    push dx 
    mov ax,a
    mov bx,b
    add ax,bx  ;cong ax voi bx
    mov so,ax
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    jmp tong
 in10:
    push ax
    push bx
    push cx
    push dx
    mov ax,so
    xor cx,cx
    mov bx,10
    cmp ax,0
    jge duong
    push ax
    mov al,'-'
    mov ah,14
    int 10h
    pop ax
    neg ax
    duong:
        xor dx,dx
        div bx
        push dx
        inc cx
        cmp ax,0
        jnz duong
   
        mov ah,2   
        
     ;in ra    
     
    inra:
        pop dx
        or dl,30h
        int 21h
        loop inra
        pop dx
        pop cx
        pop bx
        pop ax
        ret
        jmp in10
 code ends
 end Main