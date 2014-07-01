//
//  Switch.h
//  metazelda
//
//  Created by Vasco d'Orey on 01/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, SwitchState) {
  SwitchStateEither = 0,
  SwitchStateOff,
  SwitchStateOn
};

@class Symbol;

@interface Switch : NSObject

@property (nonatomic, readonly) SwitchState state;
@property (nonatomic, readonly) Symbol *symbol;

+ (instancetype)switchFor:(SwitchState)state;

/*!
 @warning mutating function
 
 @return The new state. This is also changed on the called object's state.
 */
- (SwitchState)invert;

@end
