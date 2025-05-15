; gpio.s
; Desenvolvido para a placa EK-TM4C1294XL
; Prof. Guilherme Peron
; 24/08/2020

; -------------------------------------------------------------------------------
        THUMB                        ; Instru��es do tipo Thumb-2
; -------------------------------------------------------------------------------
; Declara��es EQU - Defines
; ========================
; Defini��es de Valores
BIT0	EQU 2_0001
BIT1	EQU 2_0010
; ========================
; Defini��es dos Registradores Gerais
SYSCTL_RCGCGPIO_R	 EQU	0x400FE608
SYSCTL_PRGPIO_R		 EQU    0x400FEA08
; ========================
; NVIC
NVIC_ACTLR_R          	EQU    0xE000E008
NVIC_ST_CTRL_R        	EQU    0xE000E010
NVIC_ST_RELOAD_R      	EQU    0xE000E014
NVIC_ST_CURRENT_R     	EQU    0xE000E018
NVIC_EN0_R            	EQU    0xE000E100
NVIC_EN1_R            	EQU    0xE000E104
NVIC_EN2_R            	EQU    0xE000E108
NVIC_EN3_R            	EQU    0xE000E10C
NVIC_DIS0_R           	EQU    0xE000E180
NVIC_DIS1_R           	EQU    0xE000E184
NVIC_DIS2_R           	EQU    0xE000E188
NVIC_DIS3_R           	EQU    0xE000E18C
NVIC_PEND0_R          	EQU    0xE000E200
NVIC_PEND1_R          	EQU    0xE000E204
NVIC_PEND2_R          	EQU    0xE000E208
NVIC_PEND3_R          	EQU    0xE000E20C
NVIC_UNPEND0_R        	EQU    0xE000E280
NVIC_UNPEND1_R        	EQU    0xE000E284
NVIC_UNPEND2_R        	EQU    0xE000E288
NVIC_UNPEND3_R        	EQU    0xE000E28C
NVIC_ACTIVE0_R        	EQU    0xE000E300
NVIC_ACTIVE1_R        	EQU    0xE000E304
NVIC_ACTIVE2_R        	EQU    0xE000E308
NVIC_ACTIVE3_R        	EQU    0xE000E30C
NVIC_PRI0_R           	EQU    0xE000E400
NVIC_PRI1_R           	EQU    0xE000E404
NVIC_PRI2_R           	EQU    0xE000E408
NVIC_PRI3_R           	EQU    0xE000E40C
NVIC_PRI4_R           	EQU    0xE000E410
NVIC_PRI5_R           	EQU    0xE000E414
NVIC_PRI6_R           	EQU    0xE000E418
NVIC_PRI7_R           	EQU    0xE000E41C
NVIC_PRI8_R           	EQU    0xE000E420
NVIC_PRI9_R           	EQU    0xE000E424
NVIC_PRI10_R          	EQU    0xE000E428
NVIC_PRI11_R          	EQU    0xE000E42C
NVIC_PRI12_R          	EQU    0xE000E430
NVIC_PRI13_R          	EQU    0xE000E434
NVIC_PRI14_R          	EQU    0xE000E438
NVIC_PRI15_R          	EQU    0xE000E43C
NVIC_PRI16_R          	EQU    0xE000E440
NVIC_PRI17_R          	EQU    0xE000E444
NVIC_PRI18_R          	EQU    0xE000E448
NVIC_PRI19_R          	EQU    0xE000E44C
NVIC_PRI20_R          	EQU    0xE000E450
NVIC_PRI21_R          	EQU    0xE000E454
NVIC_PRI22_R          	EQU    0xE000E458
NVIC_PRI23_R          	EQU    0xE000E45C
NVIC_PRI24_R          	EQU    0xE000E460
NVIC_PRI25_R          	EQU    0xE000E464
NVIC_PRI26_R          	EQU    0xE000E468
NVIC_PRI27_R          	EQU    0xE000E46C
NVIC_PRI28_R          	EQU    0xE000E470
NVIC_CPUID_R          	EQU    0xE000ED00
NVIC_INT_CTRL_R       	EQU    0xE000ED04
NVIC_VTABLE_R         	EQU    0xE000ED08
NVIC_APINT_R          	EQU    0xE000ED0C
NVIC_SYS_CTRL_R       	EQU    0xE000ED10
NVIC_CFG_CTRL_R       	EQU    0xE000ED14
NVIC_SYS_PRI1_R       	EQU    0xE000ED18
NVIC_SYS_PRI2_R       	EQU    0xE000ED1C
NVIC_SYS_PRI3_R       	EQU    0xE000ED20
NVIC_SYS_HND_CTRL_R   	EQU    0xE000ED24
NVIC_FAULT_STAT_R     	EQU    0xE000ED28
NVIC_HFAULT_STAT_R    	EQU    0xE000ED2C
NVIC_DEBUG_STAT_R     	EQU    0xE000ED30
NVIC_MM_ADDR_R        	EQU    0xE000ED34
NVIC_FAULT_ADDR_R     	EQU    0xE000ED38
NVIC_CPAC_R           	EQU    0xE000ED88
NVIC_MPU_TYPE_R       	EQU    0xE000ED90
NVIC_MPU_CTRL_R       	EQU    0xE000ED94
NVIC_MPU_NUMBER_R     	EQU    0xE000ED98
NVIC_MPU_BASE_R       	EQU    0xE000ED9C
NVIC_MPU_ATTR_R       	EQU    0xE000EDA0
NVIC_MPU_BASE1_R      	EQU    0xE000EDA4
NVIC_MPU_ATTR1_R      	EQU    0xE000EDA8
NVIC_MPU_BASE2_R      	EQU    0xE000EDAC
NVIC_MPU_ATTR2_R      	EQU    0xE000EDB0
NVIC_MPU_BASE3_R      	EQU    0xE000EDB4
NVIC_MPU_ATTR3_R      	EQU    0xE000EDB8
NVIC_DBG_CTRL_R       	EQU    0xE000EDF0
NVIC_DBG_XFER_R       	EQU    0xE000EDF4
NVIC_DBG_DATA_R       	EQU    0xE000EDF8
NVIC_DBG_INT_R        	EQU    0xE000EDFC
NVIC_SW_TRIG_R        	EQU    0xE000EF00
NVIC_FPCC_R           	EQU    0xE000EF34
NVIC_FPCA_R           	EQU    0xE000EF38
NVIC_FPDSC_R          	EQU    0xE000EF3C
; ========================
; Defini��es dos Ports
; PORT J
GPIO_PORTJ_AHB_DATA_BITS_R   EQU    0x40060000
GPIO_PORTJ_AHB_DATA_R        EQU    0x400603FC
GPIO_PORTJ_AHB_DIR_R         EQU    0x40060400
GPIO_PORTJ_AHB_IS_R          EQU    0x40060404
GPIO_PORTJ_AHB_IBE_R         EQU    0x40060408
GPIO_PORTJ_AHB_IEV_R         EQU    0x4006040C
GPIO_PORTJ_AHB_IM_R          EQU    0x40060410
GPIO_PORTJ_AHB_RIS_R         EQU    0x40060414
GPIO_PORTJ_AHB_MIS_R         EQU    0x40060418
GPIO_PORTJ_AHB_ICR_R         EQU    0x4006041C
GPIO_PORTJ_AHB_AFSEL_R       EQU    0x40060420
GPIO_PORTJ_AHB_DR2R_R        EQU    0x40060500
GPIO_PORTJ_AHB_DR4R_R        EQU    0x40060504
GPIO_PORTJ_AHB_DR8R_R        EQU    0x40060508
GPIO_PORTJ_AHB_ODR_R         EQU    0x4006050C
GPIO_PORTJ_AHB_PUR_R         EQU    0x40060510
GPIO_PORTJ_AHB_PDR_R         EQU    0x40060514
GPIO_PORTJ_AHB_SLR_R         EQU    0x40060518
GPIO_PORTJ_AHB_DEN_R         EQU    0x4006051C
GPIO_PORTJ_AHB_LOCK_R        EQU    0x40060520
GPIO_PORTJ_AHB_CR_R          EQU    0x40060524
GPIO_PORTJ_AHB_AMSEL_R       EQU    0x40060528
GPIO_PORTJ_AHB_PCTL_R        EQU    0x4006052C
GPIO_PORTJ_AHB_ADCCTL_R      EQU    0x40060530
GPIO_PORTJ_AHB_DMACTL_R      EQU    0x40060534
GPIO_PORTJ_AHB_SI_R          EQU    0x40060538
GPIO_PORTJ_AHB_DR12R_R       EQU    0x4006053C
GPIO_PORTJ_AHB_WAKEPEN_R     EQU    0x40060540
GPIO_PORTJ_AHB_WAKELVL_R     EQU    0x40060544
GPIO_PORTJ_AHB_WAKESTAT_R    EQU    0x40060548
GPIO_PORTJ_AHB_PP_R          EQU    0x40060FC0
GPIO_PORTJ_AHB_PC_R          EQU    0x40060FC4
GPIO_PORTJ                   EQU    2_000000100000000

