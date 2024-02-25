;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Homelab III. Clock speed 4MHz. The Z80 T = 0.4us
;;; Screen loader
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
include 'inc/rom.asm'
include 'inc/keyboard.asm'

AUTOSTART_ADDR:     EQU $43A0  ; Betöltés után ez a cím indul automatikusan
LINE_CHAR:          EQU $CF ; $8D    ; $C3    ; $8D
; LINE_CHAR:          EQU 142    ; $C3    ; $8D
; T    0     1   BIT_REPEAT_COUNTER    teszt
; 1   $98   $49   $6F                   OK
; 2   $50   $22   $38/$40               OK
; 3  ?$33  ?$16   $25                   OK
; 4   $22   $10   $1B                  ERROR
; BIT_REPEAT_COUNTER: EQU $6F
; BIT_REPEAT_COUNTER: EQU $40
BIT_REPEAT_COUNTER: EQU $25
; BIT_REPEAT_COUNTER: EQU $1B

    ORG $7F00
    out (0ffh), a        ;     II. lapra vált
    EXX
    ld hl,0e883h            ;0680
    EXX

LOAD_RECORD:
    LD HL, $F83B         ; A vonal vége
LOAD_HEADER_PRE:         ; Az első pár 0 kiolvasása, amíg a vonalat kirajzoljuk
    CALL LOAD_A
    DEC L
    LD (HL), LINE_CHAR
    JR NZ, LOAD_HEADER_PRE
LOAD_HEADER:
    CALL LOAD_A
    CP $A5
    JR NZ, LOAD_HEADER

LOAD_NAME:
    CALL LOAD_A
    CP 0
    JR NZ, LOAD_NAME
LOAD_ADDRESS:
    CALL LOAD_A
    LD E, A
    CALL LOAD_A
    LD D, A
LOAD_SIZE:
    CALL LOAD_A
    LD C, A
    CALL LOAD_A
    LD B, A
LOAD_DATA:
    CALL LOAD_A
    ; Show line begin
    LD L, B
    LD (HL), ' '
    ; Show line end
    LD (DE), A
    INC DE
    DEC BC
    LD A, B
    OR C
    JR NZ, LOAD_DATA
LOAD_CHECKSUM:
    CALL LOAD_A
LOAD_EOF:
    CALL LOAD_A
    CP 0
    JR NZ, LOAD_RECORD
    JP AUTOSTART_ADDR

LOAD_A:          ; A 0616 a veremből kiveszi a hívó címét, így utána oda ugrik vissza, ahonnan ezt hívtuk
l0616h:          ;              LOAD one byte. A veremből kiveszi a hívó címét! ($400C) címre van betöltve ennek a rutinnak a címe
    ld a,001h    ;0616          Beállítjuk a CARRY bitet, hogy 8 lépés után 1 legyen, azaz 8 bit olvasása után le tudjon állni
l0618h:

    ; call $067C   ;0618          LOAD 1 bit and rotate

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Egy bit beoilvasása a CY flagbe Először a 7. bitet olvassa be, majd a 6. bitet, ...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sub_067ch:                      ;           LOAD 1 bit beolvasása
    exx                         ;067c       HL értéke már beállítva fixen
;    out (0ffh),a            ;067d        II. lapra vált
    ld e,a                  ;067f        E'-ben az A aktuális értéke. Ez a legelején 1, hogy a 8. hívás után jelezze, a bájt végét
    ld bc,05000h            ;0683        B' = 0101 0000      C' = 0
l0686h:
    ld d,(hl)               ;0686        Beolvas egy jelszintet?
l0687h:
    inc c                   ;0687        C' számolja, hogy milyen hosszú ez az impulzus
    ld a,(hl)               ;0688        Beolvassa a következő szintet
    xor d                   ;0689        A kettőt összehasonlítja, CY flag-et törli Az eredmény 0, ha ugyanaz
    rra                     ;068a        Eggyel jobbra tol (/2) CY -> 7 -> 0 -> CY. CY addig 0, amíg ugyanazt olvassuk
    jr nc,l0687h            ;068b        Ha CY 0, akkor még nem töltöttük bew a 8 bitet
    sla b                   ;068d        CY <- 7 <- 0 <- 0
    jr nc,l0686h            ;068f        egy teljes hullámot végigolvas
    jr z,l0698h             ;0691
    ld a,c                  ;0693        A-ba betesszük a repeat counter-t
TITOK:
    cp BIT_REPEAT_COUNTER   ;0694        CY = 0, ha az olvasott hossz >= 0x6F, és 1, ha kisebb [ 0-ás bit 0x96/0x98 1-es bit 0x48/0x49 ]
    jr c,l0686h             ;0696        olvassuk a következő jelszintet
l0698h:
    ld a,e                  ;0698        E' az eddigi bitek. CY-ben az épp most beolvasott bit, a 0. helyiértékű
    exx                     ;0699
    adc a,a                 ;069a        Balra toljuk a beolvasott biteket, és a 0. helyre tesszük a most olvasott új bitet
;    out (07fh),a            ;069b        I. lapra vált
;    ret                     ;069d
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; End copy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ; call sub_067ch
    jr nc,l0618h ;061b
    ret          ;061e          A-ban a beolvasott byte


END_OF_LOADER:
