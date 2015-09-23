//
//  Contact.m
//  AddressBook0739
//
//  Created by lanouhn on 15/9/14.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (void)dealloc {
    [_name release];
    [_gender release];
    [_phoneNum release];
    [_photo release];
    [_photoVW release];
    [super dealloc];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        self.photoVW = [UIImage imageNamed:dic[@"photo"]];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"key值不存在(⊙o⊙)哦");
}

@end
