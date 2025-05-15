; main.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 15/03/2018

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------

; -------------------------------------------------------------------------------
; �rea de Dados - Declara��es de vari�veis
		AREA  DATA, ALIGN=2
		; Se alguma vari�vel for chamada em outro arquivo
		;EXPORT  <var> [DATA,SIZE=<tam>]   ; Permite chamar a vari�vel <var> a
		                                   ; partir de outro arquivo
;<var>	SPACE <tam>                        ; Declara uma vari�vel de nome <var>
                                           ; de <tam> bytes a partir da primeira
                                           ; posi��o da RAM

; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo
        EXPORT Start                ; Permite chamar a fun��o Start a partir de
			                        ; outro arquivo. No caso startup.s

		; Se chamar alguma fun��o externa
        ;IMPORT <func>              ; Permite chamar dentro deste arquivo uma
									; fun��o <func>
		IMPORT  PLL_Init
		IMPORT  SysTick_Init
		IMPORT  SysTick_Wait1ms
		IMPORT  GPIO_Init
		IMPORT  SEG_WRITE
		IMPORT 	GPIO_PORTK_DATA_R
		IMPORT 	GPIO_PORTM_DATA_R
		EXPORT 	Modo
		EXPORT 	AtualizaPasso
		EXPORT  escrevedisplay