; PORT A
GPIO_PORTA_AHB_DATA_BITS_R   EQU 0x40058000
GPIO_PORTA_AHB_DATA_R        EQU 0x400583FC
GPIO_PORTA_AHB_DIR_R         EQU 0x40058400
GPIO_PORTA_AHB_IS_R          EQU 0x40058404
GPIO_PORTA_AHB_IBE_R         EQU 0x40058408
GPIO_PORTA_AHB_IEV_R         EQU 0x4005840C
GPIO_PORTA_AHB_IM_R          EQU 0x40058410
GPIO_PORTA_AHB_RIS_R         EQU 0x40058414
GPIO_PORTA_AHB_MIS_R         EQU 0x40058418
GPIO_PORTA_AHB_ICR_R         EQU 0x4005841C
GPIO_PORTA_AHB_AFSEL_R       EQU 0x40058420
GPIO_PORTA_AHB_DR2R_R        EQU 0x40058500
GPIO_PORTA_AHB_DR4R_R        EQU 0x40058504
GPIO_PORTA_AHB_DR8R_R        EQU 0x40058508
GPIO_PORTA_AHB_ODR_R         EQU 0x4005850C
GPIO_PORTA_AHB_PUR_R         EQU 0x40058510
GPIO_PORTA_AHB_PDR_R         EQU 0x40058514
GPIO_PORTA_AHB_SLR_R         EQU 0x40058518
GPIO_PORTA_AHB_DEN_R         EQU 0x4005851C
GPIO_PORTA_AHB_LOCK_R        EQU 0x40058520
GPIO_PORTA_AHB_CR_R          EQU 0x40058524
GPIO_PORTA_AHB_AMSEL_R       EQU 0x40058528
GPIO_PORTA_AHB_PCTL_R        EQU 0x4005852C
GPIO_PORTA_AHB_ADCCTL_R      EQU 0x40058530
GPIO_PORTA_AHB_DMACTL_R      EQU 0x40058534
GPIO_PORTA_AHB_SI_R          EQU 0x40058538
GPIO_PORTA_AHB_DR12R_R       EQU 0x4005853C
GPIO_PORTA_AHB_WAKEPEN_R     EQU 0x40058540
GPIO_PORTA_AHB_WAKELVL_R     EQU 0x40058544
GPIO_PORTA_AHB_WAKESTAT_R    EQU 0x40058548
GPIO_PORTA_AHB_PP_R          EQU 0x40058FC0
GPIO_PORTA_AHB_PC_R          EQU 0x40058FC4
GPIO_PORTA                   EQU    2_000000000000001

