//
//  UIViewController+AOP.m
//  framework
//
//  Created by 林希良 on 15/9/14.
//  Copyright (c) 2015年 xmsmart. All rights reserved.
//  AOP 面向切面编程

#import "UIViewController+AOP.h"
#import <objc/runtime.h>

@implementation UIViewController (AOP)
/**
 *  配置需要AOP的方法，自动拦截先执行AOP的方法
 *  可以通过self的Class类型进行判断控制器的类型
 *  不同控制器可以拦截不同的功能
 */
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        swizzleMethod(class, @selector(viewDidLoad), @selector(aop_viewDidLoad));
        swizzleMethod(class, @selector(viewWillAppear:), @selector(aop_viewWillAppear:));
    });
}
/**
 *  判断方法是否有AOP
 *
 *  @param class            类型
 *  @param originalSelector 方法
 *  @param swizzledSelector AOP方法
 */
void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {// 存在AOP方法
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else { // 不存在AOP方法
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


#pragma mark - Method Swizzling 自定义AOP方法

- (void)aop_viewDidLoad {
    [self aop_viewDidLoad];
    // 可以判断self的类型  根据类型执行不同的拦截
    if ([self isKindOfClass:[UIViewController class]]) {
        NSLog(@"aop_viewDidLoad-%@",[self class]);
    } else {
        NSLog(@"aop_viewDidLoad - other");
    }
    
}

- (void)aop_viewWillAppear:(BOOL)animated{
    [self aop_viewWillAppear:animated];
    NSLog(@"aop_viewWillAppear");
}
@end
