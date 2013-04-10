//
//  UVSAppDelegate.h
//  UniVerSar
//
//  Created by Michael Kernahan on 2013-04-02.
//  Copyright (c) 2013 redshirtlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UVSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (NSArray *) getAllSolarSystems;

@end
