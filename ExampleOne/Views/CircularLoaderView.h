//
//  CircularLoaderView.h
//  ExampleOne
//
//  Created by Aries on 16/6/2.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularLoaderView : UIView
@property (nonatomic,assign) CGFloat progress;

- (void)reveal;
@end
