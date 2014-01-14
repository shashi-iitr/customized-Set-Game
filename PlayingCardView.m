//
//  SGPlayingCard.m
//  MatchCards
//
//  Created by shashi kumar on 12/26/13.
//  Copyright (c) 2013 HCS. All rights reserved.
//

#import "SGPlayingCard.h"

@interface SGPlayingCard ()
@property (nonatomic) CGFloat faceCardScaleFactor;

@end

@implementation SGPlayingCard

@synthesize faceCardScaleFactor=_faceCardScaleFactor;

#define RADIUS 12.0
#define FACE_CARD_SCALE_FACTOR 0.90
#define CORNER_RADIUS 4.0
#define PIP_FONT_SCALE_FACTOR 0.16
#define CORNER_OFFSET 0.5
#define PIP_HOFFSET_PERCENTAGE 0.165
#define PIP_VOFFSET1_PERCENTAGE 0.090
#define PIP_VOFFSET2_PERCENTAGE 0.175
#define PIP_VOFFSET3_PERCENTAGE 0.270

- (void)drawRect:(CGRect)rect{
 // Drawing code
    UIBezierPath *roundRect=[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:RADIUS];
    [roundRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    if (self.faceUp) {
        // Check whether there's an image to represent the card
        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@.png", [self rankAsString], self.suit]];
        if (faceImage) {
            // We have an image - use it
            CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width * (1.0 - FACE_CARD_SCALE_FACTOR), self.bounds.size.height * (1.0 - FACE_CARD_SCALE_FACTOR));
            [faceImage drawInRect:imageRect];
        } else {
            // We don't have an image - fill the card with pips
            [self drawPips];
        }
        
        // Draw the contents that go on the card's corners
        [self drawCorner];
    } else {
        // Use the card back image
        [[UIImage imageNamed:@"CardBack.png"] drawInRect:self.bounds];
    }

    
    [[UIColor blackColor] setStroke];
    [roundRect stroke];
    
    [self drawCorner];
}

- (CGFloat)faceCardScaleFactor {
    if (!_faceCardScaleFactor) {
        _faceCardScaleFactor=FACE_CARD_SCALE_FACTOR;
    }
    return _faceCardScaleFactor;
}

-(void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor {
    _faceCardScaleFactor=faceCardScaleFactor;
    [self setNeedsDisplay];
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    if ((gesture.state==UIGestureRecognizerStateChanged) || (gesture.state==UIGestureRecognizerStateEnded)) {
        self.faceCardScaleFactor=gesture.scale;
        gesture.scale=1;
    }
}

- (void)drawCorner {
    NSMutableParagraphStyle *paragrapgStyle=[[NSMutableParagraphStyle alloc] init];
    
    paragrapgStyle.alignment=NSTextAlignmentCenter;
    
    UIFont *cornerFont=[UIFont systemFontOfSize:self.bounds.size.width*0.20];
    
    NSAttributedString *cornerText=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit ] attributes:@{NSParagraphStyleAttributeName: paragrapgStyle, NSFontAttributeName:cornerFont}];
    
    CGRect textBounds;
    textBounds.origin=CGPointMake(2.0, 2.0);
    textBounds.size=[cornerText size];
    [cornerText drawInRect:textBounds];
    
    [self pushContextAndRotate];
    [cornerText drawInRect:textBounds];
    [self popContext];
}

- (NSString *)rankAsString {
    
        return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
    

}

- (void)pushContextAndRotate {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);

}

- (void)popContext {
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (void)drawPips {
    if (self.rank == 1 || self.rank == 5 || self.rank == 9 || self.rank == 3) {
        [self drawPipsWithHorizontalOffset:0 verticalOffset:0 mirroredVertically:NO];
    }
    
    if (self.rank == 6 || self.rank == 7 || self.rank == 8) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE verticalOffset:0 mirroredVertically:NO];
    }
    
    if (self.rank == 2 || self.rank == 3 || self.rank == 7 || self.rank == 8 || self.rank == 10) {
        [self drawPipsWithHorizontalOffset:0 verticalOffset:PIP_VOFFSET2_PERCENTAGE mirroredVertically:(self.rank != 7)];
    }
    
    if (self.rank == 4 || self.rank == 5 || self.rank == 6 || self.rank == 7 || self.rank == 8 || self.rank == 9 || self.rank == 10) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE verticalOffset:PIP_VOFFSET3_PERCENTAGE mirroredVertically:YES];
    }
    
    if (self.rank == 9 || self.rank == 10) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE verticalOffset:PIP_VOFFSET1_PERCENTAGE mirroredVertically:YES];
    }
}

// Draws the card pips with horizontal spacing and mirrored as necessary.
- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset verticalOffset:(CGFloat)voffset mirroredVertically:(BOOL)mirroredVertically {
    [self drawPipsWithHorizontalOffset:hoffset verticalOffset:voffset upsideDown:NO];
    if (mirroredVertically) {
        [self drawPipsWithHorizontalOffset:hoffset verticalOffset:voffset upsideDown:YES];
    }
}

// Draws the card pips with horizontal spacing and upside-down as necessary.
- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset verticalOffset:(CGFloat)voffset upsideDown:(BOOL)upsideDown {
    if (upsideDown) {
        [self pushContextAndRotate];
    }
    
    CGPoint middle = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    UIFont *pipFont = [UIFont systemFontOfSize:self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
    NSAttributedString *attributedSuit = [[NSAttributedString alloc] initWithString:self.suit attributes:@{NSFontAttributeName : pipFont}];
    CGSize pipSize = [attributedSuit size];
    CGPoint pipOrigin = CGPointMake(middle.x - pipSize.width / 2.0 - hoffset * self.bounds.size.width, middle.y - pipSize.height / 2.0 - voffset * self.bounds.size.height);
    
    [attributedSuit drawAtPoint:pipOrigin];
    
    if (hoffset) {
        pipOrigin.x += hoffset * 2.0 * self.bounds.size.width;
        [attributedSuit drawAtPoint:pipOrigin];
    }
    
    if (upsideDown) {
        [self popContext];
    }
}


#pragma mark - setter

- (void)setRank:(NSUInteger)rank {
    _rank=rank;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit {
    _suit=suit;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp {
    _faceUp=faceUp;
    [self setNeedsDisplay];
}

#pragma mark - initialization

- (void)setUp {
    
}

- (void)awakeFromNib {
    [self setUp];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setUp];
    return self;
}


@end
