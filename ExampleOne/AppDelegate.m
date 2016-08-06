//
//  AppDelegate.m
//  ExampleOne
//
//  Created by Aries on 16/5/28.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ReadingViewController.h"
#import "QuestionViewController.h"
#import "ThingViewController.h"
#import "PersonViewController.h"
#import "DSNavigationBar.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UITabBarController *rootTabBarController = [[UITabBarController alloc]init];
    //首页
    HomeViewController *homeViewController = [[HomeViewController alloc]init];
    UINavigationController *homeNavigationController = [self dsNavigationController];
    [homeNavigationController setViewControllers:@[homeViewController]];
    
    //文章
    ReadingViewController  *readingViewController = [[ReadingViewController alloc]init];
    UINavigationController *readingNavigationController = [self dsNavigationController];
    [readingNavigationController setViewControllers:@[readingViewController]];
    
    //问题
    QuestionViewController *questionViewController = [[QuestionViewController alloc]init];
    UINavigationController *questionNavigationController = [self dsNavigationController];
    [questionNavigationController setViewControllers:@[questionViewController]];
    
    //东西
    ThingViewController  *thingVC = [[ThingViewController alloc]init];
    UINavigationController *thingNav =[self dsNavigationController];
    [thingNav setViewControllers:@[thingVC]];
    
    //个人
    PersonViewController *personVC =[[PersonViewController alloc]init];
    UINavigationController *personNav = [self dsNavigationController];    [personNav setViewControllers:@[personVC]];
    
    rootTabBarController.viewControllers = @[homeNavigationController,readingNavigationController,questionNavigationController,thingNav,personNav];
    rootTabBarController.tabBar.tintColor = RGBA(55, 196, 242, 1);
    rootTabBarController.tabBar.barTintColor = RGBA(239, 239, 239, 1);
    rootTabBarController.tabBar.backgroundColor = [UIColor clearColor];
    
    [[DSNavigationBar appearance] setNavigationBarWithColor:DawnNavigationBarColor];
    
    rootTabBarController.tabBar.backgroundImage = [self imageWithColor:[UIColor colorWithRed:241 / 255.0 green:241 / 255.0 blue:241 / 255.0 alpha:1]];
    
    // 设置状态栏的字体颜色为黑色
    [application setStatusBarStyle:UIStatusBarStyleDefault];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = rootTabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark - 导航栏
- (UINavigationController *)dsNavigationController {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[DSNavigationBar class] toolbarClass:nil];
    [navigationController.navigationBar setOpaque:YES];
    navigationController.navigationBar.tintColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:229 / 255.0];
    
    return navigationController;
}
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
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
