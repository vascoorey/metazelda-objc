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
  c->_levelSwitch = [Switch switchFor:SwitchStateEither];
  return c;
}

+ (instancetype)conditionForSymbol:(Symbol *)symbol {
  Condition *c = [[self alloc] init];
  if(symbol.value == SymbolValueSwitchOff) {
    c->_levelSwitch = [Switch switchFor:SwitchStateOff];
  } else if(symbol.value == SymbolValueSwitchOn) {
    c->_levelSwitch = [Switch switchFor:SwitchStateOn];
  } else {
    c->_keyLevel = symbol.value + 1;
    c->_levelSwitch = [Switch switchFor:SwitchStateEither];
  }
  return c;
}

+ (instancetype)conditionFromCondition:(Condition *)other {
  return [other copy];
}

+ (instancetype)conditionForSwitchState:(SwitchState)state {
  Condition *c = [[self alloc] init];
  c->_levelSwitch = [Switch switchFor:state];
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
  c->_keyLevel = _keyLevel;
  c->_levelSwitch = [_levelSwitch copy];
  return c;
}

- (BOOL)isEqualToCondition:(Condition *)other {
  return other->_keyLevel == self->_keyLevel && other->_levelSwitch.state == self->_levelSwitch.state;
}

- (BOOL)isEqual:(id)object {
  if([object isKindOfClass:[self class]]) {
    return [self isEqualToCondition:object];
  } else {
    return [super isEqual:object];
  }
}

- (void)addCondition:(Condition *)other {
  if(_levelSwitch.state == SwitchStateEither) {
    _levelSwitch.state = other->_levelSwitch.state;
  } else {
    NSAssert(_levelSwitch.state == other->_levelSwitch.state, @"States should be equal");
  }
  _keyLevel = MAX(_keyLevel, other->_keyLevel);
}

- (void)addSymbol:(Symbol *)symbol {
  if(symbol.value == SymbolValueSwitchOff) {
    _levelSwitch.state = SwitchStateOff;
  } else if(symbol.value == SymbolValueSwitchOn) {
    _levelSwitch.state = SwitchStateOn;
  } else {
    _keyLevel = MAX(_keyLevel, symbol.value + 1);
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
  return _keyLevel >= condition->_keyLevel && (_levelSwitch.state == condition->_levelSwitch.state || condition->_levelSwitch.state == SwitchStateEither);
}

- (BOOL)impliesSymbol:(Symbol *)symbol {
  return [self impliesCondition:[[self class] conditionForSymbol:symbol]];
}

- (Symbol *)singleSymbolDifference:(Condition *)condition {
  if([self isEqualToCondition:condition]) return nil;
  
  if(_levelSwitch.state == condition->_levelSwitch.state) {
    return [Symbol symbolFor:MAX(_keyLevel, condition->_keyLevel) - 1];
  } else {
    if(_keyLevel != condition->_keyLevel) return nil;
    
    NSAssert(_levelSwitch.state != condition->_levelSwitch.state, @"Switch states should be different");
    if(_levelSwitch.state != SwitchStateEither && condition->_levelSwitch.state != SwitchStateEither) return nil;
    
    SwitchState newState = _levelSwitch.state != SwitchStateEither ?: condition->_levelSwitch.state;
    
    return [Symbol symbolFor:newState == SwitchStateOn ? SymbolValueSwitchOn : SymbolValueSwitchOff];
  }
}

- (NSString *)description {
  NSString *result = @"";
  if(_keyLevel != 0) {
    result = [result stringByAppendingString:[Symbol symbolFor:_keyLevel - 1].description];
  }
  if(_levelSwitch.state != SwitchStateEither) {
    if(![result isEqualToString:@""]) {
      result = [result stringByAppendingString:@","];
    }
    result = [result stringByAppendingString:_levelSwitch.symbol.description];
  }
  return result;
}

@end