;PORT Q
GPIO_PORTQ_DATA_BITS_R       EQU 0x40066000
GPIO_PORTQ_DATA_R            EQU 0x400663FC
GPIO_PORTQ_DIR_R             EQU 0x40066400
GPIO_PORTQ_IS_R              EQU 0x40066404
GPIO_PORTQ_IBE_R             EQU 0x40066408
GPIO_PORTQ_IEV_R             EQU 0x4006640C
GPIO_PORTQ_IM_R              EQU 0x40066410
GPIO_PORTQ_RIS_R             EQU 0x40066414
GPIO_PORTQ_MIS_R             EQU 0x40066418
GPIO_PORTQ_ICR_R             EQU 0x4006641C
GPIO_PORTQ_AFSEL_R           EQU 0x40066420
GPIO_PORTQ_DR2R_R            EQU 0x40066500
GPIO_PORTQ_DR4R_R            EQU 0x40066504
GPIO_PORTQ_DR8R_R            EQU 0x40066508
GPIO_PORTQ_ODR_R             EQU 0x4006650C
GPIO_PORTQ_PUR_R             EQU 0x40066510
GPIO_PORTQ_PDR_R             EQU 0x40066514
GPIO_PORTQ_SLR_R             EQU 0x40066518
GPIO_PORTQ_DEN_R             EQU 0x4006651C
GPIO_PORTQ_LOCK_R            EQU 0x40066520
GPIO_PORTQ_CR_R              EQU 0x40066524
GPIO_PORTQ_AMSEL_R           EQU 0x40066528
GPIO_PORTQ_PCTL_R            EQU 0x4006652C
GPIO_PORTQ_ADCCTL_R          EQU 0x40066530
GPIO_PORTQ_DMACTL_R          EQU 0x40066534
GPIO_PORTQ_SI_R              EQU 0x40066538
GPIO_PORTQ_DR12R_R           EQU 0x4006653C
GPIO_PORTQ_WAKEPEN_R         EQU 0x40066540
GPIO_PORTQ_WAKELVL_R         EQU 0x40066544
GPIO_PORTQ_WAKESTAT_R        EQU 0x40066548
GPIO_PORTQ_PP_R              EQU 0x40066FC0
GPIO_PORTQ_PC_R              EQU 0x40066FC4
GPIO_PORTQ                   EQU    2_100000000000000

; PORT B
GPIO_PORTB_AHB_DATA_BITS_R   EQU 0x40059000
GPIO_PORTB_AHB_DATA_R        EQU 0x400593FC
GPIO_PORTB_AHB_DIR_R         EQU 0x40059400
GPIO_PORTB_AHB_IS_R          EQU 0x40059404
GPIO_PORTB_AHB_IBE_R         EQU 0x40059408
GPIO_PORTB_AHB_IEV_R         EQU 0x4005940C
GPIO_PORTB_AHB_IM_R          EQU 0x40059410
GPIO_PORTB_AHB_RIS_R         EQU 0x40059414
GPIO_PORTB_AHB_MIS_R         EQU 0x40059418
GPIO_PORTB_AHB_ICR_R         EQU 0x4005941C
GPIO_PORTB_AHB_AFSEL_R       EQU 0x40059420
GPIO_PORTB_AHB_DR2R_R        EQU 0x40059500
GPIO_PORTB_AHB_DR4R_R        EQU 0x40059504
GPIO_PORTB_AHB_DR8R_R        EQU 0x40059508
GPIO_PORTB_AHB_ODR_R         EQU 0x4005950C
GPIO_PORTB_AHB_PUR_R         EQU 0x40059510
GPIO_PORTB_AHB_PDR_R         EQU 0x40059514
GPIO_PORTB_AHB_SLR_R         EQU 0x40059518
GPIO_PORTB_AHB_DEN_R         EQU 0x4005951C
GPIO_PORTB_AHB_LOCK_R        EQU 0x40059520
GPIO_PORTB_AHB_CR_R          EQU 0x40059524
GPIO_PORTB_AHB_AMSEL_R       EQU 0x40059528
GPIO_PORTB_AHB_PCTL_R        EQU 0x4005952C
GPIO_PORTB_AHB_ADCCTL_R      EQU 0x40059530
GPIO_PORTB_AHB_DMACTL_R      EQU 0x40059534
GPIO_PORTB_AHB_SI_R          EQU 0x40059538
GPIO_PORTB_AHB_DR12R_R       EQU 0x4005953C
GPIO_PORTB_AHB_WAKEPEN_R     EQU 0x40059540
GPIO_PORTB_AHB_WAKELVL_R     EQU 0x40059544
GPIO_PORTB_AHB_WAKESTAT_R    EQU 0x40059548
GPIO_PORTB_AHB_PP_R          EQU 0x40059FC0
GPIO_PORTB_AHB_PC_R          EQU 0x40059FC4
GPIO_PORTB                   EQU    2_000000000000010

