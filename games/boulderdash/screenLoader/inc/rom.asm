
BASIC_START_POINTER:     EQU 0x4030
SCREEN:                  EQU 0xF800
ROM_SWITCH_PAGE_II:      EQU 0x0533 ; Kettes lapra kapcsol. Videoműveletekhez kell
ROM_SWITCH_PAGE_I:       EQU 0x05BE ; 1-es lapra kapcsol
ROM_WAIT_SCREEN:         EQU 0x00F6 ; Vár, míg a kép szerkesztése be nem fejeződik
ROM_PRINT_HEX_A:         EQU 0x01A5 ; A értékét kiírja headecimálisan
ROM_PRINT_HEX_DE         EQU 0x01A0 ; DE értékét kiírja headecimálisan
ROM_PRINT_A:             EQU 0x0284 ; A kurzor pozíciójába kiteszi az A karaktert. Speciális karaktereket is kezel
ROM_CLS:                 EQU 0x0220 ; CLS?

SPEAKER_OFF:             EQU 0xE802 ; Hangszóró ki
SPEAKER_ON:              EQU 0xE880 ; Hangszóró be
ROM_BEEP_A_C:            EQU 0x18E1 ; Hang kiadása: A=freq (f = 57692 / A Hz), C=hossz (~10.24*C ms)
ROM_BEEP_H_L:            EQU 0x0108 ; Hang kiadása: L=freq (f = 57692 / H Hz), H=hossz (~10.24*L ms)
ROM_BEEP_DE:             EQU 0x1BE7 ; Dallam lejátszása a DE címtől, míg 0x20 értéket nem olvas. 0x21-0x3F a ritmus, 0x40.. a hangmagasság

DCB_SCREEN_MODE:         EQU 0x400A ; 1=64, 2=32 karakteres mód. Hardver átkapcsolás is kell hozzá.
