DATAS SEGMENT
    ;�˴��������ݶδ���  
    c1 DB 15;���ѭ������
    c2 DB 16;�ڲ�ѭ������
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;�˴��������δ���
    mov DL,10H
    mov BH,c1
Rorat1:    
    mov BL,c2
    mov CL,DL;����DL
    mov DL,0aH;�������
    mov AH,2
  	INT 21H
  	mov DL,CL
Rorat2:
  	mov AH,2
  	INT 21H
  	INC DL
  	mov CL,DL
  	mov DL,20H;����ո�
    mov AH,2
  	INT 21H
    mov AH,2;����ո�
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
