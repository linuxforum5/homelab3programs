# Boulder Dash Truck
Boulder Dash Truck, az eredeti Boulder Dash játék Homelab 3 változata, ahol egy teherautóval kell összegyűjteni a gyémántokat.
A játék vezérelhető billentyűzetről és botkormánnyal is.
Memóriaigénye 16KB.
Különlegessége, hogy 16K-nál nagyobb gépen is a betötlés egy betöltő képernyővel kezdődik, majd a képernyő tetején egy folyamatjelző sáv jelzi a betöltődésből még hátralévő részt.

## Betöltés
A játék betöltéséhez 3 formátum is választható:
- LOAD/BlouderDashTruck.T3.wav
- LOAD/BlouderDashTruck.wav
- LOAD/BoulderDashTruck.htp

### BlouderDashTruck.T3.wav
Ez az ajánlott formátum valódi gépen való betöltéshez. Gyorsított betöltővel.

### BlouderDashTruck.wav
Amennyiben a turbo loader nem működne, a játék eredeti betöltési sebességgel is betölthető.

### blouderdash.htp
Emultáron való játékhoz. A betölrő része ebben a változatban nincs benne. MAME emulátorban automatán elindul.

## Fordítás
A játék assembly nyelven készült. A forráskód nagy része azonban az Object Assembler szintaxissal íródot, így fordítás előtt asm forráskóddá kell alakítani 
az [oasm](https://github.com/linuxforum5/oasm) preprocesszorral. Az elkészült asm kód már például pasmo fordítóval lefordítható.
A run.sh fájl tartalmazza a fordítás lépéseit.
