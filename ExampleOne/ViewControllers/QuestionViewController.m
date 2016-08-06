//
//  QuestionViewController.m
//  ExampleOne
//
//  Created by Aries on 16/5/28.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "QuestionViewController.h"
#import "RightPullToRefreshView.h"
#import "QuestionEntity.h"
#import "MJExtension.h"
#import "QuestionView.h"
#import "HTTPTool.h"

@interface QuestionViewController ()<RightPullToRefreshViewDelegate,RightPullToRefreshViewDataSource>
{
    // 当前一共有多少个item，默认为3个
    NSInteger numberOfItems;
    //保存当前查看过的数据
    NSMutableDictionary *readItems;
    //最后更新的日期
    NSString *lastUpdateDate;
    //当前是否正在右拉刷新标记
    BOOL isRefreshing;
}
@property (nonatomic,strong) RightPullToRefreshView *rightPullToRefreshView;
@end

@implementation QuestionViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *deselectedImage = [[UIImage imageNamed:@"tabbar_item_question"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:@"tabbar_item_question_selected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //底部导航item
        UITabBarItem *tabBarItem =[[UITabBarItem alloc]initWithTitle:@"问题" image:nil tag:0];
        tabBarItem.image = deselectedImage;
        tabBarItem.selectedImage = selectedImage;
        self.tabBarItem = tabBarItem;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
      self.view.backgroundColor = [UIColor orangeColor];
    
    [self setUpNavigationBarShowRightBarButtonItem:YES];
    numberOfItems = 2;
    readItems = [[NSMutableDictionary alloc]init];
    lastUpdateDate = [BaseFunction stringDateBeforeTodaySeveralDays:0];
    isRefreshing = NO;
    
    self.rightPullToRefreshView = [[RightPullToRefreshView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - CGRectGetHeight(self.tabBarController.tabBar.frame))];
    self.rightPullToRefreshView.delegate = self;
    self.rightPullToRefreshView.dataSource = self;
    [self.view addSubview:self.rightPullToRefreshView];
    
//    [NSNotificationCenter defaultCenter]
    
//    	[self requestQuestionContentAtIndex:0];
}
- (void)dealloc
{
    self.rightPullToRefreshView.delegate = nil;
    self.rightPullToRefreshView.dataSource =nil;
    self.rightPullToRefreshView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-RightPullToRefreshViewDataSource
- (NSInteger)numberOfItemsInRightPullToRefreshView:(RightPullToRefreshView *)rightPullToRefreshView
{
    return numberOfItems;
}
- (UIView *)rightPullToRefreshView:(RightPullToRefreshView *)rightPullToRefreshView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    QuestionView *questionView = nil;
    if (view == nil) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rightPullToRefreshView.frame), CGRectGetHeight(rightPullToRefreshView.frame))];
        questionView = [[QuestionView alloc]initWithFrame:view.bounds];
        [view addSubview:questionView];
    }else{
        questionView = (QuestionView *)view.subviews[0];
    }
    
    if (index == numberOfItems - 1 || index == readItems.allKeys.count) {
        //当前这个item是没有展示过的
        [questionView refreshSubviewsForNewItem];
    }else{
        //当前这个item展示过了但是没有显示过数据的
        [questionView configureViewWithQuestionEntity:readItems[[@(index)stringValue]]];
    }
    return view;
}

#pragma mark - RightPullToFreshViewDelegate
- (void)rightPullToRefreshViewRefreshing:(RightPullToRefreshView *)rightPullToRefreshView
{
    [self refreshing];
}
- (void)rightPullToRefreshView:(RightPullToRefreshView *)rightPullToRefreshView didDisplayItemAtIndex:(NSInteger)index
{
    if (index == numberOfItems -1) {
        //如果当前显示的是最后一个，则添加一个item
        numberOfItems++;
        [self.rightPullToRefreshView insertItemAtIndex:(numberOfItems -1) animated:YES];
    }
    if (index < readItems.allKeys.count && readItems[[@(index)stringValue]]) {
        QuestionView *questionView = (QuestionView *)[rightPullToRefreshView itemViewAtIndex:index].subviews[0];
        [questionView configureViewWithQuestionEntity:readItems[[@(index)stringValue]]];
    }else{
        [self requestQuestionContentAtIndex:index];
        NSLog(@"ddd");
    }
}

- (void)rightPullToRefreshViewCurrentItemIndexDidChange:(RightPullToRefreshView *)rightPullToRefreshView
{
    if (isGreatThanIOS9) {
        UIView *currentItemView = [rightPullToRefreshView currentItemView];
        for (id subView in rightPullToRefreshView.contentView.subviews) {
            if (![subView isKindOfClass:[UILabel class]]) {
                UIView *itemView = (UIView *)subView;
                QuestionView *questionView = (QuestionView *)itemView.subviews[0].subviews[0];
                UIWebView *webView = (UIWebView *)[questionView viewWithTag:WebViewTag];
                if (itemView == currentItemView.superview) {
                    webView.scrollView.scrollsToTop = YES;
                }else{
                    webView.scrollView.scrollsToTop = NO;
                }
            }
        }
    }
}
#pragma mark -Network Requests
//右拉刷新
- (void)refreshing
{
    if (readItems.allKeys.count > 0) {
        //避免第一个还未加载的时候右拉刷新更新数据
        [self showHUDWithText:@""];
        isRefreshing = YES;
        [self requestQuestionContentAtIndex:0];
    }
}
- (void)requestQuestionContentAtIndex:(NSInteger)index
{
    NSString *date = [BaseFunction stringDateBeforeTodaySeveralDays:index];
    [HTTPTool requestQuestionContentByDate:date lastUpdateDate:lastUpdateDate success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"result"] isEqualToString:REQUEST_SUCCESS]) {
            QuestionEntity *returnQuestionEntity = [QuestionEntity objectWithKeyValues:responseObject[@"questionAdEntity"]];
            if (IsStringEmpty(returnQuestionEntity.strQuestionId)) {
                returnQuestionEntity.strQuestionMarketTime = date;
            }
            
            if (isRefreshing) {
                [self endRefreshing];
                if ([returnQuestionEntity.strQuestionId isEqualToString:((QuestionEntity *)readItems[@"0"]).strQuestionId]) {// 没有最新数据
                    [self showHUDWithText:IsLatestData delay:HUD_DELAY];
                } else {// 有新数据
                    // 删掉所有的已读数据，不用考虑第一个已读数据和最新数据之间相差几天，简单粗暴
                    [readItems removeAllObjects];
                    [self hideHud];
                }
                
                [self endRequestQuestionContent:returnQuestionEntity atIndex:index];
            } else {
                [self hideHud];
                [self endRequestQuestionContent:returnQuestionEntity atIndex:index];
            }
        }
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"question error = %@", error);
    }];
}
#pragma mark -Private
- (void)endRefreshing
{
    isRefreshing = NO;
    [self.rightPullToRefreshView endRefreshing];
}
- (void)endRequestQuestionContent:(QuestionEntity *)questionEntity atIndex:(NSInteger)index
{
    [readItems setObject:questionEntity forKey:[@(index) stringValue]];
    [self.rightPullToRefreshView reloadItemAtIndex:index animated:NO];
}
- (void)share
{
    [super share];
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
