------- MALIK SHAHBAZ ---------








------- HAMZA MASOOD -----------
.MODEL SMALL

.DATA

EXTRN playerX:BYTE
EXTRN playerY:BYTE

.CODE

EXTRN DRAW_PLAYER:PROC
EXTRN ERASE_PLAYER:PROC
EXTRN QUIT_GAME:PROC

PUBLIC GET_INPUT

GET_INPUT PROC

    MOV AH,01h
    INT 16h
    JZ NO_KEY

    MOV AH,00h
    INT 16h

    CMP AL,'a'
    JE MOVE_LEFT

    CMP AL,'A'
    JE MOVE_LEFT

    CMP AH,4Bh
    JE MOVE_LEFT

    CMP AL,'d'
    JE MOVE_RIGHT

    CMP AL,'D'
    JE MOVE_RIGHT

    CMP AH,4Dh
    JE MOVE_RIGHT

    CMP AL,'q'
    JE EXIT_NOW

    CMP AL,'Q'
    JE EXIT_NOW

    RET

MOVE_LEFT:

    CMP playerX,3
    JLE NO_KEY

    CALL ERASE_PLAYER
    SUB playerX,2
    CALL DRAW_PLAYER

    RET

MOVE_RIGHT:

    CMP playerX,76
    JGE NO_KEY

    CALL ERASE_PLAYER
    ADD playerX,2
    CALL DRAW_PLAYER

    RET

EXIT_NOW:

    JMP QUIT_GAME

NO_KEY:

    RET

GET_INPUT ENDP

END

----------- MUHAMMAD WAQAR -------------------

















----------- ABDUL MUNAM -----------------------
    
