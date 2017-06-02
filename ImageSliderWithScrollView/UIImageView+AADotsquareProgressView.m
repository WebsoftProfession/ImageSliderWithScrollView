//
//  UIImageView+AADotsquareProgressView.m
//  AppleProgressHUD
//
//  Created by WebsoftProfession on 7/20/16.
//   WebsoftProfession. All rights reserved.
//

#import "UIImageView+AADotsquareProgressView.h"

@implementation UIImageView (AADotsquareProgressView)


-(void)setImageWithURLRequest:(NSString *)urlString
{
    
    
    self.image=nil;
    ProgressAnimation *progressView=[[ProgressAnimation alloc] init];
    progressView.frame=self.bounds;
    progressView.alpha=1.0;
    progressView.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:progressView];

    NSURL *imageURL = [NSURL URLWithString:urlString];
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:imageURL];
    __weak __typeof(self)weakSelf = self;
    
    __strong __typeof(weakSelf)strongSelf = weakSelf;
    [progressView initWithTimerValue];
    
   
    
//    [self setImageWithURLRequest:imageRequest
//                   placeholderImage:[UIImage imageNamed:@"icon_purple_gray"]
//                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
//     {
//         
//         [UIView animateWithDuration:0.3 animations:^{
//             
//             progressView.alpha=0.0;
//             
//         } completion:^(BOOL finished) {
//             
//             [progressView removeFromSuperview];
//         }];
//         
//         strongSelf.image = image;
//     }
//                            failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
//     {
//         strongSelf.image=nil;
//         [progressView removeFromSuperview];
//     }];
}

- (void)setImageWithURLString:(NSString *)urlString
{
    
    __weak typeof(self)weakSelf = self;
    __strong typeof(weakSelf)strongSelf = weakSelf;
    if (urlString && urlString.length > 0) {
    NSURL *url=[NSURL URLWithString:urlString];
    self.image=nil;
    
    ProgressAnimation *progressView=[[ProgressAnimation alloc] init];
        progressView.frame = self.bounds;
        progressView.center = self.center;
        progressView.autoresizingMask=self.autoresizingMask;
        progressView.alpha=0.0;
        progressView.tag=999;
        progressView.backgroundColor=[UIColor clearColor];
        if (![self viewWithTag:999]) {
            [self addSubview:progressView];
        }
        [progressView initWithTimerValue];
    [self setImageWithURL:url placeholderImage:nil options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        progressView.alpha=1.0;
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        [UIView animateWithDuration:0.3 animations:^{
            progressView.alpha=0.0;
            
        } completion:^(BOOL finished) {
            
            [strongSelf removeProgressView];
            
        }];
        
    }];
    
    }
    else{
        self.image = [UIImage imageNamed:@"no_img"];
        [UIView animateWithDuration:0.3 animations:^{
            //progressView.alpha=0.0;
           
        } completion:^(BOOL finished) {
            
            [strongSelf removeProgressView];
            
        }];
    }
    
}

-(void)removeProgressView{
    
    [[self viewWithTag:999] removeFromSuperview];

}



@end
