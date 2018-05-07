//
//  KZ_DownloadManager.h
//  KZ_Networking
//
//  Created by Kieron Zhang on 2018/5/2.
//  Copyright © 2016年 Kieron Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KZ_DownloadManager : NSObject

+ (void)downloadWithURL:(NSURL *)URL filePath:(NSString *)filePath filename:(NSString *)filename progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock completion:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completion;
+ (void)downloadTaskWithResumeData:(NSData *)resumeData filePath:(NSString *)filePath filename:(NSString *)filename progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock completion:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completion;

@end
