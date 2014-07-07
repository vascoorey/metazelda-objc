//
//  Direction.h
//  metazelda
//
//  Created by Vasco d'Orey on 03/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

@import Foundation;

typedef NS_ENUM(int, DirectionValue) {
  DirectionValueNorth = 0,
  DirectionValueEast,
  DirectionValueSouth,
  DirectionValueWest
};

static const int NumberOfDirections = 4;

@interface Direction : NSObject

@property (nonatomic, readonly) DirectionValue code;
@property (nonatomic, readonly) int x;
@property (nonatomic, readonly) int y;

+ (instancetype)direction:(DirectionValue)direction x:(int)x y:(int)y;
+ (instancetype)directionFromValue:(DirectionValue)direction;

+ (instancetype)oppositeDirectionTo:(Direction *)other;

@end
