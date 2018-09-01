include 'EMU8086.INC'       ;su dung thu vien EMU8086
.Model small
.data
.stack 100h

.code
  MAIN proc
    mov ax,@data
    mov ds, ax
    mov es, ax
    
    PRINT "nhap chuoi: "
    mov ah,2h
    int 21h 
    mov cx, 0 ;khoi tao bien dem
 Nhap:
    xor bx,bx ;bx=0
    mov ah,1h      ;ngat chuoi loai 1
    int 21h
    cmp al,13 ;Neu nguoi dung an Enter thi ket thuc nhap
    je B2
    mov bl,al
    push bx      ;dua bx vao stack
    inc cx
    jmp Nhap
 
B2:
    mov ah,1h
    PRINTN
    PRINT "chuoi nguoc la: "

 
    mov ah,2h          ;ngat chuoi loai 2
HienThi:
    pop bx             ;lay bx ra khoi stack
    mov dl,bl
    int 21h
    loop HienThi      
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; thoat.
    int 21h    
ends

endp MAIN