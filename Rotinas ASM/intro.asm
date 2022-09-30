
; Alteração da rotina de "desenho" do menu
; Escrito por Diego Hahn - Agosto de 2013
.gba

; Rever input/output
.open "C:\Users\Hansen\Romhacking\Projetos\Intro\intro.gba", "new_intro.gba", 0x08000000
.thumb



.org 0x08000000
.import "..\0776-2.gba"

.org 0x08000100
.dw 0x08660127

.org 0x08661324
.dw 0x08660211


; .org 0x660000
; .import "intro.gba"

; .org 0x660120
; bl 6629f0h

; .org 0x6629f0;0x664540
; ldr r1,=0x08660000
; mov r0, 3h
; add r3, r3, r0
; bic r3, r0
; beq Back

; Copy:
; ldmia [r1]!,r0
; stmia [r2]!,r0
; sub r3, 4h
; bne Copy

; Back:
; bx r14

.pool

.close

