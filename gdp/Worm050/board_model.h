// The board model

#ifndef _BOARD_MODEL_H
#define _BOARD_MODEL_H

#include "worm.h"
#include <curses.h>

// Positions on the board
struct pos {
  int y; // y-Coordinate (row)
  int x; // x-Coordinate (column)
};

// Placing and removing items from the game board
extern void placeItem(int y, int x, chtype symbol, enum ColorPair color_pair);

// Getters
extern int getLastRow();
extern int getLastCol();

#endif // #define _BOARD_MODEL_H
