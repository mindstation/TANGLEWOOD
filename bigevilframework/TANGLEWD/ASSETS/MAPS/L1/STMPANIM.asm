; == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == ==
;   **AUTOGENERATED WITH BEEHIVE** - the complete art tool for SEGA Mega Drive
; == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == ==
;   http://www.bigevilcorporation.co.uk
; == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == ==
;   Beehive and SEGA Genesis Framework (c) Matt Phillips 2015
; == == == == == == == == == == == == == == == == == == == == == == == == == == == == == == ==


L1_LoadSceneAnimations:
	PUSHL  a1
	lea    StampAnimObjs, a0
	lea    StampAnims, a1

	; Get stamp VRAM address
	move.w (vram_addr_leveltiles), d0
	add.w  #stampanimsheet_AnimPlants_tileoffset*size_tile_b, d0
	; Load scene anim objects
	jsr    SceneAnimInit
	lea    spritesheets_AnimPlants, a2
	move.l #stampanimsheet_AnimPlants_size_t, d1
	jsr    SceneAnimLoadStampAnim

	; Set scene animations
	move.w #stampanimsheet_AnimPlants_ground_plant_anim_frameoffset, Animation_FirstFrameOffset(a1)
	move.l #actor_AnimPlants_sheet_ground_plant_anim_anim_ground_plant_anim_track_frames, Animation_AnimTrackSpriteFrame(a1)
	move.w #actor_AnimPlants_sheet_ground_plant_anim_anim_ground_plant_anim_speed, Animation_Speed(a1)
	move.b #actor_AnimPlants_sheet_ground_plant_anim_anim_ground_plant_anim_numframes, Animation_Length(a1)
	move.b #0x1, Animation_Looping(a1)
	jsr    AnimObjSetAnimation

	add.l  #SceneAnim_Struct_Size, a0
	add.l  #Animation_Struct_Size, a1

	; Get stamp VRAM address
	move.w (vram_addr_leveltiles), d0
	add.w  #stampanimsheet_AnimWater_tileoffset*size_tile_b, d0
	; Load scene anim objects
	jsr    SceneAnimInit
	lea    spritesheets_AnimWater, a2
	move.l #stampanimsheet_AnimWater_size_t, d1
	jsr    SceneAnimLoadStampAnim

	; Set scene animations
	move.w #stampanimsheet_AnimWater_water_anim_frameoffset, Animation_FirstFrameOffset(a1)
	move.l #actor_AnimWater_sheet_water_anim_anim_water_anim_track_frames, Animation_AnimTrackSpriteFrame(a1)
	move.w #actor_AnimWater_sheet_water_anim_anim_water_anim_speed, Animation_Speed(a1)
	move.b #actor_AnimWater_sheet_water_anim_anim_water_anim_numframes, Animation_Length(a1)
	move.b #0x1, Animation_Looping(a1)
	jsr    AnimObjSetAnimation

	add.l  #SceneAnim_Struct_Size, a0
	add.l  #Animation_Struct_Size, a1

	POPL   a1
	rts

stamp_AnimPlants:

stampanimsheet_AnimPlants_size_b		equ 0x01C0	; Size in bytes
stampanimsheet_AnimPlants_size_t		equ 0x000E	; Size in tiles
stampanimsheet_AnimPlants_tileoffset		equ 0x0000	; First tile offset
stampanimsheet_AnimPlants_ground_plant_anim_frameoffset	equ 0x00	; Offset to first frame in stamp anim sheet


spritesheets_AnimPlants:

actor_AnimPlants_sheet_ground_plant_anim_frametable:
actor_AnimPlants_sheet_ground_plant_anim_frame_0_header:
	dc.w 0x0030	; Frame size (tiles)
	dc.w actor_AnimPlants_sheet_ground_plant_anim_frame_0_size_subsprites	; Frame size (subsprites)
	dc.l actor_AnimPlants_sheet_ground_plant_anim_frame_0
	dc.l actor_AnimPlants_sheet_ground_plant_anim_frame_0_subsprite_dimensions_bits
	dc.l actor_AnimPlants_sheet_ground_plant_anim_frame_0_subsprite_pos_offsets

actor_AnimPlants_sheet_ground_plant_anim_frame_1_header:
	dc.w 0x0030	; Frame size (tiles)
	dc.w actor_AnimPlants_sheet_ground_plant_anim_frame_1_size_subsprites	; Frame size (subsprites)
	dc.l actor_AnimPlants_sheet_ground_plant_anim_frame_1
	dc.l actor_AnimPlants_sheet_ground_plant_anim_frame_1_subsprite_dimensions_bits
	dc.l actor_AnimPlants_sheet_ground_plant_anim_frame_1_subsprite_pos_offsets

