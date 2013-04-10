//
//  UVSAppDelegate.m
//  UniVerSar
//
//  Created by Michael Kernahan on 2013-04-02.
//  Copyright (c) 2013 redshirtlabs. All rights reserved.
//

#import "UVSAppDelegate.h"
#import <CoreData/CoreData.h>
#import "UVSSolarSystem.h"
#import "UVSStar.h"
#import "UVSPlanet.h"

@implementation UVSAppDelegate {
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectContext *_managedObjectContext;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    srand(time(0));
    [self _setupCoreDataStack];
    [self generateUniverse];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)_setupCoreDataStack
{
    // setup managed object model
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"UniVerSar" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    // setup persistent store coordinator
    NSURL *storeURL = [NSURL fileURLWithPath:[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"UniVersar.db"]];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        // handle error
    }
    
    // create MOC
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:_persistentStoreCoordinator];
}

- (NSDecimalNumber *) randomDecimal:(double)max {
    float randomNumber = (float)(rand() / (float)RAND_MAX);
    randomNumber *= 2*max;
    randomNumber -= max;
    NSDecimalNumber *dn = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%.7f", randomNumber]];
    return dn;
}

- (void) generateUniverse {
    for (NSInteger solarIndex=1; solarIndex<100; solarIndex++) {
        UVSSolarSystem *ss = [NSEntityDescription insertNewObjectForEntityForName:@"SolarSystem"
                                                           inManagedObjectContext:_managedObjectContext];
        ss.id = [NSNumber numberWithInt:solarIndex];
        ss.latitude = [self randomDecimal:90.0];
        ss.longitude = [self randomDecimal:180.0];
        ss.name = [NSString stringWithFormat:@"SolarSystem_%d", solarIndex];
    }
    [UVSAppDelegate saveManagedObjectContext:_managedObjectContext];
}

- (NSArray *) getAllSolarSystems {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"SolarSystem" inManagedObjectContext:_managedObjectContext]];
    NSError *error = nil;
    NSArray *sss = nil;
    @try {
        sss = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    }
    @catch (NSException *exception) {
    }
    return (sss.count > 0 ? sss : @[]);
}

+ (BOOL) saveManagedObjectContext:(NSManagedObjectContext *)moc outError:(NSError **)outError {
    @try {
        NSError *localError = nil;
        if([moc save:&localError]) {
            return YES;
        }
        if (NULL != outError) {
            *outError = localError;
        }
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
    return NO;
}

+ (BOOL) saveManagedObjectContext:(NSManagedObjectContext *)moc {
    NSError *error = nil;
    BOOL saved = [UVSAppDelegate saveManagedObjectContext:moc outError:&error];
    if (!saved || error) {
        //
    }
    return saved;
}

@end
