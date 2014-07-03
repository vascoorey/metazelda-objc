//
//  Edge.m
//  metazelda
//
//  Created by Vasco d'Orey on 01/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import "Edge.h"
#import "Symbol.h"

@implementation Edge

+ (instancetype)edge {
  return [[self alloc] init];
}

+ (instancetype)edgeWithSymbol:(Symbol *)symbol {
  Edge *e = [self edge];
  e.symbol = symbol;
  return e;
}

- (BOOL)hasSymbol {
  return self.symbol != nil;
}

- (BOOL)isEqualToEdge:(Edge *)other {
  return [self.symbol isEqualToSymbol:other.symbol];
}

- (BOOL)isEqual:(id)object {
  if([object isKindOfClass:[self class]]) {
    return [self isEqualToEdge:object];
  } else {
    return [super isEqual:object];
  }
}

@end
