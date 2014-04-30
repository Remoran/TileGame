//
//  TileGameViewController.h
//  TileGame
//
//  Created by Ryan on 4/7/14.
//  Copyright (c) 2014 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieceView.h"

@interface Puzzle15ViewController : UIViewController {
    NSArray *pieces;
    int empty;
    BOOL panning;
}

@property (retain, nonatomic) IBOutletCollection(PieceView) NSArray *pieces;

- (IBAction)shufflePieces:(id)sender;

@end
