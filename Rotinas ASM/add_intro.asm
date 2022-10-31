; Teste rotina splash
; Escrito por Diego Hahn - Agosto de 2013
.gba

; Rever input/output
.open "..\0776.gba", "..\Releases\Zelda ALttP PT-BR Intro.gba", 0x08000000
.thumb

RomEnd					equ 0x083B37B4
RomEnd2					equ 0x08645c00

.org 0x0812d4a4
.dw Dummy

.org 0x0842731c
.dw ( RomEnd + 1 )

.org RomEnd

push    r4,r14								; entry point
ldr     r0,=3000BFCh
ldrb    r0,[r0]								; 
; r0 = 1 - Fade IN Nintendo
; r0 = 2 - Fade OUT Nintendo
; r0 = 3 - Fade IN Zelda
; r0 = 4 - Fade OUT Zelda
cmp     r0,6h								; comparação!!
bls     goto_run							; salta se for menor ou igual
b       goto_exit
goto_run:
lsl     r0,r0,2h
ldr     r1,=jumps
add     r0,r0,r1
ldr     r0,[r0]							
; r0 = 4 - 0800d524
; r0 = 8 - 0800d580
; r0 = 12 - 0800d590
; r0 = 16 - 0800d5e4
mov     r15,r0							; Jump para as funções de cada imagem
.pool
jumps:
.dw goto_splash_fade_in , goto_splash_fade_out
.dw goto_nintendo_fade_in , goto_nintendo_fade_out
.dw goto_zelda_fade_in , goto_zelda_fade_out
.dw goto_go_back

goto_splash_fade_in:
bl      800BED8h							; Chamado se [3000BFCh] == 0
ldr     r1,=30004A0h
mov     r0,80h
lsl     r0,r0,1h
strh    r0,[r1]
mov     r0,0E0h
lsl     r0,r0,5h
strh    r0,[r1,8h]
mov     r0,0h								; Índice 4
; ; 4 << 10h = 40000
; ; 40000 >> eh = 10
; ; 084297f8 + 10h = 08429808
bl      set_new_image							; Função que queremos
ldr     r0,=202A8C0h
ldrb    r0,[r0]
mov     r1,0h
cmp     r0,0h
bne     goto_set_palette_idx
mov     r1,3h
goto_set_palette_idx:
mov     r0,r1
; ; 08429750 + 28h * 4
; ; [084297f0] = 08143678
; ; [08143678] = 2080 00 02
; ; 0844dd74 + 2080 - Endereço paleta de cores
bl 	set_new_palette
;bl      800B890h							; Função para escolher a paleta de cores
ldr     r1,=7FFFh
mov     r0,0h
bl      800B980h
ldr     r4,=2016D60h
mov     r0,r4
mov     r1,28h
bl      800B850h
mov     r0,3Ch
strh    r0,[r4,4h]
mov     r0,2h
mov     r1,8h
bl      800C0B0h
ldr     r1,=3000BFCh
ldrb    r0,[r1]
add     r0,1h
strb    r0,[r1]
b       goto_exit
.pool

goto_nintendo_fade_in:
bl      800BED8h							; Chamado se [3000BFCh] == 0
ldr     r1,=30004A0h
mov     r0,80h
lsl     r0,r0,1h
strh    r0,[r1]
mov     r0,0E0h
lsl     r0,r0,5h
strh    r0,[r1,8h]
mov     r0,4h								; Índice 4
; ; 4 << 10h = 40000
; ; 40000 >> eh = 10
; ; 084297f8 + 10h = 08429808
bl      800BA44h							; Função que queremos
ldr     r0,=202A8C0h
ldrb    r0,[r0]
mov     r1,28h
cmp     r0,0h
bne     goto_set_palette_idx1
mov     r1,3h
goto_set_palette_idx1:
mov     r0,r1
; ; 08429750 + 28h * 4
; ; [084297f0] = 08143678
; ; [08143678] = 2080 00 02
; ; 0844dd74 + 2080 - Endereço paleta de cores
bl      800B890h							; Função para escolher a paleta de cores
ldr     r1,=7FFFh
mov     r0,0h
bl      800B980h
ldr     r4,=2016D60h
mov     r0,r4
mov     r1,28h
bl      800B850h
mov     r0,3Ch
strh    r0,[r4,4h]
mov     r0,2h
mov     r1,8h
bl      800C0B0h
ldr     r1,=3000BFCh
ldrb    r0,[r1]
add     r0,1h
strb    r0,[r1]
b       goto_exit
.pool
goto_splash_fade_out:
bl      800C41Ch
bl      800D610h
cmp     r0,0h
beq     goto_exit
mov     r0,1h
mov     r1,8h
bl      800C0B0h
b       goto_exit
ldr     r0,=3000520h
ldrb    r0,[r0]
cmp     r0,0h
bne     goto_exit
mov     r0,8h
bl      800B5ECh
b		goto_exit
.pool