actor_AnimPlants_sheet_ground_plant_anim_frame_2_header:
	dc.w 0x0030	; Frame size (tiles)
	dc.w actor_AnimPlants_sheet_ground_plant_anim_frame_2_size_subsprites	; Frame size (subsprites)
	dc.l actor_AnimPlants_sheet_ground_plant_anim_frame_2
	dc.l actor_AnimPlants_sheet_ground_plant_anim_frame_2_subsprite_dimensions_bits
	dc.l actor_AnimPlants_sheet_ground_plant_anim_frame_2_subsprite_pos_offsets

actor_AnimPlants_sheet_ground_plant_anim_frame_0_size_b		equ 0x0600	; Size in bytes
actor_AnimPlants_sheet_ground_plant_anim_frame_0_size_t		equ 0x0030	; Size in tiles
actor_AnimPlants_sheet_ground_plant_anim_frame_0_size_subsprites		equ 0x0004	; Size in subsprites

; Subsprite offsets from 0,0 (in pixels) - unflipped (ww) and flipped X (ww)
actor_AnimPlants_sheet_ground_plant_anim_frame_0_subsprite_pos_offsets:
	dc.l 0x00000000, 0x005F0000
	dc.l 0x00200000, 0x003F0000
	dc.l 0x00400000, 0x001F0000
	dc.l 0x00600000, 0xFFFFFFFF0000
	Even

; Subsprite dimension bits (for sprite descs)
actor_AnimPlants_sheet_ground_plant_anim_frame_0_subsprite_dimensions_bits:
	dc.b 0xE
	dc.b 0xE
	dc.b 0xE
	dc.b 0xE
	Even


actor_AnimPlants_sheet_ground_plant_anim_frame_1_size_b		equ 0x0600	; Size in bytes
actor_AnimPlants_sheet_ground_plant_anim_frame_1_size_t		equ 0x0030	; Size in tiles
actor_AnimPlants_sheet_ground_plant_anim_frame_1_size_subsprites		equ 0x0004	; Size in subsprites

; Subsprite offsets from 0,0 (in pixels) - unflipped (ww) and flipped X (ww)
actor_AnimPlants_sheet_ground_plant_anim_frame_1_subsprite_pos_offsets:
	dc.l 0x00000000, 0x005F0000
	dc.l 0x00200000, 0x003F0000
	dc.l 0x00400000, 0x001F0000
	dc.l 0x00600000, 0xFFFFFFFF0000
	Even

; Subsprite dimension bits (for sprite descs)
actor_AnimPlants_sheet_ground_plant_anim_frame_1_subsprite_dimensions_bits:
	dc.b 0xE
	dc.b 0xE
	dc.b 0xE
	dc.b 0xE
	Even


actor_AnimPlants_sheet_ground_plant_anim_frame_2_size_b		equ 0x0600	; Size in bytes
actor_AnimPlants_sheet_ground_plant_anim_frame_2_size_t		equ 0x0030	; Size in tiles
actor_AnimPlants_sheet_ground_plant_anim_frame_2_size_subsprites		equ 0x0004	; Size in subsprites

; Subsprite offsets from 0,0 (in pixels) - unflipped (ww) and flipped X (ww)
actor_AnimPlants_sheet_ground_plant_anim_frame_2_subsprite_pos_offsets:
	dc.l 0x00000000, 0x005F0000
	dc.l 0x00200000, 0x003F0000
	dc.l 0x00400000, 0x001F0000
	dc.l 0x00600000, 0xFFFFFFFF0000
	Even

; Subsprite dimension bits (for sprite descs)
actor_AnimPlants_sheet_ground_plant_anim_frame_2_subsprite_dimensions_bits:
	dc.b 0xE
	dc.b 0xE
	dc.b 0xE
	dc.b 0xE
	Even


stampanimsheet_AnimPlants_ground_plant_anim:

