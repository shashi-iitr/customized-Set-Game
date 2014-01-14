//
//  PlayingCardCollectionViewCell.h
//  CustomizedMatchismo
//
//  Created by shashi kumar on 12/28/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGPlayingCard.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet SGPlayingCard *playingCardView;

@end
