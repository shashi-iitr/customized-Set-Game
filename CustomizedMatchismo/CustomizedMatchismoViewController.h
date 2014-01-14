//
//  CustomizedMatchismoViewController.h
//  CustomizedMatchismo
//
//  Created by shashi kumar on 12/28/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
@interface CustomizedMatchismoViewController : UIViewController
- (Deck *)creatDeck;
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card;
@property(nonatomic) NSUInteger startingCardCount;
@end
