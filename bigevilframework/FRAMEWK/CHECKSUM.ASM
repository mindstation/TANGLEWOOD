Checksum_Font			equ tiles_sansfont
Checksum_FontSize		equ tiles_sansfont_size_t
Checksum_FontAddr		equ 0x0000
Checksum_FontTileId		equ (Exception_FontAddr/size_tile_b)
Checksum_ColourBg		equ 0x0800
Checksum_ColourTxt		equ 0x0FFF
Checksum_MsgPosX		equ 0x03
Checksum_MsgPosY		equ 0x03
Checksum_MsgLineSpace	equ 0x01
Checksum_1K				equ 0x00FFDDD6
Checksum_Full			equ 0x00FFDDDB
Checksum_Target			equ 0x00FFDDE2
Checksum_1KAddrStr		equ 0x00FFDDEA
Checksum_1KBlockAddr	equ 0x00FFDDF4
Checksum_BlockSize		equ 0x00FFDDFC
Checksum_BlockSizeStr	equ 0x00FFDE04
Checksum_BlockDir		equ 0x00FFDE10

Checksum_Msg0: dc.b "This is a checksum info screen",0
Checksum_Msg1: dc.b "Press A for block checksum",0
Checksum_Msg2: dc.b "B change block size:",0
Checksum_Msg3: dc.b "L or R check direction:",0
Checksum_Msg4: dc.b "forward",0
Checksum_Msg5: dc.b "backward",0
Checksum_Msg6: dc.b "Bock end address:",0
Checksum_Msg7: dc.b "Block checksum:",0
Checksum_Msg8: dc.b "Press C for full ROM checksum",0
Checksum_Msg9: dc.b "Target checksum:",0
Checksum_Msg10: dc.b "Full checksum:",0
Checksum_Msg11: dc.b "You may press START to run game",0

	even

Checksum_Palette:
	dc.w Checksum_ColourBg
	dc.w Checksum_ColourTxt
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000

SYS_Checksum:

	move.l  #0x400, Checksum_BlockSize
	move.b  #0x1, Checksum_BlockDir
	
	; Re-initialise VDP
	jsr     VDP_Init
	; Welcome screen	

	; Wait for A, C, Left or Right button
	@WaitACLR:
	jsr    SYS_ChecksumWelcome
	jsr    PAD_ReadPadA
    move.w (Gamepad1PrevState), d1
	move.w d0, Gamepad1PrevState
	; Check START button
	btst   #pad_button_start, d0
	bne    @RunGame
	; Check Left and Right buttons
	jsr    SYS_ChecksumBlock_DirSelect
	; Check A button
	btst   #pad_button_a, d0
	bne    @BlockCheck
	; Check C button
	btst   #pad_button_c, d0
	bne    @Fullcheck
	jmp    @WaitACLR

	@BlockCheck:
	jsr    SYS_ChecksumBlock
	jmp    @RunGame
	
	@Fullcheck:
	move.l #checksum_end, d1			; ROM End
	lea    checksum_start, a0			; ROM Start (after header, see HEADER.ASM)
	jsr    SYS_ChecksumCalc
	lea    Checksum_Full, a0			; Result string address
	jsr    TXT_ItoA_Hex_w				; d0 was calculated by SYS_ChecksumCalc
	
	; Load checksum from ROM header
	move.w header_checksum_addr, d0	; Checksum
	lea    Checksum_Target, a0			; Result string address
	jsr    TXT_ItoA_Hex_w

	jsr    SYS_FullChecksumInfo

	; Wait for START button
	@WaitStart:
	jsr     PAD_ReadPadA
	btst    #pad_button_start, d0
	beq     @WaitStart

	@RunGame:
	; Re-initialise VDP
	jsr     VDP_Init
	
	rts

SYS_ChecksumBlock:
	
	move.l Checksum_BlockSize, d3
	@StartBlockCheck:
	btst   #0x8, Checksum_BlockDir
	bne    @ForwardBlockDir
	move.l #checksum_end, d1		; Block End
	move.l d1, a0
	suba.l d3, a0
	jmp    @CheckNextBlock
	@ForwardBlockDir:
	move.l #checksum_start, d1
	add.l  d3, d1					; Block End
	lea    checksum_start, a0		; ROM Start (after header, see HEADER.ASM)
	
	@CheckNextBlock:
	jsr    SYS_ChecksumCalc	
	move.l d1, Checksum_1KBlockAddr
	
	lea    Checksum_1K, a0			; Result string address
	jsr    TXT_ItoA_Hex_w			; d0 was calculated by SYS_ChecksumCalc
	move.l Checksum_1KBlockAddr, d0	; 1K addr value
	lea    Checksum_1KAddrStr, a0	; Result string address
	jsr    TXT_ItoA_Hex_l

	@WaitASLR:
	jsr    SYS_1KChecksumInfo
	jsr    PAD_ReadPadA
	; Check A button
	move.w (Gamepad1PrevState), d1
	move.w d0, Gamepad1PrevState
	; Check START button
	btst   #pad_button_start, d0
	bne    @ExitBlockCheck
	; Check Left and Right buttons
	jsr     SYS_ChecksumBlock_DirSelect
	; Check A button
	btst   #pad_button_a, d1		; Was button A pressed?
	bne    @WaitASLR
	btst   #pad_button_a, d0		; Is button A pressed now?
	beq    @WaitASLR
	
	; Calc next block addresses
	move.l Checksum_BlockSize, d3
	move.l Checksum_1KBlockAddr, d1
	btst   #0x8, Checksum_BlockDir
	bne    @ForwardBlockDirNext
	move.l #checksum_start, d2
	sub.l  d3, d1
	move.l d1, a0
	suba.l d3, a0
	cmpa.l d2, a0
	bge    @CheckNextBlock
	jmp    @StartBlockCheck			; Loop the block check
	@ForwardBlockDirNext:
	move.l #checksum_end, d2
	move.l d1, a0
	add.l  d3, d1
	cmp.l  d2, d1
	ble    @CheckNextBlock
	jmp    @StartBlockCheck			; Loop the block check
	
	@ExitBlockCheck:
	
	rts
	