goto_nintendo_fade_out:
bl      800C41Ch
bl      800D610h
cmp     r0,0h
beq     goto_exit
mov     r0,1h
mov     r1,8h
bl      800C0B0h
b       goto_exit
ldr     r0,=3000520h
ldrb    r0,[r0]
cmp     r0,0h
bne     goto_exit
mov     r0,8h
bl      800B5ECh
b		goto_exit
.pool
goto_zelda_fade_in:
ldr     r0,=3000520h						; Chamado se [3000BFCh] == 8
ldrb    r0,[r0]
cmp     r0,0h
bne     goto_exit
mov     r0,7h								; Índice 7 Imagem
bl      800BA44h							; Entrada da função
mov     r0,7h								; Índice 7 Paleta de cores
bl      800B890h
ldr     r1,=30004A0h
mov     r0,0C0h
lsl     r0,r0,2h
strh    r0,[r1]
mov     r0,0E0h
lsl     r0,r0,5h
strh    r0,[r1,8h]
ldr     r0,=1D05h
strh    r0,[r1,14h]
mov     r0,0h
mov     r1,8h
bl      800C0B0h
ldr     r1,=2016D60h
mov     r0,78h
strh    r0,[r1,4h]
ldr     r1,=3000BFCh
ldrb    r0,[r1]
add     r0,1h
strb    r0,[r1]
b       goto_exit
.pool

goto_zelda_fade_out:
bl      800D610h
cmp     r0,0h
beq     goto_exit
mov     r0,3h
mov     r1,8h
bl      800C0B0h
b       goto_exit
goto_go_back:
ldr     r0,=3000520h
ldrb    r0,[r0]
cmp     r0,0h
bne     goto_exit
mov     r0,8h
bl      800B5ECh
goto_exit:
pop     r4
pop     r0
bx      r0
.pool


set_new_image:
push    r4,r5,r14
lsl     r0,r0,10h
ldr     r1,=PointerTbl
lsr     r0,r0,0Eh
add     r0,r0,r1
ldr     r4,[r0]
ldr     r5,=202A8C0h
goto_start:
mov     r2,0h
ldrb    r1,[r4,3h]
mov     r0,0Fh
and     r1,r0
cmp     r1,0Eh
beq     goto_equal_0e
cmp     r1,0Eh
bhi     goto_higher_than_0e
cmp     r1,7h
beq     goto_equal_07
b       goto_else
.pool
str     r7,[sp,3E0h]
lsr     r2,r0,1h
add     r0,sp,300h
lsl     r2,r0,8h
goto_higher_than_0e:
cmp     r1,0Fh
beq     goto_800BA7Eh
b       goto_else
ldrb    r0,[r5]
goto_equal_0e:
cmp     r0,1h
bls     goto_800BA8Eh
b       goto_equal_07
goto_800BA7Eh:
ldrb    r0,[r5]
cmp     r0,0h
beq     goto_800BA8Eh
b       goto_equal_07
 goto_else:
ldrb    r0,[r5]
cmp     r1,r0
bne     goto_800BA8Eh
mov     r2,1h
goto_800BA8Eh:
cmp     r2,0h
beq     goto_continue
goto_equal_07:
ldr     r2,=3000030h
ldr     r1,[r4]
ldr     r0,=0FFFFFFh
and     r1,r0
ldr     r0,[r2]
add     r3,r0,r1
ldr     r1,[r4,4h]
ldr     r2,[r4,8h]
cmp     r2,0h
bge     goto_r2_greater_than_0
ldr     r0,=5FFFFFFh
cmp     r1,r0
bls     goto_r1_ls_r2
mov     r0,r3
bl      8135B8Ch
b       goto_continue
.pool
goto_r1_ls_r2:
mov     r0,r3
bl      8135B90h
b       goto_continue
goto_r2_greater_than_0:
lsl     r2,r2,0Ah
lsr     r2,r2,0Bh
mov     r0,r3
bl      8135B7Ch
goto_continue:
ldrb    r1,[r4,3h]
mov     r0,80h
and     r1,r0
add     r4,0Ch
cmp     r1,0h
bne     goto_start
pop     r4,r5
pop     r0
bx      r0
.pool

set_new_palette:
push    r4,r14
ldr     r1,=PalettePointerTbl
lsl     r0,r0,2h
add     r0,r0,r1
ldr     r4,[r0]
b       goto_800B8A2h
.pool
; 0800B89C 9750     str     r7,[sp,140h]
; 0800B89E 0842     lsr     r2,r0,1h
goto_800B8A0h:
add     r4,4h
goto_800B8A2h:
ldrb    r3,[r4,4h]
ldrb    r0,[r4,5h]
mov     r2,0Fh
and     r2,r0
cmp     r2,0h
bne     goto_800B8B0h
mov     r2,10h
goto_800B8B0h:
ldr     r0,[r4]
ldr     r1,=3000030h
ldr     r1,[r1]
add     r0,r0,r1
mov     r1,r3
bl      800B8D4h
ldrb    r1,[r4,5h]
mov     r0,80h
and     r0,r1
cmp     r0,0h
bne     goto_800B8A0h
pop     r4
pop     r0
bx      r0
.pool

.align
PalettePointerTbl:
.dw PalettePtr

.align
PalettePtr:
.dw (SplashPal - 0x0844dd74 ) 
.db 0x00, 0x02

.align
PointerTbl:
.dw SplashBgPtr 

.org RomEnd2
SplashBgPtr:
.dw (( SplashBgImg - 0x0844dd74) | 0x87000000) , 0x06000000 , 0x800007cc
.dw	(( SplashTmImg - 0x0844dd74) | 0x07000000) , 0x0600e000 , 0x80000164

.align
SplashBgImg: .import "..\Splash\bg_splash_lz77.gba"
.align
SplashTmImg: .import "..\Splash\tm_splash_lz77.gba"
.align
SplashPal: .import "..\Splash\splash_pal.bin"

.align
Dummy: .import "..\Splash\dummy_lz77.gba"

.close