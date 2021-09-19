Checksum_Font			equ tiles_sansfont
Checksum_FontSize		equ tiles_sansfont_size_t
Checksum_FontAddr		equ 0x0000
Checksum_FontTileId		equ (Exception_FontAddr/size_tile_b)
Checksum_ColourBg		equ 0x0800
Checksum_ColourTxt		equ 0x0FFF
Checksum_MsgPosX		equ 0x03
Checksum_MsgPosY		equ 0x06
Checksum_MsgLineSpace	equ 0x01
Checksum_1K				equ 0x00FF0000
Checksum_Full			equ 0x00FF0007
Checksum_Target			equ 0x00FF000E
Checksum_1KBlockAddr	equ 0x00FF0016

Checksum_Msg0: dc.b "This is a checksum info screen",0
Checksum_Msg1: dc.b "Press A for 1KB checksum",0
Checksum_Msg2: dc.b "Press B for full ROM checksum",0
Checksum_Msg3: dc.b "1KB checksum:",0
Checksum_Msg4: dc.b "Target checksum:",0
Checksum_Msg5: dc.b "Full checksum:",0
Checksum_Msg6: dc.b "You may press START to run game",0
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

	; Re-initialise VDP
	jsr     VDP_Init
	; Welcome screen
	jsr     SYS_ChecksumWelcome

	; Wait for A or B button
	@WaitAB:
	jsr     PAD_ReadPadA
	move.w d0, Gamepad1PrevState
	; Check A button	
	btst    #pad_button_a, d0
	bne     @KBcheck
	; Check B button
	btst    #pad_button_b, d0
	bne     @Fullcheck	
	jmp @WaitAB
		
	@KBcheck:
	move.l #(checksum_start+1024), d1	; 1K section End
	lea    checksum_start, a0			; ROM Start (after header, see HEADER.ASM)
	@CheckNext1K:
	moveq  #0x0, d0
	@Check1KLp:
	add.w  (a0)+, d0
	cmp.l  a0, d1
	bne.s  @Check1KLp
	move.l d1, Checksum_1KBlockAddr
	
	lea    Checksum_1K, a0			; String address
	jsr    TXT_ItoA_Hex_w
	
	jsr    SYS_1KChecksumInfo
	
	@WaitA:
	jsr    PAD_ReadPadA
	; Check A button
	move.w (Gamepad1PrevState), d1
	move.w d0, Gamepad1PrevState
	btst   #pad_button_start, d0
	bne    @RunGame
	btst   #pad_button_a, d1		; Was button A pressed?
	bne    @WaitA
	btst   #pad_button_a, d0		; Is button A pressed now?
	beq    @WaitA	
	
	move.l Checksum_1KBlockAddr, d1
	move.l d1, a0
	add.w  #1024, d1
	jmp    @CheckNext1K	
	
	@Fullcheck:
	move.l #checksum_end, d1			; ROM End
	lea    checksum_start, a0			; ROM Start (after header, see HEADER.ASM)
	moveq  #0x0, d0
	@CheckLp:
	add.w  (a0)+, d0
	cmp.l  a0, d1
	bne.s  @CheckLp	
	lea    Checksum_Full, a0			; String address
	jsr    TXT_ItoA_Hex_w
	
	; Load checksum from ROM header
	move.w header_checksum_addr, d0	; Checksum
	lea    Checksum_Target, a0			; String address
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
	
	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+1)), d1	; XY coord
	lea     Checksum_Msg1, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+2)), d1	; XY coord
	lea     Checksum_Msg2, a0			; String address
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
	
	; Draw checksum info
	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+4)), d1	; XY coord
	lea     Checksum_Msg3, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	move.l  #(((Checksum_MsgPosX+22)<<16)|(Checksum_MsgPosY+4)), d1	; XY coord
	lea     Checksum_1K, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane

	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+8)), d1	; XY coord
	lea     Checksum_Msg6, a0			; String address
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
	lea     Checksum_Msg4, a0			; String address
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
	lea     Checksum_Msg5, a0			; String address
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

	move.l  #((Checksum_MsgPosX<<16)|(Checksum_MsgPosY+8)), d1	; XY coord
	lea     Checksum_Msg6, a0			; String address
	move.w  #Checksum_FontTileId, d0	; Font VDP address
	move.b  #0x0, d2					; Palette index
	move.b  #0x0, d3					; Plane A
	jsr     TXT_DrawPlane
	
	rts
