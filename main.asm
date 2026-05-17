----- Hamza Masood -----

.MODEL SMALL
.STACK 100h

.DATA
    ; --- Player Variables ---
    playerX DB 40
    playerY DB 22

    ; --- Target Variables ---
    targetX DB 40
    targetY DB 4

    ; --- Game Logic Variables ---
    score DB 0
    lastTick DW 0
    tickCount DW 0
    fallSpeed DW 1

    ; --- Strings ---
    msgScore DB " SYSTEM SCORE: $"
    msgGameOver DB " CRITICAL FAILURE: EMBER DROPPED $"
    msgQuit DB " SYSTEM OFFLINE. $"
    msgRestart DB " [R] REBOOT SYSTEM  |  [Q] ABORT $"

.CODE

EXTRN CLEAR_SCREEN:PROC
EXTRN DRAW_HUD:PROC
EXTRN DRAW_BORDER:PROC
EXTRN DRAW_PLAYER:PROC
EXTRN DRAW_TARGET:PROC
EXTRN DRAW_SCORE:PROC
EXTRN GET_INPUT:PROC
EXTRN ERASE_TARGET:PROC
EXTRN MOVE_TARGET:PROC
EXTRN CHECK_COLLISION:PROC
EXTRN SET_CURSOR:PROC

PUBLIC playerX
PUBLIC playerY
PUBLIC targetX
PUBLIC targetY
PUBLIC score
PUBLIC msgScore
PUBLIC msgGameOver
PUBLIC msgQuit
PUBLIC msgRestart

MAIN PROC

    MOV AX,@DATA
    MOV DS,AX

RESTART_SYSTEM:

    MOV score,0
    MOV playerX,40
    MOV targetY,4
    MOV tickCount,0

    MOV AH,00h
    INT 1Ah
    MOV lastTick,DX

    CALL CLEAR_SCREEN
    CALL DRAW_HUD
    CALL DRAW_BORDER
    CALL DRAW_PLAYER
    CALL DRAW_TARGET
    CALL DRAW_SCORE

GAME_LOOP:

    CALL GET_INPUT

    CALL CHECK_TIMER
    CMP AL,1
    JNE GAME_LOOP

    CALL ERASE_TARGET
    CALL MOVE_TARGET
    CALL CHECK_COLLISION
    CALL DRAW_TARGET
    CALL DRAW_SCORE

    JMP GAME_LOOP

QUIT_GAME:

    CALL CLEAR_SCREEN

    MOV DH,12
    MOV DL,30
    CALL SET_CURSOR

    LEA DX,msgQuit
    MOV AH,09h
    INT 21h

    JMP EXIT_GAME

SHOW_GAME_OVER:

    CALL CLEAR_SCREEN

    MOV DH,11
    MOV DL,22
    CALL SET_CURSOR

    LEA DX,msgGameOver
    MOV AH,09h
    INT 21h

    MOV DH,13
    MOV DL,22
    CALL SET_CURSOR

    LEA DX,msgRestart
    MOV AH,09h
    INT 21h

WAIT_FOR_RESTART:

    MOV AH,00h
    INT 16h

    CMP AL,'r'
    JE RESTART_SYSTEM

    CMP AL,'R'
    JE RESTART_SYSTEM

    CMP AL,'q'
    JE QUIT_GAME

    CMP AL,'Q'
    JE QUIT_GAME

    JMP WAIT_FOR_RESTART

EXIT_GAME:

    MOV AH,4Ch
    INT 21h

MAIN ENDP

CHECK_TIMER PROC

    MOV AH,00h
    INT 1Ah

    CMP DX,lastTick
    JE NO_TICK

    MOV lastTick,DX

    INC tickCount

    MOV AX,fallSpeed
    CMP tickCount,AX
    JL NO_TICK

    MOV tickCount,0
    MOV AL,1
    RET

NO_TICK:

    MOV AL,0
    RET

CHECK_TIMER ENDP

END MAIN
