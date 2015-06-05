//
//  AppDelegate.m
//  MyChecklists
//
//  Created by 陈旭 on 5/2/15.
//  Copyright (c) 2015 陈旭. All rights reserved.
//

#import "AppDelegate.h"
#import "AllListsViewController.h"
#import "DataModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

{
    DataModel *_dataModel;
}

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _dataModel = [[DataModel alloc] init];
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    AllListsViewController *controller = navigationController.viewControllers[0];
    controller.dataModel = _dataModel;
    
    UIUserNotificationType types = UIUserNotificationTypeBadge|UIUserNotificationTypeAlert|UIUserNotificationTypeSound;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    return YES;
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification{
    //NSLog(@"didReceiveLocalNotification %@", notification);
}

- (void)saveData
{
    [_dataModel saveChecklists];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self saveData];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveData];
}

@end
