//
//  ProgressAnimation.h
//  AppleProgressHUD
//
//  Created by WebsoftProfession on 7/11/16.
//   WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressAnimation : UIView
{
    float animationValue;
    float animationValue2;
    NSTimer *timer;
}

-(void)updateAnimationValue;
-(void)initWithTimerValue;

@end
