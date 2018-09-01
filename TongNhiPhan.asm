include 'EMU8086.INC'                ;su dung thu vien EMU8086.INC
.MODEL SMALL
.STACK 100h
.DATA   
   i DB 8        
   j DB 8
   k DB 16
   s DW ?

.CODE   
     MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        PRINT "Nhap so A =  "
        
        XOR BX,BX                 ;dat gia tri ban dau cua BX = 0
        XOR CX,CX                 ;dat gia tri ban dau cua CX = 0

        
       B0:
        MOV AH,1             
        INT 21h
        
        B1:                  
            CMP AL,0DH          ;So sanh voi enter
            JE B2
            
            cmp al,49
            jg thoat
            cmp al,47
            jl  thoat
            AND AL,0FH          
            SHL BL,1             ;dich sang trai 1 dv
            OR  BL,AL            ;luu tru gia tri trong thanh ghi 'BL'
            
            INT 21h
            JMP B1
      
      B2:        
      
      PRINTN
      PRINT "Nhap so B = "
        
         B3:                    

            MOV AH,1
            INT 21h
            CMP AL,0DH
            JE Tong
            
            cmp al,49
            jg thoat
            cmp al,47
            jl  thoat
            AND AL,0FH
            SHL CL,1
            OR  CL,AL
            
            JMP B3    
      thoat:
        mov ah,1
        PRINTN
        PRINT " Chi nhap 0 va 1!!! "
        int 21h
        jmp B0  
      Tong:         
      
      ADD s,BX    ;them bx voi s va giu no trong s
      ADD s,CX    ;them cx voi s va giu no trong s

     OUTPUT:
     PRINTN
     PRINT "KQ A+B = "
     Hienthi:               
           CMP k,0
           JE EXIT
           
           SHL s,1
           JC R1
           JNC R0
      R1:              
         MOV DL,'1'
         MOV AH,2
         INT 21h
         SUB k,1
         JMP Hienthi
      R0:               
         MOV DL,'0'
         MOV AH,2
         INT 21h
         SUB k,1
         JMP Hienthi
     EXIT:           ;ket thuc
        MAIN ENDP 
         
       
  END MAIN