actor_AnimPlants_sheet_ground_plant_anim_frame_0:
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x000000C0
	dc.l	0x00000050
	dc.l	0x0000F0C0
	dc.l	0x0F00C22C
	dc.l	0x02555553
	dc.l	0x775555C3

	dc.l	0x00000000
	dc.l	0x0F000000
	dc.l	0x0F00F000
	dc.l	0x0C0C0000
	dc.l	0x0C0C0C00
	dc.l	0x2CCC5525
	dc.l	0x55533353
	dc.l	0x777A5337

	dc.l	0x00000000
	dc.l	0x00696000
	dc.l	0x06EE9600
	dc.l	0x63EED360
	dc.l	0x69DDD960
	dc.l	0xB69D96B0
	dc.l	0x0B696B00
	dc.l	0x00BBB000

	dc.l	0x00000000
	dc.l	0x00030000
	dc.l	0x0EA30000
	dc.l	0x0AAB0000
	dc.l	0x000BAE00
	dc.l	0x000BAA00
	dc.l	0x0EAB0000
	dc.l	0x0AAB0000

	dc.l	0x000B0000
	dc.l	0x05030500
	dc.l	0x05535500
	dc.l	0x005B5000
	dc.l	0x000B0000
	dc.l	0x000B0000
	dc.l	0x000B0000
	dc.l	0x000B0000

	dc.l	0x000BAE00
	dc.l	0x0003AA00
	dc.l	0x0EA30000
	dc.l	0x0AAB0000
	dc.l	0x000BAE00
	dc.l	0x000BAA00
	dc.l	0x000B0000
	dc.l	0x000B0000

	dc.l	0x000B0000
	dc.l	0x05030500
	dc.l	0x05535500
	dc.l	0x005B5000
	dc.l	0x000BC000
	dc.l	0x0C0B5032
	dc.l	0x2573555C
	dc.l	0xA777CC55

	dc.l	0x000B0000
	dc.l	0x05030500
	dc.l	0x05535500
	dc.l	0x005BF000
	dc.l	0xF00BC000
	dc.l	0x20CB5050
	dc.l	0x553335CF
	dc.l	0x77355557

	dc.l	0x000B0000
	dc.l	0x05030500
	dc.l	0x05535500
	dc.l	0x005B5000
	dc.l	0x000B0000
	dc.l	0x222B0220
	dc.l	0x77AA7777
	dc.l	0x335777AA

	dc.l	0x000B0000
	dc.l	0x05030500
	dc.l	0x05535500
	dc.l	0x005B5000
	dc.l	0x000B0000
	dc.l	0x22220000
	dc.l	0xAA777220
	dc.l	0x35AA7777

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x22220000
	dc.l	0xAA777220
	dc.l	0x35AA7777

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00002222
	dc.l	0x22777AAA
	dc.l	0xA7553777

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00033222
	dc.l	0x02C533A7
	dc.l	0x7555537A

actor_AnimPlants_sheet_ground_plant_anim_frame_1:
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x000000C0
	dc.l	0x00000050
	dc.l	0x0000F0C0
	dc.l	0x0F00C22C
	dc.l	0x02555553
	dc.l	0x775555C3

	dc.l	0x00000000
	dc.l	0x0F000000
	dc.l	0x0F00F000
	dc.l	0x0C0C0000
	dc.l	0x0C0C0C00
	dc.l	0x2CCC5525
	dc.l	0x55533353
	dc.l	0x777A5337

	dc.l	0x00000000
	dc.l	0x00696000
	dc.l	0x06EE9600
	dc.l	0x63EED360
	dc.l	0x69DDD960
	dc.l	0xB69D96B0
	dc.l	0x0B696B00
	dc.l	0x00BBB000

	dc.l	0x00000000
	dc.l	0x00030000
	dc.l	0x00030000
	dc.l	0x0EABAE00
	dc.l	0x0AABAA00
	dc.l	0x000B0000
	dc.l	0x000B0000
	dc.l	0x0EABAE00

	dc.l	0x000B0000
	dc.l	0x05030500
	dc.l	0x05535500
	dc.l	0x005B5000
	dc.l	0x000B0000
	dc.l	0x000B0000
	dc.l	0x000B0000
	dc.l	0x000B0000

	dc.l	0x0AABAA00
	dc.l	0x00030000
	dc.l	0x00030000
	dc.l	0x0EABAE00
	dc.l	0x0AABAA00
	dc.l	0x000B0000
	dc.l	0x000B0000
	dc.l	0x000B0000

	dc.l	0x000B0000
	dc.l	0x05030500
	dc.l	0x05535500
	dc.l	0x005B5000
	dc.l	0x000BC000
	dc.l	0x0C0B5032
	dc.l	0x2573555C
	dc.l	0xA777CC55

	dc.l	0x000B0000
	dc.l	0x05030500
	dc.l	0x05535500
	dc.l	0x005BF000
	dc.l	0xF00BC000
	dc.l	0x20CB5050
	dc.l	0x553335CF
	dc.l	0x77355557

	dc.l	0x000B0000
	dc.l	0x05030500
	dc.l	0x05535500
	dc.l	0x005B5000
	dc.l	0x000B0000
	dc.l	0x222B0220
	dc.l	0x77AA7777
	dc.l	0x335777AA

	dc.l	0x000B0000
	dc.l	0x05030500
	dc.l	0x05535500
	dc.l	0x005B5000
	dc.l	0x000B0000
	dc.l	0x22220000
	dc.l	0xAA777220
	dc.l	0x35AA7777

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x22220000
	dc.l	0xAA777220
	dc.l	0x35AA7777

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00002222
	dc.l	0x22777AAA
	dc.l	0xA7553777

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00033222
	dc.l	0x02C533A7
	dc.l	0x7555537A

