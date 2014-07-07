//
//  Symbol.h
//  metazelda
//
//  Created by Vasco d'Orey on 01/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

@import Foundation;

typedef NS_ENUM(int, SymbolValue) {
  SymbolValueStart = -6,
  SymbolValueGoal = -5,
  SymbolValueBoss = -4,
  SymbolValueSwitchOn = -3,
  SymbolValueSwitchOff = -2,
  SymbolValueSwitch = -1
};

@interface Symbol : NSObject

@property (nonatomic, readonly) SymbolValue value;
@property (nonatomic, readonly) NSString *name;

@property (nonatomic, readonly) BOOL isStart;
@property (nonatomic, readonly) BOOL isGoal;
@property (nonatomic, readonly) BOOL isBoss;
@property (nonatomic, readonly) BOOL isSwitch;
@property (nonatomic, readonly) BOOL isSwitchState;

+ (instancetype)symbolFor:(int)symbolValue;

- (BOOL)isEqualToSymbol:(Symbol *)other;

@end
