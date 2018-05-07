//
//  AppDelegate.m
//  KZ_Networking_iOS
//
//  Created by Kieron Zhang on 2018/5/7.
//  Copyright © 2018年 Kieron Zhang. All rights reserved.
//

#import "AppDelegate.h"
#import <KZ_Database_iOS/KZ_DatabaseManager.h>
#import <KZ_Networking_iOS/KZ_NetworkingRequest.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [KZ_NetworkingRequest updateBaseURL:@"http://cloud.arrownock.com/v2/"];
    [KZ_DatabaseManager sharedManager].logSqlString = NO;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