actor_AnimPlants_sheet_ground_plant_anim_frame_2:
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x000000C0
	dc.l	0x00000050
	dc.l	0x0000F0C0
	dc.l	0x0F00C22C
	dc.l	0x02555553
	dc.l	0x775555C3

	dc.l	0x00000000
	dc.l	0x0F000000
	dc.l	0x0F00F000
	dc.l	0x0C0C0000
	dc.l	0x0C0C0C00
	dc.l	0x2CCC5525
	dc.l	0x55533353
	dc.l	0x777A5337

	dc.l	0x00696000
	dc.l	0x06EE3600
	dc.l	0x06EE9600
	dc.l	0x069D9600
	dc.l	0x0B9D9B00
	dc.l	0x0B696B00
	dc.l	0x00B6B000
	dc.l	0x00BBB000

	dc.l	0x00000000
	dc.l	0x00030000
	dc.l	0x0003AE00
	dc.l	0x000BAA00
	dc.l	0x0EAB0000
	dc.l	0x0AAB0000
	dc.l	0x000BAE00
	dc.l	0x000BAA00

	dc.l	0x000B0000
	dc.l	0x05030500
	dc.l	0x05535500
	dc.l	0x005B5000
	dc.l	0x000B0000
	dc.l	0x000B0000
	dc.l	0x000B0000
	dc.l	0x000B0000

	dc.l	0x0EAB0000
	dc.l	0x0AA30000
	dc.l	0x0003AE00
	dc.l	0x000BAA00
	dc.l	0x0EAB0000
	dc.l	0x0AAB0000
	dc.l	0x000B0000
	dc.l	0x000B0000

	dc.l	0x000B0000
	dc.l	0x05030500
	dc.l	0x05535500
	dc.l	0x005B5000
	dc.l	0x000BC000
	dc.l	0x0C0B5032
	dc.l	0x2573555C
	dc.l	0xA777CC55

	dc.l	0x000B0000
	dc.l	0x05030500
	dc.l	0x05535500
	dc.l	0x005BF000
	dc.l	0xF00BC000
	dc.l	0x20CB5050
	dc.l	0x553335CF
	dc.l	0x77355557

	dc.l	0x000B0000
	dc.l	0x05030500
	dc.l	0x05535500
	dc.l	0x005B5000
	dc.l	0x000B0000
	dc.l	0x222B0220
	dc.l	0x77AA7777
	dc.l	0x335777AA

	dc.l	0x000B0000
	dc.l	0x05030500
	dc.l	0x05535500
	dc.l	0x005B5000
	dc.l	0x000B0000
	dc.l	0x22220000
	dc.l	0xAA777220
	dc.l	0x35AA7777

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x22220000
	dc.l	0xAA777220
	dc.l	0x35AA7777

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00002222
	dc.l	0x22777AAA
	dc.l	0xA7553777

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00033222
	dc.l	0x02C533A7
	dc.l	0x7555537A



stampanims_AnimPlants:

actor_AnimPlants_sheet_ground_plant_anim_anim_ground_plant_anim:
actor_AnimPlants_sheet_ground_plant_anim_anim_ground_plant_anim_numframes: equ 0x3
actor_AnimPlants_sheet_ground_plant_anim_anim_ground_plant_anim_speed: equ 0x5
actor_AnimPlants_sheet_ground_plant_anim_anim_ground_plant_anim_track_frames:
	dc.l actor_AnimPlants_sheet_ground_plant_anim_frame_0_header
	dc.l actor_AnimPlants_sheet_ground_plant_anim_frame_1_header
	dc.l actor_AnimPlants_sheet_ground_plant_anim_frame_2_header

	Even
