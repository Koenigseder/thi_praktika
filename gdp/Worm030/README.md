# Worm030

## New in this version

Separated compilation of source code:

- We split our single program file into multiple C-files and corresponding header files

- We separate declaration and corresponding code according to responsibilities:
    - `prep.*`: Basic preparation of the application (curses)
    - `worm_model.*`: Worm data structures and manipulation functions
    - `board_model.*`:
        - Put Items onto the game board
        - Check dimensions of game board
        - Better motivation later when we store cell occupation, too.
    - `worm.*`: Main code of the game
- More complex Makefile

## Usage

During runtime following keys are treated in a special way:
- `Arrow keys`: Control the worm
- `q`: Exit the game
- `s`: Activate single-step mode
- `space`: Exit single-step mode

