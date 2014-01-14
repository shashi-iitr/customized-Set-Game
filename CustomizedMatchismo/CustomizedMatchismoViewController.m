//
//  CustomizedMatchismoViewController.m
//  CustomizedMatchismo
//
//  Created by shashi kumar on 12/28/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "CustomizedMatchismoViewController.h"
#import "CardMatchingGame.h"
#import "Deck.h"

@interface CustomizedMatchismoViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *reset;
@end

@implementation CustomizedMatchismoViewController

#pragma mark - View lifecycle

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.startingCardCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card=[self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card {
    
}

- (CardMatchingGame *)game{
    if(!_game) _game=[[CardMatchingGame alloc] initWithCardCount:self.startingCardCount  usingDeck:[self creatDeck]];
    return _game;
}

- (Deck *)creatDeck {
    return nil;
}

// updateUI matches the model, model will update the cardButtons eachtime

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        self.game=nil;
        self.flipCount=0;
        [self updateUI];
        
        
        
    } else {
        
    }
}

#pragma mark - Update UI

//reflect model in UI and set title for selected and not selected state
- (void)updateUI {
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath=[self.cardCollectionView indexPathForCell:cell];
        Card *card=[self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];
    }
    self.scoreLabel.text=[NSString stringWithFormat:@"score: %d",self.game.score];
    
}


- (void)setFlipCount:(int)flipCount{
    _flipCount=flipCount;
    self.flipLabel.text=[NSString stringWithFormat:@"flips: %d", self.flipCount];
    
}


// models decide which button is in selected state
- (IBAction)flipCard:(UITapGestureRecognizer *) gesture {
    CGPoint tapLocation=[gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath=[self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
        
        self.flipCount++;
        
        [self updateUI];
    }
    
    
}


#pragma mark - Helpers

- (IBAction)resetGame:(id)sender {
    
    [[[UIAlertView alloc] initWithTitle:@"Next Question"
                                message:@"are you sure"
                               delegate:self
                      cancelButtonTitle:@"cancel"
                      otherButtonTitles:@"OK" ,nil] show];
    
}



@end
