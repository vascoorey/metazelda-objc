//
//  IMap.h
//  metazelda
//
//  Created by Vasco d'Orey on 07/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

@import Foundation;

@protocol IRoom;
@class Coords;

@protocol IMap <NSObject>

- (id <IRoom>)roomAt:(Coords *)coords;

@end
