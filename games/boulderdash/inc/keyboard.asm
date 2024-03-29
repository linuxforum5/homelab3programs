;            D0    D1    D2    D3
; 0xE800     Le   Fel   Jobb  Bal
; 0xE801   SPACE   CR
; 0xE802    k.sz. SH1   SH2   ALT           k.sz.= kép szinkron
; 0xE803   Magnó   F2    F1
; 0xE804     0     1     2     3
; 0xE805     4     5     6     7
; 0xE806     8     9     :     ;
; 0xE807     ,     =     .     ?
; 0xE808     ^     A     A     B
; 0xE809     C     D     E     E
; 0xE80A     F     G     H     I
; 0xE80B     J     K     L     M
; 0xE80C     N     O     O     Ö
; 0xE80D     P     Q     R     S
; 0xE80E     T     U     U     V
; 0xE80F     W     X     Y     Z

KEYBOARD_CURSOR_ADDR:  EQU 0xE800
KEYBOARD_CURSOR_DOWN:  EQU 15-1
KEYBOARD_CURSOR_UP:    EQU 15-2
KEYBOARD_CURSOR_LEFT:  EQU 15-8
KEYBOARD_CURSOR_RIGHT: EQU 15-4

KEYBOARD_CURSOR_DOWN_BIT:  EQU 0
KEYBOARD_CURSOR_UP_BIT:    EQU 1
KEYBOARD_CURSOR_RIGHT_BIT: EQU 2
KEYBOARD_CURSOR_LEFT_BIT:  EQU 3

KEYBOARD_J_BIT:            EQU 0
KEYBOARD_K_BIT:            EQU 1
KEYBOARD_L_BIT:            EQU 2
KEYBOARD_M_BIT:            EQU 3

KEYBOARD_SpaceCr_ADDR: EQU 0xE801
KEYBOARD_0123_ADDR:    EQU 0xE804
KEYBOARD_4567_ADDR:    EQU 0xE805
KEYBOARD__AAB_ADDR:    EQU 0xE808
KEYBOARD_CDEE_ADDR:    EQU 0xE809
KEYBOARD_FGHI_ADDR:    EQU 0xE80A
KEYBOARD_JKLM_ADDR:    EQU 0xE80B
KEYBOARD_NOOO_ADDR:    EQU 0xE80C
KEYBOARD_PQRS_ADDR:    EQU 0xE80D
KEYBOARD_TUUV_ADDR:    EQU 0xE80E
KEYBOARD_WXYZ_ADDR:    EQU 0xE80F

NOTHING_PRESSED:       EQU 15