actor_AnimPlants_sheet_ground_plant_anim_anim_ground_plant_anim_track_posx:
	dc.b 0x00, 0x00, 0x00
	Even
actor_AnimPlants_sheet_ground_plant_anim_anim_ground_plant_anim_track_posy:
	dc.b 0x00, 0x00, 0x00
	Even
actor_AnimPlants_sheet_ground_plant_anim_anim_ground_plant_anim_track_sfx:
	dc.l 0x0, 0x0, 0x0
	Even

stamp_AnimWater:

stampanimsheet_AnimWater_size_b		equ 0x02A0	; Size in bytes
stampanimsheet_AnimWater_size_t		equ 0x0015	; Size in tiles
stampanimsheet_AnimWater_tileoffset		equ 0x0095	; First tile offset
stampanimsheet_AnimWater_water_anim_frameoffset	equ 0x00	; Offset to first frame in stamp anim sheet


spritesheets_AnimWater:

actor_AnimWater_sheet_water_anim_frametable:
actor_AnimWater_sheet_water_anim_frame_0_header:
	dc.w 0x002D	; Frame size (tiles)
	dc.w actor_AnimWater_sheet_water_anim_frame_0_size_subsprites	; Frame size (subsprites)
	dc.l actor_AnimWater_sheet_water_anim_frame_0
	dc.l actor_AnimWater_sheet_water_anim_frame_0_subsprite_dimensions_bits
	dc.l actor_AnimWater_sheet_water_anim_frame_0_subsprite_pos_offsets

actor_AnimWater_sheet_water_anim_frame_1_header:
	dc.w 0x002D	; Frame size (tiles)
	dc.w actor_AnimWater_sheet_water_anim_frame_1_size_subsprites	; Frame size (subsprites)
	dc.l actor_AnimWater_sheet_water_anim_frame_1
	dc.l actor_AnimWater_sheet_water_anim_frame_1_subsprite_dimensions_bits
	dc.l actor_AnimWater_sheet_water_anim_frame_1_subsprite_pos_offsets

actor_AnimWater_sheet_water_anim_frame_2_header:
	dc.w 0x002D	; Frame size (tiles)
	dc.w actor_AnimWater_sheet_water_anim_frame_2_size_subsprites	; Frame size (subsprites)
	dc.l actor_AnimWater_sheet_water_anim_frame_2
	dc.l actor_AnimWater_sheet_water_anim_frame_2_subsprite_dimensions_bits
	dc.l actor_AnimWater_sheet_water_anim_frame_2_subsprite_pos_offsets

actor_AnimWater_sheet_water_anim_frame_0_size_b		equ 0x05A0	; Size in bytes
actor_AnimWater_sheet_water_anim_frame_0_size_t		equ 0x002D	; Size in tiles
actor_AnimWater_sheet_water_anim_frame_0_size_subsprites		equ 0x0004	; Size in subsprites

; Subsprite offsets from 0,0 (in pixels) - unflipped (ww) and flipped X (ww)
actor_AnimWater_sheet_water_anim_frame_0_subsprite_pos_offsets:
	dc.l 0x00000000, 0x00570000
	dc.l 0x00200000, 0x00370000
	dc.l 0x00400000, 0x00170000
	dc.l 0x00600000, 0xFFFFFFFF0000
	Even

; Subsprite dimension bits (for sprite descs)
actor_AnimWater_sheet_water_anim_frame_0_subsprite_dimensions_bits:
	dc.b 0xE
	dc.b 0xE
	dc.b 0xE
	dc.b 0xA
	Even


actor_AnimWater_sheet_water_anim_frame_1_size_b		equ 0x05A0	; Size in bytes
actor_AnimWater_sheet_water_anim_frame_1_size_t		equ 0x002D	; Size in tiles
actor_AnimWater_sheet_water_anim_frame_1_size_subsprites		equ 0x0004	; Size in subsprites

; Subsprite offsets from 0,0 (in pixels) - unflipped (ww) and flipped X (ww)
actor_AnimWater_sheet_water_anim_frame_1_subsprite_pos_offsets:
	dc.l 0x00000000, 0x00570000
	dc.l 0x00200000, 0x00370000
	dc.l 0x00400000, 0x00170000
	dc.l 0x00600000, 0xFFFFFFFF0000
	Even

