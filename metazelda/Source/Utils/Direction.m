//
//  Direction.m
//  metazelda
//
//  Created by Vasco d'Orey on 03/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import "Direction.h"

@interface Direction ()

@property (nonatomic, readwrite) DirectionValue code;
@property (nonatomic, readwrite) int x;
@property (nonatomic, readwrite) int y;

@end

@implementation Direction

+ (instancetype)direction:(DirectionValue)direction x:(int)x y:(int)y {
  Direction *d = [[self alloc] init];
  d.code = direction;
  d.x = x;
  d.y = y;
  return d;
}

+ (instancetype)directionFromValue:(DirectionValue)direction {
  Direction *d = [[self alloc] init];
  d.code = direction;
  switch(direction) {
    case DirectionValueNorth:
      d.x = 0;
      d.y = -1;
      break;
    case DirectionValueEast:
      d.x = 1;
      d.y = 0;
      break;
    case DirectionValueSouth:
      d.x = 0;
      d.y = 1;
      break;
    case DirectionValueWest:
      d.x = -1;
      d.y = 0;
      break;
  }
  return d;
}

+ (instancetype)oppositeDirectionTo:(Direction *)other {
  switch(other.code) {
    case DirectionValueNorth:
      return [self directionFromValue:DirectionValueSouth];
    case DirectionValueEast:
      return [self directionFromValue:DirectionValueWest];
    case DirectionValueSouth:
      return [self directionFromValue:DirectionValueNorth];
    case DirectionValueWest:
      return [self directionFromValue:DirectionValueEast];
  }
  return nil;
}

@end
