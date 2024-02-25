#!/bin/sh
LOADERNAME=loader
PAYLOAD=../boulderdash.L40B0H.R4164H.sys
LOADADDRESS0x43A0=17312
LOADADDRESS0x7F00=32512
SCREENNAME=screen
NAME="BlouderDashTruck"
FINALWAV="$NAME.wav"
TURBO=3
FINALWAVT="$NAME.T$TURBO.wav"
if pasmo -d $LOADERNAME.asm $LOADERNAME.bin > $LOADERNAME.debug; then
  if pasmo -d $LOADERNAME.T$TURBO.asm $LOADERNAME.T$TURBO.bin > $LOADERNAME.T$TURBO.debug; then
    grep 'label ' $LOADERNAME.debug > $LOADERNAME.labels
    #############################################################################################################################
    ### Normal version
    #############################################################################################################################
    createHomelabHtp -t $LOADERNAME.txt -b $LOADERNAME.bin -L $LOADADDRESS0x7F00 -o htp/$LOADERNAME.htp -B $LOADERNAME.bas -p -n "$NAME"
    createHomelabHtp -b img/screen.bin -L 63488 -b $PAYLOAD -L $LOADADDRESS0x43A0 -o htp/$SCREENNAME.htp
    htp2wav -i htp/$LOADERNAME.htp -o wav/$LOADERNAME.wav
    htp2wav -i htp/$SCREENNAME.htp -o wav/$SCREENNAME.wav

    TMPFILE1=wav/tmp1.wav
    sox wav/$LOADERNAME.wav $TMPFILE1 pad 3 0
    TMPFILE2=wav/tmp2.wav
    sox wav/$SCREENNAME.wav $TMPFILE2 pad 1 0
    sox $TMPFILE1 $TMPFILE2 $FINALWAV
    #############################################################################################################################
    ### Turbo version
    #############################################################################################################################
    createHomelabHtp -t $LOADERNAME.txt -b $LOADERNAME.T$TURBO.bin -L $LOADADDRESS0x7F00 -o htp/$LOADERNAME.T$TURBO.htp -B $LOADERNAME.bas -p -n "$NAME"
    htp2wav -i htp/$LOADERNAME.T$TURBO.htp -o wav/$LOADERNAME.T$TURBO.wav
    htp2wav -P 50 -B 500 -i htp/$SCREENNAME.htp -o wav/$SCREENNAME.T$TURBO.wav

    TMPFILE1=wav/tmp1.wav
    sox wav/$LOADERNAME.T$TURBO.wav $TMPFILE1 pad 3 0
    TMPFILE2=wav/tmp2.wav
    sox wav/$SCREENNAME.T$TURBO.wav $TMPFILE2 pad 1 0
    sox $TMPFILE1 $TMPFILE2 $FINALWAVT

    ../../../mame-mame0257/homelab3 homelab3 -cass $FINALWAVT -autoboot_delay 1 -autoboot_command "LOAD\n" #-debug
  fi
fi
