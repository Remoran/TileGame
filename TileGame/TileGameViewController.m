//
//  TileGameViewController.m
//  TileGame
//
//  Created by Ryan on 4/7/14.
//  Copyright (c) 2014 Ryan. All rights reserved.
//

#import "TileGameViewController.h"
#import "PieceView.h"

@interface Puzzle15ViewController ()

@end

@implementation Puzzle15ViewController
@synthesize pieces;


- (void)viewDidLoad
{
    [super viewDidLoad];
    empty = 15;
    for (PieceView *piece in pieces){
        piece.location = piece.tag;
        piece.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [piece addGestureRecognizer:tapper];
        
        UIPanGestureRecognizer *panner = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [piece addGestureRecognizer:panner];
    }
}

-(void)tap:(UITapGestureRecognizer *)gesture
{
    [self movePiece:(PieceView *)gesture.view];
}

const int kSize = 70;

-(void)movePiece:(PieceView *)aPiece
{
    if([self isMovable:aPiece.location]){
        CGRect newFrame = aPiece.frame;
        newFrame.origin.x = kSize * (empty % 4);
        newFrame.origin.y = kSize * (empty / 4);
        aPiece.frame = newFrame;
        
        int oldempty = empty;
        empty = aPiece.location;
        aPiece.location = oldempty;
    }
}

enum {
    Left = 1,
    Right = 2,
    Up = 3,
    Down = 4,
};

-(int)isMovable:(int)tapPos
{
    int result = 0;
    if (tapPos == (empty - 4)) {
        result = Down;
    } else if (tapPos == (empty + 4)) {
        result = Up;
    } else if (((tapPos % 4) != 0) && (tapPos - 1) == empty) {
        result = Left;
    } else if (((tapPos % 4) != 3) && (tapPos + 1) == empty) {
        result = Right;
    }
    return result;
}


-(void)pan:(UIPanGestureRecognizer *)gesture
{
    PieceView *aPiece = (PieceView *)gesture.view;
    int direction = [self isMovable:aPiece.location];
    if (direction) {
        if ((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded)){
            CGPoint translation = [gesture translationInView:aPiece];
            if ((direction == Left) && (translation.x < 0)) {
                panning = YES;
                aPiece.center = CGPointMake(aPiece.center.x +translation.x, aPiece.center.y);
            } else if ((direction == Right) && (translation.x > 0)) {
                panning = YES;
                aPiece.center = CGPointMake(aPiece.center.x+translation.x,aPiece.center.y);
            } else if ((direction == Up) && (translation.y < 0)) {
                panning = YES;
                aPiece.center = CGPointMake(aPiece.center.x, aPiece.center.y + translation.y);
            } else if ((direction == Down) && (translation.y > 0)) {
                panning = YES;
                aPiece.center = CGPointMake(aPiece.center.x, aPiece.center.y+translation.y);
            }
            [gesture setTranslation:CGPointZero inView:aPiece];
        }
        
        if (gesture.state == UIGestureRecognizerStateEnded) {
            if (panning)[self movePiece:aPiece];
            panning = NO;
        }
    }
}

- (IBAction)shufflePieces:(id)sender {
    for (int i = 0; i < 100; i++) {
        [self movePiece:[pieces objectAtIndex:rand() % pieces.count]];
    }
}

@end
