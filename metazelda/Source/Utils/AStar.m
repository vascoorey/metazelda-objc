//
//  AStar.m
//  metazelda
//
//  Created by Vasco d'Orey on 04/07/14.
//  Copyright (c) 2014 Delta Dog. All rights reserved.
//

#import "AStar.h"
#import "Coords.h"
#import "IRoom.h"
#import <BinarySearchTree/BinarySearchTree.h>

@interface AStar ()

@property (nonatomic, strong) id <IMap> map;
@property (nonatomic, strong) Coords *from;
@property (nonatomic, strong) Coords *to;

@property (nonatomic, strong) BinarySearchTree *closedSet;
@property (nonatomic, strong) BinarySearchTree *openSet;
@property (nonatomic, strong) BinarySearchTree *fScore;
@property (nonatomic, strong) BinarySearchTree *gScore;
@property (nonatomic, strong) BinarySearchTree *cameFrom;

- (double)heuristicDistance:(Coords *)position;
- (void)updateFScore:(Coords *)position;

- (NSComparisonResult)compareCoords:(Coords *)coords to:(Coords *)to;

- (NSArray *)reconstructPath;
- (Coords *)nextStep;

@end

@implementation AStar

+ (instancetype)AStar:(id<IMap>)map from:(Coords *)from to:(Coords *)to {
  AStar *a = [[self alloc] init];
  a.map = map;
  a.from = from;
  a.to = to;
  
  a.closedSet = [[BinarySearchTree alloc] init];
  a.openSet = [[BinarySearchTree alloc] init];
  a.fScore = [[BinarySearchTree alloc] init];
  a.gScore = [[BinarySearchTree alloc] init];
  a.cameFrom = [[BinarySearchTree alloc] init];
  
  return a;
}

#pragma mark - A* Solving

- (NSArray *)solve {
  self.openSet[self.from] = @YES;
  self.gScore[self.from] = @0.0;
  [self updateFScore:self.from];
  
  while (self.openSet.size) {
    Coords *current = self.openSet[self.openSet.min];
    if([current isEqualToCoords:self.to]) {
      return [self reconstructPath];
    }
    
    self.closedSet[current] = @YES;
    
    for(Coords *neighbor in [[self.map roomAt:current] neighbors]) {
      if(self.closedSet[neighbor]) {
        continue;
      }
      
      double dist = [current distanceTo:neighbor];
      double g = [self.gScore[current] doubleValue] + dist;
      
      if(!self.openSet[neighbor] || g < [self.gScore[neighbor] doubleValue]) {
        self.cameFrom[neighbor] = current;
        self.gScore[neighbor] = @(g);
        [self updateFScore:neighbor];
        self.openSet[neighbor] = @YES;
      }
    }
  }
  return nil;
}

#pragma mark - Private methods

- (double)heuristicDistance:(Coords *)position {
  return abs(self.to.x - position.x) + abs(self.to.y - position.y);
}

- (void)updateFScore:(Coords *)position {
  self.fScore[position] = @([self.gScore[position] doubleValue] + [self heuristicDistance:position]);
}

- (NSComparisonResult)compareCoords:(Coords *)coords to:(Coords *)to {
  double s1 = [self.fScore[coords] doubleValue];
  double s2 = [self.fScore[to] doubleValue];
  
  return s1 < s2 ? NSOrderedAscending : (s1 > s2 ? NSOrderedDescending : NSOrderedSame);
}

- (NSArray *)reconstructPath {
  NSMutableArray *path = [NSMutableArray array];
  Coords *current = self.to;
  while(![current isEqualToCoords:self.from]) {
    [path addObject:current];
    current = self.cameFrom[current];
  }
  return [[path reverseObjectEnumerator] allObjects];
}

- (Coords *)nextStep {
  NSArray *path = [self solve];
  
  if(!path || path.count == 0) return nil;
  
  return [path firstObject];
}

@end
