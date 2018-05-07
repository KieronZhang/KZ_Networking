//
//  KZ_NetworkingRequest.h
//  KZ_Networking
//
//  Created by Kieron Zhang on 2018/5/2.
//  Copyright © 2016年 Kieron Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZ_HttpSessionManager.h"
#import "KZ_NetworkingQueueRequest.h"

@interface KZ_NetworkingRequest : NSObject

+ (void)updateBaseURL:(NSString *)baseURL;

+ (void)HTTPRequestWithRequestModel:(KZ_RequestModel *)requestModel progress:(void (^)(NSProgress *progress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
+ (void)addHTTPRequestWithRequestModel:(KZ_RequestModel *)requestModel;
+ (void)startLoadRequestsWithResult:(void (^)(NSArray *resultArray))result;

@end
