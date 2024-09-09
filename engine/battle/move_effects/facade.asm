BattleCommand_Facade:
ld hl, wBattleMonStatus
    ldh a, [hBattleTurn]
    and a
    jr z, .got_user
    ld hl, wEnemyMonStatus
.got_user
    bit BRN, [hl]
    jp nz, DoubleDamage

    bit PAR, [hl]
    jp nz, DoubleDamage

    bit PSN, [hl]
    jp nz, DoubleDamage
    ret