//
//  Condition.m
//  metazelda
//
//  Created by Vasco d'Orey on 01/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import "Condition.h"
#import "Symbol.h"

@implementation Condition

+ (instancetype)condition {
  Condition *c = [[self alloc] init];
  c.levelSwitch = [Switch switchFor:SwitchStateEither];
  return c;
}

+ (instancetype)conditionForSymbol:(Symbol *)symbol {
  Condition *c = [[self alloc] init];
  if(symbol.value == SymbolValueSwitchOff) {
    c.levelSwitch = [Switch switchFor:SwitchStateOff];
  } else if(symbol.value == SymbolValueSwitchOn) {
    c.levelSwitch = [Switch switchFor:SwitchStateOn];
  } else {
    c.keyLevel = symbol.value + 1;
    c.levelSwitch = [Switch switchFor:SwitchStateEither];
  }
  return c;
}

+ (instancetype)conditionFromCondition:(Condition *)other {
  return [other copy];
}

+ (instancetype)conditionForSwitchState:(SwitchState)state {
  Condition *c = [[self alloc] init];
  c.levelSwitch = [Switch switchFor:state];
  return c;
}

- (int)keyLevel {
  return _keyLevel;
}

- (Switch *)levelSwitch {
  return _levelSwitch;
}

- (id)copy {
  Condition *c = [[[self class] alloc] init];
  c.keyLevel = self.keyLevel;
  c.levelSwitch = [self.levelSwitch copy];
  return c;
}

- (BOOL)isEqualToCondition:(Condition *)other {
  return other.keyLevel == self.keyLevel && other.levelSwitch.state == self.levelSwitch.state;
}

- (BOOL)isEqual:(id)object {
  if([object isKindOfClass:[self class]]) {
    return [self isEqualToCondition:object];
  } else {
    return [super isEqual:object];
  }
}

- (void)addCondition:(Condition *)other {
  if(self.levelSwitch.state == SwitchStateEither) {
    self.levelSwitch.state = other.levelSwitch.state;
  } else {
    NSAssert(self.levelSwitch.state == other.levelSwitch.state, @"States should be equal");
  }
  self.keyLevel = self.keyLevel >= other.keyLevel ? self.keyLevel : other.keyLevel;
}

- (void)addSymbol:(Symbol *)symbol {
  if(symbol.value == SymbolValueSwitchOff) {
    self.levelSwitch.state = SwitchStateOff;
  } else if(symbol.value == SymbolValueSwitchOn) {
    self.levelSwitch.state = SwitchStateOn;
  } else {
    self.keyLevel = self.keyLevel >= (symbol.value + 1) ? self.keyLevel : symbol.value + 1;
  }
}

- (Condition *)andCondition:(Condition *)condition {
  if(!condition) return self;
  
  Condition *c = [self copy];
  [c addCondition:condition];
  return c;
}

- (Condition *)andSymbol:(Symbol *)symbol {
  Condition *c = [self copy];
  [c addSymbol:symbol];
  return c;
}

- (BOOL)impliesCondition:(Condition *)condition {
  return self.keyLevel >= condition.keyLevel && (self.levelSwitch.state == condition.levelSwitch.state || condition.levelSwitch.state == SwitchStateEither);
}

- (BOOL)impliesSymbol:(Symbol *)symbol {
  return [self impliesCondition:[[self class] conditionForSymbol:symbol]];
}

- (Symbol *)singleSymbolDifference:(Condition *)condition {
  if([self isEqualToCondition:condition]) return nil;
  
  if(self.levelSwitch.state == condition.levelSwitch.state) {
    return [Symbol symbolFor:(self.keyLevel >= condition.keyLevel ? self.keyLevel - 1 : condition.keyLevel - 1)];
  } else {
    if(self.keyLevel != condition.keyLevel) return nil;
    
    NSAssert(self.levelSwitch.state != condition.levelSwitch.state, @"Switch states should be different");
    if(self.levelSwitch.state != SwitchStateEither && condition.levelSwitch.state != SwitchStateEither) return nil;
    
    SwitchState newState = self.levelSwitch.state != SwitchStateEither ? self.levelSwitch.state : condition.levelSwitch.state;
    
    return [Symbol symbolFor:newState == SwitchStateOn ? SymbolValueSwitchOn : SymbolValueSwitchOff];
  }
}

- (NSString *)description {
  NSString *result = @"";
  if(self.keyLevel != 0) {
    result = [result stringByAppendingString:[Symbol symbolFor:self.keyLevel - 1].description];
  }
  if(self.levelSwitch.state != SwitchStateEither) {
    if(![result isEqualToString:@""]) {
      result = [result stringByAppendingString:@","];
    }
    result = [result stringByAppendingString:self.levelSwitch.symbol.description];
  }
  return result;
}

@end
