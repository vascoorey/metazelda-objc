//
//  Edge.h
//  metazelda
//
//  Created by Vasco d'Orey on 01/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

@import Foundation;

@class Symbol;

@interface Edge : NSObject

+ (instancetype)edge;
+ (instancetype)edgeWithSymbol:(Symbol *)symbol;

@property (nonatomic, readonly) BOOL hasSymbol;
@property (nonatomic, strong) Symbol *symbol;

- (BOOL)isEqualToEdge:(Edge *)other;

@end
