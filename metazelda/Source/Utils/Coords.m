//
//  Coords.m
//  metazelda
//
//  Created by Vasco d'Orey on 03/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import "Coords.h"
#import "Direction.h"

@interface Coords ()

@property (nonatomic, readwrite) int x;
@property (nonatomic, readwrite) int y;

@end

@implementation Coords

+ (instancetype)coords:(int)x y:(int)y {
  Coords *c = [[self alloc] init];
  c.x = x;
  c.y = y;
  return c;
}

- (instancetype)nextInDirection:(Direction *)d {
  return [self add:d.x dy:d.y];
}

- (instancetype)add:(int)dx dy:(int)dy {
  Coords *new = [[[self class] alloc] init];
  new.x = self.x + dx;
  new.y = self.y + dy;
  return new;
}

- (instancetype)subtract:(Coords *)other {
  return [self add:-other.x dy:-other.y];
}

- (BOOL)isEqualToCoords:(Coords *)other {
  return self.x == other.x && self.y == other.y;
}

- (BOOL)isEqual:(id)object {
  if([object isKindOfClass:[self class]]) {
    return [self isEqualToCoords:object];
  } else {
    return [super isEqual:object];
  }
}

- (NSComparisonResult)compare:(Coords *)other {
  int d = self.x - other.x;
  if(d == 0) {
    d = self.y - other.y;
  }
  return d < 0 ? NSOrderedAscending : (d == 0 ? NSOrderedSame : NSOrderedDescending);
}

- (BOOL)isAdjacentToCoords:(Coords *)other {
  int dx = abs(self.x - other.x);
  int dy = abs(self.y - other.y);
  return (dx == 1 && dy == 0) || (dx == 0 && dy == 1);
}

- (Direction *)directionTo:(Coords *)other {
  int dx = self.x - other.x;
  int dy = self.y - other.y;
  
  NSAssert(dx == 0 || dy == 0, @"Coords should align on one axis");
  NSAssert(![self isEqualToCoords:other], @"Coords can't be equal");
  
  if(dx < 0) {
    return [Direction directionFromValue:DirectionValueEast];
  } else if(dx > 0) {
    return [Direction directionFromValue:DirectionValueWest];
  } else if(dy < 0) {
    return [Direction directionFromValue:DirectionValueSouth];
  } else {
    return [Direction directionFromValue:DirectionValueNorth];
  }
}

- (double)distanceTo:(Coords *)other {
  int dx = self.x - other.x;
  int dy = self.y - other.y;
  return sqrt(dx * dx + dy * dy);
}

- (NSString *)description {
  return [NSString stringWithFormat:@"(%d, %d)", self.x, self.y];
}

@end
