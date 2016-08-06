//
//  BaseViewController.h
//  ExampleOne
//
//  Created by Aries on 16/5/28.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, copy) void (^hudWasHidden)(void);

- (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  设置导航栏
 *
 *  @param show  是否显示右侧的分享按钮
 */
- (void)setUpNavigationBarShowRightBarButtonItem:(BOOL)show;

/**
 *  点击分享按钮时调用
 */
- (void)share;

/**
 *  不显示返回按钮的Title
 */
- (void)dontShowBackButtonTitle;

- (void)showHUDWaitingWhileExecuting:(SEL)method;

- (void)showHUDWithText:(NSString *)text delay:(NSTimeInterval)delay;

- (void)showHUDDone;

- (void)showHUDDoneWithText:(NSString *)text;

- (void)showHUDErrorWithText:(NSString *)text;

- (void)showHUDNetError;

- (void)showHUDServerError;

- (void)showWithLabelText:(NSString *)showText executing:(SEL)method;

- (void)showHUDWithText:(NSString *)text;

/**
 *  隐藏当前显示的提示框
 */
- (void)hideHud;

@end
