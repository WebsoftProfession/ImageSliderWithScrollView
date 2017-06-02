//
//  UIImageView+UIActivityIndicatorForSDWebImage.m
//  UIActivityIndicator for SDWebImage
//
//  Created by Giacomo Saccardo.
//  Copyright (c) 2014 Giacomo Saccardo. All rights reserved.
//

#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import <objc/runtime.h>

static char TAG_ACTIVITY_INDICATOR;

@interface UIImageView (Private)

-(void)addActivityIndicatorWithStyle:(LLACircularProgressViewStyle) activityStyle;

@end

@implementation UIImageView (UIActivityIndicatorForSDWebImage)

@dynamic activityIndicator;

- (LLACircularProgressView *)activityIndicator {
    return (LLACircularProgressView *)objc_getAssociatedObject(self, &TAG_ACTIVITY_INDICATOR);
}

- (void)setActivityIndicator:(LLACircularProgressView *)activityIndicator {
    objc_setAssociatedObject(self, &TAG_ACTIVITY_INDICATOR, activityIndicator, OBJC_ASSOCIATION_RETAIN);
}

- (void)addActivityIndicatorWithStyle:(LLACircularProgressViewStyle) activityStyle {
    
    if (!self.activityIndicator)
    {
        
        self.activityIndicator = [[LLACircularProgressView alloc] init];
        
        if (activityStyle == LLACircularProgressViewStyleDark)
        {
            self.activityIndicator.progressTintColor = [UIColor whiteColor];
        }
        
        CGFloat width = self.frame.size.width * 0.4f;
        CGFloat height = self.frame.size.height * 0.4f;
        
        if (width<height)
        {
            height = width;
        }
        else
        {
            width = height;
        }
        
        if (width>100)
        {
            width = 80.0f;
            height = 80.0f;
        }
        
        self.activityIndicator.frame = CGRectMake(0, 0, width, height);
        
        float x = (self.frame.size.width - width) / 2.0;
        float y = (self.frame.size.height - height) / 2.0;
        self.activityIndicator.frame = CGRectMake(x, y, width, height);
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self addSubview:self.activityIndicator];
        });
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(void)
    {
        
    });
    
}

- (void)removeActivityIndicator {
    if (self.activityIndicator) {
        [self.activityIndicator removeFromSuperview];
        self.activityIndicator = nil;
    }
}

#pragma mark - Methods

- (void)setImageWithURL:(NSURL *)url usingActivityIndicatorStyle:(LLACircularProgressViewStyle)activityStyle {
    [self setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil usingActivityIndicatorStyle:activityStyle];
}



- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder usingActivityIndicatorStyle:(LLACircularProgressViewStyle)activityStye {
    [self setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil usingActivityIndicatorStyle:activityStye];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options usingActivityIndicatorStyle:(LLACircularProgressViewStyle)activityStyle{
    [self setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil usingActivityIndicatorStyle:activityStyle];
}

- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(LLACircularProgressViewStyle)activityStyle {
    [self setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock usingActivityIndicatorStyle:activityStyle];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(LLACircularProgressViewStyle)activityStyle {
    [self setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock usingActivityIndicatorStyle:activityStyle];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(LLACircularProgressViewStyle)activityStyle {
    [self setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock usingActivityIndicatorStyle:activityStyle];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(LLACircularProgressViewStyle)activityStyle {
    
    [self addActivityIndicatorWithStyle:activityStyle];
    
    __weak typeof(self) weakSelf = self;
    
    __weak typeof(LLACircularProgressView *) weakActivity = self.activityIndicator;
    
    [self setImageWithURL:url placeholderImage:placeholder options:options progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat read = receivedSize;
        CGFloat to = expectedSize;
        CGFloat progress = read / to;
        [weakActivity setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType)
    {
        if (completedBlock) {
            completedBlock(image, error, cacheType);
        }
        [weakSelf removeActivityIndicator];
    }];
}

@end
