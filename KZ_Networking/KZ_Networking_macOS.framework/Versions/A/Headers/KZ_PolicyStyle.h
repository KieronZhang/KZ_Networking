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
    KZ_RequestMethod_POSTFORM,
    KZ_RequestMethod_PUT,
    KZ_RequestMethod_PATCH,
    KZ_RequestMethod_DELETE,
    KZ_RequestMethod_HTML,
};

typedef NS_ENUM(NSInteger, KZ_RequestSerializerType) {
    KZ_RequestSerializerType_HTTP,
    KZ_RequestSerializerType_JSON,
    KZ_RequestSerializerType_PropertyList,
};

typedef NS_ENUM(NSInteger, KZ_ResponseSerializerType) {
    KZ_ResponseSerializerType_JSON,
    KZ_ResponseSerializerType_HTTP,
    KZ_ResponseSerializerType_XMLParser,
    KZ_ResponseSerializerType_PropertyList,
    KZ_ResponseSerializerType_Image,
    KZ_ResponseSerializerType_Compound,
#if TARGET_OS_OSX
    KZ_ResponseSerializerType_XMLDocument,
#endif
};
