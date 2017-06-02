//
//  UIImageView+UIActivityIndicatorForSDWebImage.h
//  UIActivityIndicator for SDWebImage
//
//  Created by Giacomo Saccardo.
//  Copyright (c) 2014 Giacomo Saccardo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"
#import "LLACircularProgressView.h"


typedef NS_ENUM(NSInteger, LLACircularProgressViewStyle)
{
    LLACircularProgressViewStyleLight,
    LLACircularProgressViewStyleDark
};

@interface UIImageView (UIActivityIndicatorForSDWebImage)

@property (nonatomic, strong) LLACircularProgressView *activityIndicator;

- (void)setImageWithURL:(NSURL *)url usingActivityIndicatorStyle:(LLACircularProgressViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder usingActivityIndicatorStyle:(LLACircularProgressViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options usingActivityIndicatorStyle:(LLACircularProgressViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(LLACircularProgressViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(LLACircularProgressViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(LLACircularProgressViewStyle)activityStyle;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorStyle:(LLACircularProgressViewStyle)activityStyle;

- (void)removeActivityIndicator;

@end