SYS_ChecksumCalc:
	; a0 --- Checksum start address
	; d1 (l) Checksum end address
	; d0 (w) OUT: Checksum
	
	moveq  #0x0, d0
	@CheckLp:
	add.w  (a0)+, d0
	cmp.l  a0, d1
	bne.s  @CheckLp	
	
	rts
	
SYS_ChecksumBlock_DirSelect:
	
	btst    #pad_button_left, d1	; Was button Left pressed?
	bne     @SkipLeftSwitch
	btst    #pad_button_left, d0	; Is button Left pressed now?
	beq     @SkipLeftSwitch
	eori.b  #0x1, Checksum_BlockDir	; Switch 1 (forward) to 0 or 0 to 1
	jmp     @SkipRightSwitch
	@SkipLeftSwitch:
	
	btst    #pad_button_right, d1	; Was button Right pressed?
	bne     @SkipRightSwitch
	btst    #pad_button_right, d0
	beq     @SkipRightSwitch
	eori.b  #0x1, Checksum_BlockDir
	@SkipRightSwitch:
	
	rts
	
SYS_ChecksumWelcome:
	; Load font
	lea     Checksum_Font, a0
	move.l  #Checksum_FontAddr, d0
	move.l  #Checksum_FontSize, d1
	jsr     TXT_LoadFont

	; Load palette
	lea     Checksum_Palette, a0
	move.l  #0x0, d0
	jsr     PAL_Load
	
	;==============================================================
	
	; Draw welcome messages
	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+0)), d1	; XY coord
	lea     Checksum_Msg0, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+2)), d1	; XY coord
	lea     Checksum_Msg1, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+3)), d1	; XY coord
	lea     Checksum_Msg2, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+4)), d1	; XY coord
	lea     Checksum_Msg3, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	jsr     SYS_BlockChecksumParams
	
	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+6)), d1	; XY coord
	lea     Checksum_Msg8, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+9)), d1	; XY coord
	lea     Checksum_Msg11, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	rts

SYS_1KChecksumInfo:
	
	; Load font
	lea     Checksum_Font, a0
	move.l  #Checksum_FontAddr, d0
	move.l  #Checksum_FontSize, d1
	jsr     TXT_LoadFont

	; Load palette
	lea     Checksum_Palette, a0
	move.l  #0x0, d0
	jsr     PAL_Load

	;==============================================================
	
	; Draw 1K checksum info
	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+2)), d1	; XY coord
	lea     Checksum_Msg1, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+3)), d1	; XY coord
	lea     Checksum_Msg2, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+4)), d1	; XY coord
	lea     Checksum_Msg3, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane	
	
	jsr     SYS_BlockChecksumParams
	
	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+6)), d1	; XY coord
	lea     Checksum_Msg6, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	move.l  #(((Checksum_MsgPosX+22)<<16)|(Checksum_MsgPosY+6)), d1	; XY coord
	lea     Checksum_1KAddrStr, a0	; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+7)), d1	; XY coord
	lea     Checksum_Msg7, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	move.l  #(((Checksum_MsgPosX+22)<<16)|(Checksum_MsgPosY+7)), d1	; XY coord
	lea     Checksum_1K, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	rts
	
SYS_BlockChecksumParams:
	
	; Show checksum block size
	move.l  Checksum_BlockSize, d0
	lea     Checksum_BlockSizeStr, a0			; Result string address
	jsr     TXT_ItoA_Hex_l
	
	move.l  #(((Checksum_MsgPosX+24)<<16)|(Checksum_MsgPosY+3)), d1	; XY coord
	lea     Checksum_BlockSizeStr, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	; Show checksum direction
	move.l  #(((Checksum_MsgPosX+24)<<16)|(Checksum_MsgPosY+4)), d1	; XY coord
	lea     Checksum_Msg4, a0			; String address
	move.b  Checksum_BlockDir, d0
	cmpi.l  #0x0, d0
	bne     @SkipBackward
	lea     Checksum_Msg5, a0			; String address
	@SkipBackward:
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	rts
	
SYS_FullChecksumInfo:
	
	; Load font
	lea     Checksum_Font, a0
	move.l  #Checksum_FontAddr, d0
	move.l  #Checksum_FontSize, d1
	jsr     TXT_LoadFont

	; Load palette
	lea     Checksum_Palette, a0
	move.l  #0x0, d0
	jsr     PAL_Load

	;==============================================================
	
	; Draw checksum info
	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+4)), d1	; XY coord
	lea     Checksum_Msg9, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	move.l  #(((Checksum_MsgPosX+22)<<16)|(Checksum_MsgPosY+4)), d1	; XY coord
	lea     Checksum_Target, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane

	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+5)), d1	; XY coord
	lea     Checksum_Msg10, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane	
	
	move.l  #(((Checksum_MsgPosX+22)<<16)|(Checksum_MsgPosY+5)), d1	; XY coord
	lea     Checksum_Full, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	rts
