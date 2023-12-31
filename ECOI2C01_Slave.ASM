; EcoI2C01
; Servidor de eco por bus i2c (versi�n slave)
; Por: Alejandro Alonso Puig - mundobot.com
; Fecha: 30/10/2003
; Controlador: 16F876 4Mhz
; Funci�n: 
; Realiza transmisi�n bidireccional i2c mediante el uso de interrupciones.
; Cuando el Master le env�a un dato, lo deja en la variable "MensajeIn",
; y lo copia a "MensajeOut". Cuando el Master le pide un dato, env�a el valor 
; que contenga la variable "MensajeOut". En resumen, la salida es un eco de la entrada.

	list 		p=16F876
	include		"P16F876.INC"


;Definici�n de constantes

	#define	DirNodo		b'01111000'	;Direcci�n I2C de este nodo (120)

;Definici�n de variables

	cblock	0x20	
	MensajeIn	;Contendr� el dato recibido por I2C del master
	MensajeOut	;Contendr� el dato a enviar por I2C al master
	BkStatus	;Backup del registro STATUS
	BkW		;Backup W
	BkStatus2	;Backup del registro STATUS (Interrupciones)
	BkW2		;Backup W (Interrupciones)
	Temp		;Variable Temporal usada para evaluaci�n de eventos I2C
	endc		;Fin de definiciones


	org	0
	goto	INICIO
	org	5		

;-------------------------------------------------------------------------------
Interrupcion   	;RUTINA DE INTERRUPCI�N. Se ocupa de los eventos I2C
;-------------------------------------------------------------------------------

	;Guardamos copia de algunos registros
	movwf	BkW2		;Hace copia de W
	movf	STATUS,W	;Hace copia de registro de estado
	banksel	BkStatus2
	movwf	BkStatus2


	;Chequeamos si la interrupci�n es por evento I2C. En caso positivo llamamos
	;a la rutina de proceso del evento
	banksel PIR1
	btfss	PIR1,SSPIF	;Ha ocurrido un evento SSP? (I2C)
	goto	IntNoSSP	;No. entonces ser� por otra cosa. Saltamos.
	bcf 	SSPCON,CKP	;Si. Detenemos reloj I2C para evitar posible desbordamiento o timeout
	call	SSP_Handler	;Procesamos el evento. Si se reciben ordenes, quedar�n
				;registradas en "MensajeIn". Se enviar�n las ordenes 
				;guardadas en "MensajeOut".
	banksel PIR1
	bcf	PIR1,SSPIF	;Limpiamos el flag
	goto	Rest

IntNoSSP	;Aqu� se gestionan interrupciones que no son por SSP

;..........
; En caso de necesitarse, poner aqu� la rutina de gesti�n de interrupciones 
; que no sean por bus I2C
;..........


Rest
	banksel	SSPCON
	bsf 	SSPCON,CKP	;Reactivamos reloj I2C 

	;Restauramos las copias de los registros
	banksel	BkStatus2
	movf	BkStatus2,W	;Restaura las copias de registros
	movwf	STATUS		;registro de estado
	movf	BkW2,W		;registro W

	retfie


;-------------------------------------------------------------------------------




INICIO		;Inicio del cuerpo del programa

	call	init_i2c_Slave	;Configuraci�n para uso de i2c
	banksel INTCON
	bsf	INTCON,GIE	;Activamos las interrupciones

	banksel MensajeIn
	clrf	MensajeIn
	clrf	MensajeOut


MLoop	

	;ECO. Lo que entra se pone en la variable de salida.
	;Se puede quitar esta copia y utilizar independientemente "MensajeIn" y
	;"MensajeOut". Simplemente en "MensajeIn" siempre estar� el �ltimo byte 
	;enviado por el master y lo que se deje en "MensajeOut" ser� enviado al 
	;master cuando este lo solicite.

	movf	MensajeIn,W	;Toma valor de entrada "MensajeIn" y lo copia...
	movwf	MensajeOut	;.. en "MensajeOut" para cuando el Master se lo pida
	goto	MLoop




;*********************************************************************************
; SUBRUTINAS
;*********************************************************************************

;-------------------------------------------------------------------------------
init_i2c_Slave		;Inicializa valores para uso de I2C en Slave
			;Ha de ser llamado tras definir TRISC (de ser necesario)
;-------------------------------------------------------------------------------

	;Guardamos copia de algunos registros
	movwf	BkW		;Hace copia de W
	movf	STATUS,W	;Hace copia de registro de estado
	banksel	BkStatus
	movwf	BkStatus

	;Configuramos I2C
	banksel TRISC		; Pasamos a direccionar Banco 1
	movlw 	b'00011000'	; Establece l�neas SDA y SCL como entradas...
	iorwf 	TRISC,f		;..respetando los valores para otras l�neas.
	bcf 	SSPSTAT,CKE 	; Establece I2C input levels
	bcf 	SSPSTAT,SMP 	; Habilita slew rate
	bsf	SSPCON2,GCEN	; Habilita direccionamiento global
	movlw	DirNodo		; Direcci�n esclavo 
	movwf	SSPADD		;
	banksel SSPCON 		; Pasamos a direccionar Banco 0
	movlw 	b'00110110'	; Slave mode, SSP enable, velocidad segun...
	movwf 	SSPCON 		; ... Fosc/(4x(SSPADD+1))
	bcf	PIR1,SSPIF	; Limpia flag de eventos SSP
	bcf	PIR1,7		; Limpia bit. Mandatorio por Datasheet

	;Configuraci�n para interrupciones por evento I2C
	banksel PIE1
	bsf	PIE1,SSPIE
	bsf	INTCON,PEIE

	;Restauramos las copias de los registros 
	movf	BkStatus,W	;Restaura las copias de registros
	movwf	STATUS		;registro de estado
	movf	BkW,W		;registro W

	return


