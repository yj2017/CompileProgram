DATAS SEGMENT 
	MSG1   DB  13, 10, 'Number: ', 13, 10, 13, 10, '$'  
	MSG2   DB  13, 10, 'Number: ', 13, 10, 13, 10, '$' 
	MSG3   DB  13, 10, 'Number: ', 13, 10, 13, 10, '$' 
    string DB 200 DUP(?)
    numC DW 0;数字 计数器
    wordC DW 0;字母计数器
    OthersC DW 0;其他字符计数器
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    LEA DI, string

    MAIN PROC FAR;MAIN主子程序
    PUSH DI;保存参数值
 INPUT:
    MOV AH,01
    INT 21H
    MOV [DI],AL;输入的内容存进string
    INC DI
    CMP BX,0DH
    JNZ INPUT;继续输入
    ;输入为回车，计算
    CALL NUMBER
    CALL WORD
    CALL OTHERS
    MOV DL,MSG1;提示数字计数：
    MOV AH,02
    INT 21H
    MOV DL,NUMC
    MOV AH,02
    INT 21H
    MOV DL,MSG2;提示字母计数：
    MOV AH,02
    INT 21H
    MOV DL,WORDC
    MOV AH,02
    INT 21H
    MOV DL,MSG3;提示其他字符计数：
    MOV AH,02
    INT 21H
    MOV DL,OTHERSC
    MOV AH,02
    INT 21H
    POP DI
    RET
    MAIN ENDP
;数字计数  
    NUMBER PROC NEAR
    PUSH DI
COMP1: 
	MOV DX,[DI];暂存DX寄存器
	INC DI;
    CMP DX,ODH
    JZ EXIT1
    CMP DX,30H
    JB COMP;小于0,判断下一个字符
    CMP DX,39H
    JA COMP  
	INC NUMC;计数器加一
	JMP COMP
EXIT1：	
	POP DI
    RET 
    NUMBER ENDP
;字母计数      
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
;其他字符计数    
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
	
EXIT3：	
    RET 
    POP DI
    OTHERS ENDP
;结束
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START



