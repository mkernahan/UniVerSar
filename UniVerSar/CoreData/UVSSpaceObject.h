//
//  UVSSpaceObject.h
//  UniVerSar
//
//  Created by Michael Kernahan on 2013-04-09.
//  Copyright (c) 2013 redshirtlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@interface UVSSpaceObject : NSManagedObject < MKAnnotation >

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSDecimalNumber * latitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * longitude;

@end
