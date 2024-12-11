# Worm050

## New in this version

- Introduction structures:
  - `struct pos`: stores y & x positions
  - `struct worm`: stores all components of a worm

- Storage location of userworm object moves from `worm_model.c` to `worm.c`. Thus, a pointer to the worm structure needs to be passed arround

- Enhancement: no longer global variables in worm_model.c

- Preparation for multiple worms

- Introduction of a message area:
  - There is a separated and reserved area at the bottom of the screen
  - All status messages and dialogs use this area
  - Reason why game ended can be displayed without corruption of game are

## Usage

During runtime following keys are treated in a special way:
- `Arrow keys`: Control the worm
- `q`: Exit the game
- `s`: Activate single-step mode
- `space`: Exit single-step mode
