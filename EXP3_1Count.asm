DATAS SEGMENT 
	MSG1   DB 13,10, 'number: ' , '$'
	MSG2   DB  13,10, 'word: ', '$'
	MSG3   DB 13,10,'others: ' , '$'
    string DB 200 DUP(?)
    numC DB 30H;数字 计数器
    wordC DB 30H;字母计数器
    OthersC DB 30H;其他字符计数器
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
  	MOV DX,offset string
    MOV AH,0AH
    INT 21H
    MOV AH,09H
	SUB CH,CH
    MOV CL,string+1;字符串个数
    LEA DI,string+2;输入的内容存进string
    CALL NUMBER
    CALL WORDS
    CALL OTHERS
    
    MOV DX,OFFSET MSG1;提示数字计数：
    MOV AH,09H
    INT 21H
    MOV DL,NUMC
    MOV AH,02H
    INT 21H
    MOV DX,OFFSET MSG2;提示字母计数：
    MOV AH,09H
    INT 21H
    MOV DL,WORDC
    MOV AH,02H
    INT 21H
    MOV DX,OFFSET MSG3;提示其他字符计数：
    MOV AH,09H
    INT 21H
    MOV DL,OTHERSC
    MOV AH,02H
    INT 21H
    MOV AH,4CH
    INT 21H
    
   
;数字计数  
    NUMBER PROC NEAR
    PUSH DI
COMP1: 
	MOV DX,[DI];暂存DX寄存器
	INC DI
    CMP DX,0DH
    JZ EXIT1
    CMP DX,30H
    JB COMP1;小于0,判断下一个字符
    CMP DX,39H
    JA COMP1  
	INC NUMC;计数器加一
	JMP COMP1
EXIT1:	
	POP DI
    RET 
    NUMBER ENDP
    
;字母计数      
    WORDS PROC NEAR  
    PUSH DI
COMP2: 
	MOV DX,[DI]
	INC DI
    CMP DX,13
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
    
    WORDS ENDP
;其他字符计数    
    OTHERS PROC NEAR
    PUSH DI
COMP3: 
	MOV DX,[DI]
    CMP DX,0DH
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
	
EXIT3:
  	POP DI
    RET 
    OTHERS ENDP

CODES ENDS
    END START








