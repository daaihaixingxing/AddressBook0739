//
//  CostomContactCell.m
//  AddressBook0739
//
//  Created by lanouhn on 15/9/14.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "CostomContactCell.h"
#import "Contact.h"

@implementation CostomContactCell

- (void)dealloc {
    self.photoView = nil;
    self.nameLabel = nil;
    self.phoneLabel = nil;
    self.callBtn = nil;
    self.indexPath = nil;
    self.contact = nil;
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //布局子控件
        [self.contentView addSubview:self.photoView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.phoneLabel];
        [self.contentView addSubview:self.callBtn];
//        self.contentView.userInteractionEnabled = YES;
    }
    return self;
}

#pragma mark lazy loading 实现控件的创建
//重写getter方法
- (UIImageView *)photoView {
    if (!_photoView) {
        self.photoView = [[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 60)] autorelease];
        _photoView.layer.cornerRadius = 27;
        _photoView.layer.masksToBounds = YES;
    }
    return [[_photoView retain] autorelease];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        self.nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(70, 10, 80, 60)] autorelease];
        _nameLabel.font = [UIFont boldSystemFontOfSize:20];
//        _nameLabel.backgroundColor = [UIColor yellowColor];
    }
    return [[_nameLabel retain] autorelease];
}

- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        self.phoneLabel = [[[UILabel alloc] initWithFrame:CGRectMake(160, 10, 120, 60)] autorelease];
//        _phoneLabel.backgroundColor = [UIColor cyanColor];
        _phoneLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return [[_phoneLabel retain] autorelease];
    
}

- (UIButton *)callBtn {
    if (!_callBtn) {
        self.callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _callBtn.backgroundColor = [UIColor redColor];
        _callBtn.frame = CGRectMake(290, 15, 40, 50);
        [_callBtn setImage:[UIImage imageNamed:@"action_call@2x"] forState:UIControlStateNormal];
        //添加触发方法
        [_callBtn addTarget:self action:@selector(handleCall:) forControlEvents:UIControlEventTouchUpInside];
    }
    return [[_callBtn retain] autorelease];
    
}

#pragma mark ---button的点击事件---
- (void)handleCall:(UIButton *)sender {
    if (_delegate && [self.delegate respondsToSelector:@selector(dial:)]) {
        [_delegate dial:self.indexPath];
    }
}

#pragma mark ---为cell的控件赋值---
//1. 自定义方法 为cell的控件赋值
- (void)configureCell:(Contact *)contact {
    self.photoView.image = [UIImage imageNamed:contact.photo];
    self.nameLabel.text = contact.name;
    self.phoneLabel.text = contact.phoneNum;
}

//2. 重写setter方法 为cell的控件赋值
- (void)setContact:(Contact *)contact {
    if (_contact != contact) {
        [_contact release];
        _contact = [contact retain];
    }
    self.photoView.image = [UIImage imageNamed:contact.photo];
    self.nameLabel.text = contact.name;
    self.phoneLabel.text = contact.phoneNum;
}

@end
