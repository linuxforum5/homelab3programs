;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; A leütött billentyűk értelmezése, és a megfelelő helyre történő beírása (CAVE_POS, LEVEL_POS)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

KEYBOARD_DATA_AB:
    DB "_A_B"   ; PRESS_CAVE_AB_A:
    DB "CDE_"   ; PRESS_CAVE_CDE_A:
    DB "FGHI"   ; PRESS_CAVE_FGHI_A:
    DB "JKLM"   ; PRESS_CAVE_JKLM_A:
    DB "N_O_"   ; PRESS_CAVE_NO_A:
    DB "PQRS"   ; PRESS_CAVE_PQRS_A:
    DB "T___"   ; PRESS_CAVE_T_A:
    DB "_123"   ; PRESS_LEVEL_123_A:
    DB "45__"   ; PRESS_LEVEL_4567_A:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Egy billentyű leütés értelmezése
;;; HL - A 4 bájt kezdőcíme
;;; A - Az adott címhez tartozó 4 bit. Egy bit akkor van kiválasztva, ha 0. 
;;;     Ha nincs lenyomva semmi, akkor értéke: 0x0F
;;; DE - A cím, ahová az eredményt ki kell írni
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PRESS_KEY_DE_HL_A:
    BIT 0, A
    JR Z, SELECT_KEY_DE_HL
    INC HL
    BIT 1, A
    JR Z, SELECT_KEY_DE_HL
    INC HL
    BIT 2, A
    JR Z, SELECT_KEY_DE_HL
    INC HL
    ; Ha ide eljut, akkor a 3. bit biztosan 0
SELECT_KEY_DE_HL:
    LD A, (HL)
    CP '_'
    RET Z
    LD (DE), A
    ; RET helyett:
    POP HL    ; Felesleges visszatérési cím kidobása
    EXX
    JP START_SCREEN_LOOP
