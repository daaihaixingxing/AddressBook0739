//
//  AddcontactViewController.m
//  AddressBook0739
//
//  Created by lanouhn on 15/9/14.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "AddcontactViewController.h"
#import "AddContactView.h"
#import "AddressBookHelper.h"

@interface AddcontactViewController ()<UIActionSheetDelegate,UIAlertViewDelegate>

@end

@implementation AddcontactViewController

- (void)loadView {
    AddContactView *addContact = [[AddContactView alloc] init];
    self.view = addContact; //如果用 self.view = addContact 不用写 super loadView 否则需要写
    [addContact release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizedNavibar];//
    [self addTapGesture];//添加轻拍手势
}

#pragma mark  ----添加轻拍手势----
- (void)addTapGesture {
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [((AddContactView *)self.view).photoView addGestureRecognizer:tap];
    [tap release];
    
}

#pragma mark ----处理轻拍手势-----
- (void)handleTap:(UITapGestureRecognizer *)tap {
    
}

#pragma mark ----设置导航栏属性----
- (void)customizedNavibar {
    self.navigationItem.title = @"添加联系人";
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"clsose@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(handleLeft:)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"doneR@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(handleRight:)] autorelease];
}

#pragma mark ---handle Action---
//关闭  放弃保存
- (void)handleLeft:(UIBarButtonItem *)item {
    AddContactView *addVC = (AddContactView *)self.view;
    
    //判断 提示用户
    if (addVC.nameTF.text.length != 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否放弃" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
        [alert release];
    } else {
        //返回
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//添加完成 保存
- (void)handleRight:(UIBarButtonItem *)item {
    AddContactView *view = (AddContactView *)self.view;
    NSString *name = view.nameTF.text;
    NSString *number = view.phoneNumTF.text;
    
    //判断
    if (name.length == 0 || number.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入姓名或者手机号码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        [alert release];
        return;
    } else {
        //创建联系人对象
        Contact *contact = [[Contact alloc] init];
        contact.name = name;
        contact.phoneNum = number;
        //添加联系人
        [AddressBookHelper addContact:contact];
        NSLog(@"%@",contact);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        //返回首页
//        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark ----alertView的button 点击事件----
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

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
