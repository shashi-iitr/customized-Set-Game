//
//  Deck.h
//  CustomizedMatchismo
//
//  Created by shashi kumar on 12/28/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject

- (void) addCard:(Card *)card atTop: (BOOL) atTop;
- (Card *) drawRandomCard;

@end