; Subsprite dimension bits (for sprite descs)
actor_AnimWater_sheet_water_anim_frame_1_subsprite_dimensions_bits:
	dc.b 0xE
	dc.b 0xE
	dc.b 0xE
	dc.b 0xA
	Even


actor_AnimWater_sheet_water_anim_frame_2_size_b		equ 0x05A0	; Size in bytes
actor_AnimWater_sheet_water_anim_frame_2_size_t		equ 0x002D	; Size in tiles
actor_AnimWater_sheet_water_anim_frame_2_size_subsprites		equ 0x0004	; Size in subsprites

; Subsprite offsets from 0,0 (in pixels) - unflipped (ww) and flipped X (ww)
actor_AnimWater_sheet_water_anim_frame_2_subsprite_pos_offsets:
	dc.l 0x00000000, 0x00570000
	dc.l 0x00200000, 0x00370000
	dc.l 0x00400000, 0x00170000
	dc.l 0x00600000, 0xFFFFFFFF0000
	Even

; Subsprite dimension bits (for sprite descs)
actor_AnimWater_sheet_water_anim_frame_2_subsprite_dimensions_bits:
	dc.b 0xE
	dc.b 0xE
	dc.b 0xE
	dc.b 0xA
	Even


stampanimsheet_AnimWater_water_anim:

actor_AnimWater_sheet_water_anim_frame_0:
	dc.l	0x777777AA
	dc.l	0xAAA5AA53
	dc.l	0xA77C577A
	dc.l	0x7A775AAA
	dc.l	0x7EAA77AA
	dc.l	0x2AEEAAAA
	dc.l	0x1272AAEA
	dc.l	0x12217777

	dc.l	0x7333537A
	dc.l	0xA77A3777
	dc.l	0xEAAAAAAA
	dc.l	0x2EEAAAAA
	dc.l	0x1277AE72
	dc.l	0x12227721
	dc.l	0x12227721
	dc.l	0x12227721

	dc.l	0xACF5CCAA
	dc.l	0x277F527E
	dc.l	0x27777772
	dc.l	0x27777711
	dc.l	0x22777711
	dc.l	0x22777711
	dc.l	0x22277711
	dc.l	0x22222221

	dc.l	0xAAAA221A
	dc.l	0xAAA72212
	dc.l	0xAAA7B212
	dc.l	0xAAA7B211
	dc.l	0xAAA2B211
	dc.l	0xAA72B211
	dc.l	0xAA22B211
	dc.l	0x7222BB11

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x22200220
	dc.l	0x66666622

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x22222000
	dc.l	0x22666662

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x02222220
	dc.l	0x66666666

	dc.l	0xEED99DED
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0xE9DEDD99
	dc.l	0x99999999
	dc.l	0x99999999

	dc.l	0xDDEED9DE
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99D9EEDD
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999

	dc.l	0xDD9DDEED
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99DD9999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999

	dc.l	0xDEDDEDDD
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999696
	dc.l	0x99662222
	dc.l	0x622777A7
	dc.l	0x77AAAAAA

	dc.l	0x9999DE9D
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x66999999
	dc.l	0x22266226
	dc.l	0x77AA7777
	dc.l	0xAAAAAAAA

	dc.l	0xD9ED9999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999696
	dc.l	0x69962222
	dc.l	0x22777AAA
	dc.l	0xAAAAAAAA

	dc.l	0xDDD99999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x66999999
	dc.l	0x22226699
	dc.l	0xAA777226
	dc.l	0xAAAAAA77

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x02222220
	dc.l	0x666666F6

	dc.l	0x23ECD9DE
	dc.l	0xC55599C9
	dc.l	0x55C53759
	dc.l	0x3CCC7772
	dc.l	0x27A7735A
	dc.l	0xAAAAA355
	dc.l	0x7AAA773C
	dc.l	0xAEEE2213

	dc.l	0xDEDF9DFE
	dc.l	0x99C0C9C9
	dc.l	0x5250C9C9
	dc.l	0x3535CCC2
	dc.l	0x73333555
	dc.l	0xAA75A777
	dc.l	0x735555A7
	dc.l	0x25555537

	dc.l	0xDEEDD9DD
	dc.l	0x9C999999
	dc.l	0x95999999
	dc.l	0x9C9FDD99
	dc.l	0xC22C9999
	dc.l	0x355599F9
	dc.l	0x3C555529
	dc.l	0x33FF5577

	dc.l	0x22119999
	dc.l	0xAAA77999
	dc.l	0x77735722
	dc.l	0xA755557A
	dc.l	0x735FC377
	dc.l	0xA33A75AA
	dc.l	0xAAAE277A
	dc.l	0xAEEA221A

	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x72199999
	dc.l	0xA777A221
	dc.l	0xAA777A77
	dc.l	0xAAAA7533
	dc.l	0xAAA77557
	dc.l	0xAAAAA7AA

	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x19999999
	dc.l	0x72233999
	dc.l	0xAA335999
	dc.l	0x77355C29
	dc.l	0xA733C557

