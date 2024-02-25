;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Homelab III. Clock speed 4MHz. The Z80 T = 0.4us
;;; Fontos!!!
;;; A startScreen.asm fájl ANIMTABLE: címkéjének 256-tal osztható címen kell kezdődnie!!!
;;; De ezek közül a legkisebbet érdemes meghagyni a tesztelés végén
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;BOTTOM_TEXT1: DB "Boulder Dash Homelab III version. 2024", 0
BOTTOM_TEXT31: DB "Select cave: A <A-T>@" ; ABCDEFGHIJKLMNOPQRST
BOTTOM_TEXT32: DB "Select level: 1 <1-5>@" ; 12345
;BOTTOM_TEXT5: DB "High:@"
;BOTTOM_TEXT4: DB "Press SPACE to start with joy, or CR to start with keyboard", 0

include 'startScreen/startScreen.ANIMTABLE.asm'

SHOW_START_SCREEN:
    CALL ROM_CLS
    CALL MUSIC_INIT
    CALL TEXT_INIT
    EXX
    CALL COPY_SHADOW_FULL
    EXX
START_SCREEN_LOOP:
    CALL MUSIC_BG
    CALL ROM_WAIT_SCREEN

    EXX
    CALL COPY_SHADOW
    CALL SHOW_BG_ANIM_V2

    LD A, (KEYBOARD_SpaceCr_ADDR)
    AND NOTHING_PRESSED
    CP NOTHING_PRESSED
    RET NZ                      ; START

    LD BC, 4
    LD HL, KEYBOARD_DATA_AB
    LD DE, CAVE_POS
    LD A, (KEYBOARD__AAB_ADDR)
    CALL CHECK_KEY_A_BC_DE_HL
    LD A, (KEYBOARD_CDEE_ADDR)
    CALL CHECK_KEY_A_BC_DE_HL
    LD A, (KEYBOARD_FGHI_ADDR)
    CALL CHECK_KEY_A_BC_DE_HL
    LD A, (KEYBOARD_JKLM_ADDR)
    CALL CHECK_KEY_A_BC_DE_HL
    LD A, (KEYBOARD_NOOO_ADDR)
    CALL CHECK_KEY_A_BC_DE_HL
    LD A, (KEYBOARD_PQRS_ADDR)
    CALL CHECK_KEY_A_BC_DE_HL
    LD A, (KEYBOARD_TUUV_ADDR)
    CALL CHECK_KEY_A_BC_DE_HL
    LD DE, LEVEL_POS
    LD A, (KEYBOARD_0123_ADDR)
    CALL CHECK_KEY_A_BC_DE_HL
    LD A, (KEYBOARD_4567_ADDR)
    CALL CHECK_KEY_A_BC_DE_HL
    EXX
    JP START_SCREEN_LOOP

CHECK_KEY_A_BC_DE_HL:
    AND NOTHING_PRESSED
    CP NOTHING_PRESSED
    JP NZ, PRESS_KEY_DE_HL_A
    ADD HL, BC
    RET

include 'startScreen/music.asm'
include 'startScreen/startScreen.asm'
include 'startScreen/main_press_key.asm'
