//
//  ThingView.h
//  ExampleOne
//
//  Created by Aries on 16/6/2.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *   东西 － View
 */
@class ThingEntity;
@interface ThingView : UIView
/**
 *  按照给定的数据显示视图
 *
 *  @param homeEntity 要显示的数据
 *  @param animated   是否需要图片的加载动画
 */
- (void)configureViewWithThingEntity:(ThingEntity *)thingEntity animated:(BOOL)animated;
/**
 *  刷新视图内的子视图，主要是为了准备显示新的item
 */
- (void)refreshSubviewsForNewItem;
@end