; --------------------------------------------------------------------------------------
SSP_Handler	; Este manejador controla cada evento SSP (I2C) acontecido. 
		; El c�digo que se muestra abajo chequea 5 posibles estados.
		; Cada uno de los 5 estados SSP son identificados haciendo 
		; XOR de los bits del registro SSPSTAT con mascaras de bits
		; predeterminadas. Una vez que el estado ha sido identificado
		; se llevan a cabo las acciones pertinentes. Los estados
		; indefinidos son considerados como estados de error.

		; State 1: Operaci�n de escritura I2C, ultimo byte era de direcci�n.
		; SSPSTAT bits: S = 1, D_A = 0, R_W = 0, BF = 1

		; State 2: Operaci�n de escritura I2C, ultimo byte era de datos.
		; SSPSTAT bits: S = 1, D_A = 1, R_W = 0, BF = 1

		; State 3: Operaci�n de lectura I2C, ultimo byte era de direcci�n.
		; SSPSTAT bits: S = 1, D_A = 0, R_W = 1, BF = 0

		; State 4: Operaci�n de lectura I2C, ultimo byte era de datos.
		; SSPSTAT bits: S = 1, D_A = 1, R_W = 1, BF = 0

		; State 5: Reset l�gico del Slave I2C por NACK del master.
		; SSPSTAT bits: S = 1, D_A = 1, R_W = 0, BF = 0

; --------------------------------------------------------------------------------------

	banksel SSPSTAT
	movf 	SSPSTAT,W 	; Obtiene el valor de SSPSTAT
	andlw 	b'00101101' 	; elimina los bits no importantes SSPSTAT.
	banksel	Temp
	movwf 	Temp 		; para chequeo posterior.

State1: 			; Operaci�n de escritura, ultimo byte ha sido
	movlw 	b'00001001' 	; de direcci�n, el buffer est� lleno.
	banksel	Temp
	xorwf 	Temp,W 		;
	btfss 	STATUS,Z 	; Estamos en el primer estado?
	goto 	State2 		; No, checkeamos siguiente estado
	call 	ReadI2C 	; SI. Hacemos un read SSPBUF (para vaciar buffer).
				; El Hardware se ocupa de mandar Ack
	return

State2: 			; Operaci�n de escritura, ultimo byte ha sido
	movlw 	b'00101001' 	; de datos, el buffer est� lleno.
	banksel	Temp
	xorwf 	Temp,W
	btfss 	STATUS,Z 	; Estamos en el segundo estado?
	goto 	State3 		; NO, checkeamos siguiente estado
	call 	ReadI2C 	; SI, Tomamos el byte del SSP.

	;Aqu� tenemos en W el valor del dato recibido
	movwf	MensajeIn
	return

State3: 			; Operaci�n de lectura, ultimo byte ha sido
	movlw 	b'00001100' 	; de direcci�n, el buffer est� vac�o
	banksel	Temp
	xorwf 	Temp,W
	btfss 	STATUS,Z 	; Estamos en el tercer estado?
	goto 	State4 		; NO, checkeamos siguiente estado

	;Aqu� debemos poner en W el valor del dato a enviar (solicitado por el master)
	movf	MensajeOut,W

	call 	WriteI2C 	; SI, escribimos el byte en SSPBUF
	return

State4: 			; Operaci�n de lectura, ultimo byte ha sido
	movlw 	b'00101100' 	; de datos, el buffer est� vac�o
	banksel	Temp
	xorwf 	Temp,W
	btfss 	STATUS,Z 	; Estamos en el cuarto estado?
	goto 	State5 		; NO, checkeamos siguiente estado

	;Aqu� debemos poner en W el valor del dato a enviar (solicitado por el master)
	movf	MensajeOut,W

	call 	WriteI2C 	; SI, escribimos el byte en SSPBUF
	return

State5:
	movlw 	b'00101000' 	; Se ha recibido un NACK mientras se transmit�an...
	banksel	Temp
	xorwf 	Temp,W 		; ..datos al master. Lo l�gica del Slave..
	btfss 	STATUS,Z 	; ..se resetea en este caso. R_W = 0, D_A = 1
	goto 	I2CErr 		; y BF = 0
	return 			; Si no estamos en State5, entonces es
				; que algo fue mal

I2CErr 	nop			; Algo fue mal. Reseteamos el m�dulo I2C
	call 	ReadI2C 	; Vaciamos buffer por si hubo overflow
	banksel SSPCON
	bcf	SSPCON,SSPEN	; Detenemos I2C
	banksel SSPSTAT
	clrf	SSPSTAT
	bcf 	SSPSTAT,CKE 	; Establece I2C input levels
	bcf 	SSPSTAT,SMP 	; Habilita slew rate
	banksel SSPCON
	bsf	SSPCON,SSPEN	; Reactivamos I2C

	return


;---------------------------------------------------------------------
WriteI2C	;Usada por SSP_Handler para escribir datos en bus I2C
;---------------------------------------------------------------------

	banksel SSPCON 		
	movwf 	SSPBUF 		; Escribe el dato en W
	bsf 	SSPCON,CKP 	; Libera el reloj
	return

;---------------------------------------------------------------------
ReadI2C		;Usada por SSP_Handler para escribir datos en bus I2C
;---------------------------------------------------------------------

	banksel SSPBUF
	movf 	SSPBUF,W 	; Toma el byte y lo guarda en W
	return

	END
