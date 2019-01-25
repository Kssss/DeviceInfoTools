//
//  DeviceTools.h
//  PhoneInfoDemo
//
//  Created by 谭建中 on 25/1/2019.
//  Copyright © 2019 PacteraLF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceTools : NSObject

/**
 获取手机的IP地址

 @param preferIPv4 是否是
 @return IP地址
 */
+ (NSString *)getIPAddress:(BOOL)preferIPv4;


/**
 获取APP下载的时间
 */
+ (NSString *)getAppCreateTime;

/**
 获取公网IP地址
 */
+(void)pubulicIPaddressSuccessBlock:(void (^)(NSDictionary * json))block;
/**
 是否越狱
 */
+ (BOOL)isJailbreak;

/**
 获取网络连接通道

 @return 3G，4G，wifi，LTE
 */
+ (NSString *)getNetWorkInfo;

/**
  获取CPU类型和核心数
 */
+(NSString *)getCPUKind;

/**
 CPU核心数
 */
+(NSInteger)getCPUNum;


/**
 获取CPU类型
 */
+ (NSString *)getCPUType;


/**
 通过系统框架获取，不准确
 */
+ (NSString *)getCarrierInfo;

/**
 通过左上角显示获取运营商信息；例如，中国移动/中国联通/中国电信/运营商
 */
+ (NSString *)serviceCompany;

/**
 获取分辨率
 */
+ (NSString *)getScreenSize;

/**
 获取手机的型号
 */
+ (NSString *)getDeviceType;

/**
 获取手机系统版本
 */
+ (NSString *)getSystemVersion;

/**
 获取IMSI部分信息 .网络国家代码，网络代码，运营商名字
 */
+ (NSString *)getImsiPart;
@end

NS_ASSUME_NONNULL_END
