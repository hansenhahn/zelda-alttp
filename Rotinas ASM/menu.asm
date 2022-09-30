; Alteração da rotina de "desenho" do menu
; Escrito por Diego Hahn - Agosto de 2013
.gba

; Rever input/output
.open "..\0776.gba", "..\Releases\Zelda ALttP (menu).gba", 0x08000000
.thumb

RomEnd					equ 0x08645c00

; Rotinas
DoItemOriginal 			equ 0x080a7f9c
EquipmentOriginal 		equ 0x080a800e

; Ponteiros
.org 0x0816be98
.dw NomesItensImg
.dw NomesItensImg
.org 0x0822b9f8 
.dw AlfabetoMenuImg
.org 0x0822ba04
.dw AlfabetoMenuImg
.org 0x0822b9f0
.dw NomePendantsImg
.org 0x0822b9fc
.dw NomePendantsImg

; Tradução das AÇÕES
.org 0x080a8dea
mov		r3,5h
.org 0x0816c912
.dh 0x8130, 0x8131, 0x8132, 0x8133, 0x8144 ; ERGUER.1
.org 0x0816c926
.dh 0x815b, 0x8154, 0x8161, 0x80f5, 0x80f5 ; LER
.org 0x0816c93a
.dh 0x8155, 0x8150, 0x815b, 0x8150, 0x8161 ; FALAR
.org 0x0816c94e
.dh 0x815f, 0x8164, 0x8167, 0x8150, 0x8161 ; PUXAR

; Tradução dos ITENS (a partir de 0x0816c428 - 32 bytes para cada nome)
.org 0x080aa3a0
mov		r2,7h	; Largura máxima de cada linha
.org 0x0816c428
; -- 428
.dh 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5	; L1: 
.dh 0x8150, 0x8161, 0x8152, 0x815e, 0x80f5, 0x80f5, 0x80f5, 0x80f5	; L2: ARCO
; -- 448
.dh 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5	; L1: 
.dh 0x8180, 0x8181, 0x8182, 0x8183, 0x8184, 0x8185, 0x8186, 0x8187	; L2: BUMERANGUE
; -- 468
.dh 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5	; L1:
.dh 0x8156, 0x8150, 0x815d, 0x8152, 0x8157, 0x815e, 0x80f5, 0x80f5	; L2: GANCHO
; -- 488
.dh 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5	; L1: 
.dh 0x8151, 0x815e, 0x815c, 0x8151, 0x8150, 0x80f5, 0x80f5, 0x80f5	; L2: BOMBA
; -- 4a8
.dh 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5	; L1: 
.dh 0x8152, 0x815e, 0x8156, 0x8154, 0x815c, 0x8154, 0x815b, 0x815e  ; L2: COGUMELO
; -- 4c8
.dh 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5	; L1: 
.org 0x0816c588
; -- 588
.dh 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5	; L1: 
.dh 0x8152, 0x815e, 0x8156, 0x8154, 0x815c, 0x8154, 0x815b, 0x815e  ; L2: COGUMELO
; -- 5a8
.dh 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5, 0x80f5	; L1: 
.dh 0x8100, 0x8101, 0x8102, 0x8103, 0x8104, 0x8105, 0x8106, 0x8107	; L2: LAMPARINA



; Queremos alterar a rotina que mostra ITEM / DO
.org DoItemOriginal
ldr		r3,=NewItemDoMenu 		; Nova rotina
mov		r15, r3
.pool

.org RomEnd 					; (rever ponteiro)
NewItemDoMenu:
lsl		r1,r5,1h
ldr		r3,=2000402h
add		r2,r1,r3
ldr		r4,=9246h				; Posição no tilemap (VRAM)
mov		r0,r4
strh	r0,[r2]
ldr		r0,=2000404h
add		r2,r1,r0
mov		r0,4h					; 4 tiles
strh	r0,[r2]
add		r3,4h					; "ITEM"
add		r2,r1,r3				
ldr		r4,=81F8h				; 81F8 = "I"
mov		r0,r4
strh	r0,[r2]
ldr		r0,=2000408h
add		r2,r1,r0
ldr		r3,=81F9h				; 81F9 = "T"
mov		r0,r3
strh	r0,[r2]
ldr		r4,=200040Ah
add		r2,r1,r4
add		r3,1h					; 81FA = "E"
mov		r0,r3
strh	r0,[r2]
add		r4,2h
add		r2,r1,r4
add		r3,1h					; 81FB = "M"
mov		r0,r3
strh	r0,[r2]
add		r4,2h
add		r2,r1,r4
; A partir daqui, a rotina é minha!
ldr		r3,=9586h				; Posição no tilemap (VRAM)
mov		r0,r3
strh	r0,[r2]
add		r4,2h
add		r2,r1,r4
ldr		r1,=DoData
ldrh	r7,[r1]
strh	r7,[r2]
ldr		r0,=2000412h			; "AÇÃO"
mov		r2,r0
add		r1,2h
mov		r4,0h
DoDataLoop:
ldrh	r3,[r1]
strh	r3,[r2]
add		r1,2h
add		r2,2h
add		r4,1h
cmp		r4,r7
bne		DoDataLoop
mov 	r1,r2
ldr		r2,=0FFFFh				; [2000416] = FFFF
mov		r0,r2
strh	r0,[r1]
ldr		r1,=2000400h
mov		r0,r5
add		r0,8h					; referente a ITEM
add		r0,r7
ldr		r3,=EquipmentOriginal	; Retorno para a rotina original
mov		r15, r3
.pool

.align 2
DoData:
.dh	0x0004, 0x8150, 0x8170, 0x816f, 0x815E ; AÇÃO
; Tamanho, Tile1, Tile2, Tile3, Tile4, ...TileN

; Imagens
.align
AlfabetoMenuImg:
.import "..\Imagens Comprimidas\AlfabetoMenu.gba"

.align
NomesItensImg:
.import "..\Imagens Comprimidas\NomesItens.gba"

.align
NomePendantsImg:
.import "..\Imagens Comprimidas\NomePendants.gba"

.close