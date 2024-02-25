START_TEXT1: EQU SCREEN + 21 * 64 + 3
START_TEXT31: EQU SCREEN + 25 * 64
START_TEXT32: EQU SCREEN + 43 + 25 * 64
START_TEXT4: EQU SCREEN + 27 * 64 + 2
START_TEXT5: EQU SCREEN + 29 * 64 + 19
START_TEXT9: EQU SCREEN + 31 * 64

CAVE_POS: EQU START_TEXT31 + 13
LEVEL_POS: EQU START_TEXT32 + 14

SHOW_BOTTOM_TEXT:
    LD HL, HOMELAB3DATA
    LD DE, START_TEXT1
    CALL BIG_PRINT_HL_DE

    LD DE, BOTTOM_TEXT31
    LD HL, START_TEXT31
    CALL Direct_Class_Screen_Method_write_text_Code ; SCREEN.write_text( DE, HL )

    LD DE, BOTTOM_TEXT32
    LD HL, START_TEXT32
    CALL Direct_Class_Screen_Method_write_text_Code ; SCREEN.write_text( DE, HL )

    LD DE, BOTTOM_TEXT4
    LD HL, START_TEXT4
    CALL Direct_Class_Screen_Method_write_text_Code ; SCREEN.write_text( DE, HL )

    LD DE, BOTTOM_TEXT5
    LD HL, START_TEXT5
    CALL Direct_Class_Screen_Method_write_text_Code ; SCREEN.write_text( DE, HL )
    CALL SHOW_HIGHSCORE_TO_HL

    LD HL, START_TEXT9
    LD DE, START_TEXT9+1
    LD BC, 63
    LD (HL), BG_CHAR
    LDIR
    RET

BIG_PRINT_HL_DE:

    LD A, (HL)     ; A-ban a bájtok száma egy sorban
    INC HL

    PUSH DE
    LD B, 0
    LD C, A
    LDIR           ; Első karaktersor kiírása
    POP DE
    LD BC, 64
    EX DE, HL
    ADD HL, BC
    EX DE, HL

    PUSH DE
    LD B, 0
    LD C, A
    LDIR           ; Második karaktersor kiírása
    POP DE
    LD BC, 64
    EX DE, HL
    ADD HL, BC
    EX DE, HL
    LD B, 0
    LD C, A
    LDIR           ; Harmadik karaktersor kiírása

    RET

; BOTTOM_TEXT1: DB "Boulder Dash Homelab III version. 2024", 0
;BOTTOM_TEXT3: DB "Select cave: A (A-T) Select level: 1 (1-5)", 0 ; ABCDEFGHIJKLMNOPQRST
; include 'startScreen/startScreen.ANIMTABLE.asm'
BOTTOM_TEXT4: DB "Press FIRE or CR to start with joystick or keyboard /Q: quit@"
BOTTOM_TEXT5: DB "Current high score: @"

HOMELAB3DATA:
include 'startScreen/homelab3.data.asm';
