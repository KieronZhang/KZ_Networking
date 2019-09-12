//
//  KZ_HttpSessionManager.h
//  KZ_Networking
//
//  Created by Kieron Zhang on 2018/5/2.
//  Copyright © 2016年 Kieron Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZ_PolicyStyle.h"
#import "KZ_RequestModel.h"

@interface KZ_HttpSessionManager : NSObject

+ (KZ_RequestModel *)getContentWithURL:(NSString *)URLString method:(KZ_RequestMethod)method;

+ (void)HTTPRequestWithRequestModel:(KZ_RequestModel *)requestModel progress:(void (^)(NSProgress *downloadProgress))downloadProgress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (BOOL)deleteDatabase;

@end
