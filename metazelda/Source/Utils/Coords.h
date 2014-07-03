//
//  Coords.h
//  metazelda
//
//  Created by Vasco d'Orey on 03/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Direction;

@interface Coords : NSObject

@property (nonatomic, readonly) int x;
@property (nonatomic, readonly) int y;

+ (instancetype)coords:(int)x y:(int)y;

- (instancetype)nextInDirection:(Direction *)d;
- (instancetype)add:(int)dx dy:(int)dy;
- (instancetype)subtract:(Coords *)other;

- (BOOL)isEqualToCoords:(Coords *)other;
- (NSComparisonResult)compare:(Coords *)other;

- (BOOL)isAdjacentToCoords:(Coords *)other;

- (Direction *)directionTo:(Coords *)other;
- (double)distanceTo:(Coords *)other;

@end
