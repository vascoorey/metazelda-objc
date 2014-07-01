//
//  Condition.h
//  metazelda
//
//  Created by Vasco d'Orey on 01/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Switch.h"

@class Symbol;

@interface Condition : NSObject {
  @protected
  int _keyLevel;
  Switch *_levelSwitch;
}

@property (nonatomic, readonly) int keyLevel;
@property (nonatomic, readonly) Switch *levelSwitch;

+ (instancetype)condition;
+ (instancetype)conditionForSymbol:(Symbol *)symbol;
+ (instancetype)conditionFromCondition:(Condition *)other;
+ (instancetype)conditionForSwitchState:(SwitchState)state;

- (BOOL)isEqualToCondition:(Condition *)other;

- (void)addSymbol:(Symbol *)symbol;
- (void)addCondition:(Condition *)other;

- (Condition *)andSymbol:(Symbol *)symbol;
- (Condition *)andCondition:(Condition *)condition;

- (BOOL)impliesCondition:(Condition *)condition;
- (BOOL)impliesSymbol:(Symbol *)symbol;

- (Symbol *)singleSymbolDifference:(Condition *)condition;

@end