; PORT K
GPIO_PORTK_DATA_BITS_R  EQU 0x40061000
GPIO_PORTK_DATA_R       EQU 0x400613FC
GPIO_PORTK_DIR_R        EQU 0x40061400
GPIO_PORTK_IS_R         EQU 0x40061404
GPIO_PORTK_IBE_R        EQU 0x40061408
GPIO_PORTK_IEV_R        EQU 0x4006140C
GPIO_PORTK_IM_R         EQU 0x40061410
GPIO_PORTK_RIS_R        EQU 0x40061414
GPIO_PORTK_MIS_R        EQU 0x40061418
GPIO_PORTK_ICR_R        EQU 0x4006141C
GPIO_PORTK_AFSEL_R      EQU 0x40061420
GPIO_PORTK_DR2R_R       EQU 0x40061500
GPIO_PORTK_DR4R_R       EQU 0x40061504
GPIO_PORTK_DR8R_R       EQU 0x40061508
GPIO_PORTK_ODR_R        EQU 0x4006150C
GPIO_PORTK_PUR_R        EQU 0x40061510
GPIO_PORTK_PDR_R        EQU 0x40061514
GPIO_PORTK_SLR_R        EQU 0x40061518
GPIO_PORTK_DEN_R        EQU 0x4006151C
GPIO_PORTK_LOCK_R       EQU 0x40061520
GPIO_PORTK_CR_R         EQU 0x40061524
GPIO_PORTK_AMSEL_R      EQU 0x40061528
GPIO_PORTK_PCTL_R       EQU 0x4006152C
GPIO_PORTK_ADCCTL_R     EQU 0x40061530
GPIO_PORTK_DMACTL_R     EQU 0x40061534
GPIO_PORTK_SI_R         EQU 0x40061538
GPIO_PORTK_DR12R_R      EQU 0x4006153C
GPIO_PORTK_WAKEPEN_R    EQU 0x40061540
GPIO_PORTK_WAKELVL_R    EQU 0x40061544
GPIO_PORTK_WAKESTAT_R   EQU 0x40061548
GPIO_PORTK_PP_R         EQU 0x40061FC0
GPIO_PORTK_PC_R         EQU 0x40061FC4
GPIO_PORTK                   EQU    2_000001000000000

; PORT M
GPIO_PORTM_DATA_BITS_R  EQU 0x40063000
GPIO_PORTM_DATA_R       EQU 0x400633FC
GPIO_PORTM_DIR_R        EQU 0x40063400
GPIO_PORTM_IS_R         EQU 0x40063404
GPIO_PORTM_IBE_R        EQU 0x40063408
GPIO_PORTM_IEV_R        EQU 0x4006340C
GPIO_PORTM_IM_R         EQU 0x40063410
GPIO_PORTM_RIS_R        EQU 0x40063414
GPIO_PORTM_MIS_R        EQU 0x40063418
GPIO_PORTM_ICR_R        EQU 0x4006341C
GPIO_PORTM_AFSEL_R      EQU 0x40063420
GPIO_PORTM_DR2R_R       EQU 0x40063500
GPIO_PORTM_DR4R_R       EQU 0x40063504
GPIO_PORTM_DR8R_R       EQU 0x40063508
GPIO_PORTM_ODR_R        EQU 0x4006350C
GPIO_PORTM_PUR_R        EQU 0x40063510
GPIO_PORTM_PDR_R        EQU 0x40063514
GPIO_PORTM_SLR_R        EQU 0x40063518
GPIO_PORTM_DEN_R        EQU 0x4006351C
GPIO_PORTM_LOCK_R       EQU 0x40063520
GPIO_PORTM_CR_R         EQU 0x40063524
GPIO_PORTM_AMSEL_R      EQU 0x40063528
GPIO_PORTM_PCTL_R       EQU 0x4006352C
GPIO_PORTM_ADCCTL_R     EQU 0x40063530
GPIO_PORTM_DMACTL_R     EQU 0x40063534
GPIO_PORTM_SI_R         EQU 0x40063538
GPIO_PORTM_DR12R_R      EQU 0x4006353C
GPIO_PORTM_WAKEPEN_R    EQU 0x40063540
GPIO_PORTM_WAKELVL_R    EQU 0x40063544
GPIO_PORTM_WAKESTAT_R   EQU 0x40063548
GPIO_PORTM_PP_R         EQU 0x40063FC0
GPIO_PORTM_PC_R         EQU 0x40063FC4
GPIO_PORTM                   EQU    2_000100000000000

