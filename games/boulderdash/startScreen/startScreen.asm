;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Felirat műveletek
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BGCNT: DB 0
LINECNT: EQU 19
FAST_LINE: EQU 17
DOWN: EQU 64

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Első publikus fő művelet, kirajzolja 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TEXT_INIT:
    EXX
    CALL SHOW_BG_ANIM
    LD DE, FELIRAT
    LD HL, SHADOW + 2*64+8
    CALL SHOW_TEXT_DE_HL
    LD HL, SHADOW + 10*64+8
    CALL SHOW_TEXT_DE_HL
    CALL SHOW_BORDER
    CALL SHOW_BOTTOM_TEXT
    EXX
    RET

BIGSPACE: EQU 96

SHOW_BORDER:
    LD HL, SHADOW
    CALL SHOW_H_LINE_HL
    LD HL, SHADOW+LINECNT*64-64
    CALL SHOW_H_LINE_HL
    LD HL, SHADOW
    LD A, BIGSPACE
    CALL SHOW_V_LINE_HL_A
    LD HL, SHADOW+1
    LD A, BIGSPACE
    CALL SHOW_V_LINE_HL_A
    LD HL, SHADOW+2
    LD A, 255
    CALL SHOW_V_LINE_HL_A
    LD HL, SHADOW+61
    LD A, 255
    CALL SHOW_V_LINE_HL_A
    LD HL, SHADOW+62
    LD A, BIGSPACE
    CALL SHOW_V_LINE_HL_A
    LD HL, SHADOW+63
    LD A, BIGSPACE
    CALL SHOW_V_LINE_HL_A
    RET

SHOW_V_LINE_HL_A:
    LD DE, 64
    LD B, LINECNT
SHOW_V_LOOP:
    LD (HL), A
    ADD HL, DE
    DJNZ SHOW_V_LOOP
    RET

SHOW_H_LINE_HL:
    PUSH HL
    POP DE
    INC DE
    LD (HL),255
    LD BC,63
    LDIR
    RET

SHOW_TEXT_DE_HL:
    LD B, 7                 ; A sorok száma
SHOW_LINE:
        LD A, 48            ; Bájtok száma a soron belül
SHOW_LINE_CHAR:
        EX AF,AF' ; '
        LD A, (DE)
        CP 46
        JR Z, SKIP_SHOW_CHAR
        LD (HL), A
SKIP_SHOW_CHAR:
        EX AF,AF' ; '
        INC DE
        INC HL
        DEC A
        JR NZ, SHOW_LINE_CHAR
        EX AF,AF' ; '
        LD A, B
        LD BC, 16
        ADD HL, BC
        LD B, A
        EX AF,AF' ; '
    DJNZ SHOW_LINE
    RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Háttéranimáció
;;; 29->28->32->0->29
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SHOW_BG_ANIM_V2:
    LD DE, SHADOW
    ;LD BC, 64 * FAST_LINE ; LINECNT*64
    LD BC, LINECNT*64
    ;EXX
    ;CALL MUSIC_BG
    ;EXX
SHOW_BG_ANIM_V2_LOOP:
    LD A, (DE)
    CP 33              ; 20 100000
    JR NC, SHOW_BG_ANIM_V2_NEXT   ; Ha >= 33, akkor mehetünk a következőre
    LD H, ANIMTABLE_HIGH
    LD L, A
    LD A, (HL)
    LD (DE), A
SHOW_BG_ANIM_V2_NEXT:
    INC DE
    DEC BC
    LD A, B
    OR C
    JR NZ, SHOW_BG_ANIM_V2_LOOP
    RET

SHOW_BG_ANIM:
    LD HL, BGCNT
    INC (HL)
    LD A, (HL)
    AND 3
    LD HL, BG
    CP 0
    JP Z, SHOW_BG_HL
    LD HL, BG1
    CP 1
    JP Z, SHOW_BG_HL
    LD HL, BG2
    CP 2
    JP Z, SHOW_BG_HL
    LD HL, BG3
SHOW_BG_HL:
    LD DE, SHADOW
    LD BC, BG_LENGTH
    LDIR
    LD HL, SHADOW
    LD BC, LINECNT*64-BG_LENGTH
    LDIR
    RET

COPY_SHADOW_FULL:
    LD HL, SHADOW
    LD DE, SCREEN+DOWN
    LD BC, 64*LINECNT
    LDIR
    RET

FELIRAT: ; A Boulder Dash felirat
include 'startScreen/startScreen.data.asm'
include 'startScreen/startScreen.bg.asm'
include 'startScreen/startScreen.copy.asm'
include 'startScreen/startScreen.bottom.asm'

SHADOW: ; DS 64*LINECNT, 0                                   ; = 1216
MAX_DIAMOND_COUNTER: EQU 178                                 ; Ez a legtöbb gyémánt egy pályán. Mivel az amőbás pályán is max 120 másodperce van, így ott is belefér ebbe
DiamondGravityPuffer: DS MAX_DIAMOND_COUNTER*3, 0            ; =  534
MAX_STONE_COUNTER:  EQU 350 ;  224                           ; stones 224, 106+200, és a másik amőbás helyen mennyi is?
StoneGravityPuffer: DS MAX_STONE_COUNTER*3, 0                ; = 1050