; -------------------------------------------------------------------------------
; Fun��o main()
Start
	BL PLL_Init                  ;Chama a subrotina para alterar o clock do microcontrolador para 80MHz
	BL SysTick_Init              ;Chama a subrotina para inicializar o SysTick
	BL GPIO_Init                 ;Chama a subrotina que inicializa os GPIO
	MOV R0, #0 ; Contador
	MOV R9, #1 ; Passo
	MOV R10, #0 ; Modo (crescente[0] ou decrescente[1])
	MOV R11, #-1

	;DISPLAY
	LDR     R1, =GPIO_PORTK_DATA_R     ; R1 <- endere�o da porta K (dados)
	LDR     R2, =GPIO_PORTM_DATA_R     ; R2 <- endere�o da porta M (controle)

	MOV     R3, #2_11111000     ; valor de controle (RS=0, RW=0,o)
	STR     R3, [R2]            ; escreve em GPIO_PORTM_DATA_R

	MOV     R3, #0x38           ; comando para
	STR     R3, [R1]            ; escreve em GPIO_PORTK_DATA_R

	MOV     R3, #2_11111100     ; E = 1 (liga o pulso)
	STR     R3, [R2]            ; escreve em GPIO_PORTM_DATA_R

	MOV     R0, #2
	BL SysTick_Wait1ms          ; pequeno delay

	MOV     R3, #2_11110000     ; todos os sinais de controle em 0
	STR     R3, [R2]            ; escreve em GPIO_PORTM_DATA_R

	MOV     R3, #0x06           ; caractere a ser escrito (ASCII de 'p')
	STR     R3, [R1]            ; escreve dado em GPIO_PORTK_DATA_R

	MOV     R3, #2_11110100     ; E = 1 (liga o pulso)
	STR     R3, [R2]            ; escreve em GPIO_PORTM_DATA_R

	MOV     R0, #2
	BL SysTick_Wait1ms          ; pequeno delay

	MOV     R3, #2_11110000     ; todos os sinais de controle em 0
	STR     R3, [R2]            ; escreve em GPIO_PORTM_DATA_R

	MOV     R3, #0x0E           ; caractere a ser escrito (ASCII de 'p')
	STR     R3, [R1]            ; escreve dado em GPIO_PORTK_DATA_R

	MOV     R3, #2_11110100     ; E = 1 (liga o pulso)
	STR     R3, [R2]            ; escreve em GPIO_PORTM_DATA_R

	MOV     R0, #2
	BL SysTick_Wait1ms          ; pequeno delay

	MOV     R3, #2_11110000     ; todos os sinais de controle em 0
	STR     R3, [R2]            ; escreve em GPIO_PORTM_DATA_R

	MOV     R3, #0x01           ; caractere a ser escrito (ASCII de 'p')
	STR     R3, [R1]            ; escreve dado em GPIO_PORTK_DATA_R

	MOV     R3, #2_11110100     ; E = 1 (liga o pulso)
	STR     R3, [R2]            ; escreve em GPIO_PORTM_DATA_R

	MOV     R0, #2
	BL SysTick_Wait1ms			; pequeno delay

	MOV     R3, #2_11110001	 	; todos os sinais de controle em 0
	STR     R3, [R2]			; escreve em GPIO_PORTM_DATA_R

	MOV     R3, #70				; caractere a ser escrito (ASCII de 'p')
	STR     R3, [R1]			; escreve dado em GPIO_PORTK_DATA_R

	MOV     R3, #2_11110101		; E = 1 (liga o pulso)
	STR     R3, [R2]			; escreve em GPIO_PORTM_DATA_R

	MOV     R0, #2
	BL SysTick_Wait1ms			; pequeno delay

	MOV     R3, #2_11110000		; todos os sinais de controle em 0
	STR     R3, [R2]			; escreve em GPIO_PORTM_DATA_R

	LDR     R0, =0x20004000     ; endere�o base

	MOV     R1, #0x64           ; valor ASCII 'D'

	STR     R1, [R0]            ; escreve R1 no endere�o [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

	MOV     R1, #0x65           ; valor ASCII 'E'

	STR     R1, [R0]            ; escreve R1 no endere�o [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

	MOV     R1, #0x63           ; valor ASCII 'C'

	STR     R1, [R0]            ; escreve R1 no endere�o [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

	MOV     R1, #0x72           ; valor ASCII 'R'

	STR     R1, [R0]            ; escreve R1 no endere�o [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

	MOV     R1, #0x65           ; valor ASCII 'E'

	STR     R1, [R0]            ; escreve R1 no endere�o [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

	MOV     R1, #0x73           ; valor ASCII 'S'

	STR     R1, [R0]            ; escreve R1 no endere�o [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

	MOV     R1, #0x63           ; valor ASCII 'C'

	STR     R1, [R0]            ; escreve R1 no endere�o [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

	MOV     R1, #0x65           ; valor ASCII 'E'

	STR     R1, [R0]            ; escreve R1 no endere�o [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

	MOV     R1, #0x6E           ; valor ASCII 'N'

	STR     R1, [R0]            ; escreve R1 no endere�o [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

	MOV     R1, #0x74           ; valor ASCII 'T'

	STR     R1, [R0]            ; escreve R1 no endere�o [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

	MOV     R1, #0x65           ; valor ASCII 'E'

	STR     R1, [R0]            ; escreve R1 no endere�o [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

	MOV     R1, #80        	    ; valor ASCII 'P'

	STR     R1, [R0]            ; escreve R1 no endere�o [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

	MOV     R1, #65             ; valor ASCII 'A'

	STR     R1, [R0]            ; escreve R1 no endere�o [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

	MOV     R1, #83             ; valor ASCII 'S'

	STR     R1, [R0]            ; escreve R1 no endere�o [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

	MOV     R1, #83             ; valor ASCII 'S'

	STR     R1, [R0]            ; escreve R1 no endere�o [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

	MOV     R1, #79             ; valor ASCII 'O'

	STR     R1, [R0]            ; escreve R1 no endereço [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

	MOV     R1, #58             ; valor ASCII ':'

	STR     R1, [R0]            ; escreve R1 no enderço [R0]
	ADD     R0, R0, #4          ; incrementa R0 em 4 bytes
	BL escrevedisplay

AtualizaContadorCresc
	ADD R3, R0, R9 ; R0 é o contador R9 é o passo
	CMP R3, #99 ; Checa se a soma (contador + passo) vai ultrapassar o limite
	ITE GT ; Se for maior que 99
	MOVGT R0, #0 ; Zera o contador
	ADDLE R0, R0, R9 ; Se for menor ou igual, soma o passo ao contador
	BL SEG_WRITE ; Escreve o valor do contador no display
	CMP R10, #0 ; Checa se o modo é crescente
	BEQ AtualizaContadorCresc ; Se for crescente, atualiza o contador de forma crescente
	BNE AtualizaContadorDecresc ; Se for decrescente, atualiza o contador de forma decrescente
AtualizaContadorDecresc
	ADD R3, R0, R9
	CMP R3, #0
	ITE LT
	MOVLT R0, #99
	ADDGE R0, R0, R9
	BL SEG_WRITE
	CMP R10, #1 ; Checa se o modo é decrescente
	BEQ AtualizaContadorDecresc
	BNE AtualizaContadorCresc
AtualizaPasso
	PUSH {LR}

	CMP R9, #1 ;
	ITE GE
	ADDGE R9, R9, #1
	SUBLT R9, R9, #1

	CMP R9, #10
	ITE EQ
	MOVEQ R9, #1
	ADDNE R9, R9, #0

	CMP R9, #-10
	ITE EQ
	MOVEQ R9, #-1
	ADDNE R9, R9, #0

	POP {LR}
	BX LR
Modo
	PUSH {LR}
	CMP R10, #0 ; Checa se o modo é crescente
	ITE EQ ; Se for igual a 0
	MOVEQ R10, #1 ; Modo decrescente
	MOVNE R10, #0 ; Modo crescente
	MUL R9, R9, R11 ; Multiplica o passo pelo sinal do modo
	POP {LR}
	BX LR							;Volta para o laço principal

limpadisplay
	PUSH {LR, R0, R1, R2, R3}
	LDR     R1, =GPIO_PORTK_DATA_R     ; R1 <- endere�o da porta K (dados)

	LDR     R2, =GPIO_PORTM_DATA_R     ; R2 <- endere�o da porta M (controle)
    MOV     R3, #2_11111000            ; valor de controle (RS=0, RW=0,o)
    STR     R3, [R2]                   ; escreve em GPIO_PORTM_DATA_R

    MOV     R3, #0x01                  ; comando para
    STR     R3, [R1]                   ; escreve em GPIO_PORTK_DATA_R

    MOV     R3, #2_11111100            ; E = 1 (liga o pulso)
    STR     R3, [R2]                   ; escreve em GPIO_PORTM_DATA_R

    MOV     R0, #2
    BL SysTick_Wait1ms               ; pequeno delay

    MOV     R3, #2_11110000            ; todos os sinais de controle em 0
    STR     R3, [R2]                   ; escreve em GPIO_PORTM_DATA_R

	POP {LR, R0, R1, R2, R3}
    BX LR

escrevedisplay
    PUSH{LR, R0,R1,R2,R3,R4,R5,R6}

    BL limpadisplay

    LDR     R4, =GPIO_PORTK_DATA_R     ; R4 <- endere�o da porta K (dados)
	LDR 	R5, =GPIO_PORTM_DATA_R     ; R5 <- endere�o da porta M (controle)

    LDR		R1, =0x20004044                ; 2D 2E 2F 30 31 32  aqui

	LDR		R0, =0x2000402C

escreverpasso
	LDR     R6, [R0]

    MOV     R3, #2_11110001            ; todos os sinais de controle em 0
    STR     R3, [R5]                   ; escreve em GPIO_PORTM_DATA_R

	MOV     R3, R6                  ; caractere a ser escrito (ASCII de 'p')
    STR     R3, [R4]                   ; escreve dado em GPIO_PORTK_DATA_R

	MOV     R3, #2_11110101            ; E = 1 (liga o pulso)
    STR     R3, [R5]                   ; escreve em GPIO_PORTM_DATA_R

	PUSH{R0}
	MOV     R0, #2
    BL SysTick_Wait1ms               ; pequeno delay
	POP{R0}

	MOV     R3, #2_11110000            ; todos os sinais de controle em 0
    STR     R3, [R5]                   ; escreve em GPIO_PORTM_DATA_R

    ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

    CMP R0, R1
    BLT escreverpasso


    MOV     R3, #2_11110001            ; todos os sinais de controle em 0
    STR     R3, [R5]                   ; escreve em GPIO_PORTM_DATA_R

	CMP R10, #1
	ITTE GE
	SUBGE R12, R9, #48
	MULGE R12, R12, R11
	ADDLT R12, R9, #48
	MOV     R3, R12                ; veremos
    STR     R3, [R4]                   ; escreve dado em GPIO_PORTK_DATA_R

	MOV     R3, #2_11110101            ; E = 1 (liga o pulso)
    STR     R3, [R5]                   ; escreve em GPIO_PORTM_DATA_R

	PUSH{R0}
	MOV     R0, #2
    BL SysTick_Wait1ms               ; pequeno delay
	POP{R0}

	MOV     R3, #2_11110000            ; todos os sinais de controle em 0
    STR     R3, [R5]                   ; escreve em GPIO_PORTM_DATA_R


    MOV     R3, #2_11110000            ; todos os sinais de controle em 0
    STR     R3, [R5]                   ; escreve em GPIO_PORTM_DATA_R

	MOV     R3, #0xC0                  ; seleciona a segunda linha
    STR     R3, [R4]                   ; escreve dado em GPIO_PORTK_DATA_R

	MOV     R3, #2_11110100            ; E = 1 (liga o pulso)
    STR     R3, [R5]                   ; escreve em GPIO_PORTM_DATA_R

	PUSH{R0}
	MOV     R0, #2
    BL SysTick_Wait1ms               ; pequeno delay
	POP{R0}

	MOV     R3, #2_11110000            ; todos os sinais de controle em 0
    STR     R3, [R5]                   ; escreve em GPIO_PORTM_DATA_R daqui

    CMP R10, #0x00
    BEQ crescente
    BHS decrescente

crescente
	LDR R0, =0x20004008
	B continua

decrescente
	LDR R0, =0x20004000
	B continua

continua
    LDR R1, =0x2000402C

menor
    LDR     R6, [R0]

    MOV     R3, #2_11110001            ; todos os sinais de controle em 0
    STR     R3, [R5]                   ; escreve em GPIO_PORTM_DATA_R

	MOV     R3, R6                  ; caractere a ser escrito (ASCII de 'p')
    STR     R3, [R4]                   ; escreve dado em GPIO_PORTK_DATA_R

	MOV     R3, #2_11110101            ; E = 1 (liga o pulso)
    STR     R3, [R5]                   ; escreve em GPIO_PORTM_DATA_R

	PUSH{R0}
	MOV     R0, #2
    BL SysTick_Wait1ms               ; pequeno delay
	POP{R0}

	MOV     R3, #2_11110000            ; todos os sinais de controle em 0
    STR     R3, [R5]                   ; escreve em GPIO_PORTM_DATA_R

    ADD     R0, R0, #4          ; incrementa R0 em 4 bytes

    CMP R0, R1
    BLT menor

    POP {LR, R0,R1,R2,R3,R4,R5,R6}
    BX LR

    ALIGN                        ;Garante que o fim da se��o est� alinhada
    END               ;Volta para o la�o principal