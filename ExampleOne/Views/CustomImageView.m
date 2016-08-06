//
//  CustomImageView.m
//  ExampleOne
//
//  Created by Aries on 16/6/2.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "CustomImageView.h"
#import "CircularLoaderView.h"
#import "UIImageView+WebCache.h"

@interface CustomImageView ()
@property (nonatomic,strong) CircularLoaderView *progressIndicatorView;

@end
@implementation CustomImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.progressIndicatorView = [[CircularLoaderView alloc]initWithFrame:CGRectZero];
        [self addSubview:self.progressIndicatorView];
    }
    return self;
}

- (void)configureImageViwWithImageURL:(NSURL *)url animated:(BOOL)animated
{
    if (animated) {
        self.progressIndicatorView.frame = self.bounds;
        [self.progressIndicatorView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        
        [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            self.progressIndicatorView.progress = @(receivedSize).floatValue / @(expectedSize).floatValue;
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self.progressIndicatorView reveal];
        }];
    }else{
        self.progressIndicatorView.frame = CGRectZero;
        [self sd_setImageWithURL:url];
    }
}

@end