; -------------------------------------------------------------------------------
; �rea de C�digo - Tudo abaixo da diretiva a seguir ser� armazenado na mem�ria de
;                  c�digo
        AREA    |.text|, CODE, READONLY, ALIGN=2

		; Se alguma fun��o do arquivo for chamada em outro arquivo
        EXPORT GPIO_Init            ; Permite chamar GPIO_Init de outro arquivo
		EXPORT SEG_WRITE
		EXPORT GPIO_PORTK_DATA_R
		EXPORT GPIO_PORTM_DATA_R
		EXPORT GPIOPortJ_Handler 
        IMPORT EnableInterrupts
        IMPORT DisableInterrupts
		IMPORT SysTick_Wait1ms
		IMPORT Modo
		IMPORT AtualizaPasso
		IMPORT escrevedisplay

;--------------------------------------------------------------------------------
; Fun��o GPIO_Init
; Par�metro de entrada: N�o tem
; Par�metro de sa�da: N�o tem
GPIO_Init
;=====================
; 1. Ativar o clock para a porta setando o bit correspondente no registrador RCGCGPIO,
; ap�s isso verificar no PRGPIO se a porta est� pronta para uso.
; enable clock to GPIOF at clock gating register

            LDR     R0, =SYSCTL_RCGCGPIO_R  		;Carrega o endere�o do registrador RCGCGPIO
			MOV		R1, #GPIO_PORTJ                 ;Seta o bit da porta j
			ORR     R1, #GPIO_PORTA					;Seta o bit da porta A, fazendo com OR
			ORR     R1, #GPIO_PORTQ					;Seta o bit da porta Q, fazendo com OR
			ORR     R1, #GPIO_PORTB					;Seta o bit da porta B, fazendo com OR
            ORR 	R1, #GPIO_PORTK					;Seta o bit da porta K, fazendo com OR
			ORR 	R1, #GPIO_PORTM					;Seta o bit da porta M, fazendo com OR
			STR     R1, [R0]						;Move para a mem�ria os bits das portas no endere�o do RCGCGPIO

            LDR     R0, =SYSCTL_PRGPIO_R			;Carrega o endere�o do PRGPIO para esperar os GPIO ficarem prontos
EsperaGPIO  LDR     R1, [R0]						;L� da mem�ria o conte�do do endere�o do registrador
			MOV     R2, #GPIO_PORTJ                 ;Seta os bits correspondentes �s portas para fazer a compara��o
			ORR     R2, #GPIO_PORTA                 ;Seta o bit da porta A, fazendo com OR
			ORR     R2, #GPIO_PORTQ                 ;Seta o bit da porta Q, fazendo com OR
			ORR     R2, #GPIO_PORTB                 ;Seta o bit da porta B, fazendo com OR
            ORR     R2, #GPIO_PORTK                 ;Seta o bit da porta K, fazendo com OR
			ORR     R2, #GPIO_PORTM                 ;Seta o bit da porta M, fazendo com OR
			TST     R1, R2							;Testa o R1 com R2 fazendo R1 & R2
            BEQ     EsperaGPIO					    ;Se o flag Z=1, volta para o la�o. Sen�o continua executando

; 2. Limpar o AMSEL para desabilitar a anal�gica
            MOV     R1, #0x00						;Colocar 0 no registrador para desabilitar a fun��o anal�gica
            LDR     R0, =GPIO_PORTJ_AHB_AMSEL_R     ;Carrega o R0 com o endere�o do AMSEL para a porta J
            STR     R1, [R0]						;Guarda no registrador AMSEL da porta J da mem�ria
            LDR     R0, =GPIO_PORTA_AHB_AMSEL_R		;Carrega o R0 com o endere�o do AMSEL para a porta A
            STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta A da mem�ria
            LDR     R0, =GPIO_PORTQ_AMSEL_R			;Carrega o R0 com o endere�o do AMSEL para a porta Q
            STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta Q da mem�ria
            LDR     R0, =GPIO_PORTB_AHB_AMSEL_R			;Carrega o R0 com o endere�o do AMSEL para a porta B
            STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta B da mem�ria
			LDR     R0, =GPIO_PORTK_AMSEL_R			;Carrega o R0 com o endere�o do AMSEL para a porta K isso
            STR     R1, [R0]					    ;Guarda no registrador AMSEL da porta K da mem�ria
            LDR     R0, =GPIO_PORTM_AMSEL_R			;Carrega o R0 com o endere�o do AMSEL para a porta M
            STR     R1, [R0]

; 3. Limpar PCTL para selecionar o GPIO
            MOV     R1, #0x00					    ;Colocar 0 no registrador para selecionar o modo GPIO
            LDR     R0, =GPIO_PORTJ_AHB_PCTL_R		;Carrega o R0 com o endere�o do PCTL para a porta J
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta J da mem�ria
            LDR     R0, =GPIO_PORTA_AHB_PCTL_R		;Carrega o R0 com o endere�o do PCTL para a porta A
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta A da mem�ria
            LDR     R0, =GPIO_PORTQ_PCTL_R      	;Carrega o R0 com o endere�o do PCTL para a porta Q
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta Q da mem�ria
            LDR     R0, =GPIO_PORTB_AHB_PCTL_R      	;Carrega o R0 com o endere�o do PCTL para a porta B
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta B da mem�ria
			LDR     R0, =GPIO_PORTK_PCTL_R      	;Carrega o R0 com o endere�o do PCTL para a porta B
            STR     R1, [R0]                        ;Guarda no registrador PCTL da porta B da mem�ria
            LDR     R0, =GPIO_PORTM_PCTL_R      	;Carrega o R0 com o endere�o do PCTL para a porta B
            STR     R1, [R0]

