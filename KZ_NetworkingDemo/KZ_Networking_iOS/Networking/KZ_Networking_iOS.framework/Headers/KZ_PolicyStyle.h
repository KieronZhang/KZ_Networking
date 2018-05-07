//
//  KZ_PolicyStyle.h
//  KZ_Networking
//
//  Created by Kieron Zhang on 2018/5/2.
//  Copyright © 2016年 Kieron Zhang. All rights reserved.
//

typedef NS_ENUM(NSInteger, KZ_PolicyStyle) {
    KZ_PolicyStyle_DoNotReadFromCache = 0, //不读缓存，也不会存库
    KZ_PolicyStyle_AlwaysReadFromCache, //总是读取缓存
    KZ_PolicyStyle_OnlyReadFromCacheWhenRequestFailed, //只有方式失败会读取缓存
    KZ_PolicyStyle_OnlyReadFromCacheWhenTimeExpired, //缓存过期之前获取缓存
    KZ_PolicyStyle_ReadFromCacheWhenTimeExpiredOrRequestFailed //缓存过期或者访问失败读取缓存
};

typedef NS_ENUM(NSInteger, KZ_RequestMethod) {
    KZ_RequestMethod_GET,
    KZ_RequestMethod_POST,
    KZ_RequestMethod_PUT,
    KZ_RequestMethod_PATCH,
    KZ_RequestMethod_DELETE,
    KZ_RequestMethod_HTML,
};
