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

@interface LoginViewController ()
@property (weak,nonatomic) UIButton *button;/**< 按钮*/
@property (strong, nonatomic) User *user;/**< 用户数据*/
@property (strong, nonatomic) FBKVOController *fbKVO;/**< 观察者*/


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"测试KVO" forState:UIControlStateNormal];
    [button setTitle:@"放开" forState:UIControlStateHighlighted];
    [button setBackgroundColor:[UIColor greenColor]];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    self.button = button;
    [self.view addSubview:self.button];
    User *user = [[User alloc] init];
    self.user = user;
    
    self.fbKVO = [FBKVOController controllerWithObserver:self];
    [self.fbKVO observe:self.user keyPath:@"username" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        NSLog(@"值变化%@",change[NSKeyValueChangeNewKey]);// 打印监听到值变化
        
    }];
}

-(void)viewWillLayoutSubviews {
    __weak LoginViewController *weakSelf = self;
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@100);
        make.centerX.centerY.equalTo(weakSelf.view);
    }];
}

- (void)btnClick {
    int nums
    = arc4random()%10;
    self.user.username = [NSString stringWithFormat:@"%d Name",nums];
}

-(void)dealloc {
//    [self.fbKVO removeObserver:self.user forKeyPath:@"username"];//单个释放
    [self.fbKVO unobserveAll];//释放所有监听
}
@end
