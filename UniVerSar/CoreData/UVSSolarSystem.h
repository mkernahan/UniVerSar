//
//  UVSSolarSystem.h
//  UniVerSar
//
//  Created by Michael Kernahan on 2013-04-09.
//  Copyright (c) 2013 redshirtlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UVSSpaceObject.h"

@class UVSPlanet, UVSStar;

@interface UVSSolarSystem : UVSSpaceObject

@property (nonatomic, retain) NSSet *stars;
@property (nonatomic, retain) NSSet *planets;
@end

@interface UVSSolarSystem (CoreDataGeneratedAccessors)

- (void)addStarsObject:(UVSStar *)value;
- (void)removeStarsObject:(UVSStar *)value;
- (void)addStars:(NSSet *)values;
- (void)removeStars:(NSSet *)values;

- (void)addPlanetsObject:(UVSPlanet *)value;
- (void)removePlanetsObject:(UVSPlanet *)value;
- (void)addPlanets:(NSSet *)values;
- (void)removePlanets:(NSSet *)values;

@end
