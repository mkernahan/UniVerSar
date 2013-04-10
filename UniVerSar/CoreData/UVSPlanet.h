//
//  UVSPlanet.h
//  UniVerSar
//
//  Created by Michael Kernahan on 2013-04-09.
//  Copyright (c) 2013 redshirtlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UVSSolarSystem;

@interface UVSPlanet : NSManagedObject

@property (nonatomic, retain) UVSSolarSystem *solarSystem;

@end
