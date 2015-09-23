//
//  ContactListViewController.m
//  AddressBook0739
//
//  Created by lanouhn on 15/9/14.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//

#import "ContactListViewController.h"
#import "AddressBookHelper.h"
#import "Contact.h"
#import "AddcontactViewController.h"
#import "MainNavigationController.h"
#import "DetailViewController.h"
#import "UIImage+Scale.h"
#import "CostomContactCell.h"

@interface ContactListViewController () <MakeACallDelegate>

@property (nonatomic,retain) UIWebView *webView;

@end

@implementation ContactListViewController

//刷新数据
- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];//重新加载数据
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customizedNaviBar];//对当前导航栏设置属性
    //注册cell
    [self.tableView registerClass:[CostomContactCell class]   forCellReuseIdentifier:@"reuse"] ;//用系统提供的cell 做测试

}

#pragma mark ---对系统当前导航栏配置属性---
- (void)customizedNaviBar {
    //导航栏标题
    self.navigationItem.title = @"0739通讯录";
    //右button
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //左button
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add_contact@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(handleAdd:)] autorelease];
}
#pragma mark --- 左button的点击事件处理 点击进入添加联系人界面---
//模态进入添加联系人界面
- (void)handleAdd:(UIBarButtonItem *)item {
    AddcontactViewController *addVC = [[AddcontactViewController alloc] init];
    MainNavigationController *mainVC = [[MainNavigationController alloc] initWithRootViewController:addVC];
    mainVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:mainVC animated:YES completion:^{
        
    }];
    [addVC release];
    [mainVC release];
    
}


#pragma mark ---内存警告---
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    
    //通过助手类 返回分区的数目
    return [AddressBookHelper numberOfSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    //通过助手类 返回分区的行数
    return [AddressBookHelper numberOfRowsInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
     */
    
    CostomContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];//取代了之前的写法，但是需要先在viewDidLoad方法中注册cell
    // Configure the cell...
    
    //获取联系人对象
    Contact *contact = [AddressBookHelper contactAtIndexPath:indexPath];//当前分区当前行的联系人
    
    //cell控件赋值
    //1. 自定义方法 为cell的控件赋值
    [cell configureCell:contact];
    //2. 重写setter方法 为cell的控件赋值
    cell.contact = contact;
    /*
    cell.nameLabel.text = contact.name;
    cell.phoneLabel.text = contact.phoneNum;
    cell.photoView.image = [UIImage imageNamed:contact.photo];
//scaleToSize:CGSizeMake(50, 80)];
     */
    //设置代理对象
    cell.delegate = self;
    cell.indexPath = indexPath;
    
    //设置辅助样式
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

//设置页眉标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [AddressBookHelper titleForHeaderInSection:section];
}

//设置右侧索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [AddressBookHelper sectionIndexTitles];
}


//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [AddressBookHelper heightForRow];
}

//设置页眉高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [AddressBookHelper heightForHeader];
}

//设置哪些行或者哪些分区不可被点击
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 8 && indexPath.section == 14) {
        return NO;
    }
    return YES;
}

// Override to support conditional editing of the table view.

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.row == 8 && indexPath.section == 14) {
        return NO;
    }
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        if ([AddressBookHelper isNeedToDeleteWholeSection:indexPath.section]) {
            //数据方面的删除
            [AddressBookHelper deleteWholeSection:indexPath.section];
            //UI界面的删除
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
        } else {
            //数据
            [AddressBookHelper deleteRowAtIndexPath:indexPath];
            //UI
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        [AddressBookHelper deleteRowAtIndexPath:indexPath.row];
    }
}


//移动操作
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    //调用助手类 完成对应的移动操作
    [AddressBookHelper moveFromIndexPath:fromIndexPath ToIndexPath:toIndexPath];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

//限制移动的范围 禁止跨区移动
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    //如果移动前后移动后的分区相同，则返回移动后的位置
    if (sourceIndexPath.section == proposedDestinationIndexPath.section) {
        return proposedDestinationIndexPath;
    }
    //否则返回原来的位置
    return sourceIndexPath;
}

#pragma mark ---UITableViewDelegate 点击进入详情页面---
//点击进入详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //push进入联系人详情页
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    //属性传值（在push进入详情页面需要进行传值）
    Contact *contact = [AddressBookHelper contactAtIndexPath:indexPath];
    detailVC.contact = contact;
    
    [self.navigationController pushViewController:detailVC animated:NO];
    [detailVC release];
    
}


#pragma mark ---MakeACallDelegate---
//拨打电话
- (void)dial:(NSIndexPath *)indexPath {
    
    Contact *contact = [AddressBookHelper contactAtIndexPath:indexPath];
//    self.webView = [[UIWebView alloc] init];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"name:%@ tel:%@ %@!", contact.name,contact.phoneNum,@""]]]];
//    NSLog(@"%@ %@",[NSString stringWithFormat:@"name:%@",contact.name],[NSString stringWithFormat:@"tel:%@", contact.phoneNum]);
    NSLog(@"%@ %@",contact.name,contact.phoneNum);
    
}


//懒加载 何时使用 何时创建
- (UIWebView *)webView {
    if (!_webView) {
        self.webView = [[UIWebView alloc] init];
        [self.view addSubview:_webView];
        [_webView release];
    }
    return [[_webView retain] autorelease];
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
