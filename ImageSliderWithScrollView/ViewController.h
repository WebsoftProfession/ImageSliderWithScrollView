//
//  ViewController.h
//  ImageSliderWithScrollView
//
//  Created by WebsoftProfession on 9/22/16.
//   WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AADotsquareProgressView.h"

@interface ViewController : UIViewController
{
    
    __weak IBOutlet UIView *containerView;
    __weak IBOutlet UIView *leftView;
    __weak IBOutlet UIView *centerView;
    __weak IBOutlet UIView *rightView;
}

@end

