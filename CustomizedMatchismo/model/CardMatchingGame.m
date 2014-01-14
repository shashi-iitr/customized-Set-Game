//
//  CardMatchingGame.m
//  CustomizedMatchismo
//
//  Created by shashi kumar on 12/28/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) NSString *messageFromMatch;
@property (nonatomic) NSMutableArray *cards;
@property (nonatomic) int gameDifficulty;
@property (nonatomic, strong) NSMutableArray *flippedHistory;


@property (nonatomic) int value;
@property (nonatomic, readwrite) int correctMatchCount;
@property (nonatomic, readwrite) int unCorrectMatchCount;




@end


@implementation CardMatchingGame


- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self=[super init];
    if (self) {
        for (int i=0; i<count; i++) {
            Card *card=[deck drawRandomCard];
            if(card){
                self.cards[i]=card;
                
            }else{
                self.cards=nil;
                
                break;
            }
        }
    }
    return self;
}


- (NSMutableArray *)cards{
    if(!_cards) _cards=[[NSMutableArray alloc] init];
    return _cards;
}


- (NSMutableArray *)flippedHistory{
    if(!_flippedHistory) _flippedHistory=[[NSMutableArray alloc] init];
    return _flippedHistory;
}


- (NSString *)flippedHistorywithScrollValue:(int)index{
    
    return self.flippedHistory[index] ;
}


#define MATCH_PENALTY 2
#define MATCH_BONUS 4
#define FLIP_COST 1



- (void)flipCardAtIndex:(NSUInteger)index{
    Card *card=[self cardAtIndex:index];
    
    if(card && !card.isUnplayable){
        if (!card.faceUp) {
            BOOL didFindAnOpenCard = NO;
            
            for (Card *otherCard in self.cards) {
                
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    didFindAnOpenCard = YES;
                    
                    
                    int matchScore=[card match:@[otherCard]];
                    if (matchScore) {
                        card.unplayable=YES;
                        otherCard.unplayable=YES;
                        self.score+=matchScore*MATCH_BONUS;
                        self.messageFromMatch=[NSString stringWithFormat:@"Matched %@ & %@ for points %d",card.contents, otherCard.contents, MATCH_BONUS];
                        
                    } else {
                        otherCard.faceUp=NO;
                        self.score-=MATCH_PENALTY;
                        self.messageFromMatch=[NSString stringWithFormat:@"%@ and %@ didn't match! %d points penalty", card.contents, otherCard.contents, MATCH_PENALTY];
                        
                    }
                    
                    break;
                }
            }
            
            if (!didFindAnOpenCard) {
                self.messageFromMatch=[NSString stringWithFormat:@"flipped card is %@", card.contents];
            }
            
            self.score-=FLIP_COST;
            
            [self.flippedHistory insertObject:self.messageFromMatch atIndex:self.value];
            self.value++;
        }
        card.faceUp=!card.isFaceUp;
    }
}





- (Card *)cardAtIndex:(NSUInteger)index{
    return (index<[self.cards count])?self.cards[index]: nil;
}





@end
