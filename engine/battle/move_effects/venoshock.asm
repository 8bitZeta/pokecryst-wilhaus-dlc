BattleCommand_Venoshock:
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and 1 << PSN
	ret z
    
	jp DoubleDamage