actor_AnimWater_sheet_water_anim_frame_1:
	dc.l	0x777777AA
	dc.l	0xAAA5AA53
	dc.l	0xA77C577A
	dc.l	0x7A775AAA
	dc.l	0x7EAA77AA
	dc.l	0x2AEEAAAA
	dc.l	0x1272AAEA
	dc.l	0x12217777

	dc.l	0x7333537A
	dc.l	0xA77A3777
	dc.l	0xEAAAAAAA
	dc.l	0x2EEAAAAA
	dc.l	0x1277AE72
	dc.l	0x12227721
	dc.l	0x12227721
	dc.l	0x12227721

	dc.l	0xACF5CCAA
	dc.l	0x277F527E
	dc.l	0x27777772
	dc.l	0x27777711
	dc.l	0x22777711
	dc.l	0x22777711
	dc.l	0x22277711
	dc.l	0x22222221

	dc.l	0xAAAA221A
	dc.l	0xAAA72212
	dc.l	0xAAA7B212
	dc.l	0xAAA7B211
	dc.l	0xAAA2B211
	dc.l	0xAA72B211
	dc.l	0xAA22B211
	dc.l	0x7222BB11

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x66666622

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x22666662

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x22222000
	dc.l	0x22666662

	dc.l	0xDD9EE9D9
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0xDE9D99EE
	dc.l	0x99999999
	dc.l	0x99999999

	dc.l	0x99DD9E9D
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0xEE9EDD99
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999

	dc.l	0x99E99DD9
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0xEE99E9E9
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999

	dc.l	0x9D99D999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999966
	dc.l	0x99662222
	dc.l	0x622777A7
	dc.l	0x77AAAAAA

	dc.l	0xE9EE9DE9
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x66969999
	dc.l	0x22266226
	dc.l	0x77AA7777
	dc.l	0xAAAAAAAA

	dc.l	0x9ED9EE9E
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999966
	dc.l	0x69962222
	dc.l	0x22777AAA
	dc.l	0xAAAAAAAA

	dc.l	0x999E9EE9
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x96999999
	dc.l	0x22226699
	dc.l	0xAA777226
	dc.l	0xAAAAAA77

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x666666F6

	dc.l	0x23ECD9DE
	dc.l	0xC55599C9
	dc.l	0x55C53759
	dc.l	0x3CCC7772
	dc.l	0x27A7735A
	dc.l	0xAAAAA355
	dc.l	0x7AAA773C
	dc.l	0xAEEE2213

	dc.l	0xDEDF9DFE
	dc.l	0x99C0C9C9
	dc.l	0x5250C9C9
	dc.l	0x3535CCC2
	dc.l	0x73333555
	dc.l	0xAA75A777
	dc.l	0x735555A7
	dc.l	0x25555537

	dc.l	0xDEEDD9DD
	dc.l	0x9C999999
	dc.l	0x95999999
	dc.l	0x9C9FDD99
	dc.l	0xC22C9999
	dc.l	0x355599F9
	dc.l	0x3C555529
	dc.l	0x33FF5577

	dc.l	0x22119999
	dc.l	0xAAA77999
	dc.l	0x77735722
	dc.l	0xA755557A
	dc.l	0x735FC377
	dc.l	0xA33A75AA
	dc.l	0xAAAE277A
	dc.l	0xAEEA221A

	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x72199999
	dc.l	0xA777A221
	dc.l	0xAA777A77
	dc.l	0xAAAA7533
	dc.l	0xAAA77557
	dc.l	0xAAAAA7AA

	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x19999999
	dc.l	0x72233999
	dc.l	0xAA335999
	dc.l	0x77355C29
	dc.l	0xA733C557

