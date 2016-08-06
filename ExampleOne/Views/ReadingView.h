//
//  ReadingView.h
//  ExampleOne
//
//  Created by Aries on 16/6/1.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  文章View
 */
@class ReadingEntity;
@interface ReadingView : UIView
- (void)configureReadingViewWithReadingEntity:(ReadingEntity *)readingEntity;

- (void)refreshSubviewForNewItem;
@end
