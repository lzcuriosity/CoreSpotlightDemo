//
//  AppDelegate.m
//  CoreSpotlightDemo
//
//  Created by Zen3 on 16/5/19.
//  Copyright © 2016年 Zen3. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
   
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    NSString* idetifier = userActivity.userInfo[@"kCSSearchableItemActivityIdentifier"];
    
    MovieDetailPage* detailPage = [[MovieDetailPage alloc] init];
    detailPage.numberOfMovie = [idetifier intValue];
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;	
    [navigationController pushViewController: detailPage animated:true];
    
    return YES;
}
@end
