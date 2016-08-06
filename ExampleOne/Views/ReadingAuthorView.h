//
//  ReadingAuthorView.h
//  ExampleOne
//
//  Created by Aries on 16/6/1.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  文章作者View
 */
@class ReadingEntity;
@interface ReadingAuthorView : UIView

- (void)configureAuthorViewWithReadingEntity: (ReadingEntity *)readingEntity;
@end
