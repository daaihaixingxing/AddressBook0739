//
//  CostomContactCell.h
//  AddressBook0739
//
//  Created by lanouhn on 15/9/14.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;

//为callBtn 制定协议方法 实现拨打电话
@protocol MakeACallDelegate <NSObject>

- (void)dial:(NSIndexPath *)indexPath;

@end


@interface CostomContactCell : UITableViewCell

@property (nonatomic,retain) UIImageView *photoView;
@property (nonatomic,retain) UILabel *nameLabel;
@property (nonatomic,retain) UILabel *phoneLabel;
@property (nonatomic,retain) UIButton *callBtn;

@property (nonatomic,assign) id<MakeACallDelegate> delegate;

@property (nonatomic,retain) NSIndexPath *indexPath;//存储当前点击的cell的索引

//声明一个联系人对象的属性
@property (nonatomic,retain) Contact *contact;

//为cell上的控件赋值
- (void)configureCell:(Contact *)contact;


@end