; 4. DIR para 0 se for entrada, 1 se for sa�da
			; O certo era verificar os outros bits da PJ para n�o transformar entradas em sa�das desnecess�rias
            LDR     R0, =GPIO_PORTJ_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta J
            MOV     R1, #0x00               		;Colocar 0 no registrador DIR para funcionar com sa�da
            STR     R1, [R0]						;Guarda no registrador PCTL da porta J da mem�ria
            LDR     R0, =GPIO_PORTA_AHB_DIR_R		;Carrega o R0 com o endere�o do DIR para a porta A
            MOV     R1, #2_11110000            		;Colocar 0 no registrador DIR para funcionar com sa�da (PA7:PA4)
            STR     R1, [R0]						;Guarda no registrador PCTL da porta A da mem�ria
            LDR     R0, =GPIO_PORTQ_DIR_R			;Carrega o R0 com o endere�o do DIR para a porta Q
            MOV     R1, #2_00001111            		;Colocar 0 no registrador DIR para funcionar com sa�da (PQ3:PQ0)
            STR     R1, [R0]						;Guarda no registrador PCTL da porta Q da mem�ria
            LDR     R0, =GPIO_PORTB_AHB_DIR_R			;Carrega o R0 com o endere�o do DIR para a porta B
            MOV     R1, #2_00110000            		;Colocar 0 no registrador DIR para funcionar com sa�da (PB5:PB4)
            STR     R1, [R0]						;Guarda no registrador PCTL da porta B da mem�ria
			LDR     R0, =GPIO_PORTK_DIR_R			;Carrega o R0 com o endere�o do DIR para a porta B
			MOV     R1, #2_11111111					;Colocar 0 no registrador DIR para funcionar com sa�da (PB5:PB4)
			STR     R1, [R0]						;Guarda no registrador PCTL da porta B da mem�ria
			LDR     R0, =GPIO_PORTM_DIR_R			;Carrega o R0 com o endere�o do DIR para a porta B
			MOV     R1, #2_11111111					;Colocar 0 no registrador DIR para funcionar com sa�da (PB5:PB4)
			STR     R1, [R0]

; 5. Limpar os bits AFSEL para 0 para selecionar GPIO
;    Sem fun��o alternativa
            MOV     R1, #0x00						;Colocar o valor 0 para n�o setar fun��o alternativa
            LDR     R0, =GPIO_PORTJ_AHB_AFSEL_R     ;Carrega o endere�o do AFSEL da porta J
            STR     R1, [R0]                        ;Escreve na porta
			LDR     R0, =GPIO_PORTA_AHB_AFSEL_R     ;Carrega o endere�o do AFSEL da porta A
            STR     R1, [R0]                        ;Escreve na porta
			LDR     R0, =GPIO_PORTQ_AFSEL_R 	    ;Carrega o endere�o do AFSEL da porta Q
            STR     R1, [R0]                        ;Escreve na porta
			LDR     R0, =GPIO_PORTB_AHB_AFSEL_R 	;Carrega o endere�o do AFSEL da porta B
            STR     R1, [R0]                        ;Escreve na porta
			LDR     R0, =GPIO_PORTK_AFSEL_R 	;Carrega o endere�o do AFSEL da porta K
            STR     R1, [R0]                        ;Escreve na porta
			LDR     R0, =GPIO_PORTM_AFSEL_R 	;Carrega o endere�o do AFSEL da porta M
            STR     R1, [R0]

; 6. Setar os bits de DEN para habilitar I/O digital
            LDR     R0, =GPIO_PORTJ_AHB_DEN_R			;Carrega o endere�o do DEN
			MOV     R1, #2_00000011                     ;J1 e J0
            STR     R1, [R0]                            ;Escreve no registrador da mem�ria funcionalidade digital
            LDR     R0, =GPIO_PORTA_AHB_DEN_R			;Carrega o endere�o do DEN
			MOV     R1, #2_11110000                     ;(PA7:PA4)
            STR     R1, [R0]                            ;Escreve no registrador da mem�ria funcionalidade digital
            LDR     R0, =GPIO_PORTQ_DEN_R				;Carrega o endere�o do DEN
			MOV     R1, #2_00001111                     ;(PQ3:PQ0)
            STR     R1, [R0]                            ;Escreve no registrador da mem�ria funcionalidade digital
            LDR     R0, =GPIO_PORTB_AHB_DEN_R				;Carrega o endere�o do DEN
			MOV     R1, #2_00110000                     ;(PB5:PB4)
            STR     R1, [R0]                            ;Escreve no registrador da mem�ria funcionalidade digital
			LDR     R0, =GPIO_PORTK_DEN_R				;Carrega o endere�o do DEN
			MOV     R1, #2_11111111                     ;(PK0:PK7)
            STR     R1, [R0]                            ;Escreve no registrador da mem�ria funcionalidade digital
            LDR     R0, =GPIO_PORTM_DEN_R				;Carrega o endere�o do DEN
			MOV     R1, #2_00000111                     ;(PK0:PK7)
            STR     R1, [R0]                            ;Escreve no registrador da mem�ria funcionalidade digital

