//
//  Bounds.m
//  metazelda
//
//  Created by Vasco d'Orey on 01/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import "Bounds.h"

@implementation Bounds

+ (instancetype)boundsForLeft:(int)left right:(int)right bottom:(int)bottom top:(int)top {
  Bounds *b = [[self alloc] init];
  b.left = left;
  b.right = right;
  b.top = top;
  b.bottom = bottom;
  return b;
}

- (int)height {
  return self.top - self.bottom + 1;
}

- (int)width {
  return self.right - self.bottom + 1;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"Bounds((%d,%d),(%d,%d))", self.left, self.top, self.right, self.bottom];
}

@end
