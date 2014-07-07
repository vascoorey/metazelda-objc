//
//  AStar.h
//  metazelda
//
//  Created by Vasco d'Orey on 04/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

@import Foundation;
#import "IMap.h"

@class Coords;

@interface AStar : NSObject

+ (instancetype)AStar:(id <IMap>)map from:(Coords *)from to:(Coords *)to;

/*!
 @abstract Solves the given problem.
 
 @return An ordered list of coordinate steps.
 */
- (NSArray *)solve;

@end
