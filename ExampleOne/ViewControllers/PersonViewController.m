//
//  PersonViewController.m
//  ExampleOne
//
//  Created by Aries on 16/5/28.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "PersonViewController.h"
#import "SettingsViewController.h"
#define rad(degrees) ((degrees)/(180.0 / M_PI))
static NSString *AccountCellID = @"AccountCellID";
static NSString *OtherCellID = @"OtherCell";

@interface PersonViewController ()<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation PersonViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *deselectedImage = [[UIImage imageNamed:@"tabbar_item_person"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:@"tabbar_item_person_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:nil tag:0];
        tabBarItem.image = deselectedImage;
        tabBarItem.selectedImage = selectedImage;
        self.tabBarItem = tabBarItem;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self setUpNavigationBarShowRightBarButtonItem:NO];
    //加载cell
    [self setupTableView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nightModeSwitch:) name:@"DKNightVersionNightFallingNotification" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nightModeSwitch:) name:@"DKNightVersionDawnComingNotification" object:nil];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)dealloc
{
    self.tableView .delegate = self;
    self.tableView.dataSource = self;
    [self.tableView removeFromSuperview];
    self.tableView =nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark-黑夜模式改变通知
- (void)nightModeSwitch:(NSNotification *)notification
{
    [self.tableView reloadData];
}
#pragma mark- 创建view
- (void)setupTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 -CGRectGetHeight(self.tabBarController.tabBar.frame))];
    //不显示空cell
    self.tableView.tableFooterView = [[UIView alloc]init];
    //设置cell的杭高
    self.tableView.rowHeight = 69;
    self.tableView.delegate  =self;
    self.tableView.dataSource = self;
    // 设置tableView分割线
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:AccountCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:OtherCellID];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.nightBackgroundColor = NightBGViewColor;
    self.tableView.separatorColor = TableViewCellSeparatorDawnColor;
    self.tableView.nightSeparatorColor = [UIColor blackColor];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = indexPath.row == 0 ? AccountCellID:OtherCellID;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"这是名字";
//        cell.imageView.image = [UIImage imageNamed:;
    }else if (indexPath.row ==1){
        cell.textLabel.text = @"设置";
//        cell.imageView.image = [UIImage imageNamed:@"setting"];
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"关于";
        NSString *imageName = Is_Night_Mode ? @"copyright_nt":@"copyright";
//        cell.imageView.image = [UIImage imageNamed:imageName];
    }
    cell.textLabel.textColor = DawnTextColor;
    cell.textLabel.nightTextColor = NightTextColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.nightBackgroundColor = NightBGViewColor;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==1) {
//        SettingsViewController *VC = [[SettingsViewController alloc]init];
//        [self.navigationController pushViewController:VC animated:YES];
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
