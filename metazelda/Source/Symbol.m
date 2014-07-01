//
//  Symbol.m
//  metazelda
//
//  Created by Vasco d'Orey on 01/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import "Symbol.h"

@interface Symbol ()

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, readwrite) SymbolValue value;

- (id)initWithValue:(int)value;

@end

@implementation Symbol

+ (instancetype)symbolFor:(int)symbolValue {
  Symbol *s = [[self alloc] initWithValue:symbolValue];
  return s;
}

- (id)initWithValue:(int)value {
  self = [super init];
  if(!self) return nil;
  
  NSString *name = @"";
  switch (value) {
    case SymbolValueStart:
      name = @"Start";
      break;
    case SymbolValueGoal:
      name = @"Goal";
      break;
    case SymbolValueBoss:
      name = @"Boss";
      break;
    case SymbolValueSwitchOn:
      name = @"ON";
      break;
    case SymbolValueSwitchOff:
      name = @"OFF";
      break;
    case SymbolValueSwitch:
      name = @"SW";
      break;
    default:
      if(value >= 0 && value < 26) {
        name = [NSString stringWithFormat:@"%c", (char)((int)'A' + value)];
      } else {
        name = [NSString stringWithFormat:@"%d", value];
      }
      break;
  }
  _name = name;
  _value = value;
  
  return self;
}

- (id)copy {
  Symbol *other = [[self class] symbolFor:self.value];
  return other;
}

- (BOOL)isStart {
  return self.value == SymbolValueStart;
}

- (BOOL)isGoal {
  return self.value == SymbolValueGoal;
}

- (BOOL)isBoss {
  return self.value == SymbolValueBoss;
}

- (BOOL)isSwitch {
  return self.value == SymbolValueSwitch;
}

- (BOOL)isSwitchState {
  return self.value == SymbolValueSwitchOn || self.value == SymbolValueSwitchOff;
}

- (NSUInteger)hash {
  return (NSUInteger)self.value;
}

- (NSString *)description {
  return self.name;
}

- (BOOL)isEqualToSymbol:(Symbol *)other {
  return self.value == other.value;
}

- (BOOL)isEqual:(id)object {
  if([object isKindOfClass:[self class]]) {
    return [self isEqualToSymbol:object];
  } else {
    return [super isEqual:object];
  }
}

@end
