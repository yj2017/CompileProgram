INCLUDE MACROOUT.LIB
DATAS SEGMENT
    ;�˴��������ݶδ��� 
    Error DB 'Input the wrong char',0aH,0dH,'$' 
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
    MOV CH,4;�������
    MOV DH,16;������λ��
    MOV BX,00H;��������
    MOV CL,4;��λλ��
L1:
	MOV AH,1
	INT 21H
	CMP AL,30H
	JB OUTPUTError
    CMP AL,39H
    JBE ChangeNum
    CMP AL,41H
    JB OUTPUTError
    CMP AL,47H
    JBE ChangeWord1
    CMP AL,61H
    JB OUTPUTError
    CMP AL,66H
    JBE ChangeWord2
    JMP OUTPUTError
OUTPUTError:
	LEA DX,Error
	MOV AH,9
	INT 21H
	
ChangeNum:;0~9����
	SUB AL,30H
	SHL BX,CL
	OR BL,AL;����AL��ֵ
	DEC CH;����ѭ������
	JNZ L1
	MOV DL,0DH;�س�
    MOV AH,2
    INT 21H
    MOV DL,0AH;����
    MOV AH,2
    INT 21H
	JMP Print 
ChangeWord1:;��д��ĸ
	SUB AL,37H
	SHL BX,CL
	OR BL,AL;����AL��ֵ
	DEC CH
	JNZ L1
	MOV DL,0DH;�س�
    MOV AH,2
    INT 21H
    MOV DL,0AH;����
    MOV AH,2
    INT 21H
	JMP Print 
ChangeWord2:;Сд��ĸ
    SUB AL,57H
	SHL BX,CL
	OR BL,AL;����AL��ֵ
	DEC CH
	JNZ L1
	MOV DL,0DH;�س�
    MOV AH,2
    INT 21H
    MOV DL,0AH;����
    MOV AH,2
    INT 21H
	JMP Print 
Print:
    SHL BX,1
    JNC Print0
;���1
    MOV DL,'1'
    MOV AH,2
    INT 21H
    DEC DH
    JNZ Print
    MOV AH,4CH
	INT 21H
   
;���0
Print0:
	MOV DL,'0'
	MOV AH,2
	INT 21H
	DEC DH
	JNZ Print
	MOV AH,4CH
	INT 21H
	

CODES ENDS
    END START