actor_AnimWater_sheet_water_anim_frame_2:
	dc.l	0x777777AA
	dc.l	0xAAA5AA53
	dc.l	0xA77C577A
	dc.l	0x7A775AAA
	dc.l	0x7EAA77AA
	dc.l	0x2AEEAAAA
	dc.l	0x1272AAEA
	dc.l	0x12217777

	dc.l	0x7333537A
	dc.l	0xA77A3777
	dc.l	0xEAAAAAAA
	dc.l	0x2EEAAAAA
	dc.l	0x1277AE72
	dc.l	0x12227721
	dc.l	0x12227721
	dc.l	0x12227721

	dc.l	0xACF5CCAA
	dc.l	0x277F527E
	dc.l	0x27777772
	dc.l	0x27777711
	dc.l	0x22777711
	dc.l	0x22777711
	dc.l	0x22277711
	dc.l	0x22222221

	dc.l	0xAAAA221A
	dc.l	0xAAA72212
	dc.l	0xAAA7B212
	dc.l	0xAAA7B211
	dc.l	0xAAA2B211
	dc.l	0xAA72B211
	dc.l	0xAA22B211
	dc.l	0x7222BB11

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x66666622

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x22666662

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x22222000
	dc.l	0x22666662

	dc.l	0x99EDDE9E
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x9DE9EEDD
	dc.l	0x99999999
	dc.l	0x99999999

	dc.l	0xEE99EDE9
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0xDDED99EE
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999

	dc.l	0xEEDEE99E
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0xDDEED9D9
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999

	dc.l	0xE9EE9EEE
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999966
	dc.l	0x99662222
	dc.l	0x622777A7
	dc.l	0x77AAAAAA

	dc.l	0xD9DDE9DE
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x66969999
	dc.l	0x22266226
	dc.l	0x77AA7777
	dc.l	0xAAAAAAAA

	dc.l	0xED9EDD9D
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999966
	dc.l	0x69962222
	dc.l	0x22777AAA
	dc.l	0xAAAAAAAA

	dc.l	0xEEED9DD9
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x96999999
	dc.l	0x22226699
	dc.l	0xAA777226
	dc.l	0xAAAAAA77

	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x00000000
	dc.l	0x666666F6

	dc.l	0x23ECD9DE
	dc.l	0xC55599C9
	dc.l	0x55C53759
	dc.l	0x3CCC7772
	dc.l	0x27A7735A
	dc.l	0xAAAAA355
	dc.l	0x7AAA773C
	dc.l	0xAEEE2213

	dc.l	0xDEDF9DFE
	dc.l	0x99C0C9C9
	dc.l	0x5250C9C9
	dc.l	0x3535CCC2
	dc.l	0x73333555
	dc.l	0xAA75A777
	dc.l	0x735555A7
	dc.l	0x25555537

	dc.l	0xDEEDD9DD
	dc.l	0x9C999999
	dc.l	0x95999999
	dc.l	0x9C9FDD99
	dc.l	0xC22C9999
	dc.l	0x355599F9
	dc.l	0x3C555529
	dc.l	0x33FF5577

	dc.l	0x22119999
	dc.l	0xAAA77999
	dc.l	0x77735722
	dc.l	0xA755557A
	dc.l	0x735FC377
	dc.l	0xA33A75AA
	dc.l	0xAAAE277A
	dc.l	0xAEEA221A

	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x72199999
	dc.l	0xA777A221
	dc.l	0xAA777A77
	dc.l	0xAAAA7533
	dc.l	0xAAA77557
	dc.l	0xAAAAA7AA

	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x99999999
	dc.l	0x19999999
	dc.l	0x72233999
	dc.l	0xAA335999
	dc.l	0x77355C29
	dc.l	0xA733C557



stampanims_AnimWater:

actor_AnimWater_sheet_water_anim_anim_water_anim:
actor_AnimWater_sheet_water_anim_anim_water_anim_numframes: equ 0x3
actor_AnimWater_sheet_water_anim_anim_water_anim_speed: equ 0x19
actor_AnimWater_sheet_water_anim_anim_water_anim_track_frames:
	dc.l actor_AnimWater_sheet_water_anim_frame_0_header
	dc.l actor_AnimWater_sheet_water_anim_frame_1_header
	dc.l actor_AnimWater_sheet_water_anim_frame_2_header

	Even
actor_AnimWater_sheet_water_anim_anim_water_anim_track_posx:
	dc.b 0x00, 0x00, 0x00
	Even
actor_AnimWater_sheet_water_anim_anim_water_anim_track_posy:
	dc.b 0x00, 0x00, 0x00
	Even
actor_AnimWater_sheet_water_anim_anim_water_anim_track_sfx:
	dc.l 0x0, 0x0, 0x0
	Even

