//
//  Switch.m
//  metazelda
//
//  Created by Vasco d'Orey on 01/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import "Switch.h"

@interface Switch ()

@property (nonatomic, readwrite) SwitchState state;

@end

@implementation Switch

+ (instancetype)switchFor:(SwitchState)state {
  Switch *s = [[self alloc] init];
  s.state = state;
  return s;
}

- (SwitchState)invert {
  switch (self.state) {
    case SwitchStateOff:
      self.state = SwitchStateOn;
      break;
    case SwitchStateOn:
      self.state = SwitchStateOff;
      break;
    default:
      break;
  }
  return self.state;
}

@end
