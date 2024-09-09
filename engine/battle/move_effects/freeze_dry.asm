BattleCommand_FreezeDry:
	ld de, wEnemyMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, .checkwater
	ld de, wBattleMonType1
	
.checkwater

	ld a, [de]
	cp WATER
	jr z, .water
	ret
	inc de
	ld a, [de]
	cp WATER
	jr z, .water

	ret

.water
	call DoubleDamage
	jp DoubleDamage