DATAS SEGMENT 
	MSG1   DB  13, 10, 'Number: ', 13, 10, 13, 10, '$'  
	MSG2   DB  13, 10, 'Number: ', 13, 10, 13, 10, '$' 
	MSG3   DB  13, 10, 'Number: ', 13, 10, 13, 10, '$' 
    string DB 200 DUP(?)
    numC DW 0;���� ������
    wordC DW 0;��ĸ������
    OthersC DW 0;�����ַ�������
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    LEA DI, string

    MAIN PROC FAR;MAIN���ӳ���
    PUSH DI;�������ֵ
 INPUT:
    MOV AH,01
    INT 21H
    MOV [DI],AL;��������ݴ��string
    INC DI
    CMP BX,0DH
    JNZ INPUT;��������
    ;����Ϊ�س�������
    CALL NUMBER
    CALL WORD
    CALL OTHERS
    MOV DL,MSG1;��ʾ���ּ�����
    MOV AH,02
    INT 21H
    MOV DL,NUMC
    MOV AH,02
    INT 21H
    MOV DL,MSG2;��ʾ��ĸ������
    MOV AH,02
    INT 21H
    MOV DL,WORDC
    MOV AH,02
    INT 21H
    MOV DL,MSG3;��ʾ�����ַ�������
    MOV AH,02
    INT 21H
    MOV DL,OTHERSC
    MOV AH,02
    INT 21H
    POP DI
    RET
    MAIN ENDP
;���ּ���  
    NUMBER PROC NEAR
    PUSH DI
COMP1: 
	MOV DX,[DI];�ݴ�DX�Ĵ���
	INC DI;
    CMP DX,ODH
    JZ EXIT1
    CMP DX,30H
    JB COMP;С��0,�ж���һ���ַ�
    CMP DX,39H
    JA COMP  
	INC NUMC;��������һ
	JMP COMP
EXIT1��	
	POP DI
    RET 
    NUMBER ENDP
;��ĸ����      
    WORD PROC NEAR  
    PUSH DI
COMP2: 
	MOV DX,[DI]
	INC,DI
    CMP DX,ODH
    JZ EXIT2
    CMP DX,41h
    JB COMP2
    CMP DX,5AH
    JBE COUNT
    CMP DX,61h
    JB COMP2
    CMP DX,7ah
    JA COMP2
COUNT:  
	INC WORDC
	JMP COMP2
EXIT2:
	POP DI
    RET 
    WORD ENDP
;�����ַ�����    
    OTHERS PROC NEAR
    PUSH DI
COMP3: 
	MOV DX,[DI]
    CMP DX,ODH
    JZ EXIT3
    CMP DX,30H
    JB COUNTothers
    CMP DX,39H
    JBE COMP3
	CMP  DX,41H
	JB COUNTothers
	CMP DX,5AH
	JBE COMP3
	CMP DX,61H
    JB COUNTothers
    CMP DX,7A
    JBE COMP3
COUNTothers:
	INC OTHERSC
	JMP COMP3
	
EXIT3��	
    RET 
    POP DI
    OTHERS ENDP
;����
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START



