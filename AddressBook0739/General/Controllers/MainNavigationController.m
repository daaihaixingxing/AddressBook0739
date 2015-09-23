//
//  MainNavigationController.m
//  AddressBook0739
//
//  Created by lanouhn on 15/9/14.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "MainNavigationController.h"
#import "UIColor+Addition.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureNavigationBar];//对通用的导航条进行一些设置
}

#pragma mark  --- 对通用的导航条进行一些属性配置 ---
- (void)configureNavigationBar {
    //设置导航条的渲染颜色
    self.navigationBar.barTintColor = [UIColor lightGreenColor];
    //设置导航条内容的渲染颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    //导航条文字属性
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

#pragma mark ---内存警告---
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
