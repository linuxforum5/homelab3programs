#!/bin/sh
BASENAME=boulderdash
TEMP_BIN_NAME=$BASENAME.L40B0H.R4164H.sys
LOADADDRESS0x43A0=17312

if oasm ./ $BASENAME ; then
    if pasmo -d $BASENAME.asm $TEMP_BIN_NAME > $BASENAME.debug; then
        grep 'label ' $BASENAME.debug > $BASENAME.labels
        # asm forráskód kész
        createHomelabHtp -t $BASENAME.txt -b $TEMP_BIN_NAME -L $LOADADDRESS0x43A0 -o $BASENAME.htp -B $BASENAME.bas -p -n "BoulderDashTruck"
        X=$?
        if [ "$X" = "0" ] ; then
            htp2h2wav -i $BASENAME.htp -o $BASENAME.wav
            ../../mame-mame0257/homelab3 homelab3 -quickload $BASENAME.htp -autoboot_command " RUN" #-debug
        fi
    fi
fi
grep BOTTOM_OF_PROGRAM boulderdash.labels 
