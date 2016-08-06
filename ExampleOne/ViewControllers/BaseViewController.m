//
//  BaseViewController.m
//  ExampleOne
//
//  Created by Aries on 16/5/28.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "BaseViewController.h"
#import "DSNavigationBar.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()<MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.nightBackgroundColor = [UIColor redColor];
    //设置夜间模式的背景色
    self.view.nightBackgroundColor = NightBGViewColor;
    //设置标题栏不能覆盖下面的ViewController的内容
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
#pragma mark  - 加载公共导航栏
- (void)setUpNavigationBarShowRightBarButtonItem:(BOOL)show {
    // 显示导航栏上的《一个》图标
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navLogo"]];

    if (show) {
        // 初始化导航栏右侧的分享按钮
        UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        [shareButton setBackgroundImage:[UIImage imageNamed:@"nav_share_btn_normal"] forState:UIControlStateNormal];
        [shareButton setBackgroundImage:[UIImage imageNamed:@"nav_share_btn_highlighted"] forState:UIControlStateHighlighted];
        UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
        
        self.navigationItem.rightBarButtonItem = shareItem;
    }
}
- (void)share
{
    
}
- (void)dontShowBackButtonTitle
{
	[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma mark - MBProgressHUD
- (void)showHUDWaitingWhileExecuting:(SEL)method
{
    HUD = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.color = RGBA(100, 100, 100, 0.9);
    HUD.delegate =self;
    [HUD showWhileExecuting:method onTarget:self withObject:nil animated:YES];
}

- (void)showHUDWithText:(NSString *)text delay:(NSTimeInterval)delay
{
    if (!HUD.isHidden) {
        [HUD hide:NO];
    }
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    HUD.mode =MBProgressHUDModeText;
    HUD.labelText  = text;
    HUD.margin = 10.0f;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.delegate = self;
    [HUD hide:YES afterDelay:delay];
}
- (void)showHUDDone
{
    [self showHUDDoneWithText:@"Done"];
}
- (void)showHUDDoneWithText:(NSString *)text
{
    if (!HUD.isHidden) {
        [HUD hide:NO];
    }
    HUD = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_right"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = text;
    
    HUD.delegate = self;
    [HUD show:YES];
    [HUD hide:YES afterDelay:HUD_DELAY];
}
- (void)showHUDErrorWithText:(NSString *)text
{
    if (!HUD.isHidden) {
        [HUD hide:NO];
    }
    HUD = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_error"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = text;
    
    HUD.delegate = self;
    [HUD show:YES];
    [HUD hide:YES afterDelay:HUD_DELAY];
}

- (void)showHUDNetError
{
    [self showHUDErrorWithText:BadNetwork];
}
- (void)showHUDServerError
{
    [self showHUDErrorWithText:@"Server Error"];
}
- (void)showWithLabelText:(NSString *)showText executing:(SEL)method
{
    if (!HUD.isHidden) {
        [HUD hide:NO];
    }
    HUD = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = showText;
    
    HUD.delegate = self;
    [HUD showWhileExecuting:method onTarget:self withObject:nil animated:YES];
}

- (void)showHUDWithText:(NSString *)text
{
    [self hideHud];
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = text;
    HUD.margin = 10.f;
    
    HUD.delegate =self;
    HUD.removeFromSuperViewOnHide = YES;
}
- (void)processServerErrorWithCode:(NSInteger)code andErrorMsg:(NSString *)msg
{
    if (code == 500) {
        [self showHUDServerError];
    }else{
        [self showHUDDoneWithText:msg];
    }
}
- (void)hideHud
{
    if (!HUD.isHidden) {
        [HUD hide:NO];
    }
}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    if (self.hudWasHidden) {
        self.hudWasHidden();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
