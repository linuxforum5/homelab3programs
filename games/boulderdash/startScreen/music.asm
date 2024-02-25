ON_OFF_ADDR1: EQU OUTPUT1+1
ON_OFF_ADDR2: EQU OUTPUT2+1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; C - counter1 : frequ1
;;; E - counter2 : frequ2
;;; HL - length counter
;;; A leggyakoribb ciklus ideje: 114T ~ 28.5us. HL=100 eseén ez 2.8ms
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BEEP2_HL_C_E:               ;
    LD B, C                 ;  4
    LD D, E                 ;  4
    LD A, (ON_OFF_ADDR1)    ; 13
    EX AF, AF' ; '          ;  4
    LD A, (ON_OFF_ADDR2)    ; 13 
soundLoop:                  ;    += 38
    EX AF, AF' ; '          ;  4
snd1:
    dec b                   ;  4     DECREMENT counter1
    jr nz, sound1_off       ; 12/7   (true/false)
    XOR $80                 ;  4     ON-toggle
    ld b, c                 ;  4     counter1 := backup1
sound1_off:
    LD (ON_OFF_ADDR1), A    ; 13
OUTPUT1:                    ;
    LD (SPEAKER_OFF), A     ; 13
    EX AF, AF' ; '          ;  4
snd2:                       ;    += 53/50
    dec d                   ;  4     DECREMENT counter2
    jr nz, sound2_off       ; 12/7
    XOR $80                 ;  4     ON-toggle
    ld d, e                 ;  4     counter2 := backup2
sound2_off:                 ;
    LD (ON_OFF_ADDR2), A    ; 13
OUTPUT2:                    ;
    LD (SPEAKER_OFF), A     ; 13
timer:                      ;    += 45/42
    DEC L                   ;  4
    jr nz,soundLoop         ; 12/7    ++= 114/111/108
    DEC H                   ;  4
    jr nz,soundLoop         ; 12=7    ++= 125/122/119
    RET                     ; 10

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Music műveletek
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MUSIC_INIT:
    LD HL, VOICE12
MUSIC_BG:
    LD A, (HL)
    CP 0
    JR Z, MUSIC_INIT
    LD C, A
    INC HL
    LD E, (HL)
    INC HL
    LD (MUSIC_POINTER), HL
    LD HL, SOUND_LENGTH_HL
    CALL BEEP2_HL_C_E
    LD HL, (MUSIC_POINTER)
    RET
MUSIC_POINTER: DW 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
wait_for_black:
    LD A, (0xE802)
    RRA
    JR C, wait_for_black    ; C=1, akkor nincs ütközés a CPU és a videogenerátor között
wait_for_black_loop:
    LD A, (0xE802)
    RRA
    JR NC, wait_for_black_loop
    RET

include 'startScreen/music.data.4600.asm'
