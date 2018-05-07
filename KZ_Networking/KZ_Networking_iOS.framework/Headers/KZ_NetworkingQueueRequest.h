//
//  KZ_NetworkingQueueRequest.h
//  KZ_Networking
//
//  Created by Kieron Zhang on 2018/5/2.
//  Copyright © 2016年 Kieron Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZ_HttpSessionManager.h"
#import "KZ_RequestModel.h"

@interface KZ_NetworkingQueueRequest : NSObject

+ (instancetype)sharedCacheNetworkingQueueRequest;

- (void)addHttpRequestWithRequestModel:(KZ_RequestModel *)requestModel;
- (void)startLoadRequestsWithResult:(void (^)(NSArray *resultArray))result;

@end