; 7. Para habilitar resistor de pull-up interno, setar PUR para 1
			LDR     R0, =GPIO_PORTJ_AHB_PUR_R			;Carrega o endere�o do PUR para a porta J
			MOV     R1, #2_11							;Habilitar funcionalidade digital de resistor de pull-up
            STR     R1, [R0]							;Escreve no registrador da mem�ria do resistor de pull-up

;Interrup��es
; 8. Desabilitar a interrup��o no registrador IM
			LDR     R0, =GPIO_PORTJ_AHB_IM_R			;Carrega o endere�o do IM para a porta M
			MOV     R1, #2_00							;Desabilitar as interrup��es
            STR     R1, [R0]							;Escreve no registrador

; 9. Configurar o tipo de interrup��o por borda no registrador IS
			LDR     R0, =GPIO_PORTJ_AHB_IS_R			;Carrega o endere�o do IS para a porta M
			MOV     R1, #2_00							;Por Borda
            STR     R1, [R0]							;Escreve no registrador

; 10. Configurar  borda �nica no registrador IBE
			LDR     R0, =GPIO_PORTJ_AHB_IBE_R				;Carrega o endere�o do IBE para a porta M
			MOV     R1, #2_00							;Borda �nica
            STR     R1, [R0]							;Escreve no registrador
; 11. Configurar  borda de descida (bot�o pressionado) no registrador IEV
			LDR     R0, =GPIO_PORTJ_AHB_IEV_R				;Carrega o endere�o do IEV para a porta M
			MOV     R1, #2_00							;Borda �nica
            STR     R1, [R0]							;Escreve no registrador

; 12. Limpar interrup��es pendentes
			LDR     R0, =GPIO_PORTJ_AHB_ICR_R				;Carrega o endere�o do IEV para a porta M
			MOV     R1, #2_11							;Borda �nica
            STR     R1, [R0]

; 13. Habilitar a interrup��o no registrador IM
			LDR     R0, =GPIO_PORTJ_AHB_IM_R				;Carrega o endere�o do IM para a porta M
			MOV     R1, #2_11							;Habilitar as interrup��es
            STR     R1, [R0]							;Escreve no registrador

;Interrup��o n�mero 51
; 14. Habilitar a interrup��o no NVIC
			LDR     R0, =NVIC_EN1_R           			;Carrega o do NVIC para o grupo que tem o M entre 64 e 95
			MOV     R1, #1
			LSL     R1, #19								;Desloca 8 bits para a esquerda j� que o M � a interrup��o do bit 8 no EN2
            STR     R1, [R0]

; 15. Setar a prioridade no NVIC
			LDR     R0, =NVIC_PRI12_R           		;Carrega o do NVIC para o grupo que tem o M entre 72 e 75
			MOV     R1, #5  		                    ;Prioridade 3
			LSL     R1, R1, #29							;Desloca 5 bits para a esquerda j� que o M � o primeiro byte do PRI18
            STR     R1, [R0]							;Escreve no registrador da mem�ria
						;Escreve no registrador da mem�ria

			BX  LR

; -------------------------------------------------------------------------------
; Fun��o SEG_WRITE
; Par�metro de entrada: R0 --> n�mero de 2 casas a ser mostrado nos displays
; Par�metro de sa�da: R1 -> d�gito a ser mostrado em um display, atrav�s da fun��o SEG_DECODER
SEG_WRITE
	PUSH{LR, R1, R0, R3, R4, R7, R6}
	MOV R3, #10 ; Divisor

