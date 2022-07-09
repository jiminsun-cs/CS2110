#ifndef MAIN_H
#define MAIN_H

#include "gba.h"
#define N_CANDIES (2)
#define CHAR_HEIGHT (10)
#define CHAR_WIDTH (10)
#define CANDY_HEIGHT (10)
#define CANDY_WIDTH (10)
// TODO: Create any necessary structs

struct character {
    int x;
    int y;
};

struct candy {
    int x;
    int y;
    int dx;
    int dy;
};

struct state {
    struct character character;
    int ncandies;
    struct candy candies_display[N_CANDIES];
};

struct state curr, prev;
struct candy *cc, *oc;

#endif
/*
* For example, for a Snake game, one could be:
*
* struct snake {
*   int heading;
*   int length;
*   int row;
*   int col;
* };
*
* Example of a struct to hold state machine data:
*
* struct state {
*   int currentState;
*   int nextState;
* };
*
*/
//struct