DATAS SEGMENT
    ;�˴��������ݶδ���  
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
    MOV  CX, 0404H
	 MOV  BX, 0
L1:  MOV  AH, 01H
	 INT     21H
	 SUB   AL, 30H 
     CMP  AL, 0AH
     JL      L2
	SUB  AL,  07H
   L2:  SHL  BX,  CL
	 OR   BL,   CL
	 mov DL,BL
	 INT 21H
	 DEC  CH
	 JNZ   L1
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