LOOP
	UDIV R1, R0, R3 ;R1(dezena)=R0(contador)/R3(#10)

	BL SEG_DECODER

	LDR	R7, =GPIO_PORTB_AHB_DATA_R
	MOV R4, #2_00010000					;Ativa PB4->Transistor Q2 (UNIDADE)
	STR R4, [R7]

	PUSH{R0}
	MOV R0, #1               			;Chamar a rotina para esperar 1ms
	BL SysTick_Wait1ms
	POP{R0}

	LDR	R7, =GPIO_PORTB_AHB_DATA_R
	MOV R4, #2_00000000					;Desativa PB5->Transistor Q3 (UNIDADE)
	STR R4, [R7]

	PUSH{R0}
	MOV R0, #1               			    ;Chamar a rotina para esperar 1ms
	BL SysTick_Wait1ms
	POP{R0}

	MLS R1, R1, R3, R0 ; R1=R1(dezena)*R3(#10)-R0(contador)

	BL SEG_DECODER

	LDR	R7, =GPIO_PORTB_AHB_DATA_R
	MOV R4, #2_00100000					;Ativa PB5->Transistor Q3 (UNIDADE)
	STR R4, [R7]

	PUSH{R0}
	MOV R0, #1               			    ;Chamar a rotina para esperar 1ms
	BL SysTick_Wait1ms
	POP{R0}

	LDR	R7, =GPIO_PORTB_AHB_DATA_R
	MOV R4, #2_00000000					;Desativa PB4->Transistor Q2 (UNIDADE)
	STR R4, [R7]

	PUSH{R0}
	MOV R0, #1               			    ;Chamar a rotina para esperar 1ms
	BL SysTick_Wait1ms
	POP{R0}

	ADD R6, R6, #1
	CMP R6, #200
	BNE LOOP

	POP{LR, R1, R0, R3, R4, R7, R6}
	BX LR

; -------------------------------------------------------------------------------
; Fun��o SEG-DECODER
; Par�metro de entrada: R1 --> n�mero a ser mostrado no display
; Par�metro de sa�da: N�o tem
SEG_DECODER
	PUSH{R1,R0}
	CMP R1, #0
	BEQ ZERO
	CMP R1, #1
	BEQ UM
	CMP R1, #2
	BEQ DOIS
	CMP R1, #3
	BEQ TRES
	CMP R1, #4
	BEQ QUATRO
	CMP R1, #5
	BEQ CINCO
	CMP R1, #6
	BEQ SEIS
	CMP R1, #7
	BEQ SETE
	CMP R1, #8
	BEQ OITO
	CMP R1, #9
	BEQ NOVE
	B FIMSEG

ZERO
	LDR	R1, =GPIO_PORTA_AHB_DATA_R
	MOV R0, #2_00110000						;e, f
	STR R0, [R1]

	LDR	R1, =GPIO_PORTQ_DATA_R
	MOV R0, #2_00001111                     ;a, b, c, d
	STR R0, [R1]
	B FIMSEG

UM
	LDR	R1, =GPIO_PORTA_AHB_DATA_R
	MOV R0, #2_00000000
	STR R0, [R1]

	LDR	R1, =GPIO_PORTQ_DATA_R
	MOV R0, #2_00000110                     ;b, c
	STR R0, [R1]
	B FIMSEG

DOIS
	LDR	R1, =GPIO_PORTA_AHB_DATA_R
	MOV R0, #2_01010000						;e, g
	STR R0, [R1]

	LDR	R1, =GPIO_PORTQ_DATA_R
	MOV R0, #2_00001011                     ;a, b, d
	STR R0, [R1]
	B FIMSEG

TRES
	LDR	R1, =GPIO_PORTA_AHB_DATA_R
	MOV R0, #2_01000000						;g
	STR R0, [R1]

	LDR	R1, =GPIO_PORTQ_DATA_R
	MOV R0, #2_00001111                     ;a, b, c, d
	STR R0, [R1]
	B FIMSEG

QUATRO
	LDR	R1, =GPIO_PORTA_AHB_DATA_R
	MOV R0, #2_01100000						;f, g
	STR R0, [R1]

	LDR	R1, =GPIO_PORTQ_DATA_R
	MOV R0, #2_00000110                     ;b, c
	STR R0, [R1]
	B FIMSEG

CINCO
	LDR	R1, =GPIO_PORTA_AHB_DATA_R
	MOV R0, #2_01100000						;f, g
	STR R0, [R1]

	LDR	R1, =GPIO_PORTQ_DATA_R
	MOV R0, #2_00001101                     ;a, c, d
	STR R0, [R1]
	B FIMSEG

SEIS
	LDR	R1, =GPIO_PORTA_AHB_DATA_R
	MOV R0, #2_01110000						;e, f, g
	STR R0, [R1]

	LDR	R1, =GPIO_PORTQ_DATA_R
	MOV R0, #2_00001101                     ;a, c, d
	STR R0, [R1]
	B FIMSEG

SETE
	LDR	R1, =GPIO_PORTA_AHB_DATA_R
	MOV R0, #2_00000000
	STR R0, [R1]

	LDR	R1, =GPIO_PORTQ_DATA_R
	MOV R0, #2_00000111                     ;a, b, c
	STR R0, [R1]
	B FIMSEG

OITO
	LDR	R1, =GPIO_PORTA_AHB_DATA_R
	MOV R0, #2_01110000						;e, f, g
	STR R0, [R1]

	LDR	R1, =GPIO_PORTQ_DATA_R
	MOV R0, #2_00001111                     ;a, b, c, d
	STR R0, [R1]
	B FIMSEG

NOVE
	LDR	R1, =GPIO_PORTA_AHB_DATA_R
	MOV R0, #2_01100000 					;f, g
	STR R0, [R1]

	LDR	R1, =GPIO_PORTQ_DATA_R
	MOV R0, #2_00001111  					;a, b, c, d
	STR R0, [R1]

FIMSEG
	POP{R1,R0}
	BX LR									;Retorno

; -------------------------------------------------------------------------------
; Fun��o ISR GPIOPortJ_Handler (Tratamento da interrup��o)
GPIOPortJ_Handler
	PUSH {LR, R0}
	LDR R0, =GPIO_PORTJ_AHB_MIS_R
	LDR R1, [R0]
VERIFICA_SW1
	CMP R1, #2_01
	BNE VERIFICA_SW2
	LDR R0, =GPIO_PORTJ_AHB_ICR_R
	MOV R1, #2_01
	STR R1, [R0]
	BL AtualizaPasso
	B FIM_INTERRUPT
VERIFICA_SW2
	CMP R1, #2_10
	BNE VERIFICA_AMBAS
	LDR R0, =GPIO_PORTJ_AHB_ICR_R
	MOV R1, #2_10
	STR R1, [R0]
    BL Modo
	B FIM_INTERRUPT
VERIFICA_AMBAS
	MOV R1, #2_11
	LDR R0, =GPIO_PORTJ_AHB_ICR_R
FIM_INTERRUPT
	BL escrevedisplay
	POP {LR, R0}
	BX LR

    ALIGN                           ; garante que o fim da se��o est� alinhada
	END                             ; fim do arquiv
