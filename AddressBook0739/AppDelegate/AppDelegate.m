//
//  AppDelegate.m
//  AddressBook0739
//
//  Created by lanouhn on 15/9/14.
//  Copyright (c) 2015年 大爱海星星. All rights reserved.
//
#define FIRST @"firstLaunch"

#import "AppDelegate.h"
#import "ContactListViewController.h"
#import "MainNavigationController.h"
#import "FirstLaunchViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)dealloc {
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    /**
     用户引导页
     
     :returns: 1.判断是否第一次安装启动
               2.如果是，则指定用户引导页为window的根视图控制器
               3.否则，进入程序的主界面
     */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults boolForKey:FIRST]) {
        FirstLaunchViewController *firstVC = [[FirstLaunchViewController alloc] init];
        self.window.rootViewController = firstVC;
        [firstVC release];
    }else {
        //设置根视图控制器
        ContactListViewController *mainVC = [[ContactListViewController alloc] initWithStyle:UITableViewStyleGrouped];
        //创建导航控制器
        MainNavigationController *navi = [[MainNavigationController alloc] initWithRootViewController:mainVC];
        //指定为window的根视图控制器
        self.window.rootViewController = navi;
        //释放所有权
        [mainVC release];
        [navi release];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
