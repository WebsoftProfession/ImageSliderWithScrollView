//
//  UIImageView+AADotsquareProgressView.h
//  AppleProgressHUD
//
//  Created by WebsoftProfession on 7/20/16.
//   WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressAnimation.h"
#import "UIImageView+WebCache.h"


@interface UIImageView (AADotsquareProgressView)

- (void)setImageWithURLString:(NSString *)urlString;

-(void)setImageWithURLRequest:(NSString *)urlString;

@end
