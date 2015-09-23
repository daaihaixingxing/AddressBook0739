//
//  AddressBookHelper.m
//  AddressBook0739
//
//  Created by lanouhn on 15/9/14.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

/**
 *  AddressBookHelper 是通讯录列表界面的助手类，帮助列表界面做数据处理相关的内容，为 ContactListViewController 瘦身，可有可无。
 M层的类：和数据有关的类。比如：数据解析类，数据请求类，数据本地化类。
 */

#define kPlistName @"contacts"
#import "AddressBookHelper.h"
#import "ChineseToPinyin.h"
#import "NSString+Addition.h"

@interface AddressBookHelper ()

@property (nonatomic,retain) NSMutableDictionary *dataSource;//存储外层信息的大字典
@property (nonatomic,retain) NSMutableArray *sortedKeys;//存储排好序的key

@end


@implementation AddressBookHelper

- (void)dealloc {
    self.dataSource = nil;
    self.sortedKeys = nil;
    [super dealloc];
}


static AddressBookHelper *helper;
//单例方法
+ (AddressBookHelper *)defaultHelper {
    //安全处理 保证多线程下的安全
    @synchronized(self) {
        if (!helper) {
            helper = [[AddressBookHelper alloc] init];
            [helper readDataFromPlist];//读取本地plist文件
        }
        return helper;
    }
}

//获取本地文件
- (void)readDataFromPlist {
    //1.读取本地文件 将信息存放到字典中
    NSString *filePath = [[NSBundle mainBundle] pathForResource:kPlistName ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    //为数据源字典开辟空间
    self.dataSource = [NSMutableDictionary dictionaryWithCapacity:dict.count];
    //2.1 遍历字典 得到key
    for (NSString *key in dict) {
        //2.2 通过key 获取联系人分组数组
        NSArray *group = dict[key];
        //2.3 创建一个可变数组 存放联系人对象
        NSMutableArray *perArr = [NSMutableArray arrayWithCapacity:group.count]; //可以直接开辟 group.count的空间  也可以直接给0，让其动态的去开辟空间
        //2.4 遍历分组数组 得到联系人信息小字典
        for (NSDictionary *dic in group) {
            //2.5 将小字典信息封装成对象 存放到数组中
            Contact *contact = [[Contact alloc] initWithDic:dic];
            [perArr addObject:contact];
            [contact release];
        }
        //2.6 将存放对象的数组及其对应的key 存放到字典中
        [self.dataSource setObject:perArr forKey:key];
    }
    //获取排好序的key
    NSArray *sortedArr = [[self.dataSource allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.sortedKeys = [NSMutableArray arrayWithArray:sortedArr];
    
}

#pragma mark source
+ (NSInteger)numberOfSection //返回分区个数
{
    return [self defaultHelper].dataSource.count;
//    return [self defaultHelper].sortedKeys.count;
}

+ (NSInteger)numberOfRowsInSection:(NSInteger)section //返回对应分区的行数
{
    return [helper.dataSource[helper.sortedKeys[section]] count];
}

+ (NSString *)titleForHeaderInSection:(NSInteger)section //返回对应分区的title
{
    return helper.sortedKeys[section];
}

+ (NSArray *)sectionIndexTitles //返回右侧索引标题
{
    return helper.sortedKeys;
}

#pragma mark delete
+ (BOOL)isNeedToDeleteWholeSection:(NSInteger)section //是否删除整个分区
{
    //获取对应分组的联系人数组
    NSArray *group = helper.dataSource[helper.sortedKeys[section]];
    //如果该数组元素个数为1 代表只有一个人 则删除整个分区
    if (group.count == 1) {
        return YES;
    }
    //否则，不删除整个分区
    return NO;
}

+ (void)deleteWholeSection:(NSInteger)section //删除整个分区
{
    //1. 获取对应的key
    NSString *key = helper.sortedKeys[section];
    //2. 从字典删除key对应的分组数组
    [helper.dataSource removeObjectForKey:key];
    //3. 从排好序的key数组中移除该key值
    [helper.sortedKeys removeObject:key];
}

+ (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath //删除一行
{
    //1. 获取对应的分组
    NSMutableArray *group = helper.dataSource[helper.sortedKeys[indexPath.section]];
    //2.从对应分组中移除该元素
    [group removeObjectAtIndex:indexPath.row];
}

#pragma mark move
+ (void)moveFromIndexPath:(NSIndexPath *)sourceIndexPath ToIndexPath:(NSIndexPath *)destinationIndexPath //返回移动到的位置
{
    //做移动操作时界面上已经发生改变，在这里只需要处理数据
    
    //1. 获取对应分组数组
    NSMutableArray *group = helper.dataSource [helper.sortedKeys[sourceIndexPath.section]];
    //2. 获取对应的联系人
    Contact *per = [[group objectAtIndex:sourceIndexPath.row] retain];
    
    //3. 删除 从数组中把对应位置的per对象删除
    [group removeObjectAtIndex:sourceIndexPath.row];
    //4. 插入 再将对应的对象移动到目的位置
    [group insertObject:per atIndex:destinationIndexPath.row];
    //5. 释放所有权
    [per release];
}


#pragma mark detail
//返回对应行所需的联系人
+ (Contact *)contactAtIndexPath:(NSIndexPath *)indexpath
{
    /*
    //获取联系人数组
    NSArray *group = helper.dataSource[helper.sortedKeys[indexpath.section]];
    //得到联系人对象
    Contact *per = group[indexpath.row];
    return per;
    */
    return helper.dataSource[helper.sortedKeys[indexpath.section]][indexpath.row];//一行代码的写法
}

#pragma mark addContact
//添加联系人
+ (void)addContact:(Contact *)newContact
{
    //1.获取联系人姓名 转化为拼音 并取姓名首字母的大写
    NSString *key = [newContact.name firstCharacter];
    //安全处理 判断key是否存在
    if (!key) {
        return;
    }
    
    //2.获取分组的数组
    NSMutableArray *group = helper.dataSource[key];
    //3.如果该分组不存在 则建立该分组
    if (!group) {
        group = [NSMutableArray array];
        //新建分组 添加到字典中
        [helper.dataSource setObject:group forKey:key];
        //对应分组的key添加到对应的数组中 并排序
        [helper.sortedKeys addObject:key];
        [helper.sortedKeys sortUsingSelector:@selector(compare:)];
    }
    //存在该分组，则直接把联系人添加到数组中
    [group addObject:newContact];
    
}

//保存数据
+ (void)saveData {
#warning 待完善~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
}

//设置行高
+ (float)heightForRow {
    return 80;
}

//设置页眉高度
+ (float)heightForHeader {
    return 20;
}

@end
