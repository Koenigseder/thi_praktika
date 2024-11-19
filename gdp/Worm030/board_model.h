// The board model

#ifndef _BOARD_MODEL_H
#define _BOARD_MODEL_H

#include "worm.h"
#include <curses.h>

// Placing and removing items from the game board
extern void placeItem(int y, int x, chtype symbol, enum ColorPair color_pair);

// Getters
extern int getLastRow();
extern int getLastCol();

#endif // #define _BOARD_MODEL_H
