//
//  ThirdPartService.m
//  framework
//
//  Created by 林希良 on 15/9/14.
//  Copyright (c) 2015年 xmsmart. All rights reserved.
//  第三方控件载入写在这里,减少AppDelegate的代码量(地图服务等也可类似的创建第三方类在自动装载)

#import "ThirdPartService.h"

@implementation ThirdPartService
/**
 *  CODELESS, Zero Line Of Code 不需要写任何代码
 *  Works Automatically //自动工作
 *  No More UIScrollView //不需要scrollview
 *  No More Subclasses //不需要继承父类
 *  No More Manual Work //不需要配置
 *  No More #imports //不需要导入
 */
+(void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 可以在此处写上第三方服务的注册（如果注册需要用到application或者launchOptions,则写到AppDelegate中）
        NSLog(@"自动装载");
    });
    
}

@end
