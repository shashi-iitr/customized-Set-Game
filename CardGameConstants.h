//
//  CardGameConstants.h
//  Matchismo
//
//  Created by Carlos M. Santiago on 3/12/13.
//  Copyright (c) 2013 Carlos M. Santiago. Some rights reserved.
//

// Constants
#define OK_BUTTON_TITLE @"OK"
#define CANCEL_BUTTON_TITLE @"Cancel"
#define OK_BUTTON_INDEX 1
#define CANCEL_BUTTON_INDEX 0

typedef enum {
    SetCardSymbolDiamond = 1,
    SetCardSymbolSquiggle = 2,
    SetCardSymbolOval = 3
} SetCardSymbol;

typedef enum {
    SetCardShadingSolid = 1,
    SetCardShadingStriped = 2,
    SetCardShadingOpen = 3
} SetCardShading;

typedef enum {
    SetCardColorRed = 1,
    SetCardColorGreen = 2,
    SetCardColorPurple = 3
} SetCardColor;
