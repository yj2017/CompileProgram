DATAS SEGMENT
;�˴��������ݶδ��� 
 
DATAS ENDS

STACKS SEGMENT
;�˴������ջ�δ���
STACKS ENDS

;ʵ��AX��������ת��ʮ���������������
CODES SEGMENT
	ASSUME CS:CODES,DS:DATAS,SS:STACKS
	START:
	MOV AX,DATAS
	MOV DS,AX
	;�˴��������δ���
	
	MOV CH,4
	mov cl,4
	MOV BX,1A00H
LABEL1: 
	MOV DL,0FH
	ROL BX,cl
	AND DL,BL
	ADD DL,30H
	CMP DL,3aH
	JL LABEL2
	ADD DL,07H
LABEL2:
	MOV AH,2
	INT 21H
	DEC CH
	JNZ LABEL1 
	
	MOV AH,4CH
	INT 21H
CODES ENDS
END START

