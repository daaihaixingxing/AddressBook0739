//
//  Contact.h
//  AddressBook0739
//
//  Created by lanouhn on 15/9/14.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Contact : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *gender;
@property (nonatomic,copy) NSString *phoneNum;
@property (nonatomic,copy) NSString *photo;

@property (nonatomic,retain) UIImage *photoVW;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
