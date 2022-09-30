; Rotina de c�pia de byte - [GBA] Zelda: A Link to the Past

; Escrito por Diego Hahn - Julho de 2010

.gba

.open "0776.gba","Zelda ALttP (TEXTS).gba", 0x0
.thumb

.org 0x129648
.db 0x20, 0x5c, 0x64, 0x08	; Endere�o do novo bloco de ponteiros/textos

; Decodifica um byte (seja ponteiro, seja texto)
; Entrada:
;		r0 - �nicio dos dados codificados (sempre 08180ce8) (n�o ser� usado)
; 		r1 - Posi��o do byte a ser decodificado
; Sa�da:
;		r0 - Byte decodificado

.org 0x129E0C
push {r4,r5,r14}
ldrb r0,[r1]
pop {r4,r5}
pop {r1}
bx r1

.org 0x645c40 ; Novo endere�o + 20h
;.import "pointers.bin"
;.import "texts.bin"
.import "outfile.bin"

.close

