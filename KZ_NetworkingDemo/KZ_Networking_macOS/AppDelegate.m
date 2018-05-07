//
//  AppDelegate.m
//  KZ_Networking_macOS
//
//  Created by Kieron Zhang on 2018/5/7.
//  Copyright © 2018年 Kieron Zhang. All rights reserved.
//

#import "AppDelegate.h"
#import <KZ_Database_macOS/KZ_DatabaseManager.h>
#import <KZ_Networking_macOS/KZ_NetworkingRequest.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [KZ_NetworkingRequest updateBaseURL:@"http://cloud.arrownock.com/v2/"];
    [KZ_DatabaseManager sharedManager].logSqlString = NO;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
}

@end
