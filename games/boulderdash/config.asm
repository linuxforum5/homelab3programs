BG_CHAR: EQU 'n'+32 ; '.' ; 46               ; A pályán kívüli háttérkarakter kódja

;0x30 Lepke, felrobbanva gyémánt lesz Óramutató járásával ellentételesen forog
;0x32 Lepke, felrobbanva gyémánt lesz. U.a.
OBJECT_BUTTERFLY1_CHAR:   EQU 'x'+64 ; 'x'+32 ; 'c'+32 ; '9'-32 ; '/' ; 'X' ; 2
OBJECT_BUTTERFLY2_CHAR:   EQU 'y'+64 ; 'w'+32 ; 'v'+64 ; '9'-31 ; '%' ; 'H' ; '+' ; 3
;0x08 Tűzlégy, ha hozzád ér meghalsz, fel tud robbanni, de csak füst lesz a helyén, azaz SPACE. Óramutató járása
OBJECT_FIREFLY1_CHAR:     EQU 2
OBJECT_FIREFLY2_CHAR:     EQU 3
;0x00 A kiásott lyuk
OBJECT_SPACE_CHAR:        EQU ' '
;0x25 PREROCKFORD Bejárat, mielőtt megjelenik a játékos
;0x38 ROCKFORD A játékos
OBJECT_PLAYER_CHAR:       EQU 132
;0x14 Gyémánt, amiket össze kell szedni
OBJECT_DIAMOND1_CHAR:     EQU 153
OBJECT_DIAMOND2_CHAR:     EQU '*'
;0x10 Szikla
OBJECT_STONE_CHAR:        EQU 154
;0x07 Acél fal, a külső fal, nem tud felrobbanni
OBJECT_STEEL_CHAR:        EQU 255
;0x01 A talaj, amiben ás
OBJECT_DIRT_CHAR:         EQU 'v' ; ';' ; 'i'+32 ; '#' ; #
;0x02 Téglafal, ami fel tud robbanni
OBJECT_WALL_CHAR:         EQU 237; 192 + 1 + 4 + 8 + 32 = 237 'y'+96+34 ; 'X' ; 25 ; 148 ; 139 ; 255 , 
;0x03 Mágikus fal: ha kő, és rá gyménttá válik, ha gyémánt, kővé, miközben átesik rajta
OBJECT_MAGICK_WALL1_CHAR: EQU 222; 192 + 2 + 4 + 8 + 16 = 222 'y'+96+34 ; 'X' ; 25 ; 148 ; 139 ; 255 , 
OBJECT_MAGICK_WALL2_CHAR: EQU 192 + 255 - 222
;0x04 PREOUTBOX Kijárat, mielőtt kinyílik az ajtó
OBJECT_OPENED_DOOR_CHAR:  EQU 15 ; 2/15
;0x3A AMOEBA Lassan terjedő szmotyi, ha akadályba ütközük, másfele terjed tovább, ha nem tud terjedni, gyémánttá válik
OBJECT_AMOEBA_CHAR:       EQU '#'

BUTTERFLY_TICK_SPEED:      EQU 5     ; A pillangó mozgási sebessége - egyben a villogás sebessége is? Bigger is slower
FIREFLY_TICK_SPEED:        EQU BUTTERFLY_TICK_SPEED     ; A tűzlégy mozgási sebessége - egyben a villogás sebessége is? Bigger is slower
AMOEBA_SLOW_TICK_SPEED:    EQU 50;    ; 1s Az amőbe mozgási sebessége slow módban. Nagyobb, lassabb
AMOEBA_FAST_TICK_SPEED:    EQU 5;     ; 1s Az amőbe terjedési sebessége fast módban. Nagyobb, lassabb
AMOEBA_STONE_LIMIT:        EQU 200; 149 ; 200 ; Ennől több amőba esetén azok kővé válnak
AMOEBA_RANDOM_LIMIT:       EQU 25 ; Az eredetiben más a random limit slow és fast módban, de nálunk azonos.
GRAVITY_TICK_SPEED:        EQU 5

CONTROLLER_SPEED:          EQU 10 ; A billentyűfigyelés gyakorisága
PLAYER_SPEED:              EQU 5 ; A billentyűfigyelés gyakorisága

MAX_TIMER_TICK:            EQU 50 ; Ennyi képfrissítési tick jelent 1 másodpercet
CLOCKDOWN_SOUND_LIMIT:     EQU 8  ; Ennyi másodperccel a vége előtt kezd csipogni a visszaszámláló (max 254, 255=off)

START_HIGHSCORE:           EQU 0 ; Ez a kiindulási highscore érték

FIRST_USED_LINE_ADDR:      EQU SCREEN + 6 * 64  ; A pálya bal első használt sorának első képernyőmemóriacíme
LeftTopAddr:               EQU FIRST_USED_LINE_ADDR + 12  ; A pálya bal felső sarkának memóriacíme a képernyőn
