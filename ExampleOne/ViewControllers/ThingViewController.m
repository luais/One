//
//  ThingViewController.m
//  ExampleOne
//
//  Created by Aries on 16/5/28.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "ThingViewController.h"
#import "RightPullToRefreshView.h"
#import "ThingEntity.h"
#import "MJExtension.h"
#import "ThingView.h"
#import "HTTPTool.h"

@interface ThingViewController ()<RightPullToRefreshViewDelegate, RightPullToRefreshViewDataSource>
{
    //当前一共多少item 默认为3个
    NSInteger numberOfItems;
    //保存当前查看过的数据
    NSMutableDictionary *readItems;
    //最后展示的item的下标
    NSInteger lastConfigureViewForItemIndex;
    //当钱是否正在右拉刷新标记
    BOOL isRefreshing;
}
@property (nonatomic,strong)RightPullToRefreshView *rightPullToRefreshView;
@end

@implementation ThingViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *deselectedImage =[[UIImage imageNamed:@"tabbar_item_thing"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage =[[UIImage imageNamed:@"tabbar_item_thing_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:@"东西" image:nil tag:0];
        tabBarItem.image = deselectedImage;
        tabBarItem.selectedImage = selectedImage;
        self.tabBarItem = tabBarItem;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    //显示Nav
    [self setUpNavigationBarShowRightBarButtonItem:YES];
    // 默认
    numberOfItems = 2;
    readItems = [[NSMutableDictionary alloc]init];
    lastConfigureViewForItemIndex = 0;
    isRefreshing = NO;
    
    self.rightPullToRefreshView = [[RightPullToRefreshView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- 64 - CGRectGetHeight(self.tabBarController.tabBar.frame))];
    self.rightPullToRefreshView.delegate = self;
    self.rightPullToRefreshView.dataSource = self;
    [self.view addSubview:self.rightPullToRefreshView];
    
    [self requestThingContentAtIndex:0];
    
}
#pragma mark - Lifecycle
- (void)dealloc
{
    self.rightPullToRefreshView.delegate = nil;
    self.rightPullToRefreshView.dataSource = nil;
    self.rightPullToRefreshView = nil;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -RightPullToRefreahViewDataSource
- (NSInteger)numberOfItemsInRightPullToRefreshView:(RightPullToRefreshView *)rightPullToRefreshView
{
    return numberOfItems;
}

- (UIView *)rightPullToRefreshView:(RightPullToRefreshView *)rightPullToRefreshView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    ThingView *thingView = nil;
    if (view == nil) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rightPullToRefreshView.frame), CGRectGetHeight(rightPullToRefreshView.frame))];
        thingView = [[ThingView alloc]initWithFrame:view.bounds];
        [view addSubview:thingView];
    }else{
        thingView = (ThingView *)view.subviews[0];
    }
    if (index == numberOfItems -1 || index == readItems.allKeys.count) {
        //当前这个item是没有展示过的
        [thingView refreshSubviewsForNewItem];
    }else{
        lastConfigureViewForItemIndex = MAX(index, lastConfigureViewForItemIndex);
        [thingView configureViewWithThingEntity:readItems[[@(index)stringValue]] animated:YES];
    }
    return view;
}

#pragma  mark - RightPullToRefreshViewDelegate
- (void)rightPullToRefreshViewRefreshing:(RightPullToRefreshView *)rightPullToRefreshView
{
    [self refreshing];
}

- (void)rightPullToRefreshView:(RightPullToRefreshView *)rightPullToRefreshView didDisplayItemAtIndex:(NSInteger)index
{
    if (index == numberOfItems - 1) {
        numberOfItems++;
        [self.rightPullToRefreshView insertItemAtIndex:(numberOfItems - 1) animated:YES];
    }
    if (index < readItems.allKeys.count && readItems[[@(index)stringValue]]) {
        ThingView *thingView = (ThingView *)[rightPullToRefreshView itemViewAtIndex:index].subviews[0];
        [thingView configureViewWithThingEntity:readItems[[@(index)stringValue]] animated:(lastConfigureViewForItemIndex == 0 || lastConfigureViewForItemIndex < index)];
    }else{
        [self requestThingContentAtIndex:index];
    }
}
- (void)rightPullToRefreshViewCurrentItemIndexDidChange:(RightPullToRefreshView *)rightPullToRefreshView
{
    if (isGreatThanIOS9) {
        UIView *currentItemView = [rightPullToRefreshView currentItemView];
        for (id subView in rightPullToRefreshView.contentView.subviews) {
            if (![subView isKindOfClass:[UILabel class]]) {
                UIView *itemView = (UIView *)subView;
                ThingView *thingView = (ThingView *)itemView.subviews[0].subviews[0];
                UIScrollView *scrollView = (UIScrollView *)[thingView viewWithTag:ScrollViewTag];
                if (itemView == currentItemView.superview) {
                    scrollView.scrollsToTop = YES;
                }else{
                    scrollView.scrollsToTop = NO;
                }
            }
        }
    }
}

#pragma mark - Network Requests
// 右拉刷新
- (void)refreshing
{
    if (readItems.allKeys.count > 0) {
        //
        [self showHUDWithText:@""];
        isRefreshing = YES;
        [self requestThingContentAtIndex:0];
    }
}

- (void)requestThingContentAtIndex:(NSInteger)index
{
    [HTTPTool requestThingContentByIndex:index success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"rs"]isEqualToString:REQUEST_SUCCESS]) {
            ThingEntity *returnThingEntity = [ThingEntity objectWithKeyValues:responseObject[@"entTg"]];
            if (isRefreshing) {
                [self endRefreshing];
                if ([returnThingEntity.strId isEqualToString:((ThingEntity *)readItems[@"0"]).strId]) {
                    //没有最新数据
                    [self showHUDWithText:IsLatestData delay:HUD_DELAY];
                }else{
                    // 有新数据
                    // 删掉所有的已读数据，不用考虑第一个已读数据和最新数据之间相差几天，简单粗暴
                    [readItems removeAllObjects];
                    [self hideHud];
                }
                [self endRequestThingContent:returnThingEntity atIndex:index];
            }else{
                [self hideHud];
                [self endRequestThingContent:returnThingEntity atIndex:index];
            }
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@", error);
    }];
}
#pragma mark - Private

- (void)endRefreshing {
    isRefreshing = NO;
    [self.rightPullToRefreshView endRefreshing];
}
- (void)endRequestThingContent:(ThingEntity *)thingEntity atIndex:(NSInteger)index {
    [readItems setObject:thingEntity forKey:[@(index) stringValue]];
    [self.rightPullToRefreshView reloadItemAtIndex:index animated:NO];
}
#pragma mark - Parent

- (void)share {
    [super share];
}
@end
