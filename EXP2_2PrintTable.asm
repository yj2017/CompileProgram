DATAS SEGMENT
    ;此处输入数据段代码  
    c1 DB 15;外层循环变量
    c2 DB 16;内层循环变量
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
    mov DL,10H
    mov BH,c1
Rorat1:    
    mov BL,c2
    mov CL,DL;保存DL
    mov DL,0aH;输出换行
    mov AH,2
  	INT 21H
  	mov DL,CL
Rorat2:
  	mov AH,2
  	INT 21H
  	INC DL
  	mov CL,DL
  	mov DL,20H;输出空格
    mov AH,2
  	INT 21H
    mov AH,2;输出空格
  	INT 21H
  	mov DL,CL
  	dec BL
  	JNZ Rorat2
  	DEC BH
  	JNZ Rorat1
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
