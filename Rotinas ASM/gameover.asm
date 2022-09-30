; Alteração da rotina de gameover
; Escrito por Diego Hahn - Agosto de 2013
.gba

; Rever input/output
.open "..\0776.gba", "..\Releases\Zelda ALttP (gameover).gba", 0x08000000
.thumb
; Rotina 1 (início em 080B0250)
.org 0x080b025e
mov     r3, 0d0h			; Posição inicial de todas as letras
.org 0x080b0264
mov     r1, 8h				; Número de letras a serem mostradas menos um
.org 0x080b027e
mov 	r0, 7h
.org 0x080b0398
.dw 0x0dd7					; The trick!!! :DDDDD

; Rotina 2 (início em 080B029C)
.org 0x080b02e4
cmp     r4, 9h				; Compara com a última letra
.org 0x080b02e8
mov     r0, 8h				; Compara com a última letra
.org 0x080b032c
cmp     r4, 8h				; Compara com a penúltima letra
.org 0x080b0330
mov		r2, 7h				; ??
.org 0x080b033c
cmp		r1, 7h				; ??
.org 0x080b03ea
; Rotina 3 (início em )
cmp		r0, 9h				; Total de letras

; Ponteiros
.org 0x080b0320
.dw GameOverXPosFinal		; Endereço da posição X final das letras  (Rever ponteiro)
.org 0x080b03a0
.dw GameOverXPosFinal		; Endereço da posição X final das letras  (Rever ponteiro
.org 0x080b041c
.dw GameOverXPosFinal2
.org 0x080b0538
.dw GameOverTileIndex		; Índice dos tiles			
.org 0x0822b338
.dw GameOverImg				; Endereço da imagem gameover

.org 0x08645c00 			; (rever ponteiro)
GameOverXPosFinal:
.db 0x38, 0x48, 0x58, 0x70	; Cada byte é a posição X final das letras
.db 0x80, 0x98, 0xa8, 0xb8	; Cada byte é a posição X final das letras
.db 0x38, 0x00, 0x00, 0x00	; Cada byte é a posição X final das letras (últimos 3 bytes de padding)
GameOverXPosFinal2:
.db 0x50, 0x58, 0x60, 0x70  ;
.db 0x78, 0x88, 0x90, 0x98  ;
.db 0xa0, 0x00, 0x00, 0x00
GameOverTileIndex:
; Índice do tile
.dh 0xaf8f, 0xa181,
.dh 0xa282, 0xa585,
.dh 0xa383, 0xa686,
.dh 0xa484, 0xa080,
.dh 0xa484, 0x0000,
GameOverImg:
.import "..\Imagens Comprimidas\GameOver.gba"

.close

