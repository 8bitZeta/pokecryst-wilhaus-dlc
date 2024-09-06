BattleCommand_Hex:
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and a
	ret z
    
	jp DoubleDamage