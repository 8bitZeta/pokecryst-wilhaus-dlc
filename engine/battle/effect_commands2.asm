INCLUDE "engine/battle/move_effects/hex.asm"

INCLUDE "engine/battle/move_effects/venoshock.asm"

INCLUDE "engine/battle/move_effects/close_combat.asm"

INCLUDE "engine/battle/move_effects/overheat.asm"

INCLUDE "engine/battle/move_effects/acrobatics.asm"

INCLUDE "engine/battle/move_effects/hail.asm"

INCLUDE "engine/battle/move_effects/brick_break.asm"

INCLUDE "engine/battle/move_effects/facade.asm"

INCLUDE "engine/battle/move_effects/freeze_dry.asm"

INCLUDE "engine/battle/move_effects/refresh.asm"

;INCLUDE "engine/battle/move_effects/payback.asm"

INCLUDE "engine/battle/move_effects/dragon_dance.asm"

INCLUDE "engine/battle/move_effects/bulk_up.asm"

INCLUDE "engine/battle/move_effects/calm_mind.asm"

INCLUDE "engine/battle/move_effects/cosmic_power.asm"


BattleCommand_DoubleFlyingDamage:
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	bit SUBSTATUS_FLYING, a
	ret z
	jr DoubleDamage

BattleCommand_DoubleUndergroundDamage:
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	bit SUBSTATUS_UNDERGROUND, a
	ret z

	; fallthrough

DoubleDamage:
	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	jr nc, .quit

	ld a, $ff
	ld [hli], a
	ld [hl], a
.quit
	ret

BattleCommand_ResetStats:
	ld a, BASE_STAT_LEVEL
	ld hl, wPlayerStatLevels
	call .Fill
	ld hl, wEnemyStatLevels
	call .Fill

	ldh a, [hBattleTurn]
	push af

	call SetPlayerTurn
	call CalcPlayerStats
	call SetEnemyTurn
	call CalcEnemyStats

	pop af
	ldh [hBattleTurn], a

	call AnimateCurrentMove

	ld hl, EliminatedStatsText
	jp StdBattleTextbox

.Fill:
	ld b, NUM_LEVEL_STATS
.next
	ld [hli], a
	dec b
	jr nz, .next
	ret

