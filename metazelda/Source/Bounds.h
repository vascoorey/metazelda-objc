//
//  Bounds.h
//  metazelda
//
//  Created by Vasco d'Orey on 01/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bounds : NSObject

@property (nonatomic) int left;
@property (nonatomic) int right;
@property (nonatomic) int top;
@property (nonatomic) int bottom;

@property (nonatomic, readonly) int width;
@property (nonatomic, readonly) int height;

+ (instancetype)boundsForLeft:(int)left right:(int)right bottom:(int)bottom top:(int)top;

@end
