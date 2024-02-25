;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Hang effektek:
;;; - Lépés a füldben, ásás
;;; - kő leesik/kő eltolása, azaz a kő elmozdulás után megáll
;;; - gyémánt leesik
;;; - Gyémánt begyűjtése
;;; - Játékos megjelenik, bejárat kinyílik - egyelőre ilyen még nincs a játékban
;;; - játékos felrobban (ráesik valami, vagy idő lejár), *fly felrobban : robbanás
;;; - idő lejáróban, utolsó 9 másodperc : Egyre magasodó ping
;;; - Ajtó kinyílt
;;; - Bónus life
;;; - Jutalompontok hozzáadása
;;; - Kilépés a kapun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CALL LEPESHANG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;LEPESHANG0:
;    LD HL, 0x0400
;LOOP:
;    DEC HL
;    LD A, H
;    CP 0
;    RET Z
;    LD A, (HL)
;    LD (LEPESHANG_SPEAKER+1), A
;LEPESHANG_SPEAKER:
;    LD (SPEAKER_OFF), A
;    JR LOOP
;
LEPESHANG:
    LD B, 0
LLOOPP:
    CALL SPEAKER_ON_OF_BY_LFSR
    DJNZ LLOOPP
LLOOPP2:
    CALL SPEAKER_ON_OF_BY_LFSR
    DJNZ LLOOPP2
    RET

SPEAKER_ON_OF_BY_LFSR:
    CALL LFSR ; IN-OUT
    LD DE, (LFSR_CURRENT_DATA16)
    BIT 7, E
    JR Z, FKIKAPCS
    LD (SPEAKER_ON), A ; BEKAPCS
    RET
FKIKAPCS:
    LD (SPEAKER_OFF), A ; KIKAPCS
    RET

LFSR_TAP_H: EQU %01000001
LFSR_TAP_L: EQU %10100111
LFSR_CURRENT_DATA16:  DW 15                ;  uint32_t       in <> 0
LFSR:
    LD A, (LFSR_CURRENT_DATA16)
    BIT 0, A
    JR Z, LFSR_CURRENT_DATA_EVEN
    ;;; Current data is odd : out = (1<<15)|((in*tap)>>1); ( tap=16807 )
    LD HL, (LFSR_CURRENT_DATA16) ; (in^tap)
    LD A, H
    XOR LFSR_TAP_H
    LD H, A
    LD A, L
    XOR LFSR_TAP_L
    LD L, A        ; HL = (in^%10100111)
    RR H
    RR L           ; HL = (in^tap)>>1
    LD DE, %1000000000000000 ; DE = (1<<15)
    LD A, D
    OR H
    LD A, E
    OR L           ; HL = (1<<15)|((in^tap)>>1)
    LD (LFSR_CURRENT_DATA16), HL ; out = (1<<15)|((in^tap)>>1)
    RET
LFSR_CURRENT_DATA_EVEN:
    ;;; Current data is even: out = in>>1
    LD HL, (LFSR_CURRENT_DATA16)
    RR H
    RR L
    LD (LFSR_CURRENT_DATA16), HL    ; out = in >> 1
    RET
