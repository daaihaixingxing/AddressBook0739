//
//  NSString+Addition.m
//  AddressBook0739
//
//  Created by lanouhn on 15/9/15.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "NSString+Addition.h"
#import "ChineseToPinyin.h"

@implementation NSString (Addition)

//中文转拼音
- (NSString *)chineseToPinYin {
    return [ChineseToPinyin pinyinFromChiniseString:self];
}

//获取字符串的首字母
- (NSString *)firstCharacter {
    return [[[self chineseToPinYin] substringToIndex:1]uppercaseString];
}



@end
