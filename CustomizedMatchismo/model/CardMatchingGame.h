//
//  CardMatchingGame.h
//  CustomizedMatchismo
//
//  Created by shashi kumar on 12/28/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject
- (id) initWithCardCount:(NSUInteger)count
               usingDeck: (Deck *)deck;
- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;


- (NSString *)flippedHistorywithScrollValue:(int)index;

@property (readonly, nonatomic) int score;
@property (readonly ,nonatomic) NSString *messageFromMatch;

@property (readonly, nonatomic) int correctMatchCount;
@property (readonly, nonatomic) int unCorrectMatchCount;


@property (readonly, nonatomic) NSMutableArray *flippedHistory;
@end
