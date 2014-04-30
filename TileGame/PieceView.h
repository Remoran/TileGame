//
//  PieceView.h
//  TileGame
//
//  Created by Ryan on 4/7/14.
//  Copyright (c) 2014 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PieceView : UIImageView {
    int location;
}

@property (assign) int location;

@end
