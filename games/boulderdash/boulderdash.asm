;;; Code segment ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
include 'inc/rom.asm'
include 'inc/keyboard.asm'
include 'config.asm'
include 'constants.asm'
ORG $43A0
LD SP, $4030
OUT (0ffh), A
CALL Direct_Class_Controller_Method_constructor_Code ; CONTROLLER := new Controller()
CALL Direct_Class_Diamonds_Method_constructor_Code ; DIAMONDS := new Diamonds()
CALL Direct_Class_Game_Method_init_Code ; GAME.init()
Class__Until_20_Begin: ; Until begin : {
  CALL SHOW_START_SCREEN
  CALL Direct_Class_Game_Method_init_new_game_Z_Code ; GAME.init_new_game_Z()
  Class__Until_21_Begin: ; Until begin : {
    Class__Until_22_Begin: ; Until begin : {
      CALL Direct_Class_Screen_Method_wait_for_black_Code ; SCREEN.wait_for_black()
      CALL Direct_Class_ScreenShadow_Method_refresh_screen_Code ; SCREEN_SHADOW.refresh_screen()
      CALL Direct_Class_Diamonds_Method_tick_Code ; DIAMONDS.tick()
      CALL Direct_Class_Game_Method_tick_Z_Code ; GAME.tick_Z()
    JP NZ, Class__Until_22_Begin ; {
    CALL Direct_Class_Game_Method_init_next_cave_Z_Code ; GAME.init_next_cave_Z()
  JP NZ, Class__Until_21_Begin ; {
  CALL Direct_Class_Game_Method_save_if_new_highscore_Code ; GAME.save_if_new_highscore()
JP Class__Until_20_Begin ; {
include 'startScreen/main.asm'
include 'sound-effects.asm'
SHOW_HIGHSCORE_TO_HL:
CALL Direct_Class_Game_Method_show_high_score_to_Code ; GAME.show_high_score_to( HL )
RET
LOAD_AT_ONCE: EQU 16
LoadingPuffer: DS 3*LOAD_AT_ONCE, 0
BIT_BLOCK_LENGTH:       EQU 30
BIT_HOSSZ:              EQU 35
SILENT_LENGTH:          DW 0
SILENT_START_LENGTH:    EQU 1
SILENT_INCREMENT_VALUE: EQU 5
SILENT_HIGH_LIMIT:      EQU 4
PUFF_BIT_BLOCK_LENGTH:       EQU 35
PUFF_BIT_HOSSZ:              EQU 30
PUFF_SILENT_LENGTH:          DW 0
PUFF_SILENT_START_LENGTH:    EQU 1
PUFF_SILENT_INCREMENT_VALUE: EQU 135
PUFF_SILENT_HIGH_LIMIT:      EQU 2
QHELP_START: EQU FIRST_USED_LINE_ADDR
MAX_BUTTERFLY_COUNTER: EQU 30
ButterflyPuffer: DS MAX_BUTTERFLY_COUNTER*3, 0
MAX_FIREFLY_COUNTER: EQU 30
FireflyPuffer: DS MAX_FIREFLY_COUNTER*3, 0
FirstAddr:  EQU CAVE_PUFFER + SHADOW_LINE_LENGTH + 1
ColCounter: EQU 38
RowCounter: EQU 20
MAX_MAGICK_COUNTER:  EQU 12
MagickPuffer: DS MAX_MAGICK_COUNTER*2, 0
randomObjects_length:   EQU 4
DIR_UP:          EQU 0
DIR_UPRIGHT:     EQU 1
DIR_RIGHT:       EQU 2
DIR_DOWNRIGHT:   EQU 3
DIR_DOWN:        EQU 4
DIR_DOWNLEFT:    EQU 5
DIR_LEFT:        EQU 6
DIR_UPLEFT:      EQU 7
SHADOW_LINE_LENGTH: EQU 40
SCREEN_LINE_LENGTH: EQU 64
CAVE_SIZE: EQU SHADOW_LINE_LENGTH * 22
CAVE_PUFFER: EQU $4030
OBJECT_SPACE:      EQU 0x00
OBJECT_DIRT2:      EQU 0x01
OBJECT_DIRT_BLUE:  EQU 0x05
OBJECT_DIRT:       EQU 0x20
OBJECT_BRICK:      EQU 0x02
OBJECT_MAGIC:      EQU 0x03
OBJECT_STEEL:      EQU 0x07
OBJECT_FIREFLY:    EQU 0x08
OBJECT_BOULDER:    EQU 0x10
OBJECT_DIAMOND:    EQU 0x14
OBJECT_BUTTERFLY:  EQU 0x30
OBJECT_BUTTERFLY2: EQU 0x32
OBJECT_ROCKFORD:   EQU 0x38
OBJECT_AMOEBA:     EQU 0x3A
OBJECT_PLAYER:     EQU 0x25
OBJECT_EXIT:       EQU 0x04
LEVELS:
CAVE_A:
DB 0x01, 0x14, 0x0A, 0x0F, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x96, 0x6E, 0x46, 0x28, 0x1E, 0x08, 0x0B, 0x09, 0xD4, 0x20, 0x00, 0x10, 0x14, 0x00, 0x3C, 0x32, 0x09, 0x00, 0x42, 0x01, 0x09, 0x1E, 0x02, 0x42, 0x09, 0x10, 0x1E, 0x02, 0x25, 0x03, 0x04, 0x04, 0x26, 0x12, 0xFF
CAVE_B:
DB 0x02, 0x14, 0x14, 0x32, 0x03, 0x00, 0x01, 0x57, 0x58, 0x0A, 0x0C, 0x09, 0x0D, 0x0A, 0x96, 0x6E, 0x46, 0x46, 0x46, 0x0A, 0x04, 0x09, 0x00, 0x00, 0x00, 0x10, 0x14, 0x08, 0x3C, 0x32, 0x09, 0x02, 0x42, 0x01, 0x08, 0x26, 0x02, 0x42, 0x01, 0x0F, 0x26, 0x02, 0x42, 0x08, 0x03, 0x14, 0x04, 0x42, 0x10, 0x03, 0x14, 0x04, 0x42, 0x18, 0x03, 0x14, 0x04, 0x42, 0x20, 0x03, 0x14, 0x04, 0x40, 0x01, 0x05, 0x26, 0x02, 0x40, 0x01, 0x0B, 0x26, 0x02, 0x40, 0x01, 0x12, 0x26, 0x02, 0x40, 0x14, 0x03, 0x14, 0x04, 0x25, 0x12, 0x15, 0x04, 0x12, 0x16, 0xFF
CAVE_C:
DB 0x03, 0x00, 0x0F, 0x00, 0x00, 0x32, 0x36, 0x34, 0x37, 0x18, 0x17, 0x18, 0x17, 0x15, 0x96, 0x64, 0x5A, 0x50, 0x46, 0x09, 0x08, 0x09, 0x04, 0x00, 0x02, 0x10, 0x14, 0x00, 0x64, 0x32, 0x09, 0x00, 0x25, 0x03, 0x04, 0x04, 0x27, 0x14, 0xFF
CAVE_D:
DB 0x04, 0x14, 0x05, 0x14, 0x00, 0x6E, 0x70, 0x73, 0x77, 0x24, 0x24, 0x24, 0x24, 0x24, 0x78, 0x64, 0x50, 0x3C, 0x32, 0x04, 0x08, 0x09, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0x00, 0x25, 0x01, 0x03, 0x04, 0x26, 0x16, 0x81, 0x08, 0x0A, 0x04, 0x04, 0x00, 0x30, 0x0A, 0x0B, 0x81, 0x10, 0x0A, 0x04, 0x04, 0x00, 0x30, 0x12, 0x0B, 0x81, 0x18, 0x0A, 0x04, 0x04, 0x00, 0x30, 0x1A, 0x0B, 0x81, 0x20, 0x0A, 0x04, 0x04, 0x00, 0x30, 0x22, 0x0B, 0xFF
CAVE_E:
DB 0x05, 0x14, 0x32, 0x5A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x05, 0x06, 0x07, 0x08, 0x96, 0x78, 0x5A, 0x3C, 0x1E, 0x09, 0x0A, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x25, 0x01, 0x03, 0x04, 0x27, 0x16, 0x80, 0x08, 0x0A, 0x03, 0x03, 0x00, 0x80, 0x10, 0x0A, 0x03, 0x03, 0x00, 0x80, 0x18, 0x0A, 0x03, 0x03, 0x00, 0x80, 0x20, 0x0A, 0x03, 0x03, 0x00, 0x14, 0x09, 0x0C, 0x08, 0x0A, 0x0A, 0x14, 0x11, 0x0C, 0x08, 0x12, 0x0A, 0x14, 0x19, 0x0C, 0x08, 0x1A, 0x0A, 0x14, 0x21, 0x0C, 0x08, 0x22, 0x0A, 0x80, 0x08, 0x10, 0x03, 0x03, 0x00, 0x80, 0x10, 0x10, 0x03, 0x03, 0x00, 0x80, 0x18, 0x10, 0x03, 0x03, 0x00, 0x80, 0x20, 0x10, 0x03, 0x03, 0x00, 0x14, 0x09, 0x12, 0x08, 0x0A, 0x10, 0x14, 0x11, 0x12, 0x08, 0x12, 0x10, 0x14, 0x19, 0x12, 0x08, 0x1A, 0x10, 0x14, 0x21, 0x12, 0x08, 0x22, 0x10, 0xFF
CAVE_F:
DB 0x06, 0x14, 0x28, 0x3C, 0x00, 0x14, 0x15, 0x16, 0x17, 0x04, 0x06, 0x07, 0x08, 0x08, 0x96, 0x78, 0x64, 0x5A, 0x50, 0x0E, 0x0A, 0x09, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x32, 0x00, 0x00, 0x00, 0x82, 0x01, 0x03, 0x0A, 0x04, 0x00, 0x82, 0x01, 0x06, 0x0A, 0x04, 0x00, 0x82, 0x01, 0x09, 0x0A, 0x04, 0x00, 0x82, 0x01, 0x0C, 0x0A, 0x04, 0x00, 0x41, 0x0A, 0x03, 0x0D, 0x04, 0x14, 0x03, 0x05, 0x08, 0x04, 0x05, 0x14, 0x03, 0x08, 0x08, 0x04, 0x08, 0x14, 0x03, 0x0B, 0x08, 0x04, 0x0B, 0x14, 0x03, 0x0E, 0x08, 0x04, 0x0E, 0x82, 0x1D, 0x03, 0x0A, 0x04, 0x00, 0x82, 0x1D, 0x06, 0x0A, 0x04, 0x00, 0x82, 0x1D, 0x09, 0x0A, 0x04, 0x00, 0x82, 0x1D, 0x0C, 0x0A, 0x04, 0x00, 0x41, 0x1D, 0x03, 0x0D, 0x04, 0x14, 0x24, 0x05, 0x08, 0x23, 0x05, 0x14, 0x24, 0x08, 0x08, 0x23, 0x08, 0x14, 0x24, 0x0B, 0x08, 0x23, 0x0B, 0x14, 0x24, 0x0E, 0x08, 0x23, 0x0E, 0x25, 0x03, 0x14, 0x04, 0x26, 0x14, 0xFF
CAVE_G:
DB 0x07, 0x4B, 0x0A, 0x14, 0x02, 0x07, 0x08, 0x0A, 0x09, 0x0F, 0x14, 0x19, 0x19, 0x19, 0x78, 0x78, 0x78, 0x78, 0x78, 0x09, 0x0A, 0x0D, 0x00, 0x00, 0x00, 0x10, 0x08, 0x00, 0x64, 0x28, 0x02, 0x00, 0x42, 0x01, 0x07, 0x0C, 0x02, 0x42, 0x1C, 0x05, 0x0B, 0x02, 0x7A, 0x13, 0x15, 0x02, 0x02, 0x14, 0x04, 0x06, 0x14, 0x04, 0x0E, 0x14, 0x04, 0x16, 0x14, 0x22, 0x04, 0x14, 0x22, 0x0C, 0x14, 0x22, 0x16, 0x25, 0x14, 0x03, 0x04, 0x27, 0x07, 0xFF
CAVE_H:
DB 0x08, 0x14, 0x0A, 0x14, 0x01, 0x03, 0x04, 0x05, 0x06, 0x0A, 0x0F, 0x14, 0x14, 0x14, 0x78, 0x6E, 0x64, 0x5A, 0x50, 0x02, 0x0E, 0x09, 0x00, 0x00, 0x00, 0x10, 0x08, 0x00, 0x5A, 0x32, 0x02, 0x00, 0x14, 0x04, 0x06, 0x14, 0x22, 0x04, 0x14, 0x22, 0x0C, 0x04, 0x00, 0x05, 0x25, 0x14, 0x03, 0x42, 0x01, 0x07, 0x0C, 0x02, 0x42, 0x01, 0x0F, 0x0C, 0x02, 0x42, 0x1C, 0x05, 0x0B, 0x02, 0x42, 0x1C, 0x0D, 0x0B, 0x02, 0x43, 0x0E, 0x11, 0x08, 0x02, 0x14, 0x0C, 0x10, 0x00, 0x0E, 0x12, 0x14, 0x13, 0x12, 0x41, 0x0E, 0x0F, 0x08, 0x02, 0xFF
CAVE_I:
DB 0x09, 0x14, 0x05, 0x0A, 0x64, 0x89, 0x8C, 0xFB, 0x33, 0x4B, 0x4B, 0x50, 0x55, 0x5A, 0x96, 0x96, 0x82, 0x82, 0x78, 0x08, 0x04, 0x09, 0x00, 0x00, 0x10, 0x14, 0x00, 0x00, 0xF0, 0x78, 0x00, 0x00, 0x82, 0x05, 0x0A, 0x0D, 0x0D, 0x00, 0x01, 0x0C, 0x0A, 0x82, 0x19, 0x0A, 0x0D, 0x0D, 0x00, 0x01, 0x1F, 0x0A, 0x42, 0x11, 0x12, 0x09, 0x02, 0x40, 0x11, 0x13, 0x09, 0x02, 0x25, 0x07, 0x0C, 0x04, 0x08, 0x0C, 0xFF
CAVE_J:
DB 0x0A, 0x14, 0x19, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x96, 0x82, 0x78, 0x6E, 0x64, 0x06, 0x08, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x25, 0x0D, 0x03, 0x04, 0x27, 0x16, 0x54, 0x05, 0x04, 0x11, 0x03, 0x54, 0x15, 0x04, 0x11, 0x05, 0x80, 0x05, 0x0B, 0x11, 0x03, 0x08, 0xC2, 0x01, 0x04, 0x15, 0x11, 0x00, 0x0D, 0x04, 0xC2, 0x07, 0x06, 0x0D, 0x0D, 0x00, 0x0D, 0x06, 0xC2, 0x09, 0x08, 0x09, 0x09, 0x00, 0x0D, 0x08, 0xC2, 0x0B, 0x0A, 0x05, 0x05, 0x00, 0x0D, 0x0A, 0x82, 0x03, 0x06, 0x03, 0x0F, 0x08, 0x00, 0x04, 0x06, 0x54, 0x04, 0x10, 0x04, 0x04, 0xFF
CAVE_K:
DB 0x0B, 0x14, 0x32, 0x00, 0x00, 0x04, 0x66, 0x97, 0x64, 0x06, 0x06, 0x06, 0x06, 0x06, 0x78, 0x78, 0x96, 0x96, 0xF0, 0x0B, 0x08, 0x09, 0x00, 0x00, 0x00, 0x10, 0x08, 0x00, 0x64, 0x50, 0x02, 0x00, 0x42, 0x0A, 0x03, 0x09, 0x04, 0x42, 0x14, 0x03, 0x09, 0x04, 0x42, 0x1E, 0x03, 0x09, 0x04, 0x42, 0x09, 0x16, 0x09, 0x00, 0x42, 0x0C, 0x0F, 0x11, 0x02, 0x42, 0x05, 0x0B, 0x09, 0x02, 0x42, 0x0F, 0x0B, 0x09, 0x02, 0x42, 0x19, 0x0B, 0x09, 0x02, 0x42, 0x1C, 0x13, 0x0B, 0x01, 0x14, 0x04, 0x03, 0x14, 0x0E, 0x03, 0x14, 0x18, 0x03, 0x14, 0x22, 0x03, 0x14, 0x04, 0x16, 0x14, 0x23, 0x15, 0x25, 0x14, 0x14, 0x04, 0x26, 0x11, 0xFF
CAVE_L:
DB 0x0C, 0x14, 0x14, 0x00, 0x00, 0x3C, 0x02, 0x3B, 0x66, 0x13, 0x13, 0x0E, 0x10, 0x15, 0xB4, 0xAA, 0xA0, 0xA0, 0xA0, 0x0C, 0x0A, 0x09, 0x00, 0x00, 0x00, 0x10, 0x14, 0x00, 0x3C, 0x32, 0x09, 0x00, 0x42, 0x0A, 0x05, 0x12, 0x04, 0x42, 0x0E, 0x05, 0x12, 0x04, 0x42, 0x12, 0x05, 0x12, 0x04, 0x42, 0x16, 0x05, 0x12, 0x04, 0x42, 0x02, 0x06, 0x0B, 0x02, 0x42, 0x02, 0x0A, 0x0B, 0x02, 0x42, 0x02, 0x0E, 0x0F, 0x02, 0x42, 0x02, 0x12, 0x0B, 0x02, 0x81, 0x1E, 0x04, 0x04, 0x04, 0x00, 0x08, 0x20, 0x05, 0x81, 0x1E, 0x09, 0x04, 0x04, 0x00, 0x08, 0x20, 0x0A, 0x81, 0x1E, 0x0E, 0x04, 0x04, 0x00, 0x08, 0x20, 0x0F, 0x25, 0x03, 0x14, 0x04, 0x27, 0x16, 0xFF
CAVE_M:
DB 0x0D, 0x8C, 0x05, 0x08, 0x00, 0x01, 0x02, 0x03, 0x04, 0x32, 0x37, 0x3C, 0x46, 0x50, 0xA0, 0x9B, 0x96, 0x91, 0x8C, 0x06, 0x08, 0x0D, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x28, 0x00, 0x00, 0x00, 0x25, 0x12, 0x03, 0x04, 0x0A, 0x03, 0x3A, 0x14, 0x03, 0x42, 0x05, 0x12, 0x1E, 0x02, 0x70, 0x05, 0x13, 0x1E, 0x02, 0x50, 0x05, 0x14, 0x1E, 0x02, 0xC1, 0x05, 0x15, 0x1E, 0x02, 0xFF
CAVE_N:
DB 0x0E, 0x14, 0x0A, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1E, 0x23, 0x28, 0x2A, 0x2D, 0x96, 0x91, 0x8C, 0x87, 0x82, 0x0C, 0x08, 0x09, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x81, 0x0A, 0x0A, 0x0D, 0x0D, 0x00, 0x70, 0x0B, 0x0B, 0x0C, 0x03, 0xC1, 0x0C, 0x0A, 0x03, 0x0D, 0xC1, 0x10, 0x0A, 0x03, 0x0D, 0xC1, 0x14, 0x0A, 0x03, 0x0D, 0x50, 0x16, 0x08, 0x0C, 0x02, 0x48, 0x16, 0x07, 0x0C, 0x02, 0xC1, 0x17, 0x06, 0x03, 0x04, 0xC1, 0x1B, 0x06, 0x03, 0x04, 0xC1, 0x1F, 0x06, 0x03, 0x04, 0x25, 0x03, 0x03, 0x04, 0x27, 0x14, 0xFF
CAVE_O:
DB 0x0F, 0x08, 0x0A, 0x14, 0x01, 0x1D, 0x1E, 0x1F, 0x20, 0x0F, 0x14, 0x14, 0x19, 0x1E, 0x78, 0x78, 0x78, 0x78, 0x8C, 0x08, 0x0E, 0x09, 0x00, 0x00, 0x00, 0x10, 0x08, 0x00, 0x64, 0x50, 0x02, 0x00, 0x42, 0x02, 0x04, 0x0A, 0x03, 0x42, 0x0F, 0x0D, 0x0A, 0x01, 0x41, 0x0C, 0x0E, 0x03, 0x02, 0x43, 0x0C, 0x0F, 0x03, 0x02, 0x04, 0x14, 0x16, 0x25, 0x14, 0x03, 0xFF
CAVE_P:
DB 0x10, 0x14, 0x0A, 0x14, 0x01, 0x78, 0x81, 0x7E, 0x7B, 0x0C, 0x0F, 0x0F, 0x0F, 0x0C, 0x96, 0x96, 0x96, 0x96, 0x96, 0x09, 0x0A, 0x09, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x32, 0x00, 0x00, 0x00, 0x25, 0x01, 0x03, 0x04, 0x27, 0x04, 0x81, 0x08, 0x13, 0x04, 0x04, 0x00, 0x08, 0x0A, 0x14, 0xC2, 0x07, 0x0A, 0x06, 0x08, 0x43, 0x07, 0x0A, 0x06, 0x02, 0x81, 0x10, 0x13, 0x04, 0x04, 0x00, 0x08, 0x12, 0x14, 0xC2, 0x0F, 0x0A, 0x06, 0x08, 0x43, 0x0F, 0x0A, 0x06, 0x02, 0x81, 0x18, 0x13, 0x04, 0x04, 0x00, 0x08, 0x1A, 0x14, 0x81, 0x20, 0x13, 0x04, 0x04, 0x00, 0x08, 0x22, 0x14, 0xFF
CAVE_Q:
DB 0x11, 0x14, 0x1E, 0x00, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x06, 0x06, 0x06, 0x06, 0x06, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0E, 0x02, 0x09, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00, 0xFF, 0x09, 0x00, 0x00, 0x87, 0x00, 0x02, 0x28, 0x16, 0x07, 0x87, 0x00, 0x02, 0x14, 0x0C, 0x00, 0x32, 0x0A, 0x0C, 0x10, 0x0A, 0x04, 0x01, 0x0A, 0x05, 0x25, 0x03, 0x05, 0x04, 0x12, 0x0C, 0xFF
CAVE_R:
DB 0x12, 0x14, 0x0A, 0x00, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x10, 0x10, 0x10, 0x10, 0x10, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x06, 0x0F, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x00, 0x02, 0x28, 0x16, 0x07, 0x87, 0x00, 0x02, 0x14, 0x0C, 0x01, 0x50, 0x01, 0x03, 0x09, 0x03, 0x48, 0x02, 0x03, 0x08, 0x03, 0x54, 0x01, 0x05, 0x08, 0x03, 0x50, 0x01, 0x06, 0x07, 0x03, 0x50, 0x12, 0x03, 0x09, 0x05, 0x54, 0x12, 0x05, 0x08, 0x05, 0x50, 0x12, 0x06, 0x07, 0x05, 0x25, 0x01, 0x04, 0x04, 0x12, 0x04, 0xFF
CAVE_S:
DB 0x13, 0x04, 0x0A, 0x00, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x14, 0x14, 0x14, 0x14, 0x14, 0x06, 0x08, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x00, 0x02, 0x28, 0x16, 0x07, 0x87, 0x00, 0x02, 0x14, 0x0C, 0x00, 0x54, 0x01, 0x0C, 0x12, 0x02, 0x88, 0x0F, 0x09, 0x04, 0x04, 0x08, 0x25, 0x08, 0x03, 0x04, 0x12, 0x07, 0xFF
CAVE_T:
DB 0x14, 0x03, 0x1E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x06, 0x06, 0x06, 0x06, 0x06, 0x14, 0x14, 0x14, 0x14, 0x14, 0x06, 0x08, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x00, 0x02, 0x28, 0x16, 0x07, 0x87, 0x00, 0x02, 0x14, 0x0C, 0x01, 0xD0, 0x0B, 0x03, 0x03, 0x02, 0x80, 0x0B, 0x07, 0x03, 0x06, 0x00, 0x43, 0x0B, 0x06, 0x03, 0x02, 0x43, 0x0B, 0x0A, 0x03, 0x02, 0x50, 0x08, 0x07, 0x03, 0x03, 0x25, 0x03, 0x03, 0x04, 0x09, 0x0A, 0xFF
END_OF_CAVES:
Status_LeftTopAddr:        EQU LeftTopAddr - 64
Status_LeftTop2Addr:       EQU Status_LeftTopAddr - 64
Status_Screen_Start:       EQU Status_LeftTopAddr + 1
Status_HighScoreText_Addr: EQU Status_Screen_Start + 39
Status_HighScore_Addr:     EQU Status_Screen_Start + 44
CAVE_START_ADDR:           EQU Status_HighScoreText_Addr+64*2
LEVEL_START_ADDR:          EQU CAVE_START_ADDR+64*2
MESSAGE_LINE1_CENTER_ADDRESS: EQU 0xF820
MESSAGE_LINE2_CENTER_ADDRESS: EQU 0xF860
STATUS_CACHE:
DB "00",OBJECT_DIAMOND1_CHAR
DB "00  "
DB "00     "
DB OBJECT_PLAYER_CHAR,":3      "
DB "000       "
DB "000000"
Status_Points_Cache_Addr:       EQU STATUS_CACHE + 32
Status_Timer_Cache_Addr:        EQU STATUS_CACHE + 22
Status_Live_Cache_Addr:         EQU STATUS_CACHE + 14
Status_DC_Cache_Addr:           EQU STATUS_CACHE + 7
Status_DiamondPoint_Cache_Addr: EQU STATUS_CACHE + 3
Status_Need_D_Cache_Addr:       EQU STATUS_CACHE + 0

;;; Data segment ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
EOF: ; <EOF> : './/boulderdash.oasm'
String_constant_1_Data: DB "Timeout! You dead!@",0 ; STATUS.show_message( "Timeout! You dead!@" )
String_constant_2_Data: DB "Stone killed You!@",0 ; STATUS.show_message( "Stone killed You!@" )
String_constant_3_Data: DB "Diamond killed You!@",0 ; STATUS.show_message( "Diamond killed You!@" )
String_constant_4_Data: DB "Butterfly killed You!@",0 ; STATUS.show_message( "Butterfly killed You!@" )
String_constant_5_Data: DB "Firefly killed You!@",0 ; STATUS.show_message( "Firefly killed You!@" )
String_constant_6_Data: DB "Player   :@",0 ; this.printat( QHELP_START+ 1*64, "Player   :@", OBJECT_PLAYER_CHAR,       147 )
String_constant_7_Data: DB "Earth    :@",0 ; this.printat( QHELP_START+ 2*64, "Earth    :@", OBJECT_DIRT_CHAR,         147 )
String_constant_8_Data: DB "Stone    :@",0 ; this.printat( QHELP_START+ 3*64, "Stone    :@", OBJECT_STONE_CHAR,        147 )
String_constant_9_Data: DB "Diamond  :@",0 ; this.printat( QHELP_START+ 4*64, "Diamond  :@", OBJECT_DIAMOND1_CHAR,     147 )
String_constant_10_Data: DB "Firefly  :@",0 ; this.printat( QHELP_START+ 5*64, "Firefly  :@", OBJECT_FIREFLY1_CHAR,     147 )
String_constant_11_Data: DB "Butterly :@",0 ; this.printat( QHELP_START+ 6*64, "Butterly :@", OBJECT_BUTTERFLY1_CHAR,   147 )
String_constant_12_Data: DB "Amoeba   :@",0 ; this.printat( QHELP_START+ 7*64, "Amoeba   :@", OBJECT_AMOEBA_CHAR,       147 )
String_constant_13_Data: DB "Exit     :@",0 ; this.printat( QHELP_START+ 8*64, "Exit     :@", OBJECT_OPENED_DOOR_CHAR,  147 )
String_constant_14_Data: DB "Wall     :@",0 ; this.printat( QHELP_START+ 9*64, "Wall     :@", OBJECT_WALL_CHAR,         147 )
String_constant_15_Data: DB "Magick W.:@",0 ; this.printat( QHELP_START+10*64, "Magick W.:@", OBJECT_MAGICK_WALL1_CHAR, 147 )
String_constant_16_Data: DB "Steel    :@",0 ; this.printat( QHELP_START+11*64, "Steel    :@", OBJECT_STEEL_CHAR,        147 )
String_constant_17_Data: DB "-=Control=@",0 ; this.printat( QHELP_START+16*64, "-=Control=@", '-',                      147 )
String_constant_18_Data: DB " Left:  K @",0 ; this.printat( QHELP_START+17*64, " Left:  K @", 10,                       147 )
String_constant_19_Data: DB " Right: L @",0 ; this.printat( QHELP_START+18*64, " Right: L @", 11,                       147 )
String_constant_20_Data: DB " Up:    J @",0 ; this.printat( QHELP_START+19*64, " Up:    J @", 08,                       147 )
String_constant_21_Data: DB " Down:  M @",0 ; this.printat( QHELP_START+20*64, " Down:  M @", 09,                       147 )
String_constant_22_Data: DB " Quit:  Q @",0 ; this.printat( QHELP_START+21*64, " Quit:  Q @", 32,                       147 )
Object_TempObject1_in_Class_BCD3_Data: DS 4,0 ; this.high_score := new BCD3( START_HIGHSCORE )
Object_TempObject2_in_Class_BCD3_Data: DS 4,0 ; this.points := new BCD3( 0 )
Object_TempObject3_in_Class_BCD1_Data: DS 1,0 ; this.diamonds := new BCD1( 0 )
Object_TempObject4_in_Class_BCD1_Data: DS 1,0 ; this.need_d := new BCD1( Cave.open_counter )
Object_TempObject5_in_Class_BCD1_Data: DS 1,0 ; this.scorePerDiamond := new BCD1( Cave.diamond_point )
Object_TempObject6_in_Class_BCD2_Data: DS 3,0 ; this.timer := new BCD2( Cave.time )
String_constant_23_Data: DB "Press FIRE to continue ...@",0 ; this.show_message0( "Press FIRE to continue ...@", MESSAGE_LINE2_CENTER_ADDRESS )
String_constant_24_Data: DB "CAVE: @",0 ; SCREEN.write_text( "CAVE: @", CAVE_START_ADDR )
String_constant_25_Data: DB "LEVEL: @",0 ; SCREEN.write_text( "LEVEL: @", LEVEL_START_ADDR )
String_constant_26_Data: DB "HIGH:@",0 ; SCREEN.write_text( "HIGH:@", Status_HighScoreText_Addr )

;;; Class segment ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class ScreenShadow extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_ScreenShadow_DirectProperty_cnt_Shift_0_Size_1_Data: DB 0 ; DB cnt

  Direct_Class_ScreenShadow_Method_refresh_status_only_Code: ; public refresh_status_only() {
    LD HL, STATUS_CACHE
    LD DE, Status_Screen_Start
    LD BC, 38
    LDIR
  RET ; }

  Direct_Class_ScreenShadow_Method_refresh_screen_Code: ; public refresh_screen() {
    LD A, (Class_ScreenShadow_DirectProperty_cnt_Shift_0_Size_1_Data) ; inc this.cnt
    INC A ; inc this.cnt
    LD (Class_ScreenShadow_DirectProperty_cnt_Shift_0_Size_1_Data), A ; inc this.cnt
    AND 1
    ; Begin if 
      Class_ScreenShadow_IfBranch_1_Begin: ; if ( Z ) {
        JP NZ, Class_ScreenShadow_IfBranch_2_Begin ; if ( Z ) {
        LD HL, STATUS_CACHE
        LD DE, Status_Screen_Start
        LD BC, 38
        LDIR
        LD HL, CAVE_PUFFER+2*SHADOW_LINE_LENGTH
        LD DE, LeftTopAddr+2*64
        JR Class_ScreenShadow_IfBranch_2_End ; if ( Z ) {
      Class_ScreenShadow_IfBranch_2_Begin: ; } else {
        LD HL, CAVE_PUFFER+1*SHADOW_LINE_LENGTH
        LD DE, LeftTopAddr+1*64
      Class_ScreenShadow_IfBranch_2_End: ; }
    ; End full if
    LD A, 10
    Class_ScreenShadow_Until_1_Begin: ; Until begin : {
      LD BC, SHADOW_LINE_LENGTH
      LDIR
      LD BC, SHADOW_LINE_LENGTH
      ADD HL, BC
      EX DE, HL
      LD BC, 64+24
      ADD HL, BC
      EX DE, HL
      DEC A
    JP NZ, Class_ScreenShadow_Until_1_Begin ; {
  RET ; }

  Direct_Class_ScreenShadow_Method_full_steel_screen_Code: ; private full_steel_screen() {
    LD HL, LeftTopAddr
    LD DE, LeftTopAddr+1
    LD B, 22 ; for B = 22 to 1 {
    Class_ScreenShadow_ForB_1_Begin:
      PUSH BC
      LD (HL), OBJECT_STEEL_CHAR
      LD BC, 39
      LDIR
      LD BC, 25
      ADD HL, BC
      EX DE, HL
      ADD HL, BC
      EX DE, HL
      POP BC
    DJNZ Class_ScreenShadow_ForB_1_Begin
  RET ; }
  SHADOW_LOAD_STEP: EQU 269

  Direct_Class_ScreenShadow_Method_firstRandomLoadFromPuffer_Code: ; private firstRandomLoadFromPuffer() {
    CALL Direct_Class_ScreenShadow_Method_full_steel_screen_Code ; this.full_steel_screen()
    LD DE, CAVE_PUFFER
    LD B, 880/LOAD_AT_ONCE ; for B = 880/LOAD_AT_ONCE to 1 {
    Class_ScreenShadow_ForB_2_Begin:
      PUSH BC
      LD BC, LoadingPuffer
      LD A, LOAD_AT_ONCE
      Class_ScreenShadow_Until_2_Begin: ; Until begin : {
        PUSH AF
        CALL Direct_Class_ScreenShadow_Method_loadFromPuffer_tick_DE_BC_Code ; this.loadFromPuffer_tick_DE_BC( DE, BC )
        POP AF
        DEC A
      JP NZ, Class_ScreenShadow_Until_2_Begin ; {
      CALL ROM_WAIT_SCREEN
      CALL Direct_Class_ScreenShadow_Method_real_puffer_copy_Code ; this.real_puffer_copy()
      CALL Direct_Class_ScreenShadow_Method_hang_Code ; this.hang()
      POP BC
    DJNZ Class_ScreenShadow_ForB_2_Begin
  RET ; }

  Direct_Class_ScreenShadow_Method_real_puffer_copy_Code: ; private real_puffer_copy() {
    PUSH DE
    LD HL, LoadingPuffer
    LD B, LOAD_AT_ONCE ; for B = LOAD_AT_ONCE to 1 {
    Class_ScreenShadow_ForB_3_Begin:
      LD A, (HL)
      INC HL
      LD E, (HL)
      INC HL
      LD D, (HL)
      LD (DE), A
      INC HL
    DJNZ Class_ScreenShadow_ForB_3_Begin
    POP DE
  RET ; }

  Direct_Class_ScreenShadow_Method_hang_Code: ; private hang() {
    PUSH HL
    CALL Direct_Class_Random_Method_get_next_value_to_A_Code ; RND.get_next_value_to_A()
    LD L, A
    LD H, 3
    CALL ROM_BEEP_H_L
    POP HL
  RET ; }

  Direct_Class_ScreenShadow_Method_loadFromPuffer_tick_DE_BC_Code: ; private loadFromPuffer_tick_DE_BC( DE, BC ) {
    LD A, (DE)
    LD (BC), A
    INC BC
    PUSH DE
    PUSH BC
    CALL Direct_Class_ScreenShadow_Method_get_screen_addr_from_puffer_addr_to_HL_Code ; this.get_screen_addr_from_puffer_addr_to_HL( DE )
    POP BC
    LD A, L
    LD (BC), A
    INC BC
    LD A, H
    LD (BC), A
    INC BC
    POP DE
    PUSH BC
    LD HL, SHADOW_LOAD_STEP
    ADD HL, DE
    LD D, H
    LD E, L
    LD BC, CAVE_PUFFER + CAVE_SIZE
    OR A
    SBC HL, BC
    ; Begin if 
      Class_ScreenShadow_IfBranch_3_Begin: ; if ( NCY ) {
        JP C, Class_ScreenShadow_IfBranch_3_End ; if ( NCY ) {
        LD BC, CAVE_PUFFER
        ADD HL, BC
        LD D, H
        LD E, L
      Class_ScreenShadow_IfBranch_3_End: ; }
    ; End full if
    POP BC
  RET ; }

  Direct_Class_ScreenShadow_Method_get_screen_addr_from_puffer_addr_to_HL_Code: ; private get_screen_addr_from_puffer_addr_to_HL( DE ) {
    LD HL, -CAVE_PUFFER
    ADD HL, DE
    EX DE, HL
    LD BC, LeftTopAddr-64
    OR A
    Class_ScreenShadow_Until_3_Begin: ; Until begin : {
      LD HL, 64
      ADD HL, BC
      LD B, H
      LD C, L
      EX DE, HL
      LD DE, 40
      SBC HL, DE
      EX DE, HL
    JP NC, Class_ScreenShadow_Until_3_Begin ; {
    LD HL, 40
    ADD HL, DE
    EX DE, HL
    LD H, B
    LD L, C
    ADD HL, DE
  RET ; }
; } ; End class ScreenShadow

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Random extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_Random_DirectProperty_RandSeed1_Shift_0_Size_1_Data: DB 0 ; DB RandSeed1
  Class_Random_DirectProperty_RandSeed2_Shift_1_Size_1_Data: DB 0 ; DB RandSeed2
  Class_Random_DirectProperty_TempRand1_Shift_2_Size_1_Data: DB 0 ; DB TempRand1
  Class_Random_DirectProperty_TempRand2_Shift_3_Size_1_Data: DB 0 ; DB TempRand2

  Direct_Class_Random_Method_init_Code: ; public init( A, B ) {
    LD (Class_Random_DirectProperty_RandSeed1_Shift_0_Size_1_Data), A ; this.RandSeed1 := A
    LD A, B ; this.RandSeed2 := B
    LD (Class_Random_DirectProperty_RandSeed2_Shift_1_Size_1_Data), A ; this.RandSeed2 := B
  RET ; }

  Direct_Class_Random_Method_get_next_value_to_A_Code: ; public get_next_value_to_A() {
    CALL Direct_Class_Random_Method_bdrandom_Code ; this.bdrandom()
    LD A, (Class_Random_DirectProperty_RandSeed1_Shift_0_Size_1_Data) ; A := this.RandSeed1
  RET ; }

  Direct_Class_Random_Method_bdrandom_Code: ; private bdrandom() {
    PUSH HL
    PUSH BC
    PUSH DE
    LD A, (Class_Random_DirectProperty_RandSeed1_Shift_0_Size_1_Data) ; A := this.RandSeed1
    RRA
    RRA
    AND 0x80
    LD (Class_Random_DirectProperty_TempRand1_Shift_2_Size_1_Data), A ; this.TempRand1 := A
    LD A, (Class_Random_DirectProperty_RandSeed2_Shift_1_Size_1_Data) ; A := this.RandSeed2
    RRA
    AND 0x7F
    LD (Class_Random_DirectProperty_TempRand2_Shift_3_Size_1_Data), A ; this.TempRand2 := A
    LD A, (Class_Random_DirectProperty_RandSeed2_Shift_1_Size_1_Data) ; A := this.RandSeed2
    LD B, A
    RRA
    RRA
    AND 0x80
    SCF
    CCF
    ADC A, B
    ADC A, 0x13
    LD (Class_Random_DirectProperty_RandSeed2_Shift_1_Size_1_Data), A ; this.RandSeed2 := A
    LD A, (Class_Random_DirectProperty_TempRand1_Shift_2_Size_1_Data) ; B := this.TempRand1
    LD B, A ; B := this.TempRand1
    LD A, (Class_Random_DirectProperty_TempRand2_Shift_3_Size_1_Data) ; C := this.TempRand2
    LD C, A ; C := this.TempRand2
    LD A, (Class_Random_DirectProperty_RandSeed1_Shift_0_Size_1_Data) ; A := this.RandSeed1
    ADC A, B
    ADC A, C
    LD (Class_Random_DirectProperty_RandSeed1_Shift_0_Size_1_Data), A ; this.RandSeed1 := A
    POP DE
    POP BC
    POP HL
  RET ; }
; } ; End class Random

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Robbanas extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_Robbanas_DirectProperty_after_char_Shift_0_Size_1_Data: DB 0 ; DB after_char

  Direct_Class_Robbanas_Method_timeout_Code: ; public timeout() {
    LD DE, String_constant_1_Data ; STATUS.show_message( "Timeout! You dead!@" )
    CALL Direct_Class_Status_Method_show_message_Code ; STATUS.show_message( "Timeout! You dead!@" )
    LD HL, (Class_Player_DirectProperty_shadow_pos_addr_Shift_0_Size_2_Data) ; HL := PLAYER.shadow_pos_addr
    CALL Direct_Class_Robbanas_Method_player_Code ; this.player( HL )
  RET ; }

  Direct_Class_Robbanas_Method_stone_kill_player_Code: ; public stone_kill_player( HL ) {
    LD DE, String_constant_2_Data ; STATUS.show_message( "Stone killed You!@" )
    CALL Direct_Class_Status_Method_show_message_Code ; STATUS.show_message( "Stone killed You!@" )
    CALL Direct_Class_Robbanas_Method_player_Code ; this.player( HL )
  RET ; }

  Direct_Class_Robbanas_Method_diamond_kill_player_Code: ; public diamond_kill_player( HL ) {
    LD DE, String_constant_3_Data ; STATUS.show_message( "Diamond killed You!@" )
    CALL Direct_Class_Status_Method_show_message_Code ; STATUS.show_message( "Diamond killed You!@" )
    CALL Direct_Class_Robbanas_Method_player_Code ; this.player( HL )
  RET ; }

  Direct_Class_Robbanas_Method_butterfly_kill_player_Code: ; public butterfly_kill_player( HL ) {
    LD DE, String_constant_4_Data ; STATUS.show_message( "Butterfly killed You!@" )
    CALL Direct_Class_Status_Method_show_message_Code ; STATUS.show_message( "Butterfly killed You!@" )
    CALL Direct_Class_Robbanas_Method_player_Code ; this.player( HL )
  RET ; }

  Direct_Class_Robbanas_Method_firefly_kill_player_Code: ; public firefly_kill_player( HL ) {
    LD DE, String_constant_5_Data ; STATUS.show_message( "Firefly killed You!@" )
    CALL Direct_Class_Status_Method_show_message_Code ; STATUS.show_message( "Firefly killed You!@" )
    CALL Direct_Class_Robbanas_Method_player_Code ; this.player( HL )
  RET ; }

  Direct_Class_Robbanas_Method_player_Code: ; private player( HL ) {
    CALL Direct_Class_Robbanas_Method_remove9objects_Code ; this.remove9objects( HL )
    LD A, OBJECT_SPACE_CHAR ; this.show_animation( HL, OBJECT_SPACE_CHAR )
    CALL Direct_Class_Robbanas_Method_show_animation_Code ; this.show_animation( HL, OBJECT_SPACE_CHAR )
    CALL Direct_Class_Player_Method_kill_Code ; PLAYER.kill()
    CALL Direct_Class_Status_Method_wait_Code ; STATUS.wait()
  RET ; }

  Direct_Class_Robbanas_Method_butterfly_Code: ; public butterfly( HL ) {
    CALL Direct_Class_Robbanas_Method_change9objectsToDiamond_Code ; this.change9objectsToDiamond( HL )
    LD A, OBJECT_DIAMOND1_CHAR ; this.show_animation( HL, OBJECT_DIAMOND1_CHAR )
    CALL Direct_Class_Robbanas_Method_show_animation_Code ; this.show_animation( HL, OBJECT_DIAMOND1_CHAR )
  RET ; }

  Direct_Class_Robbanas_Method_firefly_Code: ; public firefly( HL ) {
    CALL Direct_Class_Robbanas_Method_remove9objects_Code ; this.remove9objects( HL )
    LD A, OBJECT_SPACE_CHAR ; this.show_animation( HL, OBJECT_SPACE_CHAR )
    CALL Direct_Class_Robbanas_Method_show_animation_Code ; this.show_animation( HL, OBJECT_SPACE_CHAR )
  RET ; }

  Direct_Class_Robbanas_Method_remove9objects_Code: ; private remove9objects( HL ) {
    LD DE, -(SHADOW_LINE_LENGTH+1)
    ADD HL, DE
    CALL Direct_Class_Robbanas_Method_removeObject_Code ; this.removeObject( HL )
    INC HL
    CALL Direct_Class_Robbanas_Method_removeObject_Code ; this.removeObject( HL )
    INC HL
    CALL Direct_Class_Robbanas_Method_removeObject_Code ; this.removeObject( HL )
    LD DE, SHADOW_LINE_LENGTH-2
    ADD HL, DE
    CALL Direct_Class_Robbanas_Method_removeObject_Code ; this.removeObject( HL )
    INC HL
    CALL Direct_Class_Robbanas_Method_removeObject_Code ; this.removeObject( HL )
    INC HL
    CALL Direct_Class_Robbanas_Method_removeObject_Code ; this.removeObject( HL )
    LD DE, SHADOW_LINE_LENGTH-2
    ADD HL, DE
    CALL Direct_Class_Robbanas_Method_removeObject_Code ; this.removeObject( HL )
    INC HL
    CALL Direct_Class_Robbanas_Method_removeObject_Code ; this.removeObject( HL )
    INC HL
    CALL Direct_Class_Robbanas_Method_removeObject_Code ; this.removeObject( HL )
  RET ; }

  Direct_Class_Robbanas_Method_removeObject_Code: ; private removeObject( HL ) {
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_4_Begin: ; if ( A == OBJECT_STONE_CHAR ) {
        CP OBJECT_STONE_CHAR ; if ( A == OBJECT_STONE_CHAR ) {
        JP NZ, Class_Robbanas_IfBranch_5_Begin ; if ( A == OBJECT_STONE_CHAR ) {
        CALL Direct_Class_GravityStone_Method_remove_Code ; STONEGRAVITY.remove( HL )
        JR Class_Robbanas_IfBranch_9_End ; if ( A == OBJECT_STONE_CHAR ) {
      Class_Robbanas_IfBranch_5_Begin: ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        CP OBJECT_BUTTERFLY1_CHAR ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        JP NZ, Class_Robbanas_IfBranch_6_Begin ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        CALL Direct_Class_Butterflies_Method_remove_Code ; BUTTERFLIES.remove( HL )
        JR Class_Robbanas_IfBranch_9_End ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
      Class_Robbanas_IfBranch_6_Begin: ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
        CP OBJECT_BUTTERFLY2_CHAR ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
        JP NZ, Class_Robbanas_IfBranch_7_Begin ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
        CALL Direct_Class_Butterflies_Method_remove_Code ; BUTTERFLIES.remove( HL )
        JR Class_Robbanas_IfBranch_9_End ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
      Class_Robbanas_IfBranch_7_Begin: ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
        CP OBJECT_FIREFLY1_CHAR ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
        JP NZ, Class_Robbanas_IfBranch_8_Begin ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
        CALL Direct_Class_Fireflies_Method_remove_Code ; FIREFLIES.remove( HL )
        JR Class_Robbanas_IfBranch_9_End ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
      Class_Robbanas_IfBranch_8_Begin: ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
        CP OBJECT_FIREFLY2_CHAR ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
        JP NZ, Class_Robbanas_IfBranch_9_Begin ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
        CALL Direct_Class_Fireflies_Method_remove_Code ; FIREFLIES.remove( HL )
        JR Class_Robbanas_IfBranch_9_End ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
      Class_Robbanas_IfBranch_9_Begin: ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        CP OBJECT_PLAYER_CHAR ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        JP NZ, Class_Robbanas_IfBranch_9_End ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        CALL Direct_Class_Player_Method_kill_Code ; PLAYER.kill()
      Class_Robbanas_IfBranch_9_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Robbanas_Method_change9objectsToDiamond_Code: ; private change9objectsToDiamond( HL ) {
    LD DE, -(SHADOW_LINE_LENGTH+1)
    ADD HL, DE
    CALL Direct_Class_Robbanas_Method_changeObjectToDiamond_Code ; this.changeObjectToDiamond( HL )
    INC HL
    CALL Direct_Class_Robbanas_Method_changeObjectToDiamond_Code ; this.changeObjectToDiamond( HL )
    INC HL
    CALL Direct_Class_Robbanas_Method_changeObjectToDiamond_Code ; this.changeObjectToDiamond( HL )
    LD DE, SHADOW_LINE_LENGTH-2
    ADD HL, DE
    CALL Direct_Class_Robbanas_Method_changeObjectToDiamond_Code ; this.changeObjectToDiamond( HL )
    INC HL
    CALL Direct_Class_Robbanas_Method_changeObjectToDiamond_Code ; this.changeObjectToDiamond( HL )
    INC HL
    CALL Direct_Class_Robbanas_Method_changeObjectToDiamond_Code ; this.changeObjectToDiamond( HL )
    LD DE, SHADOW_LINE_LENGTH-2
    ADD HL, DE
    CALL Direct_Class_Robbanas_Method_changeObjectToDiamond_Code ; this.changeObjectToDiamond( HL )
    INC HL
    CALL Direct_Class_Robbanas_Method_changeObjectToDiamond_Code ; this.changeObjectToDiamond( HL )
    INC HL
    CALL Direct_Class_Robbanas_Method_changeObjectToDiamond_Code ; this.changeObjectToDiamond( HL )
  RET ; }

  Direct_Class_Robbanas_Method_changeObjectToDiamond_Code: ; private changeObjectToDiamond( HL ) {
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_10_Begin: ; if ( A == OBJECT_STONE_CHAR ) {
        CP OBJECT_STONE_CHAR ; if ( A == OBJECT_STONE_CHAR ) {
        JP NZ, Class_Robbanas_IfBranch_11_Begin ; if ( A == OBJECT_STONE_CHAR ) {
        CALL Direct_Class_GravityStone_Method_remove_Code ; STONEGRAVITY.remove( HL )
        CALL Direct_Class_GravityDiamond_Method_append_Code ; DIAMONDGRAVITY.append( HL )
        JR Class_Robbanas_IfBranch_18_End ; if ( A == OBJECT_STONE_CHAR ) {
      Class_Robbanas_IfBranch_11_Begin: ; } else if ( A == OBJECT_WALL_CHAR ) {
        CP OBJECT_WALL_CHAR ; } else if ( A == OBJECT_WALL_CHAR ) {
        JP NZ, Class_Robbanas_IfBranch_12_Begin ; } else if ( A == OBJECT_WALL_CHAR ) {
        CALL Direct_Class_GravityDiamond_Method_append_Code ; DIAMONDGRAVITY.append( HL )
        JR Class_Robbanas_IfBranch_18_End ; } else if ( A == OBJECT_WALL_CHAR ) {
      Class_Robbanas_IfBranch_12_Begin: ; } else if ( A == OBJECT_SPACE_CHAR ) {
        CP OBJECT_SPACE_CHAR ; } else if ( A == OBJECT_SPACE_CHAR ) {
        JP NZ, Class_Robbanas_IfBranch_13_Begin ; } else if ( A == OBJECT_SPACE_CHAR ) {
        CALL Direct_Class_GravityDiamond_Method_append_Code ; DIAMONDGRAVITY.append( HL )
        JR Class_Robbanas_IfBranch_18_End ; } else if ( A == OBJECT_SPACE_CHAR ) {
      Class_Robbanas_IfBranch_13_Begin: ; } else if ( A == OBJECT_DIRT_CHAR ) {
        CP OBJECT_DIRT_CHAR ; } else if ( A == OBJECT_DIRT_CHAR ) {
        JP NZ, Class_Robbanas_IfBranch_14_Begin ; } else if ( A == OBJECT_DIRT_CHAR ) {
        CALL Direct_Class_GravityDiamond_Method_append_Code ; DIAMONDGRAVITY.append( HL )
        JR Class_Robbanas_IfBranch_18_End ; } else if ( A == OBJECT_DIRT_CHAR ) {
      Class_Robbanas_IfBranch_14_Begin: ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
        CP OBJECT_FIREFLY1_CHAR ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
        JP NZ, Class_Robbanas_IfBranch_15_Begin ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
        CALL Direct_Class_Fireflies_Method_remove_Code ; FIREFLIES.remove( HL )
        CALL Direct_Class_GravityDiamond_Method_append_Code ; DIAMONDGRAVITY.append( HL )
        JR Class_Robbanas_IfBranch_18_End ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
      Class_Robbanas_IfBranch_15_Begin: ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
        CP OBJECT_FIREFLY2_CHAR ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
        JP NZ, Class_Robbanas_IfBranch_16_Begin ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
        CALL Direct_Class_Fireflies_Method_remove_Code ; FIREFLIES.remove( HL )
        CALL Direct_Class_GravityDiamond_Method_append_Code ; DIAMONDGRAVITY.append( HL )
        JR Class_Robbanas_IfBranch_18_End ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
      Class_Robbanas_IfBranch_16_Begin: ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        CP OBJECT_BUTTERFLY1_CHAR ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        JP NZ, Class_Robbanas_IfBranch_17_Begin ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        CALL Direct_Class_Butterflies_Method_remove_Code ; BUTTERFLIES.remove( HL )
        CALL Direct_Class_GravityDiamond_Method_append_Code ; DIAMONDGRAVITY.append( HL )
        JR Class_Robbanas_IfBranch_18_End ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
      Class_Robbanas_IfBranch_17_Begin: ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
        CP OBJECT_BUTTERFLY2_CHAR ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
        JP NZ, Class_Robbanas_IfBranch_18_Begin ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
        CALL Direct_Class_Butterflies_Method_remove_Code ; BUTTERFLIES.remove( HL )
        CALL Direct_Class_GravityDiamond_Method_append_Code ; DIAMONDGRAVITY.append( HL )
        JR Class_Robbanas_IfBranch_18_End ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
      Class_Robbanas_IfBranch_18_Begin: ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        CP OBJECT_PLAYER_CHAR ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        JP NZ, Class_Robbanas_IfBranch_18_End ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        CALL Direct_Class_Player_Method_kill_Code ; PLAYER.kill()
      Class_Robbanas_IfBranch_18_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Robbanas_Method_show_animation_Code: ; private show_animation( HL, A ) {
    LD (Class_Robbanas_DirectProperty_after_char_Shift_0_Size_1_Data), A ; this.after_char := A
    PUSH BC
    PUSH DE
    LD DE, -(SHADOW_LINE_LENGTH+1)
    ADD HL, DE
    CALL Direct_Class_Robbanas_Method_show_center_Code ; this.show_center( HL )
    POP DE
    POP BC
  RET ; }

  Direct_Class_Robbanas_Method_show_center_Code: ; private show_center( HL ) {
    PUSH BC
    PUSH DE
    PUSH HL
    EX DE, HL
    CALL Direct_Class_ScreenShadow_Method_get_screen_addr_from_puffer_addr_to_HL_Code ; SCREEN_SHADOW.get_screen_addr_from_puffer_addr_to_HL( DE )
    CALL Direct_Class_Robbanas_Method_show_effect_center_Code ; this.show_effect_center( HL )
    POP HL
    PUSH HL
    CALL Direct_Class_Robbanas_Method_clear9_center_Code ; this.clear9_center( HL )
    POP HL
    POP DE
    POP BC
  RET ; }

  Direct_Class_Robbanas_Method_show_effect_center_Code: ; private show_effect_center( HL ) {
    EXX
    LD HL, 13456
    LD DE, $2157
    LD BC, 1
    LD (SILENT_LENGTH), BC
    Class_Robbanas_Until_4_Begin: ; Until begin : {
      LD C, BIT_HOSSZ
      Class_Robbanas_Until_5_Begin: ; Until begin : {
        EX AF, AF'
        CALL Direct_Class_Robbanas_Method_noise_bit_Code ; this.noise_bit( C, HL, DE )
        EX AF, AF'
        LD A, (0xE802)
        RRA
      JP NC, Class_Robbanas_Until_5_Begin ; {
      LD BC, (SILENT_LENGTH)
      LD A, C
      ADD A, SILENT_INCREMENT_VALUE
      LD C, A
      LD A, 0
      ADC A, B
      LD B, A
      LD (SILENT_LENGTH), BC
      LD A, B
      CP SILENT_HIGH_LIMIT
      EXX
      RET Z
      CALL Direct_Class_Robbanas_Method_show9_Code ; this.show9( HL )
      EXX
      CALL Direct_Class_Robbanas_Method_silent_Code ; this.silent( BC )
    JP Class_Robbanas_Until_4_Begin ; {
  RET ; }

  Direct_Class_Robbanas_Method_clear9_center_Code: ; private clear9_center( HL ) {
    LD DE, -(SHADOW_LINE_LENGTH+1)
    ADD HL, DE
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_19_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_19_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, (Class_Robbanas_DirectProperty_after_char_Shift_0_Size_1_Data) ; A := this.after_char
        LD (HL), A
      Class_Robbanas_IfBranch_19_End: ; }
    ; End full if
    INC HL
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_20_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_20_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, (Class_Robbanas_DirectProperty_after_char_Shift_0_Size_1_Data) ; A := this.after_char
        LD (HL),A
      Class_Robbanas_IfBranch_20_End: ; }
    ; End full if
    INC HL
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_21_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_21_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, (Class_Robbanas_DirectProperty_after_char_Shift_0_Size_1_Data) ; A := this.after_char
        LD (HL),A
      Class_Robbanas_IfBranch_21_End: ; }
    ; End full if
    LD DE, SHADOW_LINE_LENGTH-2
    ADD HL, DE
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_22_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_22_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, (Class_Robbanas_DirectProperty_after_char_Shift_0_Size_1_Data) ; A := this.after_char
        LD (HL),A
      Class_Robbanas_IfBranch_22_End: ; }
    ; End full if
    INC HL
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_23_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_23_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, (Class_Robbanas_DirectProperty_after_char_Shift_0_Size_1_Data) ; A := this.after_char
        LD (HL),A
      Class_Robbanas_IfBranch_23_End: ; }
    ; End full if
    INC HL
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_24_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_24_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, (Class_Robbanas_DirectProperty_after_char_Shift_0_Size_1_Data) ; A := this.after_char
        LD (HL),A
      Class_Robbanas_IfBranch_24_End: ; }
    ; End full if
    ADD HL, DE
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_25_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_25_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, (Class_Robbanas_DirectProperty_after_char_Shift_0_Size_1_Data) ; A := this.after_char
        LD (HL),A
      Class_Robbanas_IfBranch_25_End: ; }
    ; End full if
    INC HL
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_26_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_26_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, (Class_Robbanas_DirectProperty_after_char_Shift_0_Size_1_Data) ; A := this.after_char
        LD (HL),A
      Class_Robbanas_IfBranch_26_End: ; }
    ; End full if
    INC HL
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_27_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_27_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, (Class_Robbanas_DirectProperty_after_char_Shift_0_Size_1_Data) ; A := this.after_char
        LD (HL),A
      Class_Robbanas_IfBranch_27_End: ; }
    ; End full if
    LD DE, -(SHADOW_LINE_LENGTH+1)
    ADD HL, DE
  RET ; }

  Direct_Class_Robbanas_Method_show9_Code: ; private show9( HL ) {
    LD DE, -(SCREEN_LINE_LENGTH+1)
    ADD HL, DE
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_28_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_28_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, R
        OR 193
        XOR 63
        LD (HL),A
      Class_Robbanas_IfBranch_28_End: ; }
    ; End full if
    INC HL
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_29_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_29_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, R
        OR 193
        XOR 63
        LD (HL),A
      Class_Robbanas_IfBranch_29_End: ; }
    ; End full if
    INC HL
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_30_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_30_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, R
        OR 193
        XOR 63
        LD (HL),A
      Class_Robbanas_IfBranch_30_End: ; }
    ; End full if
    LD DE, SCREEN_LINE_LENGTH-2
    ADD HL, DE
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_31_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_31_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, R
        OR 193
        XOR 63
        LD (HL),A
      Class_Robbanas_IfBranch_31_End: ; }
    ; End full if
    INC HL
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_32_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_32_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, R
        OR 193
        XOR 63
        LD (HL),A
      Class_Robbanas_IfBranch_32_End: ; }
    ; End full if
    INC HL
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_33_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_33_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, R
        OR 193
        XOR 63
        LD (HL),A
      Class_Robbanas_IfBranch_33_End: ; }
    ; End full if
    ADD HL, DE
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_34_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_34_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, R
        OR 193
        XOR 63
        LD (HL),A
      Class_Robbanas_IfBranch_34_End: ; }
    ; End full if
    INC HL
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_35_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_35_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, R
        OR 193
        XOR 63
        LD (HL), A
      Class_Robbanas_IfBranch_35_End: ; }
    ; End full if
    INC HL
    LD A, (HL)
    ; Begin if 
      Class_Robbanas_IfBranch_36_Begin: ; if ( A != OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; if ( A != OBJECT_STEEL_CHAR ) {
        JP Z, Class_Robbanas_IfBranch_36_End ; if ( A != OBJECT_STEEL_CHAR ) {
        LD A, R
        OR 193
        XOR 63
        LD (HL), A
      Class_Robbanas_IfBranch_36_End: ; }
    ; End full if
    LD DE, -(SCREEN_LINE_LENGTH+1)
    ADD HL, DE
  RET ; }

  Direct_Class_Robbanas_Method_silent_Code: ; private silent( BC ) {
    Class_Robbanas_Until_6_Begin: ; Until begin : {
      LD (SPEAKER_OFF), A
      NOP
      DEC BC
      LD A, B
      OR C
    JP NZ, Class_Robbanas_Until_6_Begin ; {
  RET ; }

  Direct_Class_Robbanas_Method_noise_bit_Code: ; private noise_bit( C, HL, DE ) {
    ADD HL, DE
    RLC H
    INC H
    LD A, H
    LD (NOISE_OUT+1), A
    LD B, C ; for B = C to 1 {
    Class_Robbanas_ForB_4_Begin:
      NOISE_OUT:  LD (SPEAKER_OFF), A
      NOP
    DJNZ Class_Robbanas_ForB_4_Begin
    LD (SPEAKER_OFF), A
  RET ; }
; } ; End class Robbanas

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Puffanas extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  Direct_Class_Puffanas_Method_go_Code: ; private go() {
    EXX
    LD HL, 13456
    LD DE, $2157
    LD BC, 1
    LD (PUFF_SILENT_LENGTH), BC
    Class_Puffanas_Until_7_Begin: ; Until begin : {
      LD C, PUFF_BIT_HOSSZ
      LD A, PUFF_BIT_BLOCK_LENGTH
      Class_Puffanas_Until_8_Begin: ; Until begin : {
        EX AF, AF'
        CALL Direct_Class_Puffanas_Method_noise_bit_Code ; this.noise_bit( C, HL, DE )
        EX AF, AF'
        DEC A
      JP NZ, Class_Puffanas_Until_8_Begin ; {
      LD BC, (PUFF_SILENT_LENGTH)
      LD A, C
      ADD A, PUFF_SILENT_INCREMENT_VALUE
      LD C, A
      LD A, 0
      ADC A, B
      LD B, A
      LD (PUFF_SILENT_LENGTH), BC
      LD A, B
      CP PUFF_SILENT_HIGH_LIMIT
      EXX
      RET Z
      EXX
      CALL Direct_Class_Puffanas_Method_silent_Code ; this.silent( BC )
    JP Class_Puffanas_Until_7_Begin ; {
  RET ; }

  Direct_Class_Puffanas_Method_silent_Code: ; private silent( BC ) {
    Class_Puffanas_Until_9_Begin: ; Until begin : {
      LD (SPEAKER_OFF), A
      NOP
      DEC BC
      LD A, B
      OR C
    JP NZ, Class_Puffanas_Until_9_Begin ; {
  RET ; }

  Direct_Class_Puffanas_Method_noise_bit_Code: ; private noise_bit( C, HL, DE ) {
    ADD HL, DE
    RLC H
    INC H
    LD A, H
    LD (PUFF_NOISE_OUT+1), A
    LD B, C ; for B = C to 1 {
    Class_Puffanas_ForB_5_Begin:
      PUFF_NOISE_OUT:  LD (SPEAKER_OFF), A
      NOP
    DJNZ Class_Puffanas_ForB_5_Begin
    LD (SPEAKER_OFF), A
  RET ; }
; } ; End class Puffanas

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Sounds extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  Direct_Class_Sounds_Method_timeout_Code: ; public timeout() {
    LD A, 45 ; this.ping( 45 )
    CALL Direct_Class_Sounds_Method_ping_Code ; this.ping( 45 )
  RET ; }

  Direct_Class_Sounds_Method_diamond_Code: ; public diamond() {
    LD A, 65 ; this.ping( 65 )
    CALL Direct_Class_Sounds_Method_ping_Code ; this.ping( 65 )
  RET ; }

  Direct_Class_Sounds_Method_open_door_Code: ; public open_door() {
    LD A, 165 ; this.ping( 165 )
    CALL Direct_Class_Sounds_Method_ping_Code ; this.ping( 165 )
  RET ; }

  Direct_Class_Sounds_Method_extra_life_Code: ; public extra_life() {
    LD A, 225 ; this.ping( 225 )
    CALL Direct_Class_Sounds_Method_ping_Code ; this.ping( 225 )
  RET ; }

  Direct_Class_Sounds_Method_ping_Code: ; private ping( A ) {
    EXX
    LD C, 0
    Class_Sounds_Until_10_Begin: ; Until begin : {
      LD B, A ; for B = A to 1 {
      Class_Sounds_ForB_6_Begin:
        LD (SPEAKER_ON), A
      DJNZ Class_Sounds_ForB_6_Begin
      LD B, C ; for B = C to 1 {
      Class_Sounds_ForB_7_Begin:
        LD (SPEAKER_OFF), A
      DJNZ Class_Sounds_ForB_7_Begin
      INC C
      DEC A
    JP NZ, Class_Sounds_Until_10_Begin ; {
    EXX
  RET ; }
; } ; End class Sounds

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Screen extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  Direct_Class_Screen_Method_write_text_Code: ; private write_text( DE, HL ) {
    LD A, (DE)
    Class_Screen_Until_11_Begin: ; Until begin : {
      LD (HL), A
      INC HL
      INC DE
      LD A, (DE)
    CP '@' ; {
    JP NZ, Class_Screen_Until_11_Begin ; {
  RET ; }

  Direct_Class_Screen_Method_fill_Code: ; public fill( A, BC ) {
    LD HL, SCREEN
    LD DE, SCREEN+1
    LD (HL), A
    LDIR
  RET ; }

  Direct_Class_Screen_Method_wait_for_black_Code: ; public wait_for_black() {
    Class_Screen_Until_12_Begin: ; Until begin : {
      LD A, (0xE802)
      RRA
    JP C, Class_Screen_Until_12_Begin ; {
    Class_Screen_Until_13_Begin: ; Until begin : {
      LD A, (0xE802)
      RRA
    JP NC, Class_Screen_Until_13_Begin ; {
  RET ; }
; } ; End class Screen

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Controller extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_Controller_DirectProperty_skip_counter_Shift_0_Size_1_Data: DB 0 ; DB skip_counter
  Class_Controller_DirectProperty_last_pressed_Shift_1_Size_1_Data: DB 0 ; DB last_pressed

  Direct_Class_Controller_Method_constructor_Code: ; constructor() {
    LD A, CONTROLLER_SPEED ; this.skip_counter := CONTROLLER_SPEED
    LD (Class_Controller_DirectProperty_skip_counter_Shift_0_Size_1_Data), A ; this.skip_counter := CONTROLLER_SPEED
    LD A, NOTHING_PRESSED ; this.last_pressed := NOTHING_PRESSED
    LD (Class_Controller_DirectProperty_last_pressed_Shift_1_Size_1_Data), A ; this.last_pressed := NOTHING_PRESSED
  RET ; }

  Direct_Class_Controller_Method_get_direction_to_A_Z_Code: ; public get_direction_to_A_Z() {
    CALL Direct_Class_Controller_Method_hack_keys_Code ; this.hack_keys()
    LD A, (KEYBOARD_CURSOR_ADDR)
    AND NOTHING_PRESSED
    CP NOTHING_PRESSED
    ; Begin if 
      Class_Controller_IfBranch_37_Begin: ; if ( Z ) {
        JP NZ, Class_Controller_IfBranch_37_End ; if ( Z ) {
        LD A, (KEYBOARD_JKLM_ADDR)
        AND NOTHING_PRESSED
        CP NOTHING_PRESSED
        ; Begin if 
          Class_Controller_IfBranch_38_Begin: ; if ( NZ ) {
            JP Z, Class_Controller_IfBranch_38_End ; if ( NZ ) {
            BIT KEYBOARD_J_BIT, A
            ; Begin if 
              Class_Controller_IfBranch_39_Begin: ; if ( Z ) {
                JP NZ, Class_Controller_IfBranch_40_Begin ; if ( Z ) {
                LD A, KEYBOARD_CURSOR_UP
                JR Class_Controller_IfBranch_40_End ; if ( Z ) {
              Class_Controller_IfBranch_40_Begin: ; } else {
                BIT KEYBOARD_M_BIT, A
                ; Begin if 
                  Class_Controller_IfBranch_41_Begin: ; if ( Z ) {
                    JP NZ, Class_Controller_IfBranch_42_Begin ; if ( Z ) {
                    LD A, KEYBOARD_CURSOR_DOWN
                    JR Class_Controller_IfBranch_42_End ; if ( Z ) {
                  Class_Controller_IfBranch_42_Begin: ; } else {
                    BIT KEYBOARD_L_BIT, A
                    ; Begin if 
                      Class_Controller_IfBranch_43_Begin: ; if ( Z ) {
                        JP NZ, Class_Controller_IfBranch_44_Begin ; if ( Z ) {
                        LD A, KEYBOARD_CURSOR_RIGHT
                        JR Class_Controller_IfBranch_44_End ; if ( Z ) {
                      Class_Controller_IfBranch_44_Begin: ; } else {
                        LD A, KEYBOARD_CURSOR_LEFT_BIT
                      Class_Controller_IfBranch_44_End: ; }
                    ; End full if
                  Class_Controller_IfBranch_42_End: ; }
                ; End full if
              Class_Controller_IfBranch_40_End: ; }
            ; End full if
            OR A
          Class_Controller_IfBranch_38_End: ; }
        ; End full if
      Class_Controller_IfBranch_37_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Controller_Method_check_in_wait_Code: ; public check_in_wait() {
    LD A, (KEYBOARD_CURSOR_ADDR)
    AND NOTHING_PRESSED
    ; Begin if 
      Class_Controller_IfBranch_45_Begin: ; if ( A != NOTHING_PRESSED ) {
        CP NOTHING_PRESSED ; if ( A != NOTHING_PRESSED ) {
        JP Z, Class_Controller_IfBranch_45_End ; if ( A != NOTHING_PRESSED ) {
        LD (Class_Controller_DirectProperty_last_pressed_Shift_1_Size_1_Data), A ; this.last_pressed := A
      Class_Controller_IfBranch_45_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Controller_Method_hack_keys_Code: ; private hack_keys() {
    LD A,(KEYBOARD_PQRS_ADDR)
    AND NOTHING_PRESSED
    ; Begin if 
      Class_Controller_IfBranch_46_Begin: ; if ( A == 13 ) {
        CP 13 ; if ( A == 13 ) {
        JP NZ, Class_Controller_IfBranch_46_End ; if ( A == 13 ) {
        LD A, 0 ; PLAYER.in_game := 0
        LD (Class_Player_DirectProperty_in_game_Shift_2_Size_1_Data), A ; PLAYER.in_game := 0
        LD A, 0 ; GAME.live_counter := 0
        LD (Class_Game_DirectProperty_live_counter_Shift_2_Size_1_Data), A ; GAME.live_counter := 0
      Class_Controller_IfBranch_46_End: ; }
    ; End full if
  RET ; }
; } ; End class Controller

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Modulo800 extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  BASE_VALUE:    EQU 800
  MODULO_800_START_ADDRESS: EQU CAVE_PUFFER + SHADOW_LINE_LENGTH

  Direct_Class_Modulo800_Method_add_to_HL_Code: ; public add_to_HL( DE, HL ) {
    ADD HL, DE
    LD D, H
    LD E, L
    LD BC, MODULO_800_START_ADDRESS + BASE_VALUE
    OR A
    SBC HL, BC
    ; Begin if 
      Class_Modulo800_IfBranch_47_Begin: ; if ( NCY ) {
        JP C, Class_Modulo800_IfBranch_48_Begin ; if ( NCY ) {
        LD BC, MODULO_800_START_ADDRESS
        ADD HL, BC
        JR Class_Modulo800_IfBranch_48_End ; if ( NCY ) {
      Class_Modulo800_IfBranch_48_Begin: ; } else {
        LD H, D
        LD L, E
      Class_Modulo800_IfBranch_48_End: ; }
    ; End full if
  RET ; }
; } ; End class Modulo800

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Info extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  Direct_Class_Info_Method_show_qhelp_Code: ; private show_qhelp() {
    LD HL, QHELP_START ; direct asm value ; this.printat( QHELP_START,       HLINE,         146,                      143 )
    LD DE, HLINE ; direct asm value ; this.printat( QHELP_START,       HLINE,         146,                      143 )
    LD B, 146 ; this.printat( QHELP_START,       HLINE,         146,                      143 )
    LD C, 143 ; this.printat( QHELP_START,       HLINE,         146,                      143 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START,       HLINE,         146,                      143 )
    LD HL, QHELP_START+ 1*64 ; direct asm value ; this.printat( QHELP_START+ 1*64, "Player   :@", OBJECT_PLAYER_CHAR,       147 )
    LD DE, String_constant_6_Data ; this.printat( QHELP_START+ 1*64, "Player   :@", OBJECT_PLAYER_CHAR,       147 )
    LD B, OBJECT_PLAYER_CHAR ; this.printat( QHELP_START+ 1*64, "Player   :@", OBJECT_PLAYER_CHAR,       147 )
    LD C, 147 ; this.printat( QHELP_START+ 1*64, "Player   :@", OBJECT_PLAYER_CHAR,       147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+ 1*64, "Player   :@", OBJECT_PLAYER_CHAR,       147 )
    LD HL, QHELP_START+ 2*64 ; direct asm value ; this.printat( QHELP_START+ 2*64, "Earth    :@", OBJECT_DIRT_CHAR,         147 )
    LD DE, String_constant_7_Data ; this.printat( QHELP_START+ 2*64, "Earth    :@", OBJECT_DIRT_CHAR,         147 )
    LD B, OBJECT_DIRT_CHAR ; this.printat( QHELP_START+ 2*64, "Earth    :@", OBJECT_DIRT_CHAR,         147 )
    LD C, 147 ; this.printat( QHELP_START+ 2*64, "Earth    :@", OBJECT_DIRT_CHAR,         147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+ 2*64, "Earth    :@", OBJECT_DIRT_CHAR,         147 )
    LD HL, QHELP_START+ 3*64 ; direct asm value ; this.printat( QHELP_START+ 3*64, "Stone    :@", OBJECT_STONE_CHAR,        147 )
    LD DE, String_constant_8_Data ; this.printat( QHELP_START+ 3*64, "Stone    :@", OBJECT_STONE_CHAR,        147 )
    LD B, OBJECT_STONE_CHAR ; this.printat( QHELP_START+ 3*64, "Stone    :@", OBJECT_STONE_CHAR,        147 )
    LD C, 147 ; this.printat( QHELP_START+ 3*64, "Stone    :@", OBJECT_STONE_CHAR,        147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+ 3*64, "Stone    :@", OBJECT_STONE_CHAR,        147 )
    LD HL, QHELP_START+ 4*64 ; direct asm value ; this.printat( QHELP_START+ 4*64, "Diamond  :@", OBJECT_DIAMOND1_CHAR,     147 )
    LD DE, String_constant_9_Data ; this.printat( QHELP_START+ 4*64, "Diamond  :@", OBJECT_DIAMOND1_CHAR,     147 )
    LD B, OBJECT_DIAMOND1_CHAR ; this.printat( QHELP_START+ 4*64, "Diamond  :@", OBJECT_DIAMOND1_CHAR,     147 )
    LD C, 147 ; this.printat( QHELP_START+ 4*64, "Diamond  :@", OBJECT_DIAMOND1_CHAR,     147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+ 4*64, "Diamond  :@", OBJECT_DIAMOND1_CHAR,     147 )
    LD HL, QHELP_START+ 5*64 ; direct asm value ; this.printat( QHELP_START+ 5*64, "Firefly  :@", OBJECT_FIREFLY1_CHAR,     147 )
    LD DE, String_constant_10_Data ; this.printat( QHELP_START+ 5*64, "Firefly  :@", OBJECT_FIREFLY1_CHAR,     147 )
    LD B, OBJECT_FIREFLY1_CHAR ; this.printat( QHELP_START+ 5*64, "Firefly  :@", OBJECT_FIREFLY1_CHAR,     147 )
    LD C, 147 ; this.printat( QHELP_START+ 5*64, "Firefly  :@", OBJECT_FIREFLY1_CHAR,     147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+ 5*64, "Firefly  :@", OBJECT_FIREFLY1_CHAR,     147 )
    LD HL, QHELP_START+ 6*64 ; direct asm value ; this.printat( QHELP_START+ 6*64, "Butterly :@", OBJECT_BUTTERFLY1_CHAR,   147 )
    LD DE, String_constant_11_Data ; this.printat( QHELP_START+ 6*64, "Butterly :@", OBJECT_BUTTERFLY1_CHAR,   147 )
    LD B, OBJECT_BUTTERFLY1_CHAR ; this.printat( QHELP_START+ 6*64, "Butterly :@", OBJECT_BUTTERFLY1_CHAR,   147 )
    LD C, 147 ; this.printat( QHELP_START+ 6*64, "Butterly :@", OBJECT_BUTTERFLY1_CHAR,   147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+ 6*64, "Butterly :@", OBJECT_BUTTERFLY1_CHAR,   147 )
    LD HL, QHELP_START+ 7*64 ; direct asm value ; this.printat( QHELP_START+ 7*64, "Amoeba   :@", OBJECT_AMOEBA_CHAR,       147 )
    LD DE, String_constant_12_Data ; this.printat( QHELP_START+ 7*64, "Amoeba   :@", OBJECT_AMOEBA_CHAR,       147 )
    LD B, OBJECT_AMOEBA_CHAR ; this.printat( QHELP_START+ 7*64, "Amoeba   :@", OBJECT_AMOEBA_CHAR,       147 )
    LD C, 147 ; this.printat( QHELP_START+ 7*64, "Amoeba   :@", OBJECT_AMOEBA_CHAR,       147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+ 7*64, "Amoeba   :@", OBJECT_AMOEBA_CHAR,       147 )
    LD HL, QHELP_START+ 8*64 ; direct asm value ; this.printat( QHELP_START+ 8*64, "Exit     :@", OBJECT_OPENED_DOOR_CHAR,  147 )
    LD DE, String_constant_13_Data ; this.printat( QHELP_START+ 8*64, "Exit     :@", OBJECT_OPENED_DOOR_CHAR,  147 )
    LD B, OBJECT_OPENED_DOOR_CHAR ; this.printat( QHELP_START+ 8*64, "Exit     :@", OBJECT_OPENED_DOOR_CHAR,  147 )
    LD C, 147 ; this.printat( QHELP_START+ 8*64, "Exit     :@", OBJECT_OPENED_DOOR_CHAR,  147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+ 8*64, "Exit     :@", OBJECT_OPENED_DOOR_CHAR,  147 )
    LD HL, QHELP_START+ 9*64 ; direct asm value ; this.printat( QHELP_START+ 9*64, "Wall     :@", OBJECT_WALL_CHAR,         147 )
    LD DE, String_constant_14_Data ; this.printat( QHELP_START+ 9*64, "Wall     :@", OBJECT_WALL_CHAR,         147 )
    LD B, OBJECT_WALL_CHAR ; this.printat( QHELP_START+ 9*64, "Wall     :@", OBJECT_WALL_CHAR,         147 )
    LD C, 147 ; this.printat( QHELP_START+ 9*64, "Wall     :@", OBJECT_WALL_CHAR,         147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+ 9*64, "Wall     :@", OBJECT_WALL_CHAR,         147 )
    LD HL, QHELP_START+10*64 ; direct asm value ; this.printat( QHELP_START+10*64, "Magick W.:@", OBJECT_MAGICK_WALL1_CHAR, 147 )
    LD DE, String_constant_15_Data ; this.printat( QHELP_START+10*64, "Magick W.:@", OBJECT_MAGICK_WALL1_CHAR, 147 )
    LD B, OBJECT_MAGICK_WALL1_CHAR ; this.printat( QHELP_START+10*64, "Magick W.:@", OBJECT_MAGICK_WALL1_CHAR, 147 )
    LD C, 147 ; this.printat( QHELP_START+10*64, "Magick W.:@", OBJECT_MAGICK_WALL1_CHAR, 147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+10*64, "Magick W.:@", OBJECT_MAGICK_WALL1_CHAR, 147 )
    LD HL, QHELP_START+11*64 ; direct asm value ; this.printat( QHELP_START+11*64, "Steel    :@", OBJECT_STEEL_CHAR,        147 )
    LD DE, String_constant_16_Data ; this.printat( QHELP_START+11*64, "Steel    :@", OBJECT_STEEL_CHAR,        147 )
    LD B, OBJECT_STEEL_CHAR ; this.printat( QHELP_START+11*64, "Steel    :@", OBJECT_STEEL_CHAR,        147 )
    LD C, 147 ; this.printat( QHELP_START+11*64, "Steel    :@", OBJECT_STEEL_CHAR,        147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+11*64, "Steel    :@", OBJECT_STEEL_CHAR,        147 )
    LD HL, QHELP_START+12*64 ; direct asm value ; this.printat( QHELP_START+12*64, HLINE,         146,                      145 )
    LD DE, HLINE ; direct asm value ; this.printat( QHELP_START+12*64, HLINE,         146,                      145 )
    LD B, 146 ; this.printat( QHELP_START+12*64, HLINE,         146,                      145 )
    LD C, 145 ; this.printat( QHELP_START+12*64, HLINE,         146,                      145 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+12*64, HLINE,         146,                      145 )
    LD HL, QHELP_START+15*64 ; direct asm value ; this.printat( QHELP_START+15*64, HLINE,         146,                      143 )
    LD DE, HLINE ; direct asm value ; this.printat( QHELP_START+15*64, HLINE,         146,                      143 )
    LD B, 146 ; this.printat( QHELP_START+15*64, HLINE,         146,                      143 )
    LD C, 143 ; this.printat( QHELP_START+15*64, HLINE,         146,                      143 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+15*64, HLINE,         146,                      143 )
    LD HL, QHELP_START+16*64 ; direct asm value ; this.printat( QHELP_START+16*64, "-=Control=@", '-',                      147 )
    LD DE, String_constant_17_Data ; this.printat( QHELP_START+16*64, "-=Control=@", '-',                      147 )
    LD B, '-' ; this.printat( QHELP_START+16*64, "-=Control=@", '-',                      147 )
    LD C, 147 ; this.printat( QHELP_START+16*64, "-=Control=@", '-',                      147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+16*64, "-=Control=@", '-',                      147 )
    LD HL, QHELP_START+17*64 ; direct asm value ; this.printat( QHELP_START+17*64, " Left:  K @", 10,                       147 )
    LD DE, String_constant_18_Data ; this.printat( QHELP_START+17*64, " Left:  K @", 10,                       147 )
    LD B, 10 ; this.printat( QHELP_START+17*64, " Left:  K @", 10,                       147 )
    LD C, 147 ; this.printat( QHELP_START+17*64, " Left:  K @", 10,                       147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+17*64, " Left:  K @", 10,                       147 )
    LD HL, QHELP_START+18*64 ; direct asm value ; this.printat( QHELP_START+18*64, " Right: L @", 11,                       147 )
    LD DE, String_constant_19_Data ; this.printat( QHELP_START+18*64, " Right: L @", 11,                       147 )
    LD B, 11 ; this.printat( QHELP_START+18*64, " Right: L @", 11,                       147 )
    LD C, 147 ; this.printat( QHELP_START+18*64, " Right: L @", 11,                       147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+18*64, " Right: L @", 11,                       147 )
    LD HL, QHELP_START+19*64 ; direct asm value ; this.printat( QHELP_START+19*64, " Up:    J @", 08,                       147 )
    LD DE, String_constant_20_Data ; this.printat( QHELP_START+19*64, " Up:    J @", 08,                       147 )
    LD B, 08 ; this.printat( QHELP_START+19*64, " Up:    J @", 08,                       147 )
    LD C, 147 ; this.printat( QHELP_START+19*64, " Up:    J @", 08,                       147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+19*64, " Up:    J @", 08,                       147 )
    LD HL, QHELP_START+20*64 ; direct asm value ; this.printat( QHELP_START+20*64, " Down:  M @", 09,                       147 )
    LD DE, String_constant_21_Data ; this.printat( QHELP_START+20*64, " Down:  M @", 09,                       147 )
    LD B, 09 ; this.printat( QHELP_START+20*64, " Down:  M @", 09,                       147 )
    LD C, 147 ; this.printat( QHELP_START+20*64, " Down:  M @", 09,                       147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+20*64, " Down:  M @", 09,                       147 )
    LD HL, QHELP_START+21*64 ; direct asm value ; this.printat( QHELP_START+21*64, " Quit:  Q @", 32,                       147 )
    LD DE, String_constant_22_Data ; this.printat( QHELP_START+21*64, " Quit:  Q @", 32,                       147 )
    LD B, 32 ; this.printat( QHELP_START+21*64, " Quit:  Q @", 32,                       147 )
    LD C, 147 ; this.printat( QHELP_START+21*64, " Quit:  Q @", 32,                       147 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+21*64, " Quit:  Q @", 32,                       147 )
    LD HL, QHELP_START+22*64 ; direct asm value ; this.printat( QHELP_START+22*64, HLINE,         146,                      145 )
    LD DE, HLINE ; direct asm value ; this.printat( QHELP_START+22*64, HLINE,         146,                      145 )
    LD B, 146 ; this.printat( QHELP_START+22*64, HLINE,         146,                      145 )
    LD C, 145 ; this.printat( QHELP_START+22*64, HLINE,         146,                      145 )
    CALL Direct_Class_Info_Method_printat_Code ; this.printat( QHELP_START+22*64, HLINE,         146,                      145 )
  RET ; }
  HLINE: DB 146,146,146,146,146,146,146,146,146,146,'@'

  Direct_Class_Info_Method_printat_Code: ; private printat( HL, DE, B, C ) {
    CALL Direct_Class_Screen_Method_write_text_Code ; SCREEN.write_text( DE, HL )
    LD (HL), B
    INC HL
    LD (HL), C
  RET ; }
; } ; End class Info

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Player extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_Player_DirectProperty_shadow_pos_addr_Shift_0_Size_2_Data: DW 0 ; DW shadow_pos_addr
  Class_Player_DirectProperty_in_game_Shift_2_Size_1_Data: DB 0 ; DB in_game
  Class_Player_DirectProperty_speed_Shift_3_Size_1_Data: DB 0 ; DB speed
  Class_Player_DirectProperty_move_impulse_Shift_4_Size_1_Data: DB 0 ; DB move_impulse
  Class_Player_DirectProperty_in_flash_Shift_5_Size_1_Data: DB 0 ; DB in_flash

  Direct_Class_Player_Method_init_Code: ; public init( HL ) {
    PUSH AF
    LD (Class_Player_DirectProperty_shadow_pos_addr_Shift_0_Size_2_Data), HL ; this.shadow_pos_addr := HL
    LD A, 1 ; this.in_game := 1
    LD (Class_Player_DirectProperty_in_game_Shift_2_Size_1_Data), A ; this.in_game := 1
    LD A, 0 ; this.move_impulse := 0
    LD (Class_Player_DirectProperty_move_impulse_Shift_4_Size_1_Data), A ; this.move_impulse := 0
    LD A, PLAYER_SPEED ; this.speed := PLAYER_SPEED
    LD (Class_Player_DirectProperty_speed_Shift_3_Size_1_Data), A ; this.speed := PLAYER_SPEED
    LD A, 25 ; this.in_flash := 25
    LD (Class_Player_DirectProperty_in_flash_Shift_5_Size_1_Data), A ; this.in_flash := 25
    POP AF
  RET ; }

  Direct_Class_Player_Method_check_speed_NZ_Code: ; public check_speed_NZ() {
    LD A, (Class_Player_DirectProperty_speed_Shift_3_Size_1_Data) ; dec this.speed
    DEC A ; dec this.speed
    LD (Class_Player_DirectProperty_speed_Shift_3_Size_1_Data), A ; dec this.speed
    ; Begin if 
      Class_Player_IfBranch_49_Begin: ; if ( Z ) {
        JP NZ, Class_Player_IfBranch_52_Begin ; if ( Z ) {
        LD A, PLAYER_SPEED ; this.speed := PLAYER_SPEED
        LD (Class_Player_DirectProperty_speed_Shift_3_Size_1_Data), A ; this.speed := PLAYER_SPEED
        LD A, (Class_Player_DirectProperty_in_flash_Shift_5_Size_1_Data) ; A := this.in_flash
        ; Begin if 
          Class_Player_IfBranch_50_Begin: ; if ( A != 0 ) {
            CP 0 ; if ( A != 0 ) {
            JP Z, Class_Player_IfBranch_51_Begin ; if ( A != 0 ) {
            CALL Direct_Class_Player_Method_flash_tick_Code ; this.flash_tick( A )
            XOR A
            JR Class_Player_IfBranch_51_End ; if ( A != 0 ) {
          Class_Player_IfBranch_51_Begin: ; } else {
            OR 1
          Class_Player_IfBranch_51_End: ; }
        ; End full if
        JR Class_Player_IfBranch_52_End ; if ( Z ) {
      Class_Player_IfBranch_52_Begin: ; } else {
        XOR A
      Class_Player_IfBranch_52_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Player_Method_flash_tick_Code: ; public flash_tick( A ) {
    DEC A
    LD (Class_Player_DirectProperty_in_flash_Shift_5_Size_1_Data), A ; this.in_flash := A
    LD HL, (Class_Player_DirectProperty_shadow_pos_addr_Shift_0_Size_2_Data) ; HL := this.shadow_pos_addr
    BIT 1, A
    ; Begin if 
      Class_Player_IfBranch_53_Begin: ; if ( NZ ) {
        JP Z, Class_Player_IfBranch_54_Begin ; if ( NZ ) {
        LD (HL), 0
        JR Class_Player_IfBranch_54_End ; if ( NZ ) {
      Class_Player_IfBranch_54_Begin: ; } else {
        LD (HL), OBJECT_PLAYER_CHAR
      Class_Player_IfBranch_54_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Player_Method_move_player_Code: ; public move_player( A ) {
    LD HL, (Class_Player_DirectProperty_shadow_pos_addr_Shift_0_Size_2_Data) ; HL := this.shadow_pos_addr
    PUSH HL
    POP DE
    BIT KEYBOARD_CURSOR_LEFT_BIT, A
    CALL Z, Direct_Class_Player_Method_move_left_Code ; this.move_left() if ( Z )
    BIT KEYBOARD_CURSOR_RIGHT_BIT, A
    CALL Z, Direct_Class_Player_Method_move_right_Code ; this.move_right() if ( Z )
    BIT KEYBOARD_CURSOR_UP_BIT, A
    CALL Z, Direct_Class_Player_Method_move_up_Code ; this.move_up() if ( Z )
    BIT KEYBOARD_CURSOR_DOWN_BIT, A
    CALL Z, Direct_Class_Player_Method_move_down_Code ; this.move_down() if ( Z )
  RET ; }

  Direct_Class_Player_Method_kill_Code: ; public kill() {
    LD HL, (Class_Player_DirectProperty_shadow_pos_addr_Shift_0_Size_2_Data) ; HL := this.shadow_pos_addr
    LD A, (Class_Player_DirectProperty_in_game_Shift_2_Size_1_Data) ; A := this.in_game
    ; Begin if 
      Class_Player_IfBranch_55_Begin: ; if ( A != 0 ) {
        CP 0 ; if ( A != 0 ) {
        JP Z, Class_Player_IfBranch_55_End ; if ( A != 0 ) {
        LD A, 0 ; this.in_game := 0
        LD (Class_Player_DirectProperty_in_game_Shift_2_Size_1_Data), A ; this.in_game := 0
        LD A, (Class_Game_DirectProperty_live_counter_Shift_2_Size_1_Data) ; dec GAME.live_counter
        DEC A ; dec GAME.live_counter
        LD (Class_Game_DirectProperty_live_counter_Shift_2_Size_1_Data), A ; dec GAME.live_counter
      Class_Player_IfBranch_55_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Player_Method_next_cave_Code: ; private next_cave( DE ) {
    LD A, OBJECT_SPACE_CHAR
    LD (DE), A
    CALL Direct_Class_Status_Method_addTimerToPoints_Code ; STATUS.addTimerToPoints()
    LD A, (Class_Game_DirectProperty_cave_Shift_0_Size_1_Data) ; inc GAME.cave
    INC A ; inc GAME.cave
    LD (Class_Game_DirectProperty_cave_Shift_0_Size_1_Data), A ; inc GAME.cave
    ; Begin if 
      Class_Player_IfBranch_56_Begin: ; if ( A == 'T'-'A'+1 ) {
        CP 'T'-'A'+1 ; if ( A == 'T'-'A'+1 ) {
        JP NZ, Class_Player_IfBranch_56_End ; if ( A == 'T'-'A'+1 ) {
        LD A, 0 ; GAME.cave := 0
        LD (Class_Game_DirectProperty_cave_Shift_0_Size_1_Data), A ; GAME.cave := 0
        LD A, (Class_Game_DirectProperty_level_Shift_1_Size_1_Data) ; inc GAME.level
        INC A ; inc GAME.level
        LD (Class_Game_DirectProperty_level_Shift_1_Size_1_Data), A ; inc GAME.level
        ; Begin if 
          Class_Player_IfBranch_57_Begin: ; if ( A == 6 ) {
            CP 6 ; if ( A == 6 ) {
            JP NZ, Class_Player_IfBranch_57_End ; if ( A == 6 ) {
            LD A, 1 ; GAME.level := 1
            LD (Class_Game_DirectProperty_level_Shift_1_Size_1_Data), A ; GAME.level := 1
          Class_Player_IfBranch_57_End: ; }
        ; End full if
      Class_Player_IfBranch_56_End: ; }
    ; End full if
    LD A, 0 ; this.in_game := 0
    LD (Class_Player_DirectProperty_in_game_Shift_2_Size_1_Data), A ; this.in_game := 0
  RET ; }

  Direct_Class_Player_Method_move_left_Code: ; private move_left() {
    DEC HL
    LD A, (HL)
    ; Begin if 
      Class_Player_IfBranch_58_Begin: ; if ( A == OBJECT_STONE_CHAR ) {
        CP OBJECT_STONE_CHAR ; if ( A == OBJECT_STONE_CHAR ) {
        JP NZ, Class_Player_IfBranch_63_Begin ; if ( A == OBJECT_STONE_CHAR ) {
        DEC HL
        LD A, (HL)
        INC HL
        ; Begin if 
          Class_Player_IfBranch_59_Begin: ; if ( A == OBJECT_SPACE_CHAR ) {
            CP OBJECT_SPACE_CHAR ; if ( A == OBJECT_SPACE_CHAR ) {
            JP NZ, Class_Player_IfBranch_62_Begin ; if ( A == OBJECT_SPACE_CHAR ) {
            LD A, (Class_Player_DirectProperty_move_impulse_Shift_4_Size_1_Data) ; A := this.move_impulse
            ; Begin if 
              Class_Player_IfBranch_60_Begin: ; if ( A == 1 ) {
                CP 1 ; if ( A == 1 ) {
                JP NZ, Class_Player_IfBranch_61_Begin ; if ( A == 1 ) {
                CALL Direct_Class_GravityStone_Method_move_left_Code ; STONEGRAVITY.move_left( HL )
                LD A, 0 ; this.move_impulse := 0
                LD (Class_Player_DirectProperty_move_impulse_Shift_4_Size_1_Data), A ; this.move_impulse := 0
                JR Class_Player_IfBranch_61_End ; if ( A == 1 ) {
              Class_Player_IfBranch_61_Begin: ; } else {
                LD A, 1 ; this.move_impulse := 1
                LD (Class_Player_DirectProperty_move_impulse_Shift_4_Size_1_Data), A ; this.move_impulse := 1
              Class_Player_IfBranch_61_End: ; }
            ; End full if
            JR Class_Player_IfBranch_62_End ; if ( A == OBJECT_SPACE_CHAR ) {
          Class_Player_IfBranch_62_Begin: ; } else {
            LD A, 0 ; this.move_impulse := 0
            LD (Class_Player_DirectProperty_move_impulse_Shift_4_Size_1_Data), A ; this.move_impulse := 0
          Class_Player_IfBranch_62_End: ; }
        ; End full if
        JR Class_Player_IfBranch_63_End ; if ( A == OBJECT_STONE_CHAR ) {
      Class_Player_IfBranch_63_Begin: ; } else {
        LD A, 0 ; this.move_impulse := 0
        LD (Class_Player_DirectProperty_move_impulse_Shift_4_Size_1_Data), A ; this.move_impulse := 0
      Class_Player_IfBranch_63_End: ; }
    ; End full if
    CALL Direct_Class_Player_Method_move_Code ; this.move()
  RET ; }

  Direct_Class_Player_Method_move_right_Code: ; private move_right() {
    INC HL
    LD A, (HL)
    ; Begin if 
      Class_Player_IfBranch_64_Begin: ; if ( A == OBJECT_STONE_CHAR ) {
        CP OBJECT_STONE_CHAR ; if ( A == OBJECT_STONE_CHAR ) {
        JP NZ, Class_Player_IfBranch_69_Begin ; if ( A == OBJECT_STONE_CHAR ) {
        INC HL
        LD A, (HL)
        DEC HL
        ; Begin if 
          Class_Player_IfBranch_65_Begin: ; if ( A == OBJECT_SPACE_CHAR ) {
            CP OBJECT_SPACE_CHAR ; if ( A == OBJECT_SPACE_CHAR ) {
            JP NZ, Class_Player_IfBranch_68_Begin ; if ( A == OBJECT_SPACE_CHAR ) {
            LD A, (Class_Player_DirectProperty_move_impulse_Shift_4_Size_1_Data) ; A := this.move_impulse
            ; Begin if 
              Class_Player_IfBranch_66_Begin: ; if ( A == 1 ) {
                CP 1 ; if ( A == 1 ) {
                JP NZ, Class_Player_IfBranch_67_Begin ; if ( A == 1 ) {
                CALL Direct_Class_GravityStone_Method_move_right_Code ; STONEGRAVITY.move_right( HL )
                LD A, 0 ; this.move_impulse := 0
                LD (Class_Player_DirectProperty_move_impulse_Shift_4_Size_1_Data), A ; this.move_impulse := 0
                JR Class_Player_IfBranch_67_End ; if ( A == 1 ) {
              Class_Player_IfBranch_67_Begin: ; } else {
                LD A, 1 ; this.move_impulse := 1
                LD (Class_Player_DirectProperty_move_impulse_Shift_4_Size_1_Data), A ; this.move_impulse := 1
              Class_Player_IfBranch_67_End: ; }
            ; End full if
            JR Class_Player_IfBranch_68_End ; if ( A == OBJECT_SPACE_CHAR ) {
          Class_Player_IfBranch_68_Begin: ; } else {
            LD A, 0 ; this.move_impulse := 0
            LD (Class_Player_DirectProperty_move_impulse_Shift_4_Size_1_Data), A ; this.move_impulse := 0
          Class_Player_IfBranch_68_End: ; }
        ; End full if
        JR Class_Player_IfBranch_69_End ; if ( A == OBJECT_STONE_CHAR ) {
      Class_Player_IfBranch_69_Begin: ; } else {
        LD A, 0 ; this.move_impulse := 0
        LD (Class_Player_DirectProperty_move_impulse_Shift_4_Size_1_Data), A ; this.move_impulse := 0
      Class_Player_IfBranch_69_End: ; }
    ; End full if
    CALL Direct_Class_Player_Method_move_Code ; this.move()
  RET ; }

  Direct_Class_Player_Method_move_up_Code: ; private move_up() {
    LD BC, -SHADOW_LINE_LENGTH
    ADD HL, BC
    LD A, 0 ; this.move_impulse := 0
    LD (Class_Player_DirectProperty_move_impulse_Shift_4_Size_1_Data), A ; this.move_impulse := 0
    CALL Direct_Class_Player_Method_move_Code ; this.move()
  RET ; }

  Direct_Class_Player_Method_move_down_Code: ; private move_down() {
    LD BC, SHADOW_LINE_LENGTH
    ADD HL, BC
    LD A, 0 ; this.move_impulse := 0
    LD (Class_Player_DirectProperty_move_impulse_Shift_4_Size_1_Data), A ; this.move_impulse := 0
    CALL Direct_Class_Player_Method_move_Code ; this.move()
  RET ; }

  Direct_Class_Player_Method_move_Code: ; private move() {
    LD A, (HL)
    ; Begin if 
      Class_Player_IfBranch_70_Begin: ; if ( A == OBJECT_DIRT_CHAR ) {
        CP OBJECT_DIRT_CHAR ; if ( A == OBJECT_DIRT_CHAR ) {
        JP NZ, Class_Player_IfBranch_71_Begin ; if ( A == OBJECT_DIRT_CHAR ) {
        CALL Direct_Class_Player_Method_move_ok_Code ; this.move_ok( DE, HL )
        CALL LEPESHANG
        JR Class_Player_IfBranch_78_End ; if ( A == OBJECT_DIRT_CHAR ) {
      Class_Player_IfBranch_71_Begin: ; } else if ( A == OBJECT_SPACE_CHAR ) {
        CP OBJECT_SPACE_CHAR ; } else if ( A == OBJECT_SPACE_CHAR ) {
        JP NZ, Class_Player_IfBranch_72_Begin ; } else if ( A == OBJECT_SPACE_CHAR ) {
        CALL Direct_Class_Player_Method_move_ok_Code ; this.move_ok( DE, HL )
        JR Class_Player_IfBranch_78_End ; } else if ( A == OBJECT_SPACE_CHAR ) {
      Class_Player_IfBranch_72_Begin: ; } else if ( A == OBJECT_DIAMOND1_CHAR ) {
        CP OBJECT_DIAMOND1_CHAR ; } else if ( A == OBJECT_DIAMOND1_CHAR ) {
        JP NZ, Class_Player_IfBranch_73_Begin ; } else if ( A == OBJECT_DIAMOND1_CHAR ) {
        CALL Direct_Class_Player_Method_get_diamond_Code ; this.get_diamond( DE, HL )
        JR Class_Player_IfBranch_78_End ; } else if ( A == OBJECT_DIAMOND1_CHAR ) {
      Class_Player_IfBranch_73_Begin: ; } else if ( A == OBJECT_DIAMOND2_CHAR ) {
        CP OBJECT_DIAMOND2_CHAR ; } else if ( A == OBJECT_DIAMOND2_CHAR ) {
        JP NZ, Class_Player_IfBranch_74_Begin ; } else if ( A == OBJECT_DIAMOND2_CHAR ) {
        CALL Direct_Class_Player_Method_get_diamond_Code ; this.get_diamond( DE, HL )
        JR Class_Player_IfBranch_78_End ; } else if ( A == OBJECT_DIAMOND2_CHAR ) {
      Class_Player_IfBranch_74_Begin: ; } else if ( A == OBJECT_OPENED_DOOR_CHAR ) {
        CP OBJECT_OPENED_DOOR_CHAR ; } else if ( A == OBJECT_OPENED_DOOR_CHAR ) {
        JP NZ, Class_Player_IfBranch_75_Begin ; } else if ( A == OBJECT_OPENED_DOOR_CHAR ) {
        CALL Direct_Class_Player_Method_next_cave_Code ; this.next_cave( DE )
        JR Class_Player_IfBranch_78_End ; } else if ( A == OBJECT_OPENED_DOOR_CHAR ) {
      Class_Player_IfBranch_75_Begin: ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        CP OBJECT_BUTTERFLY1_CHAR ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        JP NZ, Class_Player_IfBranch_76_Begin ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        CALL Direct_Class_Robbanas_Method_butterfly_kill_player_Code ; ROBBANAS.butterfly_kill_player( HL )
        JR Class_Player_IfBranch_78_End ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
      Class_Player_IfBranch_76_Begin: ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
        CP OBJECT_BUTTERFLY2_CHAR ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
        JP NZ, Class_Player_IfBranch_77_Begin ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
        CALL Direct_Class_Robbanas_Method_butterfly_kill_player_Code ; ROBBANAS.butterfly_kill_player( HL )
        JR Class_Player_IfBranch_78_End ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
      Class_Player_IfBranch_77_Begin: ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
        CP OBJECT_FIREFLY1_CHAR ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
        JP NZ, Class_Player_IfBranch_78_Begin ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
        CALL Direct_Class_Robbanas_Method_firefly_kill_player_Code ; ROBBANAS.firefly_kill_player( HL )
        JR Class_Player_IfBranch_78_End ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
      Class_Player_IfBranch_78_Begin: ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
        CP OBJECT_FIREFLY2_CHAR ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
        JP NZ, Class_Player_IfBranch_78_End ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
        CALL Direct_Class_Robbanas_Method_firefly_kill_player_Code ; ROBBANAS.firefly_kill_player( HL )
      Class_Player_IfBranch_78_End: ; }
    ; End full if
    POP BC
    POP BC
  RET ; }

  Direct_Class_Player_Method_get_diamond_Code: ; private get_diamond( DE, HL ) {
    CALL Direct_Class_Player_Method_move_ok_Code ; this.move_ok( DE, HL )
    CALL Direct_Class_GravityDiamond_Method_remove_Code ; DIAMONDGRAVITY.remove( HL )
    LD HL, 0x0660
    CALL ROM_BEEP_H_L
    CALL Direct_Class_Status_Method_add_diamond_Code ; STATUS.add_diamond()
  RET ; }

  Direct_Class_Player_Method_move_ok_Code: ; private move_ok( DE, HL ) {
    LD A, OBJECT_SPACE_CHAR
    LD (DE), A
    LD A, OBJECT_PLAYER_CHAR
    LD (HL), A
    LD (Class_Player_DirectProperty_shadow_pos_addr_Shift_0_Size_2_Data), HL ; this.shadow_pos_addr := HL
  RET ; }
; } ; End class Player

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Diamonds extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_Diamonds_DirectProperty_current_pointer1_Shift_0_Size_2_Data: DW 0 ; DW current_pointer1
  Class_Diamonds_DirectProperty_current_pointer2_Shift_2_Size_2_Data: DW 0 ; DW current_pointer2
  DIAMONDS_STEP1: EQU 373
  DIAMONDS_STEP2: EQU 573

  Direct_Class_Diamonds_Method_constructor_Code: ; constructor() {
    LD A, MODULO_800_START_ADDRESS+51 % 256 ; this.current_pointer1 := MODULO_800_START_ADDRESS+51
    LD (Class_Diamonds_DirectProperty_current_pointer1_Shift_0_Size_2_Data), A ; this.current_pointer1 := MODULO_800_START_ADDRESS+51
    LD A, MODULO_800_START_ADDRESS+51 / 256 ; this.current_pointer1 := MODULO_800_START_ADDRESS+51
    LD (Class_Diamonds_DirectProperty_current_pointer1_Shift_0_Size_2_Data + 1), A ; this.current_pointer1 := MODULO_800_START_ADDRESS+51
    LD A, MODULO_800_START_ADDRESS+251 % 256 ; this.current_pointer2 := MODULO_800_START_ADDRESS+251
    LD (Class_Diamonds_DirectProperty_current_pointer2_Shift_2_Size_2_Data), A ; this.current_pointer2 := MODULO_800_START_ADDRESS+251
    LD A, MODULO_800_START_ADDRESS+251 / 256 ; this.current_pointer2 := MODULO_800_START_ADDRESS+251
    LD (Class_Diamonds_DirectProperty_current_pointer2_Shift_2_Size_2_Data + 1), A ; this.current_pointer2 := MODULO_800_START_ADDRESS+251
  RET ; }

  Direct_Class_Diamonds_Method_tick_Code: ; public tick() {
    LD HL, (Class_Diamonds_DirectProperty_current_pointer1_Shift_0_Size_2_Data) ; HL := this.current_pointer1
    LD DE, DIAMONDS_STEP1 ; direct asm value ; this.tick_HL( DIAMONDS_STEP1, HL )
    CALL Direct_Class_Diamonds_Method_tick_HL_Code ; this.tick_HL( DIAMONDS_STEP1, HL )
    LD (Class_Diamonds_DirectProperty_current_pointer1_Shift_0_Size_2_Data), HL ; this.current_pointer1 := HL
    LD HL, (Class_Diamonds_DirectProperty_current_pointer2_Shift_2_Size_2_Data) ; HL := this.current_pointer2
    LD DE, DIAMONDS_STEP2 ; direct asm value ; this.tick_HL( DIAMONDS_STEP2, HL )
    CALL Direct_Class_Diamonds_Method_tick_HL_Code ; this.tick_HL( DIAMONDS_STEP2, HL )
    LD (Class_Diamonds_DirectProperty_current_pointer2_Shift_2_Size_2_Data), HL ; this.current_pointer2 := HL
  RET ; }

  Direct_Class_Diamonds_Method_tick_HL_Code: ; public tick_HL( DE, HL ) {
    LD B, 8 ; for B = 8 to 1 {
    Class_Diamonds_ForB_8_Begin:
      LD A, (HL)
      ; Begin if 
        Class_Diamonds_IfBranch_79_Begin: ; if ( A == OBJECT_DIAMOND1_CHAR ) {
          CP OBJECT_DIAMOND1_CHAR ; if ( A == OBJECT_DIAMOND1_CHAR ) {
          JP NZ, Class_Diamonds_IfBranch_80_Begin ; if ( A == OBJECT_DIAMOND1_CHAR ) {
          LD (HL), OBJECT_DIAMOND2_CHAR
          JR Class_Diamonds_IfBranch_80_End ; if ( A == OBJECT_DIAMOND1_CHAR ) {
        Class_Diamonds_IfBranch_80_Begin: ; } else if ( A == OBJECT_DIAMOND2_CHAR ) {
          CP OBJECT_DIAMOND2_CHAR ; } else if ( A == OBJECT_DIAMOND2_CHAR ) {
          JP NZ, Class_Diamonds_IfBranch_80_End ; } else if ( A == OBJECT_DIAMOND2_CHAR ) {
          LD (HL), OBJECT_DIAMOND1_CHAR
        Class_Diamonds_IfBranch_80_End: ; }
      ; End full if
      PUSH BC
      PUSH DE
      CALL Direct_Class_Modulo800_Method_add_to_HL_Code ; MODULO800.add_to_HL( DE, HL )
      POP DE
      POP BC
    DJNZ Class_Diamonds_ForB_8_Begin
  RET ; }
; } ; End class Diamonds

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Flies extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  Direct_Class_Flies_Method_fly_DE_Left_to_Code: ; protected fly_DE_Left_to( HL, DE, C ) {
    PUSH HL
    LD A, C
    DEC A
    AND 3
    CALL Direct_Class_Flies_Method_get_next_char_address_in_direction_HL_Code ; this.get_next_char_address_in_direction_HL( DE, A )
    LD A, (HL)
    ; Begin if 
      Class_Flies_IfBranch_81_Begin: ; if ( A == OBJECT_SPACE_CHAR ) {
        CP OBJECT_SPACE_CHAR ; if ( A == OBJECT_SPACE_CHAR ) {
        JP NZ, Class_Flies_IfBranch_82_Begin ; if ( A == OBJECT_SPACE_CHAR ) {
        LD (DE), A
        EX AF, AF'
        LD (HL), A
        LD A, C
        DEC A
        AND 3
        POP DE
        EX DE, HL
        DEC HL
        DEC HL
        LD (HL), E
        INC HL
        LD (HL), D
        INC HL
        LD (HL), A
        JR Class_Flies_IfBranch_83_End ; if ( A == OBJECT_SPACE_CHAR ) {
      Class_Flies_IfBranch_82_Begin: ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        CP OBJECT_PLAYER_CHAR ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        JP NZ, Class_Flies_IfBranch_83_Begin ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        POP DE
        CALL Direct_Class_Robbanas_Method_firefly_kill_player_Code ; ROBBANAS.firefly_kill_player( HL )
        JR Class_Flies_IfBranch_83_End ; } else if ( A == OBJECT_PLAYER_CHAR ) {
      Class_Flies_IfBranch_83_Begin: ; } else {
        LD A, C ; this.get_next_char_address_in_direction_HL( DE, C )
        CALL Direct_Class_Flies_Method_get_next_char_address_in_direction_HL_Code ; this.get_next_char_address_in_direction_HL( DE, C )
        LD A, (HL)
        CP OBJECT_SPACE_CHAR
        ; Begin if 
          Class_Flies_IfBranch_84_Begin: ; if ( Z ) {
            JP NZ, Class_Flies_IfBranch_85_Begin ; if ( Z ) {
            LD (DE), A
            EX AF, AF'
            LD (HL), A
            POP DE
            EX DE, HL
            DEC HL
            DEC HL
            LD (HL), E
            INC HL
            LD (HL), D
            INC HL
            LD (HL), C
            JR Class_Flies_IfBranch_85_End ; if ( Z ) {
          Class_Flies_IfBranch_85_Begin: ; } else {
            LD A, C
            INC A
            AND 3
            POP HL
            LD (HL), A
          Class_Flies_IfBranch_85_End: ; }
        ; End full if
      Class_Flies_IfBranch_83_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Flies_Method_fly_DE_Right_to_Code: ; protected fly_DE_Right_to( HL, DE, C ) {
    PUSH HL
    LD A, C
    INC A
    AND 3
    CALL Direct_Class_Flies_Method_get_next_char_address_in_direction_HL_Code ; this.get_next_char_address_in_direction_HL( DE, A )
    LD A, (HL)
    ; Begin if 
      Class_Flies_IfBranch_86_Begin: ; if ( A == OBJECT_SPACE_CHAR ) {
        CP OBJECT_SPACE_CHAR ; if ( A == OBJECT_SPACE_CHAR ) {
        JP NZ, Class_Flies_IfBranch_87_Begin ; if ( A == OBJECT_SPACE_CHAR ) {
        LD (DE), A
        EX AF, AF'
        LD (HL), A
        LD A, C
        INC A
        AND 3
        POP DE
        EX DE, HL
        DEC HL
        DEC HL
        LD (HL), E
        INC HL
        LD (HL), D
        INC HL
        LD (HL), A
        JR Class_Flies_IfBranch_88_End ; if ( A == OBJECT_SPACE_CHAR ) {
      Class_Flies_IfBranch_87_Begin: ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        CP OBJECT_PLAYER_CHAR ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        JP NZ, Class_Flies_IfBranch_88_Begin ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        POP DE
        CALL Direct_Class_Robbanas_Method_butterfly_kill_player_Code ; ROBBANAS.butterfly_kill_player( HL )
        JR Class_Flies_IfBranch_88_End ; } else if ( A == OBJECT_PLAYER_CHAR ) {
      Class_Flies_IfBranch_88_Begin: ; } else {
        LD A, C ; this.get_next_char_address_in_direction_HL( DE, C )
        CALL Direct_Class_Flies_Method_get_next_char_address_in_direction_HL_Code ; this.get_next_char_address_in_direction_HL( DE, C )
        LD A, (HL)
        CP OBJECT_SPACE_CHAR
        ; Begin if 
          Class_Flies_IfBranch_89_Begin: ; if ( Z ) {
            JP NZ, Class_Flies_IfBranch_90_Begin ; if ( Z ) {
            LD (DE), A
            EX AF, AF'
            LD (HL), A
            POP DE
            EX DE, HL
            DEC HL
            DEC HL
            LD (HL), E
            INC HL
            LD (HL), D
            INC HL
            LD (HL), C
            JR Class_Flies_IfBranch_90_End ; if ( Z ) {
          Class_Flies_IfBranch_90_Begin: ; } else {
            LD A, C
            DEC A
            AND 3
            POP HL
            LD (HL), A
          Class_Flies_IfBranch_90_End: ; }
        ; End full if
      Class_Flies_IfBranch_88_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Flies_Method_get_next_char_address_in_direction_HL_Code: ; private get_next_char_address_in_direction_HL( DE, A ) {
    LD H, D
    LD L, E
    ; Begin if 
      Class_Flies_IfBranch_91_Begin: ; if ( A == DIRECTION_RIGHT ) {
        CP DIRECTION_RIGHT ; if ( A == DIRECTION_RIGHT ) {
        JP NZ, Class_Flies_IfBranch_92_Begin ; if ( A == DIRECTION_RIGHT ) {
        INC HL
        JR Class_Flies_IfBranch_94_End ; if ( A == DIRECTION_RIGHT ) {
      Class_Flies_IfBranch_92_Begin: ; } else if ( A == DIRECTION_LEFT ) {
        CP DIRECTION_LEFT ; } else if ( A == DIRECTION_LEFT ) {
        JP NZ, Class_Flies_IfBranch_93_Begin ; } else if ( A == DIRECTION_LEFT ) {
        DEC HL
        JR Class_Flies_IfBranch_94_End ; } else if ( A == DIRECTION_LEFT ) {
      Class_Flies_IfBranch_93_Begin: ; } else if ( A == DIRECTION_UP ) {
        CP DIRECTION_UP ; } else if ( A == DIRECTION_UP ) {
        JP NZ, Class_Flies_IfBranch_94_Begin ; } else if ( A == DIRECTION_UP ) {
        PUSH DE
        LD DE, -SHADOW_LINE_LENGTH
        ADD HL, DE
        POP DE
        JR Class_Flies_IfBranch_94_End ; } else if ( A == DIRECTION_UP ) {
      Class_Flies_IfBranch_94_Begin: ; } else {
        PUSH DE
        LD DE, SHADOW_LINE_LENGTH
        ADD HL, DE
        POP DE
      Class_Flies_IfBranch_94_End: ; }
    ; End full if
  RET ; }
; } ; End class Flies

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Butterflies extends Flies {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_Butterflies_DirectProperty_first_free_addr_Shift_0_Size_2_Data: DW 0 ; DW first_free_addr
  Class_Butterflies_DirectProperty_counter_Shift_2_Size_1_Data: DB 0 ; DB counter
  Class_Butterflies_DirectProperty_tick_speed_counter_Shift_3_Size_1_Data: DB 0 ; DB tick_speed_counter

  Direct_Class_Butterflies_Method_init_Code: ; public init() {
    LD A, ButterflyPuffer % 256 ; this.first_free_addr := ButterflyPuffer
    LD (Class_Butterflies_DirectProperty_first_free_addr_Shift_0_Size_2_Data), A ; this.first_free_addr := ButterflyPuffer
    LD A, ButterflyPuffer / 256 ; this.first_free_addr := ButterflyPuffer
    LD (Class_Butterflies_DirectProperty_first_free_addr_Shift_0_Size_2_Data + 1), A ; this.first_free_addr := ButterflyPuffer
    LD A, 0 ; this.counter := 0
    LD (Class_Butterflies_DirectProperty_counter_Shift_2_Size_1_Data), A ; this.counter := 0
    LD A, BUTTERFLY_TICK_SPEED ; this.tick_speed_counter := BUTTERFLY_TICK_SPEED
    LD (Class_Butterflies_DirectProperty_tick_speed_counter_Shift_3_Size_1_Data), A ; this.tick_speed_counter := BUTTERFLY_TICK_SPEED
  RET ; }

  Direct_Class_Butterflies_Method_append_Code: ; public append( HL ) {
    PUSH BC
    PUSH DE
    PUSH HL
    POP BC
    PUSH BC
    LD A, (Class_Butterflies_DirectProperty_counter_Shift_2_Size_1_Data) ; A := this.counter
    LD HL, (Class_Butterflies_DirectProperty_first_free_addr_Shift_0_Size_2_Data) ; HL := this.first_free_addr
    LD (HL), C
    INC HL
    LD (HL), B
    INC HL
    LD (HL), DIRECTION_LEFT
    INC HL
    LD (Class_Butterflies_DirectProperty_first_free_addr_Shift_0_Size_2_Data), HL ; this.first_free_addr := HL
    LD HL, Class_Butterflies_DirectProperty_counter_Shift_2_Size_1_Data ; INC this.counter
    INC (HL) ; INC this.counter
    POP HL
    POP DE
    POP BC
  RET ; }

  Direct_Class_Butterflies_Method_remove_Code: ; public remove( HL ) {
    LD A, (Class_Butterflies_DirectProperty_counter_Shift_2_Size_1_Data) ; A := this.counter
    ; Begin if 
      Class_Butterflies_IfBranch_95_Begin: ; if ( A != 0 ) {
        CP 0 ; if ( A != 0 ) {
        JP Z, Class_Butterflies_IfBranch_95_End ; if ( A != 0 ) {
        PUSH HL
        LD DE, ButterflyPuffer
        LD C, 0
        LD B, A ; for B = A to 1 {
        Class_Butterflies_ForB_9_Begin:
          LD A, (DE)
          ; Begin if 
            Class_Butterflies_IfBranch_96_Begin: ; if ( A == L ) {
              CP L ; if ( A == L ) {
              JP NZ, Class_Butterflies_IfBranch_96_End ; if ( A == L ) {
              INC DE
              LD A, (DE)
              DEC DE
              ; Begin if 
                Class_Butterflies_IfBranch_97_Begin: ; if ( A == H ) {
                  CP H ; if ( A == H ) {
                  JP NZ, Class_Butterflies_IfBranch_97_End ; if ( A == H ) {
                  CALL Direct_Class_Butterflies_Method_drop_pointer_Code ; this.drop_pointer( DE )
                  LD HL, Class_Butterflies_DirectProperty_counter_Shift_2_Size_1_Data ; DEC this.counter
                  DEC (HL) ; DEC this.counter
                  POP HL
                  RET
                Class_Butterflies_IfBranch_97_End: ; }
              ; End full if
            Class_Butterflies_IfBranch_96_End: ; }
          ; End full if
          INC DE
          INC DE
          INC DE
          INC C
        DJNZ Class_Butterflies_ForB_9_Begin
        POP HL
      Class_Butterflies_IfBranch_95_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Butterflies_Method_drop_pointer_Code: ; private drop_pointer( DE ) {
    LD HL, (Class_Butterflies_DirectProperty_first_free_addr_Shift_0_Size_2_Data) ; HL := this.first_free_addr
    DEC HL
    DEC HL
    DEC HL
    LD (Class_Butterflies_DirectProperty_first_free_addr_Shift_0_Size_2_Data), HL ; this.first_free_addr := HL
    LD A, (HL)
    LD (DE), A
    INC HL
    INC DE
    LD A, (HL)
    LD (DE), A
    INC HL
    INC DE
    LD A, (HL)
    LD (DE), A
  RET ; }

  Direct_Class_Butterflies_Method_tick_Code: ; public tick() {
    LD HL, Class_Butterflies_DirectProperty_tick_speed_counter_Shift_3_Size_1_Data ; DEC this.tick_speed_counter
    DEC (HL) ; DEC this.tick_speed_counter
    ; Begin if 
      Class_Butterflies_IfBranch_98_Begin: ; if ( Z ) {
        JP NZ, Class_Butterflies_IfBranch_98_End ; if ( Z ) {
        LD A, BUTTERFLY_TICK_SPEED ; this.tick_speed_counter := BUTTERFLY_TICK_SPEED
        LD (Class_Butterflies_DirectProperty_tick_speed_counter_Shift_3_Size_1_Data), A ; this.tick_speed_counter := BUTTERFLY_TICK_SPEED
        LD A, (Class_Butterflies_DirectProperty_counter_Shift_2_Size_1_Data) ; A := this.counter
        ; Begin if 
          Class_Butterflies_IfBranch_99_Begin: ; if ( A != 0 ) {
            CP 0 ; if ( A != 0 ) {
            JP Z, Class_Butterflies_IfBranch_99_End ; if ( A != 0 ) {
            CALL Direct_Class_Butterflies_Method_anim_and_fly_all_Code ; this.anim_and_fly_all()
          Class_Butterflies_IfBranch_99_End: ; }
        ; End full if
      Class_Butterflies_IfBranch_98_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Butterflies_Method_anim_and_fly_all_Code: ; private anim_and_fly_all() {
    LD A, (Class_Butterflies_DirectProperty_counter_Shift_2_Size_1_Data) ; A := this.counter
    LD HL, ButterflyPuffer
    LD B, A ; for B = A to 1 {
    Class_Butterflies_ForB_10_Begin:
      LD E, (HL)
      INC HL
      LD D, (HL)
      INC HL
      LD C, (HL)
      LD A, (DE)
      ; Begin if 
        Class_Butterflies_IfBranch_100_Begin: ; if ( A == OBJECT_BUTTERFLY1_CHAR ) {
          CP OBJECT_BUTTERFLY1_CHAR ; if ( A == OBJECT_BUTTERFLY1_CHAR ) {
          JP NZ, Class_Butterflies_IfBranch_101_Begin ; if ( A == OBJECT_BUTTERFLY1_CHAR ) {
          LD A, OBJECT_BUTTERFLY2_CHAR
          JR Class_Butterflies_IfBranch_101_End ; if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        Class_Butterflies_IfBranch_101_Begin: ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
          CP OBJECT_BUTTERFLY2_CHAR ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
          JP NZ, Class_Butterflies_IfBranch_101_End ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
          LD A, OBJECT_BUTTERFLY1_CHAR
        Class_Butterflies_IfBranch_101_End: ; }
      ; End full if
      LD (DE), A
      EX AF, AF'
      PUSH BC
      PUSH HL
      CALL Direct_Class_Flies_Method_fly_DE_Right_to_Code ; this.fly_DE_Right_to( HL, DE, C )
      POP HL
      POP BC
      INC HL
    DJNZ Class_Butterflies_ForB_10_Begin
  RET ; }
; } ; End class Butterflies

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Fireflies extends Flies {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_Fireflies_DirectProperty_first_free_addr_Shift_0_Size_2_Data: DW 0 ; DW first_free_addr
  Class_Fireflies_DirectProperty_counter_Shift_2_Size_1_Data: DB 0 ; DB counter
  Class_Fireflies_DirectProperty_tick_speed_counter_Shift_3_Size_1_Data: DB 0 ; DB tick_speed_counter

  Direct_Class_Fireflies_Method_init_Code: ; public init() {
    LD A, FireflyPuffer % 256 ; this.first_free_addr := FireflyPuffer
    LD (Class_Fireflies_DirectProperty_first_free_addr_Shift_0_Size_2_Data), A ; this.first_free_addr := FireflyPuffer
    LD A, FireflyPuffer / 256 ; this.first_free_addr := FireflyPuffer
    LD (Class_Fireflies_DirectProperty_first_free_addr_Shift_0_Size_2_Data + 1), A ; this.first_free_addr := FireflyPuffer
    LD A, 0 ; this.counter := 0
    LD (Class_Fireflies_DirectProperty_counter_Shift_2_Size_1_Data), A ; this.counter := 0
    LD A, FIREFLY_TICK_SPEED ; this.tick_speed_counter := FIREFLY_TICK_SPEED
    LD (Class_Fireflies_DirectProperty_tick_speed_counter_Shift_3_Size_1_Data), A ; this.tick_speed_counter := FIREFLY_TICK_SPEED
  RET ; }

  Direct_Class_Fireflies_Method_append_Code: ; public append( HL ) {
    PUSH BC
    PUSH DE
    PUSH HL
    POP BC
    PUSH BC
    LD A, (Class_Fireflies_DirectProperty_counter_Shift_2_Size_1_Data) ; A := this.counter
    LD HL, (Class_Fireflies_DirectProperty_first_free_addr_Shift_0_Size_2_Data) ; HL := this.first_free_addr
    LD (HL), C
    INC HL
    LD (HL), B
    INC HL
    LD (HL), DIRECTION_RIGHT
    INC HL
    LD (Class_Fireflies_DirectProperty_first_free_addr_Shift_0_Size_2_Data), HL ; this.first_free_addr := HL
    LD HL, Class_Fireflies_DirectProperty_counter_Shift_2_Size_1_Data ; INC this.counter
    INC (HL) ; INC this.counter
    POP HL
    POP DE
    POP BC
  RET ; }

  Direct_Class_Fireflies_Method_remove_Code: ; public remove( HL ) {
    LD A, (Class_Fireflies_DirectProperty_counter_Shift_2_Size_1_Data) ; A := this.counter
    ; Begin if 
      Class_Fireflies_IfBranch_102_Begin: ; if ( A != 0 ) {
        CP 0 ; if ( A != 0 ) {
        JP Z, Class_Fireflies_IfBranch_102_End ; if ( A != 0 ) {
        PUSH HL
        LD DE, FireflyPuffer
        LD C, 0
        LD B, A ; for B = A to 1 {
        Class_Fireflies_ForB_11_Begin:
          LD A, (DE)
          ; Begin if 
            Class_Fireflies_IfBranch_103_Begin: ; if ( A == L ) {
              CP L ; if ( A == L ) {
              JP NZ, Class_Fireflies_IfBranch_103_End ; if ( A == L ) {
              INC DE
              LD A, (DE)
              DEC DE
              ; Begin if 
                Class_Fireflies_IfBranch_104_Begin: ; if ( A == H ) {
                  CP H ; if ( A == H ) {
                  JP NZ, Class_Fireflies_IfBranch_104_End ; if ( A == H ) {
                  CALL Direct_Class_Fireflies_Method_drop_pointer_Code ; this.drop_pointer( DE )
                  LD HL, Class_Fireflies_DirectProperty_counter_Shift_2_Size_1_Data ; DEC this.counter
                  DEC (HL) ; DEC this.counter
                  POP HL
                  RET
                Class_Fireflies_IfBranch_104_End: ; }
              ; End full if
            Class_Fireflies_IfBranch_103_End: ; }
          ; End full if
          INC DE
          INC DE
          INC DE
          INC C
        DJNZ Class_Fireflies_ForB_11_Begin
        POP HL
      Class_Fireflies_IfBranch_102_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Fireflies_Method_drop_pointer_Code: ; private drop_pointer( DE ) {
    LD HL, (Class_Fireflies_DirectProperty_first_free_addr_Shift_0_Size_2_Data) ; HL := this.first_free_addr
    DEC HL
    DEC HL
    DEC HL
    LD (Class_Fireflies_DirectProperty_first_free_addr_Shift_0_Size_2_Data), HL ; this.first_free_addr := HL
    LD A, (HL)
    LD (DE), A
    INC HL
    INC DE
    LD A, (HL)
    LD (DE), A
    INC HL
    INC DE
    LD A, (HL)
    LD (DE), A
  RET ; }

  Direct_Class_Fireflies_Method_tick_Code: ; public tick() {
    LD HL, Class_Fireflies_DirectProperty_tick_speed_counter_Shift_3_Size_1_Data ; DEC this.tick_speed_counter
    DEC (HL) ; DEC this.tick_speed_counter
    ; Begin if 
      Class_Fireflies_IfBranch_105_Begin: ; if ( Z ) {
        JP NZ, Class_Fireflies_IfBranch_105_End ; if ( Z ) {
        LD A, FIREFLY_TICK_SPEED ; this.tick_speed_counter := FIREFLY_TICK_SPEED
        LD (Class_Fireflies_DirectProperty_tick_speed_counter_Shift_3_Size_1_Data), A ; this.tick_speed_counter := FIREFLY_TICK_SPEED
        LD A, (Class_Fireflies_DirectProperty_counter_Shift_2_Size_1_Data) ; A := this.counter
        ; Begin if 
          Class_Fireflies_IfBranch_106_Begin: ; if ( A != 0 ) {
            CP 0 ; if ( A != 0 ) {
            JP Z, Class_Fireflies_IfBranch_106_End ; if ( A != 0 ) {
            CALL Direct_Class_Fireflies_Method_anim_and_fly_all_Code ; this.anim_and_fly_all()
          Class_Fireflies_IfBranch_106_End: ; }
        ; End full if
      Class_Fireflies_IfBranch_105_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Fireflies_Method_anim_and_fly_all_Code: ; private anim_and_fly_all() {
    LD A, (Class_Fireflies_DirectProperty_counter_Shift_2_Size_1_Data) ; A := this.counter
    LD HL, FireflyPuffer
    LD B, A ; for B = A to 1 {
    Class_Fireflies_ForB_12_Begin:
      LD E, (HL)
      INC HL
      LD D, (HL)
      INC HL
      LD C, (HL)
      LD A, (DE)
      ; Begin if 
        Class_Fireflies_IfBranch_107_Begin: ; if ( A == OBJECT_FIREFLY1_CHAR ) {
          CP OBJECT_FIREFLY1_CHAR ; if ( A == OBJECT_FIREFLY1_CHAR ) {
          JP NZ, Class_Fireflies_IfBranch_108_Begin ; if ( A == OBJECT_FIREFLY1_CHAR ) {
          LD A, OBJECT_FIREFLY2_CHAR
          JR Class_Fireflies_IfBranch_108_End ; if ( A == OBJECT_FIREFLY1_CHAR ) {
        Class_Fireflies_IfBranch_108_Begin: ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
          CP OBJECT_FIREFLY2_CHAR ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
          JP NZ, Class_Fireflies_IfBranch_108_End ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
          LD A, OBJECT_FIREFLY1_CHAR
        Class_Fireflies_IfBranch_108_End: ; }
      ; End full if
      LD (DE), A
      EX AF, AF'
      PUSH BC
      PUSH HL
      CALL Direct_Class_Flies_Method_fly_DE_Left_to_Code ; this.fly_DE_Left_to( HL, DE, C )
      POP HL
      POP BC
      INC HL
    DJNZ Class_Fireflies_ForB_12_Begin
  RET ; }
; } ; End class Fireflies

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Amoebas extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_Amoebas_DirectProperty_tick_speed_counter_Shift_0_Size_1_Data: DB 0 ; DB tick_speed_counter
  Class_Amoebas_DirectProperty_counter_Shift_1_Size_1_Data: DB 0 ; DB counter
  Class_Amoebas_DirectProperty_open_cell_counter_Shift_2_Size_1_Data: DB 0 ; DB open_cell_counter
  Class_Amoebas_DirectProperty_slow_counter_Shift_3_Size_1_Data: DB 0 ; DB slow_counter

  Direct_Class_Amoebas_Method_init_Code: ; public init( A ) {
    LD (Class_Amoebas_DirectProperty_slow_counter_Shift_3_Size_1_Data), A ; this.slow_counter := A
    LD A, AMOEBA_SLOW_TICK_SPEED ; this.tick_speed_counter := AMOEBA_SLOW_TICK_SPEED
    LD (Class_Amoebas_DirectProperty_tick_speed_counter_Shift_0_Size_1_Data), A ; this.tick_speed_counter := AMOEBA_SLOW_TICK_SPEED
    LD A, 0 ; this.counter := 0
    LD (Class_Amoebas_DirectProperty_counter_Shift_1_Size_1_Data), A ; this.counter := 0
    LD A, 0 ; RND.init( 0, 1 )
    LD B, 1 ; RND.init( 0, 1 )
    CALL Direct_Class_Random_Method_init_Code ; RND.init( 0, 1 )
  RET ; }

  Direct_Class_Amoebas_Method_append_Code: ; public append() {
    LD A, (Class_Amoebas_DirectProperty_counter_Shift_1_Size_1_Data) ; A := this.counter
    INC A
    LD (Class_Amoebas_DirectProperty_counter_Shift_1_Size_1_Data), A ; this.counter := A
  RET ; }

  Direct_Class_Amoebas_Method_change_Code: ; private change() {
    LD C, OBJECT_DIAMOND1_CHAR
    LD A, (Class_Amoebas_DirectProperty_counter_Shift_1_Size_1_Data) ; A := this.counter
    CP AMOEBA_STONE_LIMIT
    ; Begin if 
      Class_Amoebas_IfBranch_109_Begin: ; if ( NCY ) {
        JP C, Class_Amoebas_IfBranch_109_End ; if ( NCY ) {
        LD C, OBJECT_STONE_CHAR
      Class_Amoebas_IfBranch_109_End: ; }
    ; End full if
    LD A, 0 ; this.counter := 0
    LD (Class_Amoebas_DirectProperty_counter_Shift_1_Size_1_Data), A ; this.counter := 0
    LD HL, FirstAddr
    LD B, RowCounter ; for B = RowCounter to 1 {
    Class_Amoebas_ForB_13_Begin:
      CALL Direct_Class_Amoebas_Method_changeAllInLine_HL_Code ; this.changeAllInLine_HL( HL, C )
    DJNZ Class_Amoebas_ForB_13_Begin
  RET ; }

  Direct_Class_Amoebas_Method_changeAllInLine_HL_Code: ; private changeAllInLine_HL( HL, C ) {
    PUSH BC
    LD B, ColCounter ; for B = ColCounter to 1 {
    Class_Amoebas_ForB_14_Begin:
      LD A, (HL)
      ; Begin if 
        Class_Amoebas_IfBranch_110_Begin: ; if ( A == OBJECT_AMOEBA_CHAR ) {
          CP OBJECT_AMOEBA_CHAR ; if ( A == OBJECT_AMOEBA_CHAR ) {
          JP NZ, Class_Amoebas_IfBranch_110_End ; if ( A == OBJECT_AMOEBA_CHAR ) {
          CALL Direct_Class_Amoebas_Method_change_cell_Code ; this.change_cell( HL, C )
        Class_Amoebas_IfBranch_110_End: ; }
      ; End full if
      INC HL
    DJNZ Class_Amoebas_ForB_14_Begin
    LD DE, SHADOW_LINE_LENGTH - ColCounter
    ADD HL, DE
    POP BC
  RET ; }

  Direct_Class_Amoebas_Method_change_cell_Code: ; private change_cell( HL, C ) {
    LD A, C
    ; Begin if 
      Class_Amoebas_IfBranch_111_Begin: ; if ( A == OBJECT_DIAMOND1_CHAR ) {
        CP OBJECT_DIAMOND1_CHAR ; if ( A == OBJECT_DIAMOND1_CHAR ) {
        JP NZ, Class_Amoebas_IfBranch_112_Begin ; if ( A == OBJECT_DIAMOND1_CHAR ) {
        CALL Direct_Class_GravityDiamond_Method_append_Code ; DIAMONDGRAVITY.append( HL )
        JR Class_Amoebas_IfBranch_112_End ; if ( A == OBJECT_DIAMOND1_CHAR ) {
      Class_Amoebas_IfBranch_112_Begin: ; } else {
        CALL Direct_Class_GravityStone_Method_append_Code ; STONEGRAVITY.append( HL )
      Class_Amoebas_IfBranch_112_End: ; }
    ; End full if
    LD (HL), C
  RET ; }

  Direct_Class_Amoebas_Method_tick_Code: ; public tick() {
    LD A, (Class_Amoebas_DirectProperty_counter_Shift_1_Size_1_Data) ; A := this.counter
    ; Begin if 
      Class_Amoebas_IfBranch_113_Begin: ; if ( A != 0 ) {
        CP 0 ; if ( A != 0 ) {
        JP Z, Class_Amoebas_IfBranch_113_End ; if ( A != 0 ) {
        LD A, (Class_Amoebas_DirectProperty_tick_speed_counter_Shift_0_Size_1_Data) ; dec this.tick_speed_counter
        DEC A ; dec this.tick_speed_counter
        LD (Class_Amoebas_DirectProperty_tick_speed_counter_Shift_0_Size_1_Data), A ; dec this.tick_speed_counter
        ; Begin if 
          Class_Amoebas_IfBranch_114_Begin: ; if ( Z ) {
            JP NZ, Class_Amoebas_IfBranch_114_End ; if ( Z ) {
            LD A, (Class_Amoebas_DirectProperty_slow_counter_Shift_3_Size_1_Data) ; A := this.slow_counter
            ; Begin if 
              Class_Amoebas_IfBranch_115_Begin: ; if ( A != 0 ) {
                CP 0 ; if ( A != 0 ) {
                JP Z, Class_Amoebas_IfBranch_116_Begin ; if ( A != 0 ) {
                LD HL, Class_Amoebas_DirectProperty_slow_counter_Shift_3_Size_1_Data ; DEC this.slow_counter
                DEC (HL) ; DEC this.slow_counter
                LD A, AMOEBA_SLOW_TICK_SPEED ; this.tick_speed_counter := AMOEBA_SLOW_TICK_SPEED
                LD (Class_Amoebas_DirectProperty_tick_speed_counter_Shift_0_Size_1_Data), A ; this.tick_speed_counter := AMOEBA_SLOW_TICK_SPEED
                JR Class_Amoebas_IfBranch_116_End ; if ( A != 0 ) {
              Class_Amoebas_IfBranch_116_Begin: ; } else {
                LD A, AMOEBA_FAST_TICK_SPEED ; this.tick_speed_counter := AMOEBA_FAST_TICK_SPEED
                LD (Class_Amoebas_DirectProperty_tick_speed_counter_Shift_0_Size_1_Data), A ; this.tick_speed_counter := AMOEBA_FAST_TICK_SPEED
              Class_Amoebas_IfBranch_116_End: ; }
            ; End full if
            CALL Direct_Class_Amoebas_Method_flow_Code ; this.flow()
          Class_Amoebas_IfBranch_114_End: ; }
        ; End full if
      Class_Amoebas_IfBranch_113_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Amoebas_Method_flow_Code: ; private flow() {
    LD A, 0 ; this.open_cell_counter := 0
    LD (Class_Amoebas_DirectProperty_open_cell_counter_Shift_2_Size_1_Data), A ; this.open_cell_counter := 0
    LD A, (Class_Amoebas_DirectProperty_counter_Shift_1_Size_1_Data) ; A := this.counter
    CP AMOEBA_STONE_LIMIT
    ; Begin if 
      Class_Amoebas_IfBranch_117_Begin: ; if ( CY ) {
        JP NC, Class_Amoebas_IfBranch_117_End ; if ( CY ) {
        LD C, RowCounter
        LD HL, FirstAddr
        LD B, RowCounter ; for B = RowCounter to 1 {
        Class_Amoebas_ForB_15_Begin:
          CALL Direct_Class_Amoebas_Method_searchOpenCellInLine_HL_Code ; this.searchOpenCellInLine_HL( HL )
        DJNZ Class_Amoebas_ForB_15_Begin
      Class_Amoebas_IfBranch_117_End: ; }
    ; End full if
    LD A, (Class_Amoebas_DirectProperty_open_cell_counter_Shift_2_Size_1_Data) ; A := this.open_cell_counter
    ; Begin if 
      Class_Amoebas_IfBranch_118_Begin: ; if ( A == 0 ) {
        CP 0 ; if ( A == 0 ) {
        JP NZ, Class_Amoebas_IfBranch_118_End ; if ( A == 0 ) {
        CALL Direct_Class_Amoebas_Method_change_Code ; this.change()
        LD A, 0 ; this.counter := 0
        LD (Class_Amoebas_DirectProperty_counter_Shift_1_Size_1_Data), A ; this.counter := 0
      Class_Amoebas_IfBranch_118_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Amoebas_Method_searchOpenCellInLine_HL_Code: ; private searchOpenCellInLine_HL( HL ) {
    PUSH BC
    LD B, ColCounter ; for B = ColCounter to 1 {
    Class_Amoebas_ForB_16_Begin:
      LD A, (HL)
      ; Begin if 
        Class_Amoebas_IfBranch_119_Begin: ; if ( A == OBJECT_AMOEBA_CHAR ) {
          CP OBJECT_AMOEBA_CHAR ; if ( A == OBJECT_AMOEBA_CHAR ) {
          JP NZ, Class_Amoebas_IfBranch_119_End ; if ( A == OBJECT_AMOEBA_CHAR ) {
          CALL Direct_Class_Amoebas_Method_found_amoeba_HL_Code ; this.found_amoeba_HL( HL )
        Class_Amoebas_IfBranch_119_End: ; }
      ; End full if
      INC HL
    DJNZ Class_Amoebas_ForB_16_Begin
    LD DE, SHADOW_LINE_LENGTH - ColCounter
    ADD HL, DE
    POP BC
  RET ; }

  Direct_Class_Amoebas_Method_found_amoeba_HL_Code: ; private found_amoeba_HL( HL ) {
    LD DE, -SHADOW_LINE_LENGTH
    ADD HL, DE
    CALL Direct_Class_Amoebas_Method_check_flow_Code ; this.check_flow( HL )
    LD DE, SHADOW_LINE_LENGTH
    ADD HL, DE
    DEC HL
    CALL Direct_Class_Amoebas_Method_check_flow_Code ; this.check_flow( HL )
    INC HL
    INC HL
    CALL Direct_Class_Amoebas_Method_check_flow_Code ; this.check_flow( HL )
    DEC HL
    LD DE, SHADOW_LINE_LENGTH
    ADD HL, DE
    CALL Direct_Class_Amoebas_Method_check_flow_Code ; this.check_flow( HL )
    LD DE, -SHADOW_LINE_LENGTH
    ADD HL, DE
  RET ; }

  Direct_Class_Amoebas_Method_check_flow_Code: ; private check_flow( HL ) {
    LD A, (HL)
    ; Begin if 
      Class_Amoebas_IfBranch_120_Begin: ; if ( A == OBJECT_SPACE_CHAR ) {
        CP OBJECT_SPACE_CHAR ; if ( A == OBJECT_SPACE_CHAR ) {
        JP NZ, Class_Amoebas_IfBranch_121_Begin ; if ( A == OBJECT_SPACE_CHAR ) {
        CALL Direct_Class_Amoebas_Method_found_free_useable_cell_Code ; this.found_free_useable_cell( HL )
        JR Class_Amoebas_IfBranch_121_End ; if ( A == OBJECT_SPACE_CHAR ) {
      Class_Amoebas_IfBranch_121_Begin: ; } else if ( A == OBJECT_DIRT_CHAR ) {
        CP OBJECT_DIRT_CHAR ; } else if ( A == OBJECT_DIRT_CHAR ) {
        JP NZ, Class_Amoebas_IfBranch_121_End ; } else if ( A == OBJECT_DIRT_CHAR ) {
        CALL Direct_Class_Amoebas_Method_found_free_useable_cell_Code ; this.found_free_useable_cell( HL )
      Class_Amoebas_IfBranch_121_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Amoebas_Method_found_free_useable_cell_Code: ; private found_free_useable_cell( HL ) {
    LD A, (Class_Amoebas_DirectProperty_counter_Shift_1_Size_1_Data) ; A := this.counter
    ; Begin if 
      Class_Amoebas_IfBranch_122_Begin: ; if ( A == AMOEBA_STONE_LIMIT ) {
        CP AMOEBA_STONE_LIMIT ; if ( A == AMOEBA_STONE_LIMIT ) {
        JP NZ, Class_Amoebas_IfBranch_123_Begin ; if ( A == AMOEBA_STONE_LIMIT ) {
        LD A, (Class_Amoebas_DirectProperty_open_cell_counter_Shift_2_Size_1_Data) ; inc this.open_cell_counter
        INC A ; inc this.open_cell_counter
        LD (Class_Amoebas_DirectProperty_open_cell_counter_Shift_2_Size_1_Data), A ; inc this.open_cell_counter
        JR Class_Amoebas_IfBranch_123_End ; if ( A == AMOEBA_STONE_LIMIT ) {
      Class_Amoebas_IfBranch_123_Begin: ; } else {
        CALL Direct_Class_Random_Method_get_next_value_to_A_Code ; RND.get_next_value_to_A()
        CP AMOEBA_RANDOM_LIMIT
        ; Begin if 
          Class_Amoebas_IfBranch_124_Begin: ; if ( CY ) {
            JP NC, Class_Amoebas_IfBranch_125_Begin ; if ( CY ) {
            LD (HL), OBJECT_AMOEBA_CHAR
            LD A, (Class_Amoebas_DirectProperty_counter_Shift_1_Size_1_Data) ; inc this.counter
            INC A ; inc this.counter
            LD (Class_Amoebas_DirectProperty_counter_Shift_1_Size_1_Data), A ; inc this.counter
            JR Class_Amoebas_IfBranch_125_End ; if ( CY ) {
          Class_Amoebas_IfBranch_125_Begin: ; } else {
            LD A, (Class_Amoebas_DirectProperty_open_cell_counter_Shift_2_Size_1_Data) ; inc this.open_cell_counter
            INC A ; inc this.open_cell_counter
            LD (Class_Amoebas_DirectProperty_open_cell_counter_Shift_2_Size_1_Data), A ; inc this.open_cell_counter
          Class_Amoebas_IfBranch_125_End: ; }
        ; End full if
      Class_Amoebas_IfBranch_123_End: ; }
    ; End full if
  RET ; }
; } ; End class Amoebas

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class GravityStone extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_GravityStone_DirectProperty_first_free_addr_Shift_0_Size_2_Data: DW 0 ; DW first_free_addr
  Class_GravityStone_DirectProperty_tick_speed_counter_Shift_2_Size_1_Data: DB 0 ; DB tick_speed_counter

  Direct_Class_GravityStone_Method_init_Code: ; public init() {
    LD A, StoneGravityPuffer % 256 ; this.first_free_addr := StoneGravityPuffer
    LD (Class_GravityStone_DirectProperty_first_free_addr_Shift_0_Size_2_Data), A ; this.first_free_addr := StoneGravityPuffer
    LD A, StoneGravityPuffer / 256 ; this.first_free_addr := StoneGravityPuffer
    LD (Class_GravityStone_DirectProperty_first_free_addr_Shift_0_Size_2_Data + 1), A ; this.first_free_addr := StoneGravityPuffer
    LD A, GRAVITY_TICK_SPEED ; this.tick_speed_counter := GRAVITY_TICK_SPEED
    LD (Class_GravityStone_DirectProperty_tick_speed_counter_Shift_2_Size_1_Data), A ; this.tick_speed_counter := GRAVITY_TICK_SPEED
  RET ; }

  Direct_Class_GravityStone_Method_append_Code: ; public append( HL ) {
    PUSH HL
    PUSH DE
    EX DE, HL
    LD HL, (Class_GravityStone_DirectProperty_first_free_addr_Shift_0_Size_2_Data) ; HL := this.first_free_addr
    LD (HL), E
    INC HL
    LD (HL), D
    INC HL
    LD (HL), 0
    INC HL
    LD (Class_GravityStone_DirectProperty_first_free_addr_Shift_0_Size_2_Data), HL ; this.first_free_addr := HL
    POP DE
    POP HL
  RET ; }

  Direct_Class_GravityStone_Method_move_left_Code: ; public move_left( HL ) {
    PUSH HL
    PUSH DE
    CALL Direct_Class_GravityStone_Method_find_pointer_Z_DE_Code ; this.find_pointer_Z_DE( HL )
    ; Begin if 
      Class_GravityStone_IfBranch_126_Begin: ; if ( NZ ) {
        JP Z, Class_GravityStone_IfBranch_126_End ; if ( NZ ) {
        LD (HL), OBJECT_SPACE_CHAR
        DEC HL
        LD (HL), OBJECT_STONE_CHAR
        EX DE, HL
        LD (HL), E
        INC HL
        LD (HL), D
      Class_GravityStone_IfBranch_126_End: ; }
    ; End full if
    POP DE
    POP HL
  RET ; }

  Direct_Class_GravityStone_Method_move_right_Code: ; public move_right( HL ) {
    PUSH HL
    PUSH DE
    CALL Direct_Class_GravityStone_Method_find_pointer_Z_DE_Code ; this.find_pointer_Z_DE( HL )
    ; Begin if 
      Class_GravityStone_IfBranch_127_Begin: ; if ( NZ ) {
        JP Z, Class_GravityStone_IfBranch_127_End ; if ( NZ ) {
        LD (HL), OBJECT_SPACE_CHAR
        INC HL
        LD (HL), OBJECT_STONE_CHAR
        EX DE, HL
        LD (HL), E
        INC HL
        LD (HL), D
      Class_GravityStone_IfBranch_127_End: ; }
    ; End full if
    POP DE
    POP HL
  RET ; }

  Direct_Class_GravityStone_Method_find_pointer_Z_DE_Code: ; private find_pointer_Z_DE( HL ) {
    LD DE, StoneGravityPuffer
    EX DE, HL
    CALL Direct_Class_GravityStone_Method_is_eof_Code ; this.is_eof( HL )
    Class_GravityStone_While_1_Begin: ; while( NZ ) {
      JP Z, Class_GravityStone_While_2_End ; while( NZ ) {
      LD A, (HL)
      ; Begin if 
        Class_GravityStone_IfBranch_128_Begin: ; if ( A == E ) {
          CP E ; if ( A == E ) {
          JP NZ, Class_GravityStone_IfBranch_131_Begin ; if ( A == E ) {
          INC HL
          LD A, (HL)
          ; Begin if 
            Class_GravityStone_IfBranch_129_Begin: ; if ( A == D ) {
              CP D ; if ( A == D ) {
              JP NZ, Class_GravityStone_IfBranch_130_Begin ; if ( A == D ) {
              DEC HL
              AND 0
              JR Class_GravityStone_IfBranch_130_End ; if ( A == D ) {
            Class_GravityStone_IfBranch_130_Begin: ; } else {
              INC HL
              INC HL
              CALL Direct_Class_GravityStone_Method_is_eof_Code ; this.is_eof( HL )
            Class_GravityStone_IfBranch_130_End: ; }
          ; End full if
          JR Class_GravityStone_IfBranch_131_End ; if ( A == E ) {
        Class_GravityStone_IfBranch_131_Begin: ; } else {
          INC HL
          INC HL
          INC HL
          CALL Direct_Class_GravityStone_Method_is_eof_Code ; this.is_eof( HL )
        Class_GravityStone_IfBranch_131_End: ; }
      ; End full if
    JR Class_GravityStone_While_1_Begin ; } 
    Class_GravityStone_While_2_End:
    CALL Direct_Class_GravityStone_Method_is_eof_Code ; this.is_eof( HL )
    EX DE, HL
  RET ; }

  Direct_Class_GravityStone_Method_is_eof_Code: ; private is_eof( HL ) {
    LD A, (Class_GravityStone_DirectProperty_first_free_addr_Shift_0_Size_2_Data) ; A := this.first_free_addr
    ; Begin if 
      Class_GravityStone_IfBranch_132_Begin: ; if ( A == L ) {
        CP L ; if ( A == L ) {
        JP NZ, Class_GravityStone_IfBranch_132_End ; if ( A == L ) {
        LD A, (Class_GravityStone_DirectProperty_first_free_addr_Shift_0_Size_2_Data + 1) ; A := this.first_free_addr+1
        ; Begin if 
          Class_GravityStone_IfBranch_133_Begin: ; if ( A == H ) {
            CP H ; if ( A == H ) {
            JP NZ, Class_GravityStone_IfBranch_133_End ; if ( A == H ) {
            RET
          Class_GravityStone_IfBranch_133_End: ; }
        ; End full if
      Class_GravityStone_IfBranch_132_End: ; }
    ; End full if
  RET ; }

  Direct_Class_GravityStone_Method_remove_Code: ; public remove( HL ) {
    PUSH HL
    CALL Direct_Class_GravityStone_Method_find_pointer_Z_DE_Code ; this.find_pointer_Z_DE( HL )
    ; Begin if 
      Class_GravityStone_IfBranch_134_Begin: ; if ( NZ ) {
        JP Z, Class_GravityStone_IfBranch_134_End ; if ( NZ ) {
        EX DE, HL
        LD HL, (Class_GravityStone_DirectProperty_first_free_addr_Shift_0_Size_2_Data) ; HL := this.first_free_addr
        DEC HL
        DEC HL
        DEC HL
        LD (Class_GravityStone_DirectProperty_first_free_addr_Shift_0_Size_2_Data), HL ; this.first_free_addr := HL
        EX DE, HL
        CALL Direct_Class_GravityStone_Method_find_pointer_Z_DE_Code ; this.find_pointer_Z_DE( HL )
        ; Begin if 
          Class_GravityStone_IfBranch_135_Begin: ; if ( NZ ) {
            JP Z, Class_GravityStone_IfBranch_135_End ; if ( NZ ) {
            LD HL, (Class_GravityStone_DirectProperty_first_free_addr_Shift_0_Size_2_Data) ; HL := this.first_free_addr
            LD A, (HL)
            LD (DE), A
            INC DE
            INC HL
            LD A, (HL)
            LD (DE), A
            INC DE
            INC HL
            LD A, (HL)
            LD (DE), A
          Class_GravityStone_IfBranch_135_End: ; }
        ; End full if
      Class_GravityStone_IfBranch_134_End: ; }
    ; End full if
    POP HL
  RET ; }

  Direct_Class_GravityStone_Method_tick_Code: ; public tick() {
    LD HL, Class_GravityStone_DirectProperty_tick_speed_counter_Shift_2_Size_1_Data ; DEC this.tick_speed_counter
    DEC (HL) ; DEC this.tick_speed_counter
    ; Begin if 
      Class_GravityStone_IfBranch_136_Begin: ; if ( Z ) {
        JP NZ, Class_GravityStone_IfBranch_136_End ; if ( Z ) {
        CALL Direct_Class_MagickAnim_Method_anim_Code ; MAGICKANIM.anim()
        LD A, GRAVITY_TICK_SPEED ; this.tick_speed_counter := GRAVITY_TICK_SPEED
        LD (Class_GravityStone_DirectProperty_tick_speed_counter_Shift_2_Size_1_Data), A ; this.tick_speed_counter := GRAVITY_TICK_SPEED
        LD HL, StoneGravityPuffer
        CALL Direct_Class_GravityStone_Method_is_eof_Code ; this.is_eof( HL )
        Class_GravityStone_While_3_Begin: ; while ( NZ ) {
          JP Z, Class_GravityStone_While_4_End ; while ( NZ ) {
          PUSH HL
          CALL Direct_Class_GravityStone_Method_tick1_Code ; this.tick1( HL )
          POP HL
          CALL Direct_Class_GravityStone_Method_is_eof_Code ; this.is_eof( HL )
          ; Begin if 
            Class_GravityStone_IfBranch_137_Begin: ; if ( NZ ) {
              JP Z, Class_GravityStone_IfBranch_137_End ; if ( NZ ) {
              INC HL
              INC HL
              INC HL
              CALL Direct_Class_GravityStone_Method_is_eof_Code ; this.is_eof( HL )
            Class_GravityStone_IfBranch_137_End: ; }
          ; End full if
        JR Class_GravityStone_While_3_Begin ; } 
        Class_GravityStone_While_4_End:
      Class_GravityStone_IfBranch_136_End: ; }
    ; End full if
  RET ; }

  Direct_Class_GravityStone_Method_tick1_Code: ; public tick1( HL ) {
    PUSH HL
    LD C, (HL)
    INC HL
    LD B, (HL)
    INC HL
    EX DE, HL
    LD HL, SHADOW_LINE_LENGTH
    ADD HL, BC
    LD A, (HL)
    ; Begin if 
      Class_GravityStone_IfBranch_138_Begin: ; IF ( A == OBJECT_SPACE_CHAR ) {
        CP OBJECT_SPACE_CHAR ; IF ( A == OBJECT_SPACE_CHAR ) {
        JP NZ, Class_GravityStone_IfBranch_139_Begin ; IF ( A == OBJECT_SPACE_CHAR ) {
        LD A, 1
        LD (DE), A
        CALL Direct_Class_GravityStone_Method_move_to_Code ; this.move_to( BC, DE, HL)
        JP Class_GravityStone_IfBranch_152_End ; IF ( A == OBJECT_SPACE_CHAR ) {
      Class_GravityStone_IfBranch_139_Begin: ; } else if ( A == OBJECT_STONE_CHAR ) {
        CP OBJECT_STONE_CHAR ; } else if ( A == OBJECT_STONE_CHAR ) {
        JP NZ, Class_GravityStone_IfBranch_140_Begin ; } else if ( A == OBJECT_STONE_CHAR ) {
        CALL Direct_Class_GravityStone_Method_check_left_right_Code ; this.check_left_right( BC, DE, HL )
        JP Class_GravityStone_IfBranch_152_End ; } else if ( A == OBJECT_STONE_CHAR ) {
      Class_GravityStone_IfBranch_140_Begin: ; } else if ( A == OBJECT_WALL_CHAR ) {
        CP OBJECT_WALL_CHAR ; } else if ( A == OBJECT_WALL_CHAR ) {
        JP NZ, Class_GravityStone_IfBranch_141_Begin ; } else if ( A == OBJECT_WALL_CHAR ) {
        CALL Direct_Class_GravityStone_Method_check_left_right_Code ; this.check_left_right( BC, DE, HL )
        JP Class_GravityStone_IfBranch_152_End ; } else if ( A == OBJECT_WALL_CHAR ) {
      Class_GravityStone_IfBranch_141_Begin: ; } else if ( A == OBJECT_MAGICK_WALL1_CHAR ) {
        CP OBJECT_MAGICK_WALL1_CHAR ; } else if ( A == OBJECT_MAGICK_WALL1_CHAR ) {
        JP NZ, Class_GravityStone_IfBranch_142_Begin ; } else if ( A == OBJECT_MAGICK_WALL1_CHAR ) {
        LD A, (DE)
        CP 0
        CALL NZ, Direct_Class_GravityStone_Method_check_magick_Code ; this.check_magick( BC, DE, HL ) if ( NZ )
        JP Class_GravityStone_IfBranch_152_End ; } else if ( A == OBJECT_MAGICK_WALL1_CHAR ) {
      Class_GravityStone_IfBranch_142_Begin: ; } else if ( A == OBJECT_MAGICK_WALL2_CHAR ) {
        CP OBJECT_MAGICK_WALL2_CHAR ; } else if ( A == OBJECT_MAGICK_WALL2_CHAR ) {
        JP NZ, Class_GravityStone_IfBranch_143_Begin ; } else if ( A == OBJECT_MAGICK_WALL2_CHAR ) {
        LD A, (DE)
        CP 0
        CALL NZ, Direct_Class_GravityStone_Method_check_magick_Code ; this.check_magick( BC, DE, HL ) if ( NZ )
        JP Class_GravityStone_IfBranch_152_End ; } else if ( A == OBJECT_MAGICK_WALL2_CHAR ) {
      Class_GravityStone_IfBranch_143_Begin: ; } else if ( A == OBJECT_DIAMOND1_CHAR ) {
        CP OBJECT_DIAMOND1_CHAR ; } else if ( A == OBJECT_DIAMOND1_CHAR ) {
        JP NZ, Class_GravityStone_IfBranch_144_Begin ; } else if ( A == OBJECT_DIAMOND1_CHAR ) {
        CALL Direct_Class_GravityStone_Method_check_left_right_Code ; this.check_left_right( BC, DE, HL )
        JP Class_GravityStone_IfBranch_152_End ; } else if ( A == OBJECT_DIAMOND1_CHAR ) {
      Class_GravityStone_IfBranch_144_Begin: ; } else if ( A == OBJECT_DIAMOND2_CHAR ) {
        CP OBJECT_DIAMOND2_CHAR ; } else if ( A == OBJECT_DIAMOND2_CHAR ) {
        JP NZ, Class_GravityStone_IfBranch_145_Begin ; } else if ( A == OBJECT_DIAMOND2_CHAR ) {
        CALL Direct_Class_GravityStone_Method_check_left_right_Code ; this.check_left_right( BC, DE, HL )
        JP Class_GravityStone_IfBranch_152_End ; } else if ( A == OBJECT_DIAMOND2_CHAR ) {
      Class_GravityStone_IfBranch_145_Begin: ; } else if ( A == OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; } else if ( A == OBJECT_STEEL_CHAR ) {
        JP NZ, Class_GravityStone_IfBranch_146_Begin ; } else if ( A == OBJECT_STEEL_CHAR ) {
        CALL Direct_Class_GravityStone_Method_check_left_right_Code ; this.check_left_right( BC, DE, HL )
        JP Class_GravityStone_IfBranch_152_End ; } else if ( A == OBJECT_STEEL_CHAR ) {
      Class_GravityStone_IfBranch_146_Begin: ; } else if ( A == OBJECT_OPENED_DOOR_CHAR ) {
        CP OBJECT_OPENED_DOOR_CHAR ; } else if ( A == OBJECT_OPENED_DOOR_CHAR ) {
        JP NZ, Class_GravityStone_IfBranch_147_Begin ; } else if ( A == OBJECT_OPENED_DOOR_CHAR ) {
        CALL Direct_Class_GravityStone_Method_check_left_right_Code ; this.check_left_right( BC, DE, HL )
        JP Class_GravityStone_IfBranch_152_End ; } else if ( A == OBJECT_OPENED_DOOR_CHAR ) {
      Class_GravityStone_IfBranch_147_Begin: ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        CP OBJECT_BUTTERFLY1_CHAR ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        JP NZ, Class_GravityStone_IfBranch_148_Begin ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        CALL Direct_Class_Robbanas_Method_butterfly_Code ; ROBBANAS.butterfly( HL )
        JP Class_GravityStone_IfBranch_152_End ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
      Class_GravityStone_IfBranch_148_Begin: ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
        CP OBJECT_BUTTERFLY2_CHAR ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
        JP NZ, Class_GravityStone_IfBranch_149_Begin ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
        CALL Direct_Class_Robbanas_Method_butterfly_Code ; ROBBANAS.butterfly( HL )
        JP Class_GravityStone_IfBranch_152_End ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
      Class_GravityStone_IfBranch_149_Begin: ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
        CP OBJECT_FIREFLY1_CHAR ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
        JP NZ, Class_GravityStone_IfBranch_150_Begin ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
        CALL Direct_Class_Robbanas_Method_firefly_Code ; ROBBANAS.firefly( HL )
        JP Class_GravityStone_IfBranch_152_End ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
      Class_GravityStone_IfBranch_150_Begin: ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
        CP OBJECT_FIREFLY2_CHAR ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
        JP NZ, Class_GravityStone_IfBranch_151_Begin ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
        CALL Direct_Class_Robbanas_Method_firefly_Code ; ROBBANAS.firefly( HL )
        JP Class_GravityStone_IfBranch_152_End ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
      Class_GravityStone_IfBranch_151_Begin: ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        CP OBJECT_PLAYER_CHAR ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        JP NZ, Class_GravityStone_IfBranch_152_Begin ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        LD A, (DE)
        CP 0
        CALL NZ, Direct_Class_Robbanas_Method_stone_kill_player_Code ; ROBBANAS.stone_kill_player( HL ) if ( NZ )
        JP Class_GravityStone_IfBranch_152_End ; } else if ( A == OBJECT_PLAYER_CHAR ) {
      Class_GravityStone_IfBranch_152_Begin: ; } else {
        LD A, (DE)
        CP 0
        CALL NZ, Direct_Class_Puffanas_Method_go_Code ; PUFFANAS.go() if ( NZ )
        LD A, 0
        LD (DE), A
      Class_GravityStone_IfBranch_152_End: ; }
    ; End full if
    POP HL
  RET ; }

  Direct_Class_GravityStone_Method_check_magick_Code: ; private check_magick( BC, DE, HL ) {
    PUSH DE
    LD DE, SHADOW_LINE_LENGTH
    ADD HL, DE
    POP DE
    LD A, (HL)
    ; Begin if 
      Class_GravityStone_IfBranch_153_Begin: ; if ( A == OBJECT_SPACE_CHAR ) {
        CP OBJECT_SPACE_CHAR ; if ( A == OBJECT_SPACE_CHAR ) {
        JP NZ, Class_GravityStone_IfBranch_154_Begin ; if ( A == OBJECT_SPACE_CHAR ) {
        LD A, 1 ; MAGICKANIM.active := 1
        LD (Class_MagickAnim_DirectProperty_active_Shift_2_Size_1_Data), A ; MAGICKANIM.active := 1
        CALL Direct_Class_GravityDiamond_Method_append_Code ; DIAMONDGRAVITY.append( HL )
        LD (HL), OBJECT_DIAMOND1_CHAR
        LD A, OBJECT_SPACE_CHAR
        LD (BC), A
        LD H, B ; this.remove( BC )
        LD L, C ; this.remove( BC )
        CALL Direct_Class_GravityStone_Method_remove_Code ; this.remove( BC )
        JR Class_GravityStone_IfBranch_154_End ; if ( A == OBJECT_SPACE_CHAR ) {
      Class_GravityStone_IfBranch_154_Begin: ; } else {
        LD A, 0
        LD (DE), A
      Class_GravityStone_IfBranch_154_End: ; }
    ; End full if
  RET ; }

  Direct_Class_GravityStone_Method_check_left_right_Code: ; private check_left_right( BC, DE, HL ) {
    LD A, (DE)
    CP 0
    CALL NZ, Direct_Class_Puffanas_Method_go_Code ; PUFFANAS.go() if ( NZ )
    LD A, 0
    LD (DE), A
    DEC HL
    LD A, (HL)
    ; Begin if 
      Class_GravityStone_IfBranch_155_Begin: ; if ( A == OBJECT_SPACE_CHAR ) {
        CP OBJECT_SPACE_CHAR ; if ( A == OBJECT_SPACE_CHAR ) {
        JP NZ, Class_GravityStone_IfBranch_156_Begin ; if ( A == OBJECT_SPACE_CHAR ) {
        CALL Direct_Class_GravityStone_Method_check_horizontal_move_Code ; this.check_horizontal_move( BC, DE, HL )
        JR Class_GravityStone_IfBranch_156_End ; if ( A == OBJECT_SPACE_CHAR ) {
      Class_GravityStone_IfBranch_156_Begin: ; } else {
        INC HL
        INC HL
        LD A, (HL)
        ; Begin if 
          Class_GravityStone_IfBranch_157_Begin: ; if ( A == OBJECT_SPACE_CHAR ) {
            CP OBJECT_SPACE_CHAR ; if ( A == OBJECT_SPACE_CHAR ) {
            JP NZ, Class_GravityStone_IfBranch_157_End ; if ( A == OBJECT_SPACE_CHAR ) {
            CALL Direct_Class_GravityStone_Method_check_horizontal_move_Code ; this.check_horizontal_move( BC, DE, HL )
          Class_GravityStone_IfBranch_157_End: ; }
        ; End full if
      Class_GravityStone_IfBranch_156_End: ; }
    ; End full if
  RET ; }

  Direct_Class_GravityStone_Method_check_horizontal_move_Code: ; private check_horizontal_move( BC, DE, HL ) {
    PUSH HL
    PUSH DE
    LD DE, -SHADOW_LINE_LENGTH
    ADD HL, DE
    POP DE
    LD A, (HL)
    POP HL
    CP OBJECT_SPACE_CHAR
    CALL Z, Direct_Class_GravityStone_Method_move_to_Code ; this.move_to( BC, DE, HL) if ( Z )
  RET ; }

  Direct_Class_GravityStone_Method_move_to_Code: ; private move_to( BC, DE, HL) {
    LD (HL), OBJECT_STONE_CHAR
    LD A, OBJECT_SPACE_CHAR
    LD (BC), A
    DEC DE
    LD A, H
    LD (DE), A
    DEC DE
    LD A, L
    LD (DE), A
  RET ; }
; } ; End class GravityStone

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class GravityDiamond extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_GravityDiamond_DirectProperty_first_free_addr_Shift_0_Size_2_Data: DW 0 ; DW first_free_addr
  Class_GravityDiamond_DirectProperty_tick_speed_counter_Shift_2_Size_1_Data: DB 0 ; DB tick_speed_counter

  Direct_Class_GravityDiamond_Method_init_Code: ; public init() {
    LD A, DiamondGravityPuffer % 256 ; this.first_free_addr := DiamondGravityPuffer
    LD (Class_GravityDiamond_DirectProperty_first_free_addr_Shift_0_Size_2_Data), A ; this.first_free_addr := DiamondGravityPuffer
    LD A, DiamondGravityPuffer / 256 ; this.first_free_addr := DiamondGravityPuffer
    LD (Class_GravityDiamond_DirectProperty_first_free_addr_Shift_0_Size_2_Data + 1), A ; this.first_free_addr := DiamondGravityPuffer
    LD A, GRAVITY_TICK_SPEED ; this.tick_speed_counter := GRAVITY_TICK_SPEED
    LD (Class_GravityDiamond_DirectProperty_tick_speed_counter_Shift_2_Size_1_Data), A ; this.tick_speed_counter := GRAVITY_TICK_SPEED
  RET ; }

  Direct_Class_GravityDiamond_Method_append_Code: ; public append( HL ) {
    PUSH HL
    PUSH DE
    EX DE, HL
    LD HL, (Class_GravityDiamond_DirectProperty_first_free_addr_Shift_0_Size_2_Data) ; HL := this.first_free_addr
    LD (HL), E
    INC HL
    LD (HL), D
    INC HL
    LD (HL), 0
    INC HL
    LD (Class_GravityDiamond_DirectProperty_first_free_addr_Shift_0_Size_2_Data), HL ; this.first_free_addr := HL
    POP DE
    POP HL
  RET ; }

  Direct_Class_GravityDiamond_Method_find_pointer_Z_DE_Code: ; private find_pointer_Z_DE( HL ) {
    LD DE, DiamondGravityPuffer
    EX DE, HL
    CALL Direct_Class_GravityDiamond_Method_is_eof_Code ; this.is_eof( HL )
    Class_GravityDiamond_While_5_Begin: ; while( NZ ) {
      JP Z, Class_GravityDiamond_While_6_End ; while( NZ ) {
      LD A, (HL)
      ; Begin if 
        Class_GravityDiamond_IfBranch_158_Begin: ; if ( A == E ) {
          CP E ; if ( A == E ) {
          JP NZ, Class_GravityDiamond_IfBranch_161_Begin ; if ( A == E ) {
          INC HL
          LD A, (HL)
          ; Begin if 
            Class_GravityDiamond_IfBranch_159_Begin: ; if ( A == D ) {
              CP D ; if ( A == D ) {
              JP NZ, Class_GravityDiamond_IfBranch_160_Begin ; if ( A == D ) {
              DEC HL
              AND 0
              JR Class_GravityDiamond_IfBranch_160_End ; if ( A == D ) {
            Class_GravityDiamond_IfBranch_160_Begin: ; } else {
              INC HL
              INC HL
              CALL Direct_Class_GravityDiamond_Method_is_eof_Code ; this.is_eof( HL )
            Class_GravityDiamond_IfBranch_160_End: ; }
          ; End full if
          JR Class_GravityDiamond_IfBranch_161_End ; if ( A == E ) {
        Class_GravityDiamond_IfBranch_161_Begin: ; } else {
          INC HL
          INC HL
          INC HL
          CALL Direct_Class_GravityDiamond_Method_is_eof_Code ; this.is_eof( HL )
        Class_GravityDiamond_IfBranch_161_End: ; }
      ; End full if
    JR Class_GravityDiamond_While_5_Begin ; } 
    Class_GravityDiamond_While_6_End:
    CALL Direct_Class_GravityDiamond_Method_is_eof_Code ; this.is_eof( HL )
    EX DE, HL
  RET ; }

  Direct_Class_GravityDiamond_Method_is_eof_Code: ; private is_eof( HL ) {
    LD A, (Class_GravityDiamond_DirectProperty_first_free_addr_Shift_0_Size_2_Data) ; A := this.first_free_addr
    ; Begin if 
      Class_GravityDiamond_IfBranch_162_Begin: ; if ( A == L ) {
        CP L ; if ( A == L ) {
        JP NZ, Class_GravityDiamond_IfBranch_162_End ; if ( A == L ) {
        LD A, (Class_GravityDiamond_DirectProperty_first_free_addr_Shift_0_Size_2_Data + 1) ; A := this.first_free_addr+1
        ; Begin if 
          Class_GravityDiamond_IfBranch_163_Begin: ; if ( A == H ) {
            CP H ; if ( A == H ) {
            JP NZ, Class_GravityDiamond_IfBranch_163_End ; if ( A == H ) {
            RET
          Class_GravityDiamond_IfBranch_163_End: ; }
        ; End full if
      Class_GravityDiamond_IfBranch_162_End: ; }
    ; End full if
  RET ; }

  Direct_Class_GravityDiamond_Method_remove_Code: ; public remove( HL ) {
    PUSH HL
    CALL Direct_Class_GravityDiamond_Method_find_pointer_Z_DE_Code ; this.find_pointer_Z_DE( HL )
    ; Begin if 
      Class_GravityDiamond_IfBranch_164_Begin: ; if ( NZ ) {
        JP Z, Class_GravityDiamond_IfBranch_164_End ; if ( NZ ) {
        EX DE, HL
        LD HL, (Class_GravityDiamond_DirectProperty_first_free_addr_Shift_0_Size_2_Data) ; HL := this.first_free_addr
        DEC HL
        DEC HL
        DEC HL
        LD (Class_GravityDiamond_DirectProperty_first_free_addr_Shift_0_Size_2_Data), HL ; this.first_free_addr := HL
        EX DE, HL
        CALL Direct_Class_GravityDiamond_Method_find_pointer_Z_DE_Code ; this.find_pointer_Z_DE( HL )
        ; Begin if 
          Class_GravityDiamond_IfBranch_165_Begin: ; if ( NZ ) {
            JP Z, Class_GravityDiamond_IfBranch_165_End ; if ( NZ ) {
            LD HL, (Class_GravityDiamond_DirectProperty_first_free_addr_Shift_0_Size_2_Data) ; HL := this.first_free_addr
            LD A, (HL)
            LD (DE), A
            INC DE
            INC HL
            LD A, (HL)
            LD (DE), A
            INC DE
            INC HL
            LD A, (HL)
            LD (DE), A
          Class_GravityDiamond_IfBranch_165_End: ; }
        ; End full if
      Class_GravityDiamond_IfBranch_164_End: ; }
    ; End full if
    POP HL
  RET ; }

  Direct_Class_GravityDiamond_Method_tick_Code: ; public tick() {
    LD HL, Class_GravityDiamond_DirectProperty_tick_speed_counter_Shift_2_Size_1_Data ; DEC this.tick_speed_counter
    DEC (HL) ; DEC this.tick_speed_counter
    ; Begin if 
      Class_GravityDiamond_IfBranch_166_Begin: ; if ( Z ) {
        JP NZ, Class_GravityDiamond_IfBranch_166_End ; if ( Z ) {
        LD A, GRAVITY_TICK_SPEED ; this.tick_speed_counter := GRAVITY_TICK_SPEED
        LD (Class_GravityDiamond_DirectProperty_tick_speed_counter_Shift_2_Size_1_Data), A ; this.tick_speed_counter := GRAVITY_TICK_SPEED
        LD HL, DiamondGravityPuffer
        CALL Direct_Class_GravityDiamond_Method_is_eof_Code ; this.is_eof( HL )
        Class_GravityDiamond_While_7_Begin: ; while ( NZ ) {
          JP Z, Class_GravityDiamond_While_8_End ; while ( NZ ) {
          PUSH HL
          CALL Direct_Class_GravityDiamond_Method_tick1_Code ; this.tick1( HL )
          POP HL
          CALL Direct_Class_GravityDiamond_Method_is_eof_Code ; this.is_eof( HL )
          ; Begin if 
            Class_GravityDiamond_IfBranch_167_Begin: ; if ( NZ ) {
              JP Z, Class_GravityDiamond_IfBranch_167_End ; if ( NZ ) {
              INC HL
              INC HL
              INC HL
              CALL Direct_Class_GravityDiamond_Method_is_eof_Code ; this.is_eof( HL )
            Class_GravityDiamond_IfBranch_167_End: ; }
          ; End full if
        JR Class_GravityDiamond_While_7_Begin ; } 
        Class_GravityDiamond_While_8_End:
      Class_GravityDiamond_IfBranch_166_End: ; }
    ; End full if
  RET ; }

  Direct_Class_GravityDiamond_Method_tick1_Code: ; public tick1( HL ) {
    PUSH HL
    LD C, (HL)
    INC HL
    LD B, (HL)
    INC HL
    EX DE, HL
    LD HL, SHADOW_LINE_LENGTH
    ADD HL, BC
    LD A, (HL)
    ; Begin if 
      Class_GravityDiamond_IfBranch_168_Begin: ; IF ( A == OBJECT_SPACE_CHAR ) {
        CP OBJECT_SPACE_CHAR ; IF ( A == OBJECT_SPACE_CHAR ) {
        JP NZ, Class_GravityDiamond_IfBranch_169_Begin ; IF ( A == OBJECT_SPACE_CHAR ) {
        LD A, 1
        LD (DE), A
        CALL Direct_Class_GravityDiamond_Method_move_to_Code ; this.move_to( BC, DE, HL)
        JP Class_GravityDiamond_IfBranch_182_End ; IF ( A == OBJECT_SPACE_CHAR ) {
      Class_GravityDiamond_IfBranch_169_Begin: ; } else if ( A == OBJECT_STONE_CHAR ) {
        CP OBJECT_STONE_CHAR ; } else if ( A == OBJECT_STONE_CHAR ) {
        JP NZ, Class_GravityDiamond_IfBranch_170_Begin ; } else if ( A == OBJECT_STONE_CHAR ) {
        CALL Direct_Class_GravityDiamond_Method_check_left_right_Code ; this.check_left_right( BC, DE, HL )
        JP Class_GravityDiamond_IfBranch_182_End ; } else if ( A == OBJECT_STONE_CHAR ) {
      Class_GravityDiamond_IfBranch_170_Begin: ; } else if ( A == OBJECT_WALL_CHAR ) {
        CP OBJECT_WALL_CHAR ; } else if ( A == OBJECT_WALL_CHAR ) {
        JP NZ, Class_GravityDiamond_IfBranch_171_Begin ; } else if ( A == OBJECT_WALL_CHAR ) {
        CALL Direct_Class_GravityDiamond_Method_check_left_right_Code ; this.check_left_right( BC, DE, HL )
        JP Class_GravityDiamond_IfBranch_182_End ; } else if ( A == OBJECT_WALL_CHAR ) {
      Class_GravityDiamond_IfBranch_171_Begin: ; } else if ( A == OBJECT_MAGICK_WALL1_CHAR ) {
        CP OBJECT_MAGICK_WALL1_CHAR ; } else if ( A == OBJECT_MAGICK_WALL1_CHAR ) {
        JP NZ, Class_GravityDiamond_IfBranch_172_Begin ; } else if ( A == OBJECT_MAGICK_WALL1_CHAR ) {
        LD A, (DE)
        CP 0
        CALL NZ, Direct_Class_GravityDiamond_Method_check_magick_Code ; this.check_magick( BC, DE, HL ) if ( NZ )
        JP Class_GravityDiamond_IfBranch_182_End ; } else if ( A == OBJECT_MAGICK_WALL1_CHAR ) {
      Class_GravityDiamond_IfBranch_172_Begin: ; } else if ( A == OBJECT_MAGICK_WALL2_CHAR ) {
        CP OBJECT_MAGICK_WALL2_CHAR ; } else if ( A == OBJECT_MAGICK_WALL2_CHAR ) {
        JP NZ, Class_GravityDiamond_IfBranch_173_Begin ; } else if ( A == OBJECT_MAGICK_WALL2_CHAR ) {
        LD A, (DE)
        CP 0
        CALL NZ, Direct_Class_GravityDiamond_Method_check_magick_Code ; this.check_magick( BC, DE, HL ) if ( NZ )
        JP Class_GravityDiamond_IfBranch_182_End ; } else if ( A == OBJECT_MAGICK_WALL2_CHAR ) {
      Class_GravityDiamond_IfBranch_173_Begin: ; } else if ( A == OBJECT_DIAMOND1_CHAR ) {
        CP OBJECT_DIAMOND1_CHAR ; } else if ( A == OBJECT_DIAMOND1_CHAR ) {
        JP NZ, Class_GravityDiamond_IfBranch_174_Begin ; } else if ( A == OBJECT_DIAMOND1_CHAR ) {
        CALL Direct_Class_GravityDiamond_Method_check_left_right_Code ; this.check_left_right( BC, DE, HL )
        JP Class_GravityDiamond_IfBranch_182_End ; } else if ( A == OBJECT_DIAMOND1_CHAR ) {
      Class_GravityDiamond_IfBranch_174_Begin: ; } else if ( A == OBJECT_DIAMOND2_CHAR ) {
        CP OBJECT_DIAMOND2_CHAR ; } else if ( A == OBJECT_DIAMOND2_CHAR ) {
        JP NZ, Class_GravityDiamond_IfBranch_175_Begin ; } else if ( A == OBJECT_DIAMOND2_CHAR ) {
        CALL Direct_Class_GravityDiamond_Method_check_left_right_Code ; this.check_left_right( BC, DE, HL )
        JP Class_GravityDiamond_IfBranch_182_End ; } else if ( A == OBJECT_DIAMOND2_CHAR ) {
      Class_GravityDiamond_IfBranch_175_Begin: ; } else if ( A == OBJECT_STEEL_CHAR ) {
        CP OBJECT_STEEL_CHAR ; } else if ( A == OBJECT_STEEL_CHAR ) {
        JP NZ, Class_GravityDiamond_IfBranch_176_Begin ; } else if ( A == OBJECT_STEEL_CHAR ) {
        CALL Direct_Class_GravityDiamond_Method_check_left_right_Code ; this.check_left_right( BC, DE, HL )
        JP Class_GravityDiamond_IfBranch_182_End ; } else if ( A == OBJECT_STEEL_CHAR ) {
      Class_GravityDiamond_IfBranch_176_Begin: ; } else if ( A == OBJECT_OPENED_DOOR_CHAR ) {
        CP OBJECT_OPENED_DOOR_CHAR ; } else if ( A == OBJECT_OPENED_DOOR_CHAR ) {
        JP NZ, Class_GravityDiamond_IfBranch_177_Begin ; } else if ( A == OBJECT_OPENED_DOOR_CHAR ) {
        CALL Direct_Class_GravityDiamond_Method_check_left_right_Code ; this.check_left_right( BC, DE, HL )
        JP Class_GravityDiamond_IfBranch_182_End ; } else if ( A == OBJECT_OPENED_DOOR_CHAR ) {
      Class_GravityDiamond_IfBranch_177_Begin: ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        CP OBJECT_BUTTERFLY1_CHAR ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        JP NZ, Class_GravityDiamond_IfBranch_178_Begin ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        CALL Direct_Class_Robbanas_Method_butterfly_Code ; ROBBANAS.butterfly( HL )
        JP Class_GravityDiamond_IfBranch_182_End ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
      Class_GravityDiamond_IfBranch_178_Begin: ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
        CP OBJECT_BUTTERFLY2_CHAR ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
        JP NZ, Class_GravityDiamond_IfBranch_179_Begin ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
        CALL Direct_Class_Robbanas_Method_butterfly_Code ; ROBBANAS.butterfly( HL )
        JP Class_GravityDiamond_IfBranch_182_End ; } else if ( A == OBJECT_BUTTERFLY2_CHAR ) {
      Class_GravityDiamond_IfBranch_179_Begin: ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
        CP OBJECT_FIREFLY1_CHAR ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
        JP NZ, Class_GravityDiamond_IfBranch_180_Begin ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
        CALL Direct_Class_Robbanas_Method_firefly_Code ; ROBBANAS.firefly( HL )
        JP Class_GravityDiamond_IfBranch_182_End ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
      Class_GravityDiamond_IfBranch_180_Begin: ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
        CP OBJECT_FIREFLY2_CHAR ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
        JP NZ, Class_GravityDiamond_IfBranch_181_Begin ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
        CALL Direct_Class_Robbanas_Method_firefly_Code ; ROBBANAS.firefly( HL )
        JP Class_GravityDiamond_IfBranch_182_End ; } else if ( A == OBJECT_FIREFLY2_CHAR ) {
      Class_GravityDiamond_IfBranch_181_Begin: ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        CP OBJECT_PLAYER_CHAR ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        JP NZ, Class_GravityDiamond_IfBranch_182_Begin ; } else if ( A == OBJECT_PLAYER_CHAR ) {
        LD A, (DE )
        CP 0
        CALL NZ, Direct_Class_Robbanas_Method_diamond_kill_player_Code ; ROBBANAS.diamond_kill_player( HL ) if ( NZ )
        JP Class_GravityDiamond_IfBranch_182_End ; } else if ( A == OBJECT_PLAYER_CHAR ) {
      Class_GravityDiamond_IfBranch_182_Begin: ; } else {
        LD A, (DE)
        CP 0
        CALL NZ, Direct_Class_Sounds_Method_diamond_Code ; SOUNDS.diamond() if ( NZ )
        LD A, 0
        LD (DE), A
      Class_GravityDiamond_IfBranch_182_End: ; }
    ; End full if
    POP HL
  RET ; }

  Direct_Class_GravityDiamond_Method_check_magick_Code: ; private check_magick( BC, DE, HL ) {
    PUSH DE
    LD DE, SHADOW_LINE_LENGTH
    ADD HL, DE
    POP DE
    LD A, (HL)
    ; Begin if 
      Class_GravityDiamond_IfBranch_183_Begin: ; if ( A == OBJECT_SPACE_CHAR ) {
        CP OBJECT_SPACE_CHAR ; if ( A == OBJECT_SPACE_CHAR ) {
        JP NZ, Class_GravityDiamond_IfBranch_184_Begin ; if ( A == OBJECT_SPACE_CHAR ) {
        LD (HL), OBJECT_STONE_CHAR
        CALL Direct_Class_GravityStone_Method_append_Code ; STONEGRAVITY.append( HL )
        LD A, OBJECT_SPACE_CHAR
        LD (BC), A
        LD H, B ; this.remove( BC )
        LD L, C ; this.remove( BC )
        CALL Direct_Class_GravityDiamond_Method_remove_Code ; this.remove( BC )
        JR Class_GravityDiamond_IfBranch_184_End ; if ( A == OBJECT_SPACE_CHAR ) {
      Class_GravityDiamond_IfBranch_184_Begin: ; } else {
        LD A, 0
        LD (DE), A
      Class_GravityDiamond_IfBranch_184_End: ; }
    ; End full if
  RET ; }

  Direct_Class_GravityDiamond_Method_check_left_right_Code: ; private check_left_right( BC, DE, HL ) {
    LD A, (DE)
    CP 0
    CALL NZ, Direct_Class_Sounds_Method_diamond_Code ; SOUNDS.diamond() if ( NZ )
    LD A, 0
    LD (DE), A
    DEC HL
    LD A, (HL)
    ; Begin if 
      Class_GravityDiamond_IfBranch_185_Begin: ; if ( A == OBJECT_SPACE_CHAR ) {
        CP OBJECT_SPACE_CHAR ; if ( A == OBJECT_SPACE_CHAR ) {
        JP NZ, Class_GravityDiamond_IfBranch_186_Begin ; if ( A == OBJECT_SPACE_CHAR ) {
        CALL Direct_Class_GravityDiamond_Method_check_horizontal_move_Code ; this.check_horizontal_move( BC, DE, HL )
        JR Class_GravityDiamond_IfBranch_186_End ; if ( A == OBJECT_SPACE_CHAR ) {
      Class_GravityDiamond_IfBranch_186_Begin: ; } else {
        INC HL
        INC HL
        LD A, (HL)
        ; Begin if 
          Class_GravityDiamond_IfBranch_187_Begin: ; if ( A == OBJECT_SPACE_CHAR ) {
            CP OBJECT_SPACE_CHAR ; if ( A == OBJECT_SPACE_CHAR ) {
            JP NZ, Class_GravityDiamond_IfBranch_187_End ; if ( A == OBJECT_SPACE_CHAR ) {
            CALL Direct_Class_GravityDiamond_Method_check_horizontal_move_Code ; this.check_horizontal_move( BC, DE, HL )
          Class_GravityDiamond_IfBranch_187_End: ; }
        ; End full if
      Class_GravityDiamond_IfBranch_186_End: ; }
    ; End full if
  RET ; }

  Direct_Class_GravityDiamond_Method_check_horizontal_move_Code: ; private check_horizontal_move( BC, DE, HL ) {
    PUSH HL
    PUSH DE
    LD DE, -SHADOW_LINE_LENGTH
    ADD HL, DE
    POP DE
    LD A, (HL)
    POP HL
    CP OBJECT_SPACE_CHAR
    CALL Z, Direct_Class_GravityDiamond_Method_move_to_Code ; this.move_to( BC, DE, HL) if ( Z )
  RET ; }

  Direct_Class_GravityDiamond_Method_move_to_Code: ; private move_to( BC, DE, HL) {
    LD (HL), OBJECT_DIAMOND1_CHAR
    LD A, OBJECT_SPACE_CHAR
    LD (BC), A
    DEC DE
    LD A, H
    LD (DE), A
    DEC DE
    LD A, L
    LD (DE), A
  RET ; }
; } ; End class GravityDiamond

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class MagickAnim extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_MagickAnim_DirectProperty_first_free_addr_Shift_0_Size_2_Data: DW 0 ; DW first_free_addr
  Class_MagickAnim_DirectProperty_active_Shift_2_Size_1_Data: DB 0 ; DB active
  Class_MagickAnim_DirectProperty_timer_Shift_3_Size_1_Data: DB 0 ; DB timer

  Direct_Class_MagickAnim_Method_init_Code: ; public init( A ) {
    INC A
    LD (Class_MagickAnim_DirectProperty_timer_Shift_3_Size_1_Data), A ; this.timer := A
    LD A, MagickPuffer % 256 ; this.first_free_addr := MagickPuffer
    LD (Class_MagickAnim_DirectProperty_first_free_addr_Shift_0_Size_2_Data), A ; this.first_free_addr := MagickPuffer
    LD A, MagickPuffer / 256 ; this.first_free_addr := MagickPuffer
    LD (Class_MagickAnim_DirectProperty_first_free_addr_Shift_0_Size_2_Data + 1), A ; this.first_free_addr := MagickPuffer
    LD A, 0 ; this.active := 0
    LD (Class_MagickAnim_DirectProperty_active_Shift_2_Size_1_Data), A ; this.active := 0
  RET ; }

  Direct_Class_MagickAnim_Method_append_Code: ; public append( HL ) {
    PUSH HL
    PUSH DE
    EX DE, HL
    LD HL, (Class_MagickAnim_DirectProperty_first_free_addr_Shift_0_Size_2_Data) ; HL := this.first_free_addr
    LD (HL), E
    INC HL
    LD (HL), D
    INC HL
    LD (Class_MagickAnim_DirectProperty_first_free_addr_Shift_0_Size_2_Data), HL ; this.first_free_addr := HL
    POP DE
    POP HL
  RET ; }

  Direct_Class_MagickAnim_Method_is_eof_Code: ; private is_eof( HL ) {
    LD A, (Class_MagickAnim_DirectProperty_first_free_addr_Shift_0_Size_2_Data) ; A := this.first_free_addr
    ; Begin if 
      Class_MagickAnim_IfBranch_188_Begin: ; if ( A == L ) {
        CP L ; if ( A == L ) {
        JP NZ, Class_MagickAnim_IfBranch_188_End ; if ( A == L ) {
        LD A, (Class_MagickAnim_DirectProperty_first_free_addr_Shift_0_Size_2_Data + 1) ; A := this.first_free_addr+1
        CP H
        RET Z
      Class_MagickAnim_IfBranch_188_End: ; }
    ; End full if
  RET ; }

  Direct_Class_MagickAnim_Method_anim_Code: ; public anim() {
    PUSH HL
    PUSH DE
    LD A, (Class_MagickAnim_DirectProperty_active_Shift_2_Size_1_Data) ; A := this.active
    ; Begin if 
      Class_MagickAnim_IfBranch_189_Begin: ; if ( A == 1 ) {
        CP 1 ; if ( A == 1 ) {
        JP NZ, Class_MagickAnim_IfBranch_189_End ; if ( A == 1 ) {
        LD HL, MagickPuffer
        CALL Direct_Class_MagickAnim_Method_is_eof_Code ; this.is_eof( HL )
        Class_MagickAnim_While_9_Begin: ; while ( NZ ) {
          JP Z, Class_MagickAnim_While_10_End ; while ( NZ ) {
          CALL Direct_Class_MagickAnim_Method_anim_one_Code ; this.anim_one( HL )
          CALL Direct_Class_MagickAnim_Method_is_eof_Code ; this.is_eof( HL )
        JR Class_MagickAnim_While_9_Begin ; } 
        Class_MagickAnim_While_10_End:
      Class_MagickAnim_IfBranch_189_End: ; }
    ; End full if
    POP DE
    POP HL
  RET ; }

  Direct_Class_MagickAnim_Method_countdown_Code: ; public countdown() {
    LD A, (Class_MagickAnim_DirectProperty_active_Shift_2_Size_1_Data) ; A := this.active
    ; Begin if 
      Class_MagickAnim_IfBranch_190_Begin: ; if ( A == 1 ) {
        CP 1 ; if ( A == 1 ) {
        JP NZ, Class_MagickAnim_IfBranch_190_End ; if ( A == 1 ) {
        LD A, (Class_MagickAnim_DirectProperty_timer_Shift_3_Size_1_Data) ; A := this.timer
        ; Begin if 
          Class_MagickAnim_IfBranch_191_Begin: ; if ( A != 0 ) {
            CP 0 ; if ( A != 0 ) {
            JP Z, Class_MagickAnim_IfBranch_191_End ; if ( A != 0 ) {
            DEC A
            LD (Class_MagickAnim_DirectProperty_timer_Shift_3_Size_1_Data), A ; this.timer := A
            CALL Z, Direct_Class_MagickAnim_Method_deactivate_Code ; this.deactivate() if ( Z )
          Class_MagickAnim_IfBranch_191_End: ; }
        ; End full if
      Class_MagickAnim_IfBranch_190_End: ; }
    ; End full if
  RET ; }

  Direct_Class_MagickAnim_Method_anim_one_Code: ; private anim_one( HL ) {
    LD E, (HL)
    INC HL
    LD D, (HL)
    INC HL
    EX DE, HL
    LD A, (HL)
    ; Begin if 
      Class_MagickAnim_IfBranch_192_Begin: ; if ( A == OBJECT_MAGICK_WALL1_CHAR ) {
        CP OBJECT_MAGICK_WALL1_CHAR ; if ( A == OBJECT_MAGICK_WALL1_CHAR ) {
        JP NZ, Class_MagickAnim_IfBranch_193_Begin ; if ( A == OBJECT_MAGICK_WALL1_CHAR ) {
        LD (HL), OBJECT_MAGICK_WALL2_CHAR
        JR Class_MagickAnim_IfBranch_193_End ; if ( A == OBJECT_MAGICK_WALL1_CHAR ) {
      Class_MagickAnim_IfBranch_193_Begin: ; } else {
        LD (HL), OBJECT_MAGICK_WALL1_CHAR
      Class_MagickAnim_IfBranch_193_End: ; }
    ; End full if
    EX DE, HL
  RET ; }

  Direct_Class_MagickAnim_Method_deactivate_Code: ; private deactivate() {
    LD HL, MagickPuffer
    CALL Direct_Class_MagickAnim_Method_is_eof_Code ; this.is_eof( HL )
    Class_MagickAnim_While_11_Begin: ; while ( NZ ) {
      JP Z, Class_MagickAnim_While_12_End ; while ( NZ ) {
      LD E, (HL)
      INC HL
      LD D, (HL)
      INC HL
      EX DE, HL
      LD (HL), OBJECT_WALL_CHAR
      EX DE, HL
      CALL Direct_Class_MagickAnim_Method_is_eof_Code ; this.is_eof( HL )
    JR Class_MagickAnim_While_11_Begin ; } 
    Class_MagickAnim_While_12_End:
    LD A, 0 ; this.active := 0
    LD (Class_MagickAnim_DirectProperty_active_Shift_2_Size_1_Data), A ; this.active := 0
  RET ; }
; } ; End class MagickAnim

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Cave extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_Cave_DirectProperty_randomSeed_Shift_0_Size_1_Data: DB 0 ; DB randomSeed
  Class_Cave_DirectProperty_randomObjects_Shift_1_Size_2_Data: DW 0 ; DW randomObjects
  Class_Cave_DirectProperty_randomObjectProb_Shift_3_Size_2_Data: DW 0 ; DW randomObjectProb
  Class_Cave_DirectProperty_open_counter_Shift_5_Size_1_Data: DB 0 ; DB open_counter
  Class_Cave_DirectProperty_diamond_point_Shift_6_Size_1_Data: DB 0 ; DB diamond_point
  Class_Cave_DirectProperty_extra_diamond_point_Shift_7_Size_1_Data: DB 0 ; DB extra_diamond_point
  Class_Cave_DirectProperty_time_Shift_8_Size_1_Data: DB 0 ; DB time
  Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data: DB 0 ; DB _pos_x
  Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data: DB 0 ; DB _pos_y
  Class_Cave_DirectProperty__width_Shift_11_Size_1_Data: DB 0 ; DB _width
  Class_Cave_DirectProperty__height_Shift_12_Size_1_Data: DB 0 ; DB _height
  Class_Cave_DirectProperty__length_Shift_13_Size_1_Data: DB 0 ; DB _length
  Class_Cave_DirectProperty__dir_Shift_14_Size_1_Data: DB 0 ; DB _dir
  Class_Cave_DirectProperty__object_index_Shift_15_Size_1_Data: DB 0 ; DB _object_index
  Class_Cave_DirectProperty__fill_index_Shift_16_Size_1_Data: DB 0 ; DB _fill_index
  Class_Cave_DirectProperty__cave_index0_Shift_17_Size_1_Data: DB 0 ; DB _cave_index0
  Class_Cave_DirectProperty__door_puffer_pointer_Shift_18_Size_2_Data: DW 0 ; DW _door_puffer_pointer
  Class_Cave_DirectProperty__magicWallMillingTime_and_amoebaSlowGrowthTime_Shift_20_Size_1_Data: DB 0 ; DB _magicWallMillingTime_and_amoebaSlowGrowthTime

  Direct_Class_Cave_Method_get_level_indexed_value_to_A_and_add_5_to_HL_Code: ; private get_level_indexed_value_to_A_and_add_5_to_HL( HL, C ) {
    LD A, 0
    Class_Cave_Until_14_Begin: ; Until begin : {
      INC A
      ; Begin if 
        Class_Cave_IfBranch_194_Begin: ; if ( A == C ) {
          CP C ; if ( A == C ) {
          JP NZ, Class_Cave_IfBranch_194_End ; if ( A == C ) {
          LD B, (HL)
        Class_Cave_IfBranch_194_End: ; }
      ; End full if
      INC HL
    CP 5 ; {
    JP NZ, Class_Cave_Until_14_Begin ; {
    LD A, B
  RET ; }

  Direct_Class_Cave_Method_load_cave_header_data_HL_Code: ; private load_cave_header_data_HL( HL ) {
    LD A, (Class_Game_DirectProperty_level_Shift_1_Size_1_Data) ; C := GAME.level
    LD C, A ; C := GAME.level
    INC HL
    LD A, (HL)
    LD (Class_Cave_DirectProperty__magicWallMillingTime_and_amoebaSlowGrowthTime_Shift_20_Size_1_Data), A ; this._magicWallMillingTime_and_amoebaSlowGrowthTime := A
    INC HL
    LD A, (HL)
    LD A, (HL) ; this.diamond_point := (HL)
    LD (Class_Cave_DirectProperty_diamond_point_Shift_6_Size_1_Data), A ; this.diamond_point := (HL)
    INC HL
    LD A, (HL) ; this.extra_diamond_point := (HL)
    LD (Class_Cave_DirectProperty_extra_diamond_point_Shift_7_Size_1_Data), A ; this.extra_diamond_point := (HL)
    INC HL
    CALL Direct_Class_Cave_Method_get_level_indexed_value_to_A_and_add_5_to_HL_Code ; this.get_level_indexed_value_to_A_and_add_5_to_HL( HL, C )
    LD (Class_Cave_DirectProperty_randomSeed_Shift_0_Size_1_Data), A ; this.randomSeed := A
    CALL Direct_Class_Cave_Method_get_level_indexed_value_to_A_and_add_5_to_HL_Code ; this.get_level_indexed_value_to_A_and_add_5_to_HL( HL, C )
    LD (Class_Cave_DirectProperty_open_counter_Shift_5_Size_1_Data), A ; this.open_counter := A
    CALL Direct_Class_Cave_Method_get_level_indexed_value_to_A_and_add_5_to_HL_Code ; this.get_level_indexed_value_to_A_and_add_5_to_HL( HL, C )
    LD (Class_Cave_DirectProperty_time_Shift_8_Size_1_Data), A ; this.time := A
    INC HL
    INC HL
    INC HL
    INC HL
    INC HL
    LD (Class_Cave_DirectProperty_randomObjects_Shift_1_Size_2_Data), HL ; this.randomObjects := HL
    INC HL
    INC HL
    INC HL
    INC HL
    LD (Class_Cave_DirectProperty_randomObjectProb_Shift_3_Size_2_Data), HL ; this.randomObjectProb := HL
    INC HL
    INC HL
    INC HL
    INC HL
  RET ; }

  Direct_Class_Cave_Method_init_show_Code: ; public init_show( A ) {
    LD (Class_Cave_DirectProperty__cave_index0_Shift_17_Size_1_Data), A ; this._cave_index0 := A
    LD A, 0 ; this._pos_x := 0
    LD (Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data), A ; this._pos_x := 0
    LD A, 0 ; this._pos_y := 0
    LD (Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data), A ; this._pos_y := 0
    LD A, SHADOW_LINE_LENGTH ; this._width := SHADOW_LINE_LENGTH
    LD (Class_Cave_DirectProperty__width_Shift_11_Size_1_Data), A ; this._width := SHADOW_LINE_LENGTH
    LD A, 22 ; this._height := 22
    LD (Class_Cave_DirectProperty__height_Shift_12_Size_1_Data), A ; this._height := 22
    LD A, OBJECT_SPACE ; this._object_index := OBJECT_SPACE
    LD (Class_Cave_DirectProperty__object_index_Shift_15_Size_1_Data), A ; this._object_index := OBJECT_SPACE
    CALL Direct_Class_Cave_Method_drawFill_Code ; this.drawFill()
    LD A, (Class_Cave_DirectProperty__cave_index0_Shift_17_Size_1_Data) ; A := this._cave_index0
    CALL Direct_Class_Cave_Method_load_cave_into_puffer_Code ; this.load_cave_into_puffer( A )
    CALL Direct_Class_ScreenShadow_Method_firstRandomLoadFromPuffer_Code ; SCREEN_SHADOW.firstRandomLoadFromPuffer()
    CALL Direct_Class_Cave_Method_init_collections_Code ; this.init_collections()
  RET ; }

  Direct_Class_Cave_Method_init_collections_Code: ; private init_collections() {
    LD A, (Class_Cave_DirectProperty__magicWallMillingTime_and_amoebaSlowGrowthTime_Shift_20_Size_1_Data) ; AMOEBAS.init( this._magicWallMillingTime_and_amoebaSlowGrowthTime )
    CALL Direct_Class_Amoebas_Method_init_Code ; AMOEBAS.init( this._magicWallMillingTime_and_amoebaSlowGrowthTime )
    LD A, (Class_Cave_DirectProperty__magicWallMillingTime_and_amoebaSlowGrowthTime_Shift_20_Size_1_Data) ; MAGICKANIM.init( this._magicWallMillingTime_and_amoebaSlowGrowthTime )
    CALL Direct_Class_MagickAnim_Method_init_Code ; MAGICKANIM.init( this._magicWallMillingTime_and_amoebaSlowGrowthTime )
    CALL Direct_Class_GravityStone_Method_init_Code ; STONEGRAVITY.init()
    CALL Direct_Class_GravityDiamond_Method_init_Code ; DIAMONDGRAVITY.init()
    CALL Direct_Class_Butterflies_Method_init_Code ; BUTTERFLIES.init()
    CALL Direct_Class_Fireflies_Method_init_Code ; FIREFLIES.init()
    LD A, 0 ; this._pos_x := 0
    LD (Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data), A ; this._pos_x := 0
    LD A, 1 ; this._pos_y := 1
    LD (Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data), A ; this._pos_y := 1
    Class_Cave_Until_15_Begin: ; Until begin : {
      CALL Direct_Class_Cave_Method_get_pos_puffer_addr_to_HL_Code ; this.get_pos_puffer_addr_to_HL()
      LD A, (HL)
      ; Begin if 
        Class_Cave_IfBranch_195_Begin: ; if ( A == OBJECT_DIAMOND1_CHAR ) {
          CP OBJECT_DIAMOND1_CHAR ; if ( A == OBJECT_DIAMOND1_CHAR ) {
          JP NZ, Class_Cave_IfBranch_196_Begin ; if ( A == OBJECT_DIAMOND1_CHAR ) {
          CALL Direct_Class_GravityDiamond_Method_append_Code ; DIAMONDGRAVITY.append( HL )
          JR Class_Cave_IfBranch_201_End ; if ( A == OBJECT_DIAMOND1_CHAR ) {
        Class_Cave_IfBranch_196_Begin: ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
          CP OBJECT_BUTTERFLY1_CHAR ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
          JP NZ, Class_Cave_IfBranch_197_Begin ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
          CALL Direct_Class_Butterflies_Method_append_Code ; BUTTERFLIES.append( HL )
          JR Class_Cave_IfBranch_201_End ; } else if ( A == OBJECT_BUTTERFLY1_CHAR ) {
        Class_Cave_IfBranch_197_Begin: ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
          CP OBJECT_FIREFLY1_CHAR ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
          JP NZ, Class_Cave_IfBranch_198_Begin ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
          CALL Direct_Class_Fireflies_Method_append_Code ; FIREFLIES.append( HL )
          JR Class_Cave_IfBranch_201_End ; } else if ( A == OBJECT_FIREFLY1_CHAR ) {
        Class_Cave_IfBranch_198_Begin: ; } else if ( A == OBJECT_MAGICK_WALL1_CHAR ) {
          CP OBJECT_MAGICK_WALL1_CHAR ; } else if ( A == OBJECT_MAGICK_WALL1_CHAR ) {
          JP NZ, Class_Cave_IfBranch_199_Begin ; } else if ( A == OBJECT_MAGICK_WALL1_CHAR ) {
          CALL Direct_Class_MagickAnim_Method_append_Code ; MAGICKANIM.append( HL )
          JR Class_Cave_IfBranch_201_End ; } else if ( A == OBJECT_MAGICK_WALL1_CHAR ) {
        Class_Cave_IfBranch_199_Begin: ; } else if ( A == OBJECT_AMOEBA_CHAR ) {
          CP OBJECT_AMOEBA_CHAR ; } else if ( A == OBJECT_AMOEBA_CHAR ) {
          JP NZ, Class_Cave_IfBranch_200_Begin ; } else if ( A == OBJECT_AMOEBA_CHAR ) {
          CALL Direct_Class_Amoebas_Method_append_Code ; AMOEBAS.append()
          JR Class_Cave_IfBranch_201_End ; } else if ( A == OBJECT_AMOEBA_CHAR ) {
        Class_Cave_IfBranch_200_Begin: ; } else if ( A == OBJECT_STONE_CHAR ) {
          CP OBJECT_STONE_CHAR ; } else if ( A == OBJECT_STONE_CHAR ) {
          JP NZ, Class_Cave_IfBranch_201_Begin ; } else if ( A == OBJECT_STONE_CHAR ) {
          CALL Direct_Class_GravityStone_Method_append_Code ; STONEGRAVITY.append( HL )
          JR Class_Cave_IfBranch_201_End ; } else if ( A == OBJECT_STONE_CHAR ) {
        Class_Cave_IfBranch_201_Begin: ; } else if ( A == OBJECT_PLAYER_CHAR ) {
          CP OBJECT_PLAYER_CHAR ; } else if ( A == OBJECT_PLAYER_CHAR ) {
          JP NZ, Class_Cave_IfBranch_201_End ; } else if ( A == OBJECT_PLAYER_CHAR ) {
          CALL Direct_Class_Player_Method_init_Code ; PLAYER.init( HL )
        Class_Cave_IfBranch_201_End: ; }
      ; End full if
      CALL Direct_Class_Cave_Method_inc_pos_left_Z_Code ; this.inc_pos_left_Z()
    JP NZ, Class_Cave_Until_15_Begin ; {
  RET ; }

  Direct_Class_Cave_Method_check_open_door_Code: ; public check_open_door( A ) {
    LD B, A
    LD A, (Class_Cave_DirectProperty_open_counter_Shift_5_Size_1_Data) ; A := this.open_counter
    ; Begin if 
      Class_Cave_IfBranch_202_Begin: ; if ( A == B ) {
        CP B ; if ( A == B ) {
        JP NZ, Class_Cave_IfBranch_202_End ; if ( A == B ) {
        LD HL, (Class_Cave_DirectProperty__door_puffer_pointer_Shift_18_Size_2_Data) ; HL := this._door_puffer_pointer
        LD (HL), OBJECT_OPENED_DOOR_CHAR
        LD A, (Class_Cave_DirectProperty_extra_diamond_point_Shift_7_Size_1_Data) ; this.diamond_point := this.extra_diamond_point
        LD (Class_Cave_DirectProperty_diamond_point_Shift_6_Size_1_Data), A ; this.diamond_point := this.extra_diamond_point
        LD A, (Class_Cave_DirectProperty_diamond_point_Shift_6_Size_1_Data) ; STATUS.set_new_scorePerDiamond( this.diamond_point )
        LD C, A ; STATUS.set_new_scorePerDiamond( this.diamond_point )
        CALL Direct_Class_Status_Method_set_new_scorePerDiamond_Code ; STATUS.set_new_scorePerDiamond( this.diamond_point )
        CALL Direct_Class_Status_Method_hide_diamond_limit_Code ; STATUS.hide_diamond_limit()
        CALL Direct_Class_Sounds_Method_open_door_Code ; SOUNDS.open_door()
      Class_Cave_IfBranch_202_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Cave_Method_load_cave_into_puffer_Code: ; private load_cave_into_puffer( A ) {
    CALL Direct_Class_Cave_Method_search_start_addr_to_HL_Code ; this.search_start_addr_to_HL( A )
    CALL Direct_Class_Cave_Method_load_cave_header_data_HL_Code ; this.load_cave_header_data_HL( HL )
    PUSH HL
    CALL Direct_Class_Cave_Method_drawRandomObjects_Code ; this.drawRandomObjects()
    LD A, 0 ; this._pos_x := 0
    LD (Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data), A ; this._pos_x := 0
    LD A, 0 ; this._pos_y := 0
    LD (Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data), A ; this._pos_y := 0
    LD A, SHADOW_LINE_LENGTH ; this._width := SHADOW_LINE_LENGTH
    LD (Class_Cave_DirectProperty__width_Shift_11_Size_1_Data), A ; this._width := SHADOW_LINE_LENGTH
    LD A, 22 ; this._height := 22
    LD (Class_Cave_DirectProperty__height_Shift_12_Size_1_Data), A ; this._height := 22
    LD A, OBJECT_STEEL ; this._object_index := OBJECT_STEEL
    LD (Class_Cave_DirectProperty__object_index_Shift_15_Size_1_Data), A ; this._object_index := OBJECT_STEEL
    CALL Direct_Class_Cave_Method_drawRect_Code ; this.drawRect()
    POP HL
    LD A, (HL)
    Class_Cave_Until_16_Begin: ; Until begin : {
      LD C, A
      AND 0x3F
      LD (Class_Cave_DirectProperty__object_index_Shift_15_Size_1_Data), A ; this._object_index := A
      LD A, C
      AND 0xC0
      LD C, A
      INC HL
      LD A, (HL) ; this._pos_x := (HL)
      LD (Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data), A ; this._pos_x := (HL)
      INC HL
      LD A, (HL)
      DEC A
      DEC A
      LD (Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data), A ; this._pos_y := A
      INC HL
      LD A, C
      ; Begin if 
        Class_Cave_IfBranch_203_Begin: ; if ( A == 0x00 ) {
          CP 0x00 ; if ( A == 0x00 ) {
          JP NZ, Class_Cave_IfBranch_204_Begin ; if ( A == 0x00 ) {
          CALL Direct_Class_Cave_Method_drawSingleObject_Code ; this.drawSingleObject()
          JR Class_Cave_IfBranch_206_End ; if ( A == 0x00 ) {
        Class_Cave_IfBranch_204_Begin: ; } else if ( A == 0x40 ) {
          CP 0x40 ; } else if ( A == 0x40 ) {
          JP NZ, Class_Cave_IfBranch_205_Begin ; } else if ( A == 0x40 ) {
          LD A, (HL) ; this._length := (HL)
          LD (Class_Cave_DirectProperty__length_Shift_13_Size_1_Data), A ; this._length := (HL)
          INC HL
          LD A, (HL) ; this._dir := (HL)
          LD (Class_Cave_DirectProperty__dir_Shift_14_Size_1_Data), A ; this._dir := (HL)
          INC HL
          CALL Direct_Class_Cave_Method_drawLine_Code ; this.drawLine()
          JR Class_Cave_IfBranch_206_End ; } else if ( A == 0x40 ) {
        Class_Cave_IfBranch_205_Begin: ; } else if ( A == 0x80 ) {
          CP 0x80 ; } else if ( A == 0x80 ) {
          JP NZ, Class_Cave_IfBranch_206_Begin ; } else if ( A == 0x80 ) {
          LD A, (HL) ; this._width := (HL)
          LD (Class_Cave_DirectProperty__width_Shift_11_Size_1_Data), A ; this._width := (HL)
          INC HL
          LD A, (HL) ; this._height := (HL)
          LD (Class_Cave_DirectProperty__height_Shift_12_Size_1_Data), A ; this._height := (HL)
          INC HL
          LD A, (HL) ; this._fill_index := (HL)
          LD (Class_Cave_DirectProperty__fill_index_Shift_16_Size_1_Data), A ; this._fill_index := (HL)
          INC HL
          CALL Direct_Class_Cave_Method_drawFilledRect_Code ; this.drawFilledRect()
          JR Class_Cave_IfBranch_206_End ; } else if ( A == 0x80 ) {
        Class_Cave_IfBranch_206_Begin: ; } else {
          LD A, (HL) ; this._width := (HL)
          LD (Class_Cave_DirectProperty__width_Shift_11_Size_1_Data), A ; this._width := (HL)
          INC HL
          LD A, (HL) ; this._height := (HL)
          LD (Class_Cave_DirectProperty__height_Shift_12_Size_1_Data), A ; this._height := (HL)
          INC HL
          CALL Direct_Class_Cave_Method_drawRect_Code ; this.drawRect()
        Class_Cave_IfBranch_206_End: ; }
      ; End full if
      LD A, ( HL )
    CP 0xFF ; {
    JP NZ, Class_Cave_Until_16_Begin ; {
  RET ; }

  Direct_Class_Cave_Method_drawLine_Code: ; private drawLine() {
    PUSH HL
    LD A, (Class_Cave_DirectProperty__length_Shift_13_Size_1_Data) ; A := this._length
    LD B, A ; for B = A to 1 {
    Class_Cave_ForB_17_Begin:
      CALL Direct_Class_Cave_Method_drawSingleObject_Code ; this.drawSingleObject()
      LD A, B
      ; Begin if 
        Class_Cave_IfBranch_207_Begin: ; if ( A >= 2 ) {
          CP 2 ; if ( A >= 2 ) {
          JP M, Class_Cave_IfBranch_207_End ; if ( A >= 2 ) {
          LD A, (Class_Cave_DirectProperty__dir_Shift_14_Size_1_Data) ; A := this._dir
          ; Begin if 
            Class_Cave_IfBranch_208_Begin: ; if ( A == DIR_UP ) {
              CP DIR_UP ; if ( A == DIR_UP ) {
              JP NZ, Class_Cave_IfBranch_209_Begin ; if ( A == DIR_UP ) {
              LD HL, Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data ; DEC this._pos_y
              DEC (HL) ; DEC this._pos_y
              JR Class_Cave_IfBranch_215_End ; if ( A == DIR_UP ) {
            Class_Cave_IfBranch_209_Begin: ; } else if ( A == DIR_UPRIGHT ) {
              CP DIR_UPRIGHT ; } else if ( A == DIR_UPRIGHT ) {
              JP NZ, Class_Cave_IfBranch_210_Begin ; } else if ( A == DIR_UPRIGHT ) {
              LD HL, Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data ; INC this._pos_x
              INC (HL) ; INC this._pos_x
              LD HL, Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data ; DEC this._pos_y
              DEC (HL) ; DEC this._pos_y
              JR Class_Cave_IfBranch_215_End ; } else if ( A == DIR_UPRIGHT ) {
            Class_Cave_IfBranch_210_Begin: ; } else if ( A == DIR_RIGHT ) {
              CP DIR_RIGHT ; } else if ( A == DIR_RIGHT ) {
              JP NZ, Class_Cave_IfBranch_211_Begin ; } else if ( A == DIR_RIGHT ) {
              LD HL, Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data ; INC this._pos_x
              INC (HL) ; INC this._pos_x
              JR Class_Cave_IfBranch_215_End ; } else if ( A == DIR_RIGHT ) {
            Class_Cave_IfBranch_211_Begin: ; } else if ( A == DIR_DOWNRIGHT ) {
              CP DIR_DOWNRIGHT ; } else if ( A == DIR_DOWNRIGHT ) {
              JP NZ, Class_Cave_IfBranch_212_Begin ; } else if ( A == DIR_DOWNRIGHT ) {
              LD HL, Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data ; INC this._pos_x
              INC (HL) ; INC this._pos_x
              LD HL, Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data ; INC this._pos_y
              INC (HL) ; INC this._pos_y
              JR Class_Cave_IfBranch_215_End ; } else if ( A == DIR_DOWNRIGHT ) {
            Class_Cave_IfBranch_212_Begin: ; } else if ( A == DIR_DOWN ) {
              CP DIR_DOWN ; } else if ( A == DIR_DOWN ) {
              JP NZ, Class_Cave_IfBranch_213_Begin ; } else if ( A == DIR_DOWN ) {
              LD HL, Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data ; INC this._pos_y
              INC (HL) ; INC this._pos_y
              JR Class_Cave_IfBranch_215_End ; } else if ( A == DIR_DOWN ) {
            Class_Cave_IfBranch_213_Begin: ; } else if ( A == DIR_DOWNLEFT ) {
              CP DIR_DOWNLEFT ; } else if ( A == DIR_DOWNLEFT ) {
              JP NZ, Class_Cave_IfBranch_214_Begin ; } else if ( A == DIR_DOWNLEFT ) {
              LD HL, Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data ; DEC this._pos_x
              DEC (HL) ; DEC this._pos_x
              LD HL, Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data ; INC this._pos_y
              INC (HL) ; INC this._pos_y
              JR Class_Cave_IfBranch_215_End ; } else if ( A == DIR_DOWNLEFT ) {
            Class_Cave_IfBranch_214_Begin: ; } else if ( A == DIR_LEFT ) {
              CP DIR_LEFT ; } else if ( A == DIR_LEFT ) {
              JP NZ, Class_Cave_IfBranch_215_Begin ; } else if ( A == DIR_LEFT ) {
              LD HL, Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data ; DEC this._pos_x
              DEC (HL) ; DEC this._pos_x
              JR Class_Cave_IfBranch_215_End ; } else if ( A == DIR_LEFT ) {
            Class_Cave_IfBranch_215_Begin: ; } else {
              LD HL, Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data ; DEC this._pos_x
              DEC (HL) ; DEC this._pos_x
              LD HL, Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data ; DEC this._pos_y
              DEC (HL) ; DEC this._pos_y
            Class_Cave_IfBranch_215_End: ; }
          ; End full if
        Class_Cave_IfBranch_207_End: ; }
      ; End full if
    DJNZ Class_Cave_ForB_17_Begin
    POP HL
  RET ; }

  Direct_Class_Cave_Method_drawRect_Code: ; private drawRect() {
    PUSH HL
    LD A, (Class_Cave_DirectProperty__width_Shift_11_Size_1_Data) ; this._length := this._width
    LD (Class_Cave_DirectProperty__length_Shift_13_Size_1_Data), A ; this._length := this._width
    LD A, DIR_RIGHT ; this._dir := DIR_RIGHT
    LD (Class_Cave_DirectProperty__dir_Shift_14_Size_1_Data), A ; this._dir := DIR_RIGHT
    CALL Direct_Class_Cave_Method_drawLine_Code ; this.drawLine()
    LD A, (Class_Cave_DirectProperty__height_Shift_12_Size_1_Data) ; this._length := this._height
    LD (Class_Cave_DirectProperty__length_Shift_13_Size_1_Data), A ; this._length := this._height
    LD A, DIR_DOWN ; this._dir := DIR_DOWN
    LD (Class_Cave_DirectProperty__dir_Shift_14_Size_1_Data), A ; this._dir := DIR_DOWN
    CALL Direct_Class_Cave_Method_drawLine_Code ; this.drawLine()
    LD A, (Class_Cave_DirectProperty__width_Shift_11_Size_1_Data) ; this._length := this._width
    LD (Class_Cave_DirectProperty__length_Shift_13_Size_1_Data), A ; this._length := this._width
    LD A, DIR_LEFT ; this._dir := DIR_LEFT
    LD (Class_Cave_DirectProperty__dir_Shift_14_Size_1_Data), A ; this._dir := DIR_LEFT
    CALL Direct_Class_Cave_Method_drawLine_Code ; this.drawLine()
    LD A, (Class_Cave_DirectProperty__height_Shift_12_Size_1_Data) ; this._length := this._height
    LD (Class_Cave_DirectProperty__length_Shift_13_Size_1_Data), A ; this._length := this._height
    LD A, DIR_UP ; this._dir := DIR_UP
    LD (Class_Cave_DirectProperty__dir_Shift_14_Size_1_Data), A ; this._dir := DIR_UP
    CALL Direct_Class_Cave_Method_drawLine_Code ; this.drawLine()
    POP HL
  RET ; }

  Direct_Class_Cave_Method_drawFilledRect_Code: ; private drawFilledRect() {
    PUSH HL
    CALL Direct_Class_Cave_Method_drawRect_Code ; this.drawRect()
    LD HL, Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data ; INC this._pos_x
    INC (HL) ; INC this._pos_x
    LD HL, Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data ; INC this._pos_y
    INC (HL) ; INC this._pos_y
    LD HL, Class_Cave_DirectProperty__width_Shift_11_Size_1_Data ; DEC this._width
    DEC (HL) ; DEC this._width
    LD HL, Class_Cave_DirectProperty__height_Shift_12_Size_1_Data ; DEC this._height
    DEC (HL) ; DEC this._height
    LD HL, Class_Cave_DirectProperty__width_Shift_11_Size_1_Data ; DEC this._width
    DEC (HL) ; DEC this._width
    LD HL, Class_Cave_DirectProperty__height_Shift_12_Size_1_Data ; DEC this._height
    DEC (HL) ; DEC this._height
    LD A, (Class_Cave_DirectProperty__fill_index_Shift_16_Size_1_Data) ; this._object_index := this._fill_index
    LD (Class_Cave_DirectProperty__object_index_Shift_15_Size_1_Data), A ; this._object_index := this._fill_index
    CALL Direct_Class_Cave_Method_drawFill_Code ; this.drawFill()
    POP HL
  RET ; }

  Direct_Class_Cave_Method_drawFill_Code: ; private drawFill() {
    PUSH HL
    LD A, (Class_Cave_DirectProperty__height_Shift_12_Size_1_Data) ; B := this._height
    LD B, A ; B := this._height
    LD A, (Class_Cave_DirectProperty__width_Shift_11_Size_1_Data) ; this._length := this._width
    LD (Class_Cave_DirectProperty__length_Shift_13_Size_1_Data), A ; this._length := this._width
    LD A, DIR_RIGHT ; this._dir := DIR_RIGHT
    LD (Class_Cave_DirectProperty__dir_Shift_14_Size_1_Data), A ; this._dir := DIR_RIGHT
    LD B, B ; for B = B to 1 {
    Class_Cave_ForB_18_Begin:
      PUSH BC
      CALL Direct_Class_Cave_Method_drawLine_Code ; this.drawLine()
      LD HL, Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data ; INC this._pos_y
      INC (HL) ; INC this._pos_y
      LD A, (Class_Cave_DirectProperty__dir_Shift_14_Size_1_Data) ; A := this._dir
      ; Begin if 
        Class_Cave_IfBranch_216_Begin: ; if ( A == DIR_LEFT ) {
          CP DIR_LEFT ; if ( A == DIR_LEFT ) {
          JP NZ, Class_Cave_IfBranch_217_Begin ; if ( A == DIR_LEFT ) {
          LD A, DIR_RIGHT ; this._dir := DIR_RIGHT
          LD (Class_Cave_DirectProperty__dir_Shift_14_Size_1_Data), A ; this._dir := DIR_RIGHT
          JR Class_Cave_IfBranch_217_End ; if ( A == DIR_LEFT ) {
        Class_Cave_IfBranch_217_Begin: ; } else {
          LD A, DIR_LEFT ; this._dir := DIR_LEFT
          LD (Class_Cave_DirectProperty__dir_Shift_14_Size_1_Data), A ; this._dir := DIR_LEFT
        Class_Cave_IfBranch_217_End: ; }
      ; End full if
      POP BC
    DJNZ Class_Cave_ForB_18_Begin
    POP HL
  RET ; }

  Direct_Class_Cave_Method_search_start_addr_to_HL_Code: ; private search_start_addr_to_HL( A )  {
    LD DE, 0x20
    LD HL, LEVELS
    Class_Cave_While_13_Begin: ; while ( A >= 1 ) {
      CP 1 ; while ( A >= 1 ) {
      JP M, Class_Cave_While_14_End ; while ( A >= 1 ) {
      ADD HL, DE
      EX AF, AF'
      Class_Cave_Until_17_Begin: ; Until begin : {
        LD A, (HL)
        INC HL
      CP 0xFF ; {
      JP NZ, Class_Cave_Until_17_Begin ; {
      EX AF, AF'
      DEC A
    JR Class_Cave_While_13_Begin ; } 
    Class_Cave_While_14_End:
  RET ; }

  Direct_Class_Cave_Method_drawRandomObjects_Code: ; private drawRandomObjects() {
    LD A, (Class_Cave_DirectProperty_randomSeed_Shift_0_Size_1_Data) ; A := this.randomSeed
    LD B, A
    LD A, 0 ; RND.init( 0, B )
    CALL Direct_Class_Random_Method_init_Code ; RND.init( 0, B )
    LD A, 0 ; this._pos_x := 0
    LD (Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data), A ; this._pos_x := 0
    LD A, 1 ; this._pos_y := 1
    LD (Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data), A ; this._pos_y := 1
    Class_Cave_Until_18_Begin: ; Until begin : {
      LD A, OBJECT_DIRT ; this._object_index := OBJECT_DIRT
      LD (Class_Cave_DirectProperty__object_index_Shift_15_Size_1_Data), A ; this._object_index := OBJECT_DIRT
      CALL Direct_Class_Random_Method_get_next_value_to_A_Code ; RND.get_next_value_to_A()
      LD C, A
      LD HL, (Class_Cave_DirectProperty_randomObjectProb_Shift_3_Size_2_Data) ; HL := this.randomObjectProb
      EXX
      LD HL, (Class_Cave_DirectProperty_randomObjects_Shift_1_Size_2_Data) ; HL := this.randomObjects
      EXX
      LD B, randomObjects_length ; for B = randomObjects_length to 1 {
      Class_Cave_ForB_19_Begin:
        LD A, C
        CP (HL)
        ; Begin if 
          Class_Cave_IfBranch_218_Begin: ; if ( CY ) {
            JP NC, Class_Cave_IfBranch_218_End ; if ( CY ) {
            EXX
            LD A, (HL) ; this._object_index := (HL)
            LD (Class_Cave_DirectProperty__object_index_Shift_15_Size_1_Data), A ; this._object_index := (HL)
            EXX
          Class_Cave_IfBranch_218_End: ; }
        ; End full if
        INC HL
        EXX
        INC HL
        EXX
      DJNZ Class_Cave_ForB_19_Begin
      CALL Direct_Class_Cave_Method_drawSingleObject_Code ; this.drawSingleObject()
      CALL Direct_Class_Cave_Method_inc_pos_left_Z_Code ; this.inc_pos_left_Z()
    JP NZ, Class_Cave_Until_18_Begin ; {
  RET ; }

  Direct_Class_Cave_Method_inc_pos_left_Z_Code: ; private inc_pos_left_Z() {
    LD A, (Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data) ; A := this._pos_x
    INC A
    ; Begin if 
      Class_Cave_IfBranch_219_Begin: ; if ( A < SHADOW_LINE_LENGTH ) {
        CP SHADOW_LINE_LENGTH ; if ( A < SHADOW_LINE_LENGTH ) {
        JP P, Class_Cave_IfBranch_220_Begin ; if ( A < SHADOW_LINE_LENGTH ) {
        LD (Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data), A ; this._pos_x := A
        JR Class_Cave_IfBranch_220_End ; if ( A < SHADOW_LINE_LENGTH ) {
      Class_Cave_IfBranch_220_Begin: ; } else {
        LD A, 0 ; this._pos_x := 0
        LD (Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data), A ; this._pos_x := 0
        LD A, (Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data) ; A := this._pos_y
        INC A
        ; Begin if 
          Class_Cave_IfBranch_221_Begin: ; if ( A < 21 ) {
            CP 21 ; if ( A < 21 ) {
            JP P, Class_Cave_IfBranch_222_Begin ; if ( A < 21 ) {
            LD (Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data), A ; this._pos_y := A
            LD A, 0
            CP 1
            JR Class_Cave_IfBranch_222_End ; if ( A < 21 ) {
          Class_Cave_IfBranch_222_Begin: ; } else {
            CP A
          Class_Cave_IfBranch_222_End: ; }
        ; End full if
      Class_Cave_IfBranch_220_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Cave_Method_invalidChar_Code: ; private invalidChar() {
    LD A, (Class_Cave_DirectProperty__object_index_Shift_15_Size_1_Data) ; A := this._object_index
    HALT
  RET ; }

  Direct_Class_Cave_Method_drawSingleObject_Code: ; private drawSingleObject() {
    PUSH HL
    CALL Direct_Class_Cave_Method_get_pos_puffer_addr_to_HL_Code ; this.get_pos_puffer_addr_to_HL()
    LD A, (Class_Cave_DirectProperty__object_index_Shift_15_Size_1_Data) ; A := this._object_index
    ; Begin if 
      Class_Cave_IfBranch_223_Begin: ; IF ( A == OBJECT_SPACE ) {
        CP OBJECT_SPACE ; IF ( A == OBJECT_SPACE ) {
        JP NZ, Class_Cave_IfBranch_224_Begin ; IF ( A == OBJECT_SPACE ) {
        LD A, OBJECT_SPACE_CHAR
        JP Class_Cave_IfBranch_238_End ; IF ( A == OBJECT_SPACE ) {
      Class_Cave_IfBranch_224_Begin: ; } else if ( A == OBJECT_DIRT2 ) {
        CP OBJECT_DIRT2 ; } else if ( A == OBJECT_DIRT2 ) {
        JP NZ, Class_Cave_IfBranch_225_Begin ; } else if ( A == OBJECT_DIRT2 ) {
        LD A, OBJECT_DIRT_CHAR
        JP Class_Cave_IfBranch_238_End ; } else if ( A == OBJECT_DIRT2 ) {
      Class_Cave_IfBranch_225_Begin: ; } else if ( A == OBJECT_BRICK ) {
        CP OBJECT_BRICK ; } else if ( A == OBJECT_BRICK ) {
        JP NZ, Class_Cave_IfBranch_226_Begin ; } else if ( A == OBJECT_BRICK ) {
        LD A, OBJECT_WALL_CHAR
        JP Class_Cave_IfBranch_238_End ; } else if ( A == OBJECT_BRICK ) {
      Class_Cave_IfBranch_226_Begin: ; } else if ( A == OBJECT_MAGIC ) {
        CP OBJECT_MAGIC ; } else if ( A == OBJECT_MAGIC ) {
        JP NZ, Class_Cave_IfBranch_227_Begin ; } else if ( A == OBJECT_MAGIC ) {
        LD A, OBJECT_MAGICK_WALL1_CHAR
        JP Class_Cave_IfBranch_238_End ; } else if ( A == OBJECT_MAGIC ) {
      Class_Cave_IfBranch_227_Begin: ; } else if ( A == OBJECT_EXIT ) {
        CP OBJECT_EXIT ; } else if ( A == OBJECT_EXIT ) {
        JP NZ, Class_Cave_IfBranch_228_Begin ; } else if ( A == OBJECT_EXIT ) {
        PUSH HL
        CALL Direct_Class_Cave_Method_get_pos_puffer_addr_to_HL_Code ; this.get_pos_puffer_addr_to_HL()
        LD (Class_Cave_DirectProperty__door_puffer_pointer_Shift_18_Size_2_Data), HL ; this._door_puffer_pointer := HL
        POP HL
        LD A, OBJECT_STEEL_CHAR
        JP Class_Cave_IfBranch_238_End ; } else if ( A == OBJECT_EXIT ) {
      Class_Cave_IfBranch_228_Begin: ; } else if ( A == OBJECT_DIRT_BLUE ) {
        CP OBJECT_DIRT_BLUE ; } else if ( A == OBJECT_DIRT_BLUE ) {
        JP NZ, Class_Cave_IfBranch_229_Begin ; } else if ( A == OBJECT_DIRT_BLUE ) {
        LD A, OBJECT_DIRT_CHAR
        JP Class_Cave_IfBranch_238_End ; } else if ( A == OBJECT_DIRT_BLUE ) {
      Class_Cave_IfBranch_229_Begin: ; } else if ( A == OBJECT_STEEL ) {
        CP OBJECT_STEEL ; } else if ( A == OBJECT_STEEL ) {
        JP NZ, Class_Cave_IfBranch_230_Begin ; } else if ( A == OBJECT_STEEL ) {
        LD A, OBJECT_STEEL_CHAR
        JP Class_Cave_IfBranch_238_End ; } else if ( A == OBJECT_STEEL ) {
      Class_Cave_IfBranch_230_Begin: ; } else if ( A == OBJECT_FIREFLY ) {
        CP OBJECT_FIREFLY ; } else if ( A == OBJECT_FIREFLY ) {
        JP NZ, Class_Cave_IfBranch_231_Begin ; } else if ( A == OBJECT_FIREFLY ) {
        LD A, OBJECT_FIREFLY1_CHAR
        JP Class_Cave_IfBranch_238_End ; } else if ( A == OBJECT_FIREFLY ) {
      Class_Cave_IfBranch_231_Begin: ; } else if ( A == OBJECT_BOULDER ) {
        CP OBJECT_BOULDER ; } else if ( A == OBJECT_BOULDER ) {
        JP NZ, Class_Cave_IfBranch_232_Begin ; } else if ( A == OBJECT_BOULDER ) {
        LD A, OBJECT_STONE_CHAR
        JP Class_Cave_IfBranch_238_End ; } else if ( A == OBJECT_BOULDER ) {
      Class_Cave_IfBranch_232_Begin: ; } else if ( A == OBJECT_DIAMOND ) {
        CP OBJECT_DIAMOND ; } else if ( A == OBJECT_DIAMOND ) {
        JP NZ, Class_Cave_IfBranch_233_Begin ; } else if ( A == OBJECT_DIAMOND ) {
        LD A, OBJECT_DIAMOND1_CHAR
        JP Class_Cave_IfBranch_238_End ; } else if ( A == OBJECT_DIAMOND ) {
      Class_Cave_IfBranch_233_Begin: ; } else if ( A == OBJECT_DIRT ) {
        CP OBJECT_DIRT ; } else if ( A == OBJECT_DIRT ) {
        JP NZ, Class_Cave_IfBranch_234_Begin ; } else if ( A == OBJECT_DIRT ) {
        LD A, OBJECT_DIRT_CHAR
        JP Class_Cave_IfBranch_238_End ; } else if ( A == OBJECT_DIRT ) {
      Class_Cave_IfBranch_234_Begin: ; } else if ( A == OBJECT_PLAYER ) {
        CP OBJECT_PLAYER ; } else if ( A == OBJECT_PLAYER ) {
        JP NZ, Class_Cave_IfBranch_235_Begin ; } else if ( A == OBJECT_PLAYER ) {
        LD A, OBJECT_PLAYER_CHAR
        JP Class_Cave_IfBranch_238_End ; } else if ( A == OBJECT_PLAYER ) {
      Class_Cave_IfBranch_235_Begin: ; } else if ( A == OBJECT_BUTTERFLY ) {
        CP OBJECT_BUTTERFLY ; } else if ( A == OBJECT_BUTTERFLY ) {
        JP NZ, Class_Cave_IfBranch_236_Begin ; } else if ( A == OBJECT_BUTTERFLY ) {
        LD A, OBJECT_BUTTERFLY1_CHAR
        JP Class_Cave_IfBranch_238_End ; } else if ( A == OBJECT_BUTTERFLY ) {
      Class_Cave_IfBranch_236_Begin: ; } else if ( A == OBJECT_BUTTERFLY2 ) {
        CP OBJECT_BUTTERFLY2 ; } else if ( A == OBJECT_BUTTERFLY2 ) {
        JP NZ, Class_Cave_IfBranch_237_Begin ; } else if ( A == OBJECT_BUTTERFLY2 ) {
        LD A, OBJECT_BUTTERFLY1_CHAR
        JP Class_Cave_IfBranch_238_End ; } else if ( A == OBJECT_BUTTERFLY2 ) {
      Class_Cave_IfBranch_237_Begin: ; } else if ( A == OBJECT_AMOEBA ) {
        CP OBJECT_AMOEBA ; } else if ( A == OBJECT_AMOEBA ) {
        JP NZ, Class_Cave_IfBranch_238_Begin ; } else if ( A == OBJECT_AMOEBA ) {
        LD A, OBJECT_AMOEBA_CHAR
        JP Class_Cave_IfBranch_238_End ; } else if ( A == OBJECT_AMOEBA ) {
      Class_Cave_IfBranch_238_Begin: ; } else {
        CALL Direct_Class_Cave_Method_invalidChar_Code ; this.invalidChar()
      Class_Cave_IfBranch_238_End: ; }
    ; End full if
    LD (HL), A
    POP HL
  RET ; }

  Direct_Class_Cave_Method_get_pos_puffer_addr_to_HL_Code: ; private get_pos_puffer_addr_to_HL() {
    LD HL, CAVE_PUFFER
    PUSH BC
    PUSH DE
    LD D, 0
    LD A, (Class_Cave_DirectProperty__pos_x_Shift_9_Size_1_Data) ; E := this._pos_x
    LD E, A ; E := this._pos_x
    ADD HL, DE
    LD DE, SHADOW_LINE_LENGTH
    LD A, (Class_Cave_DirectProperty__pos_y_Shift_10_Size_1_Data) ; A := this._pos_y
    ; Begin if 
      Class_Cave_IfBranch_239_Begin: ; if ( A >= 1 ) {
        CP 1 ; if ( A >= 1 ) {
        JP M, Class_Cave_IfBranch_239_End ; if ( A >= 1 ) {
        LD B, A ; for B = A to 1 {
        Class_Cave_ForB_20_Begin:
          ADD HL, DE
        DJNZ Class_Cave_ForB_20_Begin
      Class_Cave_IfBranch_239_End: ; }
    ; End full if
    POP DE
    POP BC
  RET ; }
; } ; End class Cave

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class BCD1 extends PropertiesIX {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_BCD1_IndexedIXProperty_b1_Shift_0_Size_1_Data: EQU 0 ; DB b1

  Multi_Class_BCD1_Method_constructor_Code: ; constructor( C ) {
    CALL Multi_Class_BCD1_Method_set_new_value_Code ; this.set_new_value( C )
  RET ; }

  Multi_Class_BCD1_Method_set_new_value_Code: ; public set_new_value( C ) {
    LD (IX+Class_BCD1_IndexedIXProperty_b1_Shift_0_Size_1_Data), 0 ; this.b1 := 0
    LD A, C
    Class_BCD1_While_15_Begin: ; while ( A != 0 ) {
      CP 0 ; while ( A != 0 ) {
      JP Z, Class_BCD1_While_16_End ; while ( A != 0 ) {
      PUSH BC
      CALL Multi_Class_BCD1_Method_inc_Code ; this.inc()
      POP BC
      DEC C
      LD A, C
    JR Class_BCD1_While_15_Begin ; } 
    Class_BCD1_While_16_End:
  RET ; }

  Multi_Class_BCD1_Method_get_value_to_A_Code: ; public get_value_to_A() {
    LD A, (IX+Class_BCD1_IndexedIXProperty_b1_Shift_0_Size_1_Data) ; A := this.b1
    PUSH BC
    LD C, A
    AND 0xF0
    SRL A
    LD B, A
    SRL A
    SRL A
    ADD A, B
    LD B, A
    LD A, C
    AND 0x0F
    ADD A, B
    POP BC
  RET ; }

  Multi_Class_BCD1_Method_inc_Code: ; public inc() {
    LD C, (IX+Class_BCD1_IndexedIXProperty_b1_Shift_0_Size_1_Data) ; C := this.b1
    LD A, 1
    ADD A, C
    DAA
    LD (IX+Class_BCD1_IndexedIXProperty_b1_Shift_0_Size_1_Data), A ; this.b1 := A
  RET ; }

  Multi_Class_BCD1_Method_dec_Code: ; public dec() {
    LD C, 1
    LD A, (IX+Class_BCD1_IndexedIXProperty_b1_Shift_0_Size_1_Data) ; A := this.b1
    SUB C
    DAA
    LD (IX+Class_BCD1_IndexedIXProperty_b1_Shift_0_Size_1_Data), A ; this.b1 := A
  RET ; }

  Multi_Class_BCD1_Method_print_Code: ; public print( HL ) {
    LD A, (IX+Class_BCD1_IndexedIXProperty_b1_Shift_0_Size_1_Data) ; this.print_byte( HL, this.b1 )
    CALL Multi_Class_BCD1_Method_print_byte_Code ; this.print_byte( HL, this.b1 )
  RET ; }
  BCD_TEMP_BYTE: DB 0

  Multi_Class_BCD1_Method_print_byte_Code: ; protected print_byte( HL, A ) {
    TEVE:
    PUSH HL
    LD HL, BCD_TEMP_BYTE
    LD (HL), A
    LD A, 48
    RLD
    EX (SP), HL
    LD (HL), A
    INC HL
    EX (SP), HL
    RLD
    EX (SP), HL
    LD (HL), A
    INC HL
    EX (SP), HL
    POP HL
  RET ; }

  Multi_Class_BCD1_Method_print1_byte_Code: ; protected print1_byte( HL, A ) {
    PUSH HL
    LD HL, BCD_TEMP_BYTE
    LD (HL), A
    LD A, 48
    RLD
    EX (SP), HL
    ; Begin if 
      Class_BCD1_IfBranch_240_Begin: ; if ( A == '0' ) {
        CP '0' ; if ( A == '0' ) {
        JP NZ, Class_BCD1_IfBranch_241_Begin ; if ( A == '0' ) {
        LD (HL), OBJECT_SPACE_CHAR
        JR Class_BCD1_IfBranch_241_End ; if ( A == '0' ) {
      Class_BCD1_IfBranch_241_Begin: ; } else {
        LD (HL), A
      Class_BCD1_IfBranch_241_End: ; }
    ; End full if
    INC HL
    EX (SP), HL
    RLD
    EX (SP), HL
    LD (HL), A
    INC HL
    EX (SP), HL
    POP HL
  RET ; }

  Multi_Class_BCD1_Method_get_val1_A_Code: ; public get_val1_A() {
    LD A, (IX+Class_BCD1_IndexedIXProperty_b1_Shift_0_Size_1_Data) ; A := this.b1
  RET ; }

  Multi_Class_BCD1_Method_set_val1_Code: ; public set_val1( A ) {
    LD (IX+Class_BCD1_IndexedIXProperty_b1_Shift_0_Size_1_Data), A ; this.b1 := A
  RET ; }
; } ; End class BCD1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class BCD2 extends BCD1 {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_BCD2_IndexedIXProperty_b2_Shift_1_Size_1_Data: EQU 1 ; DB b2
  Class_BCD2_IndexedIXProperty_dec_val_Shift_2_Size_1_Data: EQU 2 ; DB dec_val

  Multi_Class_BCD2_Method_constructor_Code: ; constructor( B ) {
    LD (IX+Class_BCD1_IndexedIXProperty_b1_Shift_0_Size_1_Data), 0 ; this.b1 := 0
    LD (IX+Class_BCD2_IndexedIXProperty_b2_Shift_1_Size_1_Data), 0 ; this.b2 := 0
    LD (IX+Class_BCD2_IndexedIXProperty_dec_val_Shift_2_Size_1_Data), 0 ; this.dec_val := 0
    LD A, B
    CP 0
    Class_BCD2_While_17_Begin: ; while ( NZ ) {
      JP Z, Class_BCD2_While_18_End ; while ( NZ ) {
      PUSH BC
      CALL Multi_Class_BCD2_Method_inc_Code ; this.inc()
      POP BC
      DEC B
      LD A, B
      CP 0
    JR Class_BCD2_While_17_Begin ; } 
    Class_BCD2_While_18_End:
  RET ; }

  Multi_Class_BCD2_Method_inc_Code: ; public inc() {
    inc (IX+Class_BCD2_IndexedIXProperty_dec_val_Shift_2_Size_1_Data) ; inc this.dec_val
    CALL Multi_Class_BCD1_Method_inc_Code ; parent.inc()
    RET NC
    LD C, (IX+Class_BCD2_IndexedIXProperty_b2_Shift_1_Size_1_Data) ; C := this.b2
    LD A, 1
    ADD A, C
    DAA
    LD (IX+Class_BCD2_IndexedIXProperty_b2_Shift_1_Size_1_Data), A ; this.b2 := A
  RET ; }

  Multi_Class_BCD2_Method_dec_Code: ; public dec() {
    dec (IX+Class_BCD2_IndexedIXProperty_dec_val_Shift_2_Size_1_Data) ; dec this.dec_val
    CALL Multi_Class_BCD1_Method_dec_Code ; parent.dec()
    RET NC
    LD A, (IX+Class_BCD2_IndexedIXProperty_b2_Shift_1_Size_1_Data) ; A := this.b2
    SUB C
    DAA
    LD (IX+Class_BCD2_IndexedIXProperty_b2_Shift_1_Size_1_Data), A ; this.b2 := A
  RET ; }

  Multi_Class_BCD2_Method_get_dec_val_to_A_Code: ; public get_dec_val_to_A() {
    LD A, (IX+Class_BCD2_IndexedIXProperty_dec_val_Shift_2_Size_1_Data) ; A := this.dec_val
  RET ; }

  Multi_Class_BCD2_Method_cp0_Code: ; public cp0() {
    LD B, (IX+Class_BCD1_IndexedIXProperty_b1_Shift_0_Size_1_Data) ; B := this.b1
    LD A, (IX+Class_BCD2_IndexedIXProperty_b2_Shift_1_Size_1_Data) ; A := this.b2
    OR B
  RET ; }

  Multi_Class_BCD2_Method_cp_Code: ; public cp( A ) {
    LD B, A
    LD A, (IX+Class_BCD2_IndexedIXProperty_b2_Shift_1_Size_1_Data) ; A := this.b2
    CP 0
    RET NZ
    LD A, (IX+Class_BCD1_IndexedIXProperty_b1_Shift_0_Size_1_Data) ; A := this.b1
    CP B
  RET ; }

  Multi_Class_BCD2_Method_print_Code: ; public print( HL ) {
    LD A, (IX+Class_BCD2_IndexedIXProperty_b2_Shift_1_Size_1_Data) ; this.print_byte( HL, this.b2 )
    CALL Multi_Class_BCD1_Method_print_byte_Code ; this.print_byte( HL, this.b2 )
    CALL Multi_Class_BCD1_Method_print_Code ; parent.print( HL )
  RET ; }

  Multi_Class_BCD2_Method_print1_Code: ; public print1( HL ) {
    LD A, (IX+Class_BCD2_IndexedIXProperty_b2_Shift_1_Size_1_Data) ; this.print1_byte( HL, this.b2 )
    CALL Multi_Class_BCD1_Method_print1_byte_Code ; this.print1_byte( HL, this.b2 )
    CALL Multi_Class_BCD1_Method_print_Code ; parent.print( HL )
  RET ; }

  Multi_Class_BCD2_Method_get_val2_A_Code: ; public get_val2_A() {
    LD A, (IX+Class_BCD2_IndexedIXProperty_b2_Shift_1_Size_1_Data) ; A := this.b2
  RET ; }

  Multi_Class_BCD2_Method_set_val2_Code: ; public set_val2( A ) {
    LD (IX+Class_BCD2_IndexedIXProperty_b2_Shift_1_Size_1_Data), A ; this.b2 := A
  RET ; }
; } ; End class BCD2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class BCD3 extends BCD2 {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_BCD3_IndexedIXProperty_b3_Shift_3_Size_1_Data: EQU 3 ; DB b3

  Multi_Class_BCD3_Method_constructor_Code: ; constructor( BC ) {
    LD (IX+Class_BCD1_IndexedIXProperty_b1_Shift_0_Size_1_Data), 0 ; this.b1 := 0
    LD (IX+Class_BCD2_IndexedIXProperty_b2_Shift_1_Size_1_Data), 0 ; this.b2 := 0
    LD (IX+Class_BCD3_IndexedIXProperty_b3_Shift_3_Size_1_Data), 0 ; this.b3 := 0
    LD A, B
    OR C
    Class_BCD3_While_19_Begin: ; while ( NZ ) {
      JP Z, Class_BCD3_While_20_End ; while ( NZ ) {
      PUSH BC
      CALL Multi_Class_BCD3_Method_inc_Code ; this.inc()
      POP BC
      DEC BC
      LD A, B
      OR C
    JR Class_BCD3_While_19_Begin ; } 
    Class_BCD3_While_20_End:
  RET ; }

  Multi_Class_BCD3_Method_inc_Code: ; public inc() {
    CALL Multi_Class_BCD2_Method_inc_Code ; parent.inc()
    RET NC
    LD C, (IX+Class_BCD3_IndexedIXProperty_b3_Shift_3_Size_1_Data) ; C := this.b3
    LD A, 1
    ADD A, C
    DAA
    LD (IX+Class_BCD3_IndexedIXProperty_b3_Shift_3_Size_1_Data), A ; this.b3 := A
  RET ; }

  Multi_Class_BCD3_Method_dec_Code: ; public dec() {
    CALL Multi_Class_BCD2_Method_dec_Code ; parent.dec()
    RET NC
    LD A, (IX+Class_BCD3_IndexedIXProperty_b3_Shift_3_Size_1_Data) ; A := this.b3
    SUB C
    DAA
    LD (IX+Class_BCD3_IndexedIXProperty_b3_Shift_3_Size_1_Data), A ; this.b3 := A
  RET ; }

  Multi_Class_BCD3_Method_print_Code: ; public print( HL ) {
    LD A, (IX+Class_BCD3_IndexedIXProperty_b3_Shift_3_Size_1_Data) ; this.print_byte( HL, this.b3 )
    CALL Multi_Class_BCD1_Method_print_byte_Code ; this.print_byte( HL, this.b3 )
    CALL Multi_Class_BCD2_Method_print_Code ; parent.print( HL )
  RET ; }

  Multi_Class_BCD3_Method_get_val3_A_Code: ; public get_val3_A() {
    LD A, (IX+Class_BCD3_IndexedIXProperty_b3_Shift_3_Size_1_Data) ; A := this.b3
  RET ; }

  Multi_Class_BCD3_Method_set_val3_Code: ; public set_val3( A ) {
    LD (IX+Class_BCD3_IndexedIXProperty_b3_Shift_3_Size_1_Data), A ; this.b3 := A
  RET ; }
; } ; End class BCD3

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Game extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_Game_DirectProperty_cave_Shift_0_Size_1_Data: DB 0 ; DB cave
  Class_Game_DirectProperty_level_Shift_1_Size_1_Data: DB 0 ; DB level
  Class_Game_DirectProperty_live_counter_Shift_2_Size_1_Data: DB 0 ; DB live_counter
  Class_Game_DirectProperty_diamond_sum_counter_Shift_3_Size_1_Data: DB 0 ; DB diamond_sum_counter
  Class_Game_DirectProperty_points_Shift_4_Size_2_Data: DW 0 ; DW points
  Class_Game_DirectProperty_high_score_Shift_6_Size_2_Data: DW 0 ; DW high_score

  Direct_Class_Game_Method_init_Code: ; public init() {
    LD IX, Object_TempObject1_in_Class_BCD3_Data ; this.high_score := new BCD3( START_HIGHSCORE )
    LD BC, START_HIGHSCORE ; direct asm value ; this.high_score := new BCD3( START_HIGHSCORE )
    CALL Multi_Class_BCD3_Method_constructor_Code ; this.high_score := new BCD3( START_HIGHSCORE )
    LD HL, Object_TempObject1_in_Class_BCD3_Data ; this.high_score := new BCD3( START_HIGHSCORE )
    LD (Class_Game_DirectProperty_high_score_Shift_6_Size_2_Data), HL ; this.high_score := new BCD3( START_HIGHSCORE )
  RET ; }

  Direct_Class_Game_Method_show_high_score_to_Code: ; public show_high_score_to( HL ) {
    LD IX, Object_TempObject1_in_Class_BCD3_Data ; this.high_score.print( HL )
    CALL Multi_Class_BCD3_Method_print_Code ; this.high_score.print( HL )
  RET ; }

  Direct_Class_Game_Method_init_new_game_Z_Code: ; public init_new_game_Z() {
    LD IX, Object_TempObject2_in_Class_BCD3_Data ; this.points := new BCD3( 0 )
    LD BC, 0 ; direct asm value ; this.points := new BCD3( 0 )
    CALL Multi_Class_BCD3_Method_constructor_Code ; this.points := new BCD3( 0 )
    LD HL, Object_TempObject2_in_Class_BCD3_Data ; this.points := new BCD3( 0 )
    LD (Class_Game_DirectProperty_points_Shift_4_Size_2_Data), HL ; this.points := new BCD3( 0 )
    LD A, (CAVE_POS)
    SUB 'A'
    LD (Class_Game_DirectProperty_cave_Shift_0_Size_1_Data), A ; this.cave := A
    LD A, (LEVEL_POS)
    SUB '0'
    LD (Class_Game_DirectProperty_level_Shift_1_Size_1_Data), A ; this.level := A
    LD A, 0 ; this.diamond_sum_counter := 0
    LD (Class_Game_DirectProperty_diamond_sum_counter_Shift_3_Size_1_Data), A ; this.diamond_sum_counter := 0
    LD A, 3 ; this.live_counter := 3
    LD (Class_Game_DirectProperty_live_counter_Shift_2_Size_1_Data), A ; this.live_counter := 3
    CALL Direct_Class_Game_Method_init_level_Code ; this.init_level()
    XOR A
    INC A
  RET ; }

  Direct_Class_Game_Method_save_if_new_highscore_Code: ; public save_if_new_highscore() {
    LD IX, Object_TempObject1_in_Class_BCD3_Data ; this.high_score.get_val3_A()
    CALL Multi_Class_BCD3_Method_get_val3_A_Code ; this.high_score.get_val3_A()
    LD B, A
    LD IX, Object_TempObject2_in_Class_BCD3_Data ; this.points.get_val3_A()
    CALL Multi_Class_BCD3_Method_get_val3_A_Code ; this.points.get_val3_A()
    CP B
    RET C
    ; Begin if 
      Class_Game_IfBranch_242_Begin: ; if ( Z ) {
        JP NZ, Class_Game_IfBranch_247_Begin ; if ( Z ) {
        LD IX, Object_TempObject1_in_Class_BCD3_Data ; this.high_score.get_val2_A()
        CALL Multi_Class_BCD2_Method_get_val2_A_Code ; this.high_score.get_val2_A()
        LD B, A
        LD IX, Object_TempObject2_in_Class_BCD3_Data ; this.points.get_val2_A()
        CALL Multi_Class_BCD2_Method_get_val2_A_Code ; this.points.get_val2_A()
        CP B
        RET C
        ; Begin if 
          Class_Game_IfBranch_243_Begin: ; if ( Z ) {
            JP NZ, Class_Game_IfBranch_246_Begin ; if ( Z ) {
            LD IX, Object_TempObject1_in_Class_BCD3_Data ; this.high_score.get_val1_A()
            CALL Multi_Class_BCD1_Method_get_val1_A_Code ; this.high_score.get_val1_A()
            LD B, A
            LD IX, Object_TempObject2_in_Class_BCD3_Data ; this.points.get_val1_A()
            CALL Multi_Class_BCD1_Method_get_val1_A_Code ; this.points.get_val1_A()
            CP B
            RET C
            ; Begin if 
              Class_Game_IfBranch_244_Begin: ; if ( Z ) {
                JP NZ, Class_Game_IfBranch_245_Begin ; if ( Z ) {
                JR Class_Game_IfBranch_245_End ; if ( Z ) {
              Class_Game_IfBranch_245_Begin: ; } else {
                LD IX, Object_TempObject1_in_Class_BCD3_Data ; this.high_score.set_val1( A )
                CALL Multi_Class_BCD1_Method_set_val1_Code ; this.high_score.set_val1( A )
              Class_Game_IfBranch_245_End: ; }
            ; End full if
            JR Class_Game_IfBranch_246_End ; if ( Z ) {
          Class_Game_IfBranch_246_Begin: ; } else {
            LD IX, Object_TempObject1_in_Class_BCD3_Data ; this.high_score.set_val2( A )
            CALL Multi_Class_BCD2_Method_set_val2_Code ; this.high_score.set_val2( A )
            LD IX, Object_TempObject2_in_Class_BCD3_Data ; this.points.get_val1_A()
            CALL Multi_Class_BCD1_Method_get_val1_A_Code ; this.points.get_val1_A()
            LD IX, Object_TempObject1_in_Class_BCD3_Data ; this.high_score.set_val1( A )
            CALL Multi_Class_BCD1_Method_set_val1_Code ; this.high_score.set_val1( A )
          Class_Game_IfBranch_246_End: ; }
        ; End full if
        JR Class_Game_IfBranch_247_End ; if ( Z ) {
      Class_Game_IfBranch_247_Begin: ; } else {
        LD IX, Object_TempObject1_in_Class_BCD3_Data ; this.high_score.set_val3( A )
        CALL Multi_Class_BCD3_Method_set_val3_Code ; this.high_score.set_val3( A )
        LD IX, Object_TempObject2_in_Class_BCD3_Data ; this.points.get_val2_A()
        CALL Multi_Class_BCD2_Method_get_val2_A_Code ; this.points.get_val2_A()
        LD IX, Object_TempObject1_in_Class_BCD3_Data ; this.high_score.set_val2( A )
        CALL Multi_Class_BCD2_Method_set_val2_Code ; this.high_score.set_val2( A )
        LD IX, Object_TempObject2_in_Class_BCD3_Data ; this.points.get_val1_A()
        CALL Multi_Class_BCD1_Method_get_val1_A_Code ; this.points.get_val1_A()
        LD IX, Object_TempObject1_in_Class_BCD3_Data ; this.high_score.set_val1( A )
        CALL Multi_Class_BCD1_Method_set_val1_Code ; this.high_score.set_val1( A )
      Class_Game_IfBranch_247_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Game_Method_init_level_Code: ; private init_level() {
    LD A, BG_CHAR ; SCREEN.fill( BG_CHAR, 64*32-1 )
    LD BC, 64*32-1 ; direct asm value ; SCREEN.fill( BG_CHAR, 64*32-1 )
    CALL Direct_Class_Screen_Method_fill_Code ; SCREEN.fill( BG_CHAR, 64*32-1 )
    LD A, OBJECT_SPACE_CHAR ; SCREEN.fill( OBJECT_SPACE_CHAR, 64*1-1 )
    LD BC, 64*1-1 ; direct asm value ; SCREEN.fill( OBJECT_SPACE_CHAR, 64*1-1 )
    CALL Direct_Class_Screen_Method_fill_Code ; SCREEN.fill( OBJECT_SPACE_CHAR, 64*1-1 )
    LD A, (Class_Game_DirectProperty_cave_Shift_0_Size_1_Data) ; Cave.init_show( this.cave )
    CALL Direct_Class_Cave_Method_init_show_Code ; Cave.init_show( this.cave )
    CALL Direct_Class_Status_Method_init_Code ; STATUS.init()
  RET ; }

  Direct_Class_Game_Method_inc_diamond_sum_counter_Code: ; public inc_diamond_sum_counter() {
    LD A, (Class_Game_DirectProperty_diamond_sum_counter_Shift_3_Size_1_Data) ; A := this.diamond_sum_counter
    INC A
    ; Begin if 
      Class_Game_IfBranch_248_Begin: ; if ( NZ ) {
        JP Z, Class_Game_IfBranch_248_End ; if ( NZ ) {
        LD (Class_Game_DirectProperty_diamond_sum_counter_Shift_3_Size_1_Data), A ; this.diamond_sum_counter := A
        ; Begin if 
          Class_Game_IfBranch_249_Begin: ; if ( A == 14 ) {
            CP 14 ; if ( A == 14 ) {
            JP NZ, Class_Game_IfBranch_250_Begin ; if ( A == 14 ) {
            CALL Direct_Class_Game_Method_inc_live_Code ; this.inc_live()
            JR Class_Game_IfBranch_252_End ; if ( A == 14 ) {
          Class_Game_IfBranch_250_Begin: ; } else if ( A == 38 ) {
            CP 38 ; } else if ( A == 38 ) {
            JP NZ, Class_Game_IfBranch_251_Begin ; } else if ( A == 38 ) {
            CALL Direct_Class_Game_Method_inc_live_Code ; this.inc_live()
            JR Class_Game_IfBranch_252_End ; } else if ( A == 38 ) {
          Class_Game_IfBranch_251_Begin: ; } else if ( A == 120 ) {
            CP 120 ; } else if ( A == 120 ) {
            JP NZ, Class_Game_IfBranch_252_Begin ; } else if ( A == 120 ) {
            CALL Direct_Class_Game_Method_inc_live_Code ; this.inc_live()
            JR Class_Game_IfBranch_252_End ; } else if ( A == 120 ) {
          Class_Game_IfBranch_252_Begin: ; } else if ( A == 200 ) {
            CP 200 ; } else if ( A == 200 ) {
            JP NZ, Class_Game_IfBranch_252_End ; } else if ( A == 200 ) {
            CALL Direct_Class_Game_Method_inc_live_Code ; this.inc_live()
          Class_Game_IfBranch_252_End: ; }
        ; End full if
      Class_Game_IfBranch_248_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Game_Method_inc_live_Code: ; private inc_live() {
    LD HL, Class_Game_DirectProperty_live_counter_Shift_2_Size_1_Data ; INC this.live_counter
    INC (HL) ; INC this.live_counter
    CALL Direct_Class_Status_Method_show_player_lives_Code ; STATUS.show_player_lives()
    CALL Direct_Class_Sounds_Method_extra_life_Code ; SOUNDS.extra_life()
  RET ; }

  Direct_Class_Game_Method_init_next_cave_Z_Code: ; public init_next_cave_Z() {
    LD A, (Class_Game_DirectProperty_live_counter_Shift_2_Size_1_Data) ; A := this.live_counter
    ; Begin if 
      Class_Game_IfBranch_253_Begin: ; if ( A != 0 ) {
        CP 0 ; if ( A != 0 ) {
        JP Z, Class_Game_IfBranch_253_End ; if ( A != 0 ) {
        CALL Direct_Class_Game_Method_init_level_Code ; this.init_level()
        OR 1
      Class_Game_IfBranch_253_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Game_Method_tick_Z_Code: ; public tick_Z() {
    LD A, (Class_Player_DirectProperty_in_game_Shift_2_Size_1_Data) ; A := PLAYER.in_game
    ; Begin if 
      Class_Game_IfBranch_254_Begin: ; if ( A != 0 ) {
        CP 0 ; if ( A != 0 ) {
        JP Z, Class_Game_IfBranch_254_End ; if ( A != 0 ) {
        CALL Direct_Class_Player_Method_check_speed_NZ_Code ; PLAYER.check_speed_NZ()
        CALL NZ, Direct_Class_Controller_Method_get_direction_to_A_Z_Code ; CONTROLLER.get_direction_to_A_Z() if ( NZ )
        CALL NZ, Direct_Class_Player_Method_move_player_Code ; PLAYER.move_player( A ) if ( NZ )
        CALL Direct_Class_Butterflies_Method_tick_Code ; BUTTERFLIES.tick()
        CALL Direct_Class_Fireflies_Method_tick_Code ; FIREFLIES.tick()
        CALL Direct_Class_GravityStone_Method_tick_Code ; STONEGRAVITY.tick()
        CALL Direct_Class_GravityDiamond_Method_tick_Code ; DIAMONDGRAVITY.tick()
        CALL Direct_Class_Amoebas_Method_tick_Code ; AMOEBAS.tick()
        CALL Direct_Class_Status_Method_timer_tick_Code ; STATUS.timer_tick()
        OR 1
      Class_Game_IfBranch_254_End: ; }
    ; End full if
  RET ; }
; } ; End class Game

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; class Status extends PropertiesDirect {
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  Class_Status_DirectProperty_diamonds_Shift_0_Size_2_Data: DW 0 ; DW diamonds
  Class_Status_DirectProperty_need_d_Shift_2_Size_2_Data: DW 0 ; DW need_d
  Class_Status_DirectProperty_scorePerDiamond_Shift_4_Size_2_Data: DW 0 ; DW scorePerDiamond
  Class_Status_DirectProperty_timer_Shift_6_Size_2_Data: DW 0 ; DW timer
  Class_Status_DirectProperty_ticks_Shift_8_Size_1_Data: DB 0 ; DB ticks

  Direct_Class_Status_Method_hide_diamond_limit_Code: ; public hide_diamond_limit() {
    LD A, OBJECT_DIAMOND1_CHAR
    LD (Status_Need_D_Cache_Addr), A
    LD (Status_Need_D_Cache_Addr+1), A
  RET ; }

  Direct_Class_Status_Method_init_Code: ; public init() {
    LD IX, Object_TempObject3_in_Class_BCD1_Data ; this.diamonds := new BCD1( 0 )
    LD C, 0 ; this.diamonds := new BCD1( 0 )
    CALL Multi_Class_BCD1_Method_constructor_Code ; this.diamonds := new BCD1( 0 )
    LD HL, Object_TempObject3_in_Class_BCD1_Data ; this.diamonds := new BCD1( 0 )
    LD (Class_Status_DirectProperty_diamonds_Shift_0_Size_2_Data), HL ; this.diamonds := new BCD1( 0 )
    LD IX, Object_TempObject4_in_Class_BCD1_Data ; this.need_d := new BCD1( Cave.open_counter )
    LD A, (Class_Cave_DirectProperty_open_counter_Shift_5_Size_1_Data) ; this.need_d := new BCD1( Cave.open_counter )
    LD C, A ; this.need_d := new BCD1( Cave.open_counter )
    CALL Multi_Class_BCD1_Method_constructor_Code ; this.need_d := new BCD1( Cave.open_counter )
    LD HL, Object_TempObject4_in_Class_BCD1_Data ; this.need_d := new BCD1( Cave.open_counter )
    LD (Class_Status_DirectProperty_need_d_Shift_2_Size_2_Data), HL ; this.need_d := new BCD1( Cave.open_counter )
    LD IX, Object_TempObject5_in_Class_BCD1_Data ; this.scorePerDiamond := new BCD1( Cave.diamond_point )
    LD A, (Class_Cave_DirectProperty_diamond_point_Shift_6_Size_1_Data) ; this.scorePerDiamond := new BCD1( Cave.diamond_point )
    LD C, A ; this.scorePerDiamond := new BCD1( Cave.diamond_point )
    CALL Multi_Class_BCD1_Method_constructor_Code ; this.scorePerDiamond := new BCD1( Cave.diamond_point )
    LD HL, Object_TempObject5_in_Class_BCD1_Data ; this.scorePerDiamond := new BCD1( Cave.diamond_point )
    LD (Class_Status_DirectProperty_scorePerDiamond_Shift_4_Size_2_Data), HL ; this.scorePerDiamond := new BCD1( Cave.diamond_point )
    LD IX, Object_TempObject5_in_Class_BCD1_Data ; this.scorePerDiamond.print( Status_DiamondPoint_Cache_Addr )
    LD HL, Status_DiamondPoint_Cache_Addr ; direct asm value ; this.scorePerDiamond.print( Status_DiamondPoint_Cache_Addr )
    CALL Multi_Class_BCD1_Method_print_Code ; this.scorePerDiamond.print( Status_DiamondPoint_Cache_Addr )
    LD IX, Object_TempObject6_in_Class_BCD2_Data ; this.timer := new BCD2( Cave.time )
    LD A, (Class_Cave_DirectProperty_time_Shift_8_Size_1_Data) ; this.timer := new BCD2( Cave.time )
    LD B, A ; this.timer := new BCD2( Cave.time )
    CALL Multi_Class_BCD2_Method_constructor_Code ; this.timer := new BCD2( Cave.time )
    LD HL, Object_TempObject6_in_Class_BCD2_Data ; this.timer := new BCD2( Cave.time )
    LD (Class_Status_DirectProperty_timer_Shift_6_Size_2_Data), HL ; this.timer := new BCD2( Cave.time )
    LD IX, Object_TempObject6_in_Class_BCD2_Data ; this.timer.print1( Status_Timer_Cache_Addr )
    LD HL, Status_Timer_Cache_Addr ; direct asm value ; this.timer.print1( Status_Timer_Cache_Addr )
    CALL Multi_Class_BCD2_Method_print1_Code ; this.timer.print1( Status_Timer_Cache_Addr )
    LD A, MAX_TIMER_TICK ; this.ticks := MAX_TIMER_TICK
    LD (Class_Status_DirectProperty_ticks_Shift_8_Size_1_Data), A ; this.ticks := MAX_TIMER_TICK
    CALL Direct_Class_Status_Method_clearStatusLineBg_Code ; this.clearStatusLineBg()
    CALL Direct_Class_Status_Method_clearRightDataWindows_Code ; this.clearRightDataWindows()
    CALL Direct_Class_Status_Method_show_player_lives_Code ; this.show_player_lives()
    CALL Direct_Class_Status_Method_show_cave_Code ; this.show_cave()
    CALL Direct_Class_Status_Method_show_level_Code ; this.show_level()
    CALL Direct_Class_Info_Method_show_qhelp_Code ; INFO.show_qhelp()
    CALL Direct_Class_Status_Method_show_high_score_Code ; this.show_high_score()
    LD IX, Object_TempObject2_in_Class_BCD3_Data ; GAME.points.print( Status_Points_Cache_Addr )
    LD HL, Status_Points_Cache_Addr ; direct asm value ; GAME.points.print( Status_Points_Cache_Addr )
    CALL Multi_Class_BCD3_Method_print_Code ; GAME.points.print( Status_Points_Cache_Addr )
    LD IX, Object_TempObject3_in_Class_BCD1_Data ; this.diamonds.print( Status_DC_Cache_Addr )
    LD HL, Status_DC_Cache_Addr ; direct asm value ; this.diamonds.print( Status_DC_Cache_Addr )
    CALL Multi_Class_BCD1_Method_print_Code ; this.diamonds.print( Status_DC_Cache_Addr )
    LD IX, Object_TempObject4_in_Class_BCD1_Data ; this.need_d.print( Status_Need_D_Cache_Addr )
    LD HL, Status_Need_D_Cache_Addr ; direct asm value ; this.need_d.print( Status_Need_D_Cache_Addr )
    CALL Multi_Class_BCD1_Method_print_Code ; this.need_d.print( Status_Need_D_Cache_Addr )
  RET ; }

  Direct_Class_Status_Method_wait_Code: ; public wait() {
    CALL Direct_Class_ScreenShadow_Method_refresh_screen_Code ; SCREEN_SHADOW.refresh_screen()
    CALL Direct_Class_ScreenShadow_Method_refresh_screen_Code ; SCREEN_SHADOW.refresh_screen()
    LD DE, String_constant_23_Data ; this.show_message0( "Press FIRE to continue ...@", MESSAGE_LINE2_CENTER_ADDRESS )
    LD HL, MESSAGE_LINE2_CENTER_ADDRESS ; direct asm value ; this.show_message0( "Press FIRE to continue ...@", MESSAGE_LINE2_CENTER_ADDRESS )
    CALL Direct_Class_Status_Method_show_message0_Code ; this.show_message0( "Press FIRE to continue ...@", MESSAGE_LINE2_CENTER_ADDRESS )
    Class_Status_Until_19_Begin: ; Until begin : {
      LD A,(KEYBOARD_SpaceCr_ADDR)
      AND NOTHING_PRESSED
    CP NOTHING_PRESSED ; {
    JP Z, Class_Status_Until_19_Begin ; {
  RET ; }

  Direct_Class_Status_Method_clearStatusLineBg_Code: ; private clearStatusLineBg() {
    LD HL, Status_LeftTop2Addr
    LD (HL), 142
    INC HL
    LD (HL), 146
    LD BC, 50
    LD DE, Status_LeftTop2Addr+2
    LDIR
    LD (HL), 143
    LD HL, Status_LeftTop2Addr+39
    LD (HL), 190
    LD HL, Status_LeftTopAddr
    LD (HL), 147
    LD HL, Status_LeftTopAddr+39
    LD (HL), 147
  RET ; }

  Direct_Class_Status_Method_clearRightDataWindows_Code: ; private clearRightDataWindows() {
    LD HL, Status_HighScoreText_Addr-64 ; direct asm value ; this.clearRightRow( Status_HighScoreText_Addr-64, 143 )
    LD A, 143 ; this.clearRightRow( Status_HighScoreText_Addr-64, 143 )
    CALL Direct_Class_Status_Method_clearRightRow_Code ; this.clearRightRow( Status_HighScoreText_Addr-64, 143 )
    CALL Direct_Class_Status_Method_clearNextLine_Code ; this.clearNextLine( HL )
    LD HL, CAVE_START_ADDR-64 ; direct asm value ; this.clearRightRow( CAVE_START_ADDR-64, 159 )
    LD A, 159 ; this.clearRightRow( CAVE_START_ADDR-64, 159 )
    CALL Direct_Class_Status_Method_clearRightRow_Code ; this.clearRightRow( CAVE_START_ADDR-64, 159 )
    CALL Direct_Class_Status_Method_clearNextLine_Code ; this.clearNextLine( HL )
    LD HL, LEVEL_START_ADDR-64 ; direct asm value ; this.clearRightRow( LEVEL_START_ADDR-64, 159 )
    LD A, 159 ; this.clearRightRow( LEVEL_START_ADDR-64, 159 )
    CALL Direct_Class_Status_Method_clearRightRow_Code ; this.clearRightRow( LEVEL_START_ADDR-64, 159 )
    CALL Direct_Class_Status_Method_clearNextLine_Code ; this.clearNextLine( HL )
    LD HL, LEVEL_START_ADDR+64 ; direct asm value ; this.clearRightRow( LEVEL_START_ADDR+64, 145 )
    LD A, 145 ; this.clearRightRow( LEVEL_START_ADDR+64, 145 )
    CALL Direct_Class_Status_Method_clearRightRow_Code ; this.clearRightRow( LEVEL_START_ADDR+64, 145 )
  RET ; }

  Direct_Class_Status_Method_clearRightRow_Code: ; private clearRightRow( HL, A ) {
    LD (HL), 146
    PUSH HL
    POP DE
    PUSH HL
    INC DE
    LD BC, 11
    LDIR
    LD (HL), A
    POP HL
  RET ; }

  Direct_Class_Status_Method_clearNextLine_Code: ; private clearNextLine( HL ) {
    LD DE, 64
    ADD HL, DE
    PUSH HL
    POP DE
    INC DE
    LD BC, 11
    LD (HL), OBJECT_SPACE_CHAR
    LDIR
    LD (HL), 147
  RET ; }

  Direct_Class_Status_Method_show_message_Code: ; public show_message( DE ) {
    PUSH HL
    LD HL, MESSAGE_LINE1_CENTER_ADDRESS ; direct asm value ; this.show_message0( DE, MESSAGE_LINE1_CENTER_ADDRESS )
    CALL Direct_Class_Status_Method_show_message0_Code ; this.show_message0( DE, MESSAGE_LINE1_CENTER_ADDRESS )
    POP HL
  RET ; }

  Direct_Class_Status_Method_show_message0_Code: ; public show_message0( DE, HL ) {
    PUSH BC
    PUSH DE
    LD BC, 0
    LD A, (DE)
    Class_Status_While_21_Begin: ; while( A != '@' ) {
      CP '@' ; while( A != '@' ) {
      JP Z, Class_Status_While_22_End ; while( A != '@' ) {
      INC BC
      INC DE
      LD A, (DE)
      ; Begin if 
        Class_Status_IfBranch_255_Begin: ; if ( A != '@' ) {
          CP '@' ; if ( A != '@' ) {
          JP Z, Class_Status_IfBranch_255_End ; if ( A != '@' ) {
          DEC HL
          INC BC
          INC DE
          LD A, (DE)
        Class_Status_IfBranch_255_End: ; }
      ; End full if
    JR Class_Status_While_21_Begin ; } 
    Class_Status_While_22_End:
    POP DE
    DEC HL
    LD (HL), 32
    PUSH HL
    PUSH BC
    INC HL
    EX DE, HL
    LDIR
    LD A, 32
    LD (DE), A
    POP BC
    POP HL
    LD DE, 64
    ADD HL, DE
    LD (HL), 32
    PUSH HL
    POP DE
    INC DE
    INC BC
    LDIR
    POP BC
  RET ; }

  Direct_Class_Status_Method_set_new_scorePerDiamond_Code: ; public set_new_scorePerDiamond( C ) {
    LD IX, Object_TempObject5_in_Class_BCD1_Data ; this.scorePerDiamond.set_new_value( C )
    CALL Multi_Class_BCD1_Method_set_new_value_Code ; this.scorePerDiamond.set_new_value( C )
    LD IX, Object_TempObject5_in_Class_BCD1_Data ; this.scorePerDiamond.print( Status_DiamondPoint_Cache_Addr )
    LD HL, Status_DiamondPoint_Cache_Addr ; direct asm value ; this.scorePerDiamond.print( Status_DiamondPoint_Cache_Addr )
    CALL Multi_Class_BCD1_Method_print_Code ; this.scorePerDiamond.print( Status_DiamondPoint_Cache_Addr )
  RET ; }

  Direct_Class_Status_Method_timer_tick_Code: ; public timer_tick() {
    LD A, (Class_Player_DirectProperty_in_flash_Shift_5_Size_1_Data) ; A := PLAYER.in_flash
    ; Begin if 
      Class_Status_IfBranch_256_Begin: ; if ( A == 0 ) {
        CP 0 ; if ( A == 0 ) {
        JP NZ, Class_Status_IfBranch_256_End ; if ( A == 0 ) {
        LD A, (Class_Status_DirectProperty_ticks_Shift_8_Size_1_Data) ; A := this.ticks
        DEC A
        ; Begin if 
          Class_Status_IfBranch_257_Begin: ; if ( Z ) {
            JP NZ, Class_Status_IfBranch_258_Begin ; if ( Z ) {
            CALL Direct_Class_MagickAnim_Method_countdown_Code ; MAGICKANIM.countdown()
            LD A, MAX_TIMER_TICK ; this.ticks := MAX_TIMER_TICK
            LD (Class_Status_DirectProperty_ticks_Shift_8_Size_1_Data), A ; this.ticks := MAX_TIMER_TICK
            LD IX, Object_TempObject6_in_Class_BCD2_Data ; this.timer.dec()
            CALL Multi_Class_BCD2_Method_dec_Code ; this.timer.dec()
            LD IX, Object_TempObject6_in_Class_BCD2_Data ; this.timer.cp( CLOCKDOWN_SOUND_LIMIT + 1 )
            LD A, CLOCKDOWN_SOUND_LIMIT + 1 ; this.timer.cp( CLOCKDOWN_SOUND_LIMIT + 1 )
            CALL Multi_Class_BCD2_Method_cp_Code ; this.timer.cp( CLOCKDOWN_SOUND_LIMIT + 1 )
            CALL C, Direct_Class_Sounds_Method_timeout_Code ; SOUNDS.timeout() if (CY)
            LD IX, Object_TempObject6_in_Class_BCD2_Data ; this.timer.print1( Status_Timer_Cache_Addr )
            LD HL, Status_Timer_Cache_Addr ; direct asm value ; this.timer.print1( Status_Timer_Cache_Addr )
            CALL Multi_Class_BCD2_Method_print1_Code ; this.timer.print1( Status_Timer_Cache_Addr )
            LD IX, Object_TempObject6_in_Class_BCD2_Data ; this.timer.cp0()
            CALL Multi_Class_BCD2_Method_cp0_Code ; this.timer.cp0()
            CALL Z, Direct_Class_Robbanas_Method_timeout_Code ; ROBBANAS.timeout() if (Z)
            JR Class_Status_IfBranch_258_End ; if ( Z ) {
          Class_Status_IfBranch_258_Begin: ; } else {
            LD (Class_Status_DirectProperty_ticks_Shift_8_Size_1_Data), A ; this.ticks := A
          Class_Status_IfBranch_258_End: ; }
        ; End full if
      Class_Status_IfBranch_256_End: ; }
    ; End full if
  RET ; }

  Direct_Class_Status_Method_add_diamond_Code: ; public add_diamond() {
    LD IX, Object_TempObject3_in_Class_BCD1_Data ; this.diamonds.inc()
    CALL Multi_Class_BCD1_Method_inc_Code ; this.diamonds.inc()
    LD IX, Object_TempObject3_in_Class_BCD1_Data ; this.diamonds.get_value_to_A()
    CALL Multi_Class_BCD1_Method_get_value_to_A_Code ; this.diamonds.get_value_to_A()
    CALL Direct_Class_Cave_Method_check_open_door_Code ; Cave.check_open_door( A )
    LD A, (Class_Cave_DirectProperty_diamond_point_Shift_6_Size_1_Data) ; A := Cave.diamond_point
    LD B, A ; for B = A to 1 {
    Class_Status_ForB_21_Begin:
      LD IX, Object_TempObject2_in_Class_BCD3_Data ; GAME.points.inc()
      CALL Multi_Class_BCD3_Method_inc_Code ; GAME.points.inc()
    DJNZ Class_Status_ForB_21_Begin
    CALL Direct_Class_Game_Method_inc_diamond_sum_counter_Code ; GAME.inc_diamond_sum_counter()
    LD IX, Object_TempObject2_in_Class_BCD3_Data ; GAME.points.print( Status_Points_Cache_Addr )
    LD HL, Status_Points_Cache_Addr ; direct asm value ; GAME.points.print( Status_Points_Cache_Addr )
    CALL Multi_Class_BCD3_Method_print_Code ; GAME.points.print( Status_Points_Cache_Addr )
    LD IX, Object_TempObject3_in_Class_BCD1_Data ; this.diamonds.print( Status_DC_Cache_Addr )
    LD HL, Status_DC_Cache_Addr ; direct asm value ; this.diamonds.print( Status_DC_Cache_Addr )
    CALL Multi_Class_BCD1_Method_print_Code ; this.diamonds.print( Status_DC_Cache_Addr )
    LD IX, Object_TempObject5_in_Class_BCD1_Data ; this.scorePerDiamond.print( Status_DiamondPoint_Cache_Addr )
    LD HL, Status_DiamondPoint_Cache_Addr ; direct asm value ; this.scorePerDiamond.print( Status_DiamondPoint_Cache_Addr )
    CALL Multi_Class_BCD1_Method_print_Code ; this.scorePerDiamond.print( Status_DiamondPoint_Cache_Addr )
  RET ; }

  Direct_Class_Status_Method_show_cave_Code: ; public show_cave() {
    LD DE, String_constant_24_Data ; SCREEN.write_text( "CAVE: @", CAVE_START_ADDR )
    LD HL, CAVE_START_ADDR ; direct asm value ; SCREEN.write_text( "CAVE: @", CAVE_START_ADDR )
    CALL Direct_Class_Screen_Method_write_text_Code ; SCREEN.write_text( "CAVE: @", CAVE_START_ADDR )
    LD A, (Class_Game_DirectProperty_cave_Shift_0_Size_1_Data) ; A := GAME.cave
    ADD A, 'A'
    LD (HL), A
  RET ; }

  Direct_Class_Status_Method_show_level_Code: ; public show_level() {
    LD DE, String_constant_25_Data ; SCREEN.write_text( "LEVEL: @", LEVEL_START_ADDR )
    LD HL, LEVEL_START_ADDR ; direct asm value ; SCREEN.write_text( "LEVEL: @", LEVEL_START_ADDR )
    CALL Direct_Class_Screen_Method_write_text_Code ; SCREEN.write_text( "LEVEL: @", LEVEL_START_ADDR )
    LD A, (Class_Game_DirectProperty_level_Shift_1_Size_1_Data) ; A := GAME.level
    ADD A, '0'
    LD (HL), A
  RET ; }

  Direct_Class_Status_Method_show_high_score_Code: ; public show_high_score() {
    LD DE, String_constant_26_Data ; SCREEN.write_text( "HIGH:@", Status_HighScoreText_Addr )
    LD HL, Status_HighScoreText_Addr ; direct asm value ; SCREEN.write_text( "HIGH:@", Status_HighScoreText_Addr )
    CALL Direct_Class_Screen_Method_write_text_Code ; SCREEN.write_text( "HIGH:@", Status_HighScoreText_Addr )
    LD IX, Object_TempObject1_in_Class_BCD3_Data ; GAME.high_score.print( Status_HighScore_Addr )
    LD HL, Status_HighScore_Addr ; direct asm value ; GAME.high_score.print( Status_HighScore_Addr )
    CALL Multi_Class_BCD3_Method_print_Code ; GAME.high_score.print( Status_HighScore_Addr )
  RET ; }

  Direct_Class_Status_Method_show_player_lives_Code: ; public show_player_lives() {
    LD A, (Class_Game_DirectProperty_live_counter_Shift_2_Size_1_Data) ; A := GAME.live_counter
    ADD A, 48
    LD (Status_Live_Cache_Addr+2), A
  RET ; }

  Direct_Class_Status_Method_addTimerToPoints_Code: ; public addTimerToPoints() {
    PUSH HL
    PUSH BC
    PUSH DE
    LD IX, Object_TempObject6_in_Class_BCD2_Data ; this.timer.cp0()
    CALL Multi_Class_BCD2_Method_cp0_Code ; this.timer.cp0()
    Class_Status_While_23_Begin: ; while( NZ ) {
      JP Z, Class_Status_While_24_End ; while( NZ ) {
      LD IX, Object_TempObject2_in_Class_BCD3_Data ; GAME.points.inc()
      CALL Multi_Class_BCD3_Method_inc_Code ; GAME.points.inc()
      LD IX, Object_TempObject2_in_Class_BCD3_Data ; GAME.points.print( Status_Points_Cache_Addr )
      LD HL, Status_Points_Cache_Addr ; direct asm value ; GAME.points.print( Status_Points_Cache_Addr )
      CALL Multi_Class_BCD3_Method_print_Code ; GAME.points.print( Status_Points_Cache_Addr )
      LD IX, Object_TempObject6_in_Class_BCD2_Data ; this.timer.dec()
      CALL Multi_Class_BCD2_Method_dec_Code ; this.timer.dec()
      LD IX, Object_TempObject6_in_Class_BCD2_Data ; this.timer.print1( Status_Timer_Cache_Addr )
      LD HL, Status_Timer_Cache_Addr ; direct asm value ; this.timer.print1( Status_Timer_Cache_Addr )
      CALL Multi_Class_BCD2_Method_print1_Code ; this.timer.print1( Status_Timer_Cache_Addr )
      CALL ROM_WAIT_SCREEN
      CALL Direct_Class_ScreenShadow_Method_refresh_status_only_Code ; SCREEN_SHADOW.refresh_status_only()
      LD IX, Object_TempObject6_in_Class_BCD2_Data ; this.timer.get_dec_val_to_A()
      CALL Multi_Class_BCD2_Method_get_dec_val_to_A_Code ; this.timer.get_dec_val_to_A()
      LD L, A
      LD H, 3
      CALL ROM_BEEP_H_L
      LD IX, Object_TempObject6_in_Class_BCD2_Data ; this.timer.cp0()
      CALL Multi_Class_BCD2_Method_cp0_Code ; this.timer.cp0()
    JR Class_Status_While_23_Begin ; } 
    Class_Status_While_24_End:
    POP DE
    POP BC
    POP HL
  RET ; }
; } ; End class Status
;;; End of file ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BOTTOM_OF_PROGRAM:
