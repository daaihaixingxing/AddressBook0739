//
//  AddressBookHelper.h
//  AddressBook0739
//
//  Created by lanouhn on 15/9/14.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"
#import <UIKit/UIKit.h>

@interface AddressBookHelper : NSObject

//提供相应的方法给对应的controller

#pragma mark source
+ (NSInteger)numberOfSection;//返回分区个数

+ (NSInteger)numberOfRowsInSection:(NSInteger)section;//返回对应分区的行数

+ (NSString *)titleForHeaderInSection:(NSInteger)section;//返回对应分区的title

+ (NSArray *)sectionIndexTitles;//返回右侧索引标题

#pragma mark delete
+ (BOOL)isNeedToDeleteWholeSection:(NSInteger)section;//是否删除整个分区

+ (void)deleteWholeSection:(NSInteger)section;//删除整个分区

+ (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath;//删除一行

#pragma mark move
+ (void)moveFromIndexPath:(NSIndexPath *)sourceIndexPath ToIndexPath:(NSIndexPath *)destinationIndexPath;//返回移动到的位置

#pragma mark detail
//返回对应行所需的联系人
+ (Contact *)contactAtIndexPath:(NSIndexPath *)indexpath;

#pragma mark addContact
//添加联系人
+ (void)addContact:(Contact *)newContact;

//保存数据
+ (void)saveData;


//设置行高
+ (float)heightForRow;

//设置页眉高度
+ (float)heightForHeader;

@end
