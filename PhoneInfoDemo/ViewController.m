//
//  ViewController.m
//  PhoneInfoDemo
//
//  Created by PacteraLF on 2017/8/1.
//  Copyright © 2017年 PacteraLF. All rights reserved.
//

#import "ViewController.h"
#import <sys/utsname.h>
#include <mach/mach.h>
#import <sys/sysctl.h>
#import <sys/stat.h>
#import "DeviceTools.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <AddressBook/AddressBook.h>

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

#import "SAMKeychain.h"

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"


extern NSString *CTSettingCopyMyPhoneNumber();

@interface ViewController ()
{
    CGFloat contentH; //ScrollView可滚动范围
}

@property (nonatomic, strong) UIScrollView *scrollView;

//存放各种标签的数组
@property (nonatomic, strong) NSMutableArray <UILabel *>*labelArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    //获取手机型号，例如iPhone 5s
    self.labelArray[0].text = [NSString stringWithFormat:@"设备具体型号为：%@",[DeviceTools getDeviceType]];
    //获取当前操作系统，例如 iOS 10.1.1
    self.labelArray[1].text = [NSString stringWithFormat:@"设备系统版本为：%@",[DeviceTools getSystemVersion]];
    //屏幕分辨率；例如1920*1080
    self.labelArray[2].text = [NSString stringWithFormat:@"设备屏幕尺寸为：%@",[DeviceTools getScreenSize]];
    //获取运营商；例如中国移动。。。无则显示为运营商
    self.labelArray[3].text = [NSString stringWithFormat:@"获取运营商方法1为：%@",[DeviceTools serviceCompany]];
    //如果无则返回null
    self.labelArray[4].text = [NSString stringWithFormat:@"获取运营商方法2为：%@",[DeviceTools getCarrierInfo]];
    //获取IMSI部分信息
    self.labelArray[5].text = [NSString stringWithFormat:@"IMSI部分信息：%@",[DeviceTools getImsiPart]];
    //CPU类型
    self.labelArray[6].text = [NSString stringWithFormat:@"CPU类型为：%@",[DeviceTools getCPUKind]];
    //是否被破解jailbroken
    NSString *jailStr = [DeviceTools isJailbreak]?@"是":@"否";
    self.labelArray[7].text = [NSString stringWithFormat:@"是否被破解：%@",jailStr];
    //网络状态
    self.labelArray[8].text = [NSString stringWithFormat:@"连接通道为：%@",[DeviceTools getNetWorkInfo]];
    //当前IP，准确的 IP 地址应该从后台获取
    self.labelArray[9].text = [NSString stringWithFormat:@"当前局域网IP为：%@",[DeviceTools getIPAddress:NO]];

    //应用创建实际和更新时间
    self.labelArray[10].text = [NSString stringWithFormat:@"App创建和更新时间：%@",[DeviceTools getAppCreateTime]];
    [DeviceTools pubulicIPaddressSuccessBlock:^(NSDictionary * _Nonnull json) {
        NSString * ip = json[@"cip"];
        self.labelArray[11].text = [NSString stringWithFormat:@"公网IP地址：%@",ip.length?ip:@"无法获取"];
    }];
    
    
}



//创建label
-(void)createUI{
    self.labelArray = [NSMutableArray arrayWithCapacity:20];
    
    UIScrollView *sView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:sView];
    self.scrollView = sView;
    
    for (NSInteger i = 0; i < 20; i++) {
        UILabel *tempLabel = [[UILabel alloc]init];
        [self.scrollView addSubview:tempLabel];
        tempLabel.font = [UIFont systemFontOfSize:11];
        tempLabel.numberOfLines = 0;
        tempLabel.frame = CGRectMake(15, 44 * i + 20, self.view.bounds.size.width - 30, 44);
        [self.labelArray addObject:tempLabel];
    }
    contentH = 20 * 40 + 10;
    self.scrollView.contentSize = CGSizeMake(0, contentH);
}


@end
