//
//  UVSSpaceObject.m
//  UniVerSar
//
//  Created by Michael Kernahan on 2013-04-09.
//  Copyright (c) 2013 redshirtlabs. All rights reserved.
//

#import "UVSSpaceObject.h"


@implementation UVSSpaceObject

@dynamic id;
@dynamic latitude;
@dynamic name;
@dynamic longitude;


#pragma mark - @protocol MKAnnotation <NSObject>

- (CLLocationCoordinate2D) coordinate {
    return CLLocationCoordinate2DMake(self.latitude.doubleValue, self.longitude.doubleValue);
}

// Title and subtitle for use by selection UI.
- (NSString *) title { return self.name; }
- (NSString *) subtitle { return nil; }

@end
