//
//  DetailView.m
//  AddressBook0739
//
//  Created by lanouhn on 15/9/15.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "DetailView.h"

@interface DetailView () <UITextFieldDelegate>

@end

@implementation DetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
    }
    return self;
}

//布局子视图
- (void)setUpViews {
    //图像
    self.photoView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, 100, 100)];
    _photoView.image = [UIImage imageNamed:@"green_avatarEmpty@2x"];
    _photoView.userInteractionEnabled = YES;
    _photoView.layer.cornerRadius = 50;
    _photoView.layer.masksToBounds = YES;
    [self addSubview:_photoView];
    [_photoView release];
    
    //姓名
    self.nameTF = [[UITextField alloc] initWithFrame:CGRectMake(140, 80, 120, 40)];
    _nameTF.placeholder = @"姓名";
    _nameTF.font = [UIFont systemFontOfSize:30];
    _nameTF.delegate = self;
    _nameTF.backgroundColor = [UIColor lightGrayColor];
    _nameTF.textColor = [UIColor whiteColor];
    [self addSubview:_nameTF];
    [_nameTF release];
    //性别
    self.genderTF = [[UITextField alloc] initWithFrame:CGRectMake(140, 140, 120, 40)];
    _genderTF.placeholder = @"性别";
    _genderTF.font = [UIFont systemFontOfSize:30];
    _genderTF.delegate = self;
    _genderTF.backgroundColor = [UIColor lightGrayColor];
    _genderTF.textColor = [UIColor whiteColor];
    [self addSubview:_genderTF];
    [_genderTF release];
    //手机号码
    self.phoneNumTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 230, 275, 40)];
    _phoneNumTF.placeholder = @"手机号码";
    _phoneNumTF.textAlignment = NSTextAlignmentCenter;
    _phoneNumTF.font = [UIFont systemFontOfSize:30];
    _phoneNumTF.delegate = self;
    _phoneNumTF.backgroundColor = [UIColor lightGrayColor];
    _phoneNumTF.textColor = [UIColor whiteColor];
    [self addSubview:_phoneNumTF];
    [_phoneNumTF release];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_nameTF resignFirstResponder];
    [_genderTF resignFirstResponder];
    [_phoneNumTF resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

- (void)dealloc {
    self.photoView = nil;
    self.nameTF = nil;
    self.genderTF = nil;
    self.phoneNumTF = nil;
    [super dealloc];
}



@end
