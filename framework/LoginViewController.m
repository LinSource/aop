//
//  LoginViewController.m
//  framework
//
//  Created by 林希良 on 15/9/15.
//  Copyright (c) 2015年 xmsmart. All rights reserved.
//

#import "LoginViewController.h"
#import "Masonry.h"
#import "User.h"
#import "FBKVOController.h"
//#import "ReactiveCocoa.h"

@interface LoginViewController ()
@property (weak,nonatomic) UIButton *button;/**< 改值按钮*/
@property (weak,nonatomic) UIButton *pushBtn;/**< 跳转按钮*/
@property (strong, nonatomic) User *user;/**< 用户数据*/
@property (strong, nonatomic) FBKVOController *fbKVO;/**< 观察者*/


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    self.title = @"测试KVO";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"测试KVO" forState:UIControlStateNormal];
    [button setTitle:@"放开" forState:UIControlStateHighlighted];
    [button setBackgroundColor:[UIColor greenColor]];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    self.button = button;
    [self.view addSubview:self.button];
    User *user = [[User alloc] init];
    self.user = user;
    
    __weak LoginViewController *weakSelf = self;
    self.fbKVO = [FBKVOController controllerWithObserver:self];
    [self.fbKVO observe:self.user keyPath:@"username" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        weakSelf.title = [NSString stringWithFormat:@"改变后:%@",change[NSKeyValueChangeNewKey]];
        
    }];

//    ReactiveCocoa 方式监听
//    [RACObserve(self.user, username) subscribeNext:^(NSString *username) {
//        NSLog(@"-RAC -%@",username);
//    }];
    
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushBtn setBackgroundColor:[UIColor blueColor]];
    [pushBtn setTitle:@"push" forState:UIControlStateNormal];
    [pushBtn setTitle:@"放开我" forState:UIControlStateHighlighted];
    [pushBtn addTarget:self action:@selector(pushClick) forControlEvents:UIControlEventTouchUpInside];
    self.pushBtn = pushBtn;
    [self.view addSubview:pushBtn];
}

/**
 *  布局
 *  利用masonry进行布局
 */
-(void)viewWillLayoutSubviews {
    __weak LoginViewController *weakSelf = self;
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@100);
        make.centerX.centerY.equalTo(weakSelf.view);
    }];
    
    [self.pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@100);
        make.top.equalTo(weakSelf.button.mas_bottom).offset(20);
        make.centerX.equalTo(weakSelf.view);
    }];
}


#pragma mark -按钮方法
/**
 *  按钮点击方法
 */
- (void)btnClick {
    int nums
    = arc4random()%10;
    self.user.username = [NSString stringWithFormat:@"%d Name",nums];
}

- (void)pushClick {

}

/**
 *  销毁方法
 */
-(void)dealloc {
//    [self.fbKVO unobserve:self.user keyPath:@"username"];//单个移除监听
    [self.fbKVO unobserveAll];//释放所有监听
}
@end
