INCLUDE MACROOUT.LIB
DATAS SEGMENT
    ;此处输入数据段代码 
    Error DB 'Input the wrong char',0aH,0dH,'$' 
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
    MOV CH,4;输入个数
    MOV DH,16;二进制位数
    MOV BX,00H;二进制数
    MOV CL,4;移位位数
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
	
ChangeNum:;0~9数字
	SUB AL,30H
	SHL BX,CL
	OR BL,AL;复制AL的值
	DEC CH;输入循环变量
	JNZ L1
	MOV DL,0DH;回车
    MOV AH,2
    INT 21H
    MOV DL,0AH;换行
    MOV AH,2
    INT 21H
	JMP Print 
ChangeWord1:;大写字母
	SUB AL,37H
	SHL BX,CL
	OR BL,AL;复制AL的值
	DEC CH
	JNZ L1
	MOV DL,0DH;回车
    MOV AH,2
    INT 21H
    MOV DL,0AH;换行
    MOV AH,2
    INT 21H
	JMP Print 
ChangeWord2:;小写字母
    SUB AL,57H
	SHL BX,CL
	OR BL,AL;复制AL的值
	DEC CH
	JNZ L1
	MOV DL,0DH;回车
    MOV AH,2
    INT 21H
    MOV DL,0AH;换行
    MOV AH,2
    INT 21H
	JMP Print 
Print:
    SHL BX,1
    JNC Print0
;输出1
    MOV DL,'1'
    MOV AH,2
    INT 21H
    DEC DH
    JNZ Print
    MOV AH,4CH
	INT 21H
   
;输出0
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







