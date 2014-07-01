//
//  Condition.h
//  metazelda
//
//  Created by Vasco d'Orey on 01/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Switch;

@interface Condition : NSObject {
  @protected
  int _keyLevel;
  Switch *_levelSwitch;
}

+ (instancetype)condition;

@end
