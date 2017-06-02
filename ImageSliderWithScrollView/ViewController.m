//
//  ViewController.m
//  ImageSliderWithScrollView
//
//  Created by WebsoftProfession on 9/22/16.
//   WebsoftProfession. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIPanGestureRecognizer *pan;
    CGFloat touchX;
    CGFloat nextViewX;
    CGFloat preViewX;
    
    CGRect centerFrame;
    CGRect leftFrame;
    CGRect rightFrame;
    
    UIView *currentActiveView;
    UIView *nextView;
    UIView *preView;
    
    NSInteger activeIndex;
    BOOL isLeftDirection;
    
    NSInteger activeArrayIndex;
    NSInteger prevArrayIndex;
    NSInteger nextArrayIndex;
    
    NSMutableArray *picArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isLeftDirection=NO;
    activeArrayIndex=1;
    prevArrayIndex=0;
    nextArrayIndex=2;
    picArray=[[NSMutableArray alloc] initWithObjects:@"http://www.hdiphone6wallpaper.com/wp-content/uploads/City/London%20HD%20landscape%202%20iPhone%206%20Wallpaper.jpg",@"http://www.hdiphone6pluswallpaper.com/wp-content/uploads/City/Beautiful%20city%20at%20dusk%20iphone%206%20plus%20wallpaper.jpg",@"http://www.wallpapersforiphone6plus.com/wp-content/uploads/Sunset/Tropical%20sunset%20HD%20wallpaper%20for%20iphone%206%20plus.jpg",@"http://files.wallpapersip.webnode.com.br/system_preview_detail_200001266-35e3036daa-public/hd-wallpaper-iphone-320x480-97.jpg",@"http://pre14.deviantart.net/78f4/th/pre/f/2013/180/4/9/london_phone_wallpaper_1_by_digitaldragonwolf-d6b69ao.jpg", nil];

    
    centerFrame=centerView.frame;
    rightFrame=rightView.frame;
    leftFrame=leftView.frame;
    
    UIImageView *imgActive=[centerView viewWithTag:5];
    UIImageView *imgNext=[rightView viewWithTag:5];
    UIImageView *imgPrev=[leftView viewWithTag:5];
    
    
    [imgActive setImageWithURLString:[picArray objectAtIndex:activeArrayIndex]];
    [imgNext setImageWithURLString:[picArray objectAtIndex:activeArrayIndex+1]];
    [imgPrev setImageWithURLString:[picArray objectAtIndex:activeArrayIndex-1]];
    
//    currentActiveView=centerView;
//    nextView=rightView;
//    preView=leftView;
//    activeIndex=centerView.tag;
    
    [self checkCurrentActiveView];
    
    //pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewDragged:)];
    //[containerView addGestureRecognizer:pan];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)checkCurrentActiveView
{
    
    if (activeArrayIndex<0) {
        
        activeArrayIndex=picArray.count-1;
        nextArrayIndex=0;
        prevArrayIndex=activeArrayIndex-1;
        
    }
    
    
    
    if (activeArrayIndex>picArray.count-1) {
        
        activeArrayIndex=0;
        nextArrayIndex=activeArrayIndex+1;
        prevArrayIndex=picArray.count-1;
    }
    
    for (UIView *view in containerView.subviews) {
        
        if (view.frame.origin.x==0) {
            
            currentActiveView=view;
            activeIndex=view.tag;
            
            
            
            
            switch (activeIndex) {
                case 1:
                {
                    nextView=rightView;
                    preView=leftView;
                    [self setupImageForViews];
                }
                    break;
                case 2:
                {
                    nextView=leftView;
                    preView=centerView;
                    [self setupImageForViews];
                }
                    break;
                case 3:
                {
                    nextView=centerView;
                    preView=rightView;
                    [self setupImageForViews];
                }
                    break;
                    
                default:
                    break;
            }
            
            break;
            return;
        }
    }
}

-(void)setupImageForViews
{
    
    
    NSLog(@"%ld",activeArrayIndex);
    
//    [imgNext setImage:[UIImage imageNamed:[picArray objectAtIndex:activeArrayIndex]]];
//    [imgPrev setImage:[UIImage imageNamed:[picArray objectAtIndex:activeArrayIndex]]];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        
        CGPoint touchPoint=[touch locationInView:containerView];
        touchX=touchPoint.x;
        
        nextViewX=nextView.frame.origin.x;
        preViewX=preView.frame.origin.x;
        
        
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIImageView *imgActive=[currentActiveView viewWithTag:5];
    UIImageView *imgNext=[nextView viewWithTag:5];
    UIImageView *imgPrev=[preView viewWithTag:5];
    
    if (activeArrayIndex==0) {
        
        nextArrayIndex=activeArrayIndex+1;
        prevArrayIndex=picArray.count-1;
    }
    if (activeArrayIndex==picArray.count-1) {
        
        nextArrayIndex=0;
        prevArrayIndex=activeArrayIndex-1;
    }
    
    [imgActive setImageWithURLString:[picArray objectAtIndex:activeArrayIndex]];
    [imgNext setImageWithURLString:[picArray objectAtIndex:nextArrayIndex]];
    [imgPrev setImageWithURLString:[picArray objectAtIndex:prevArrayIndex]];
    
    for (UITouch *touch in touches) {
        
        CGPoint touchPoint=[touch locationInView:containerView];
        if (touchX>touchPoint.x) {
            isLeftDirection=YES;
            [containerView bringSubviewToFront:nextView];
            [containerView sendSubviewToBack:preView];
            [UIView animateWithDuration:0.1 animations:^{
                
                
                nextView.frame=CGRectMake(nextViewX+((touchPoint.x-touchX)*1), rightView.frame.origin.y, rightView.frame.size.width, rightView.frame.size.height);
                currentActiveView.frame=CGRectMake(centerFrame.origin.x-(rightFrame.origin.x-nextView.frame.origin.x), rightView.frame.origin.y, rightView.frame.size.width, rightView.frame.size.height);
                
                
                
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
            isLeftDirection=NO;
            
            [containerView bringSubviewToFront:preView];
            [containerView sendSubviewToBack:nextView];
            preView.frame=CGRectMake(preViewX+((touchPoint.x-touchX)*1), rightView.frame.origin.y, rightView.frame.size.width, rightView.frame.size.height);
            currentActiveView.frame=CGRectMake(centerFrame.origin.x-(leftFrame.origin.x-preView.frame.origin.x), rightView.frame.origin.y, rightView.frame.size.width, rightView.frame.size.height);
        }
        
        
        
        
//        paddleNode.position=SCNVector3Make(paddleX+((touchPoint.x-touchX)*0.1), paddleNode.position.y, paddleNode.position.z);
        //        verticalCameraNode.position=SCNVector3Make(paddleNode.position.x, verticalCameraNode.position.y, verticalCameraNode.position.z);
        //        horizontalCameraNode.position=SCNVector3Make(paddleNode.position.x, horizontalCameraNode.position.y, horizontalCameraNode.position.z);
//        if (paddleNode.position.x>4.5) {
//            
//            paddleNode.position=SCNVector3Make(4.5, paddleNode.position.y, paddleNode.position.z);
//        }else if (paddleNode.position.x<-4.5)
//        {
//            paddleNode.position=SCNVector3Make(-4.5, paddleNode.position.y, paddleNode.position.z);
//        }
        
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        
        //CGPoint touchPoint=[touch locationInView:containerView];
        if (isLeftDirection) {
            
            if (nextView.frame.origin.x>containerView.frame.size.width/2) {
                
                
                
                [UIView animateWithDuration:0.5 animations:^{
                    nextView.frame=rightFrame;
                    currentActiveView.frame=centerFrame;
                    preView.frame=leftFrame;
                } completion:^(BOOL finished) {
                    
                    [self checkCurrentActiveView];
                    
                }];
            }
            else
            {
                activeArrayIndex++;
                nextArrayIndex=activeArrayIndex+1;
                prevArrayIndex=activeArrayIndex-1;
                [UIView animateWithDuration:0.5 animations:^{
                    nextView.frame=centerFrame;
                    currentActiveView.frame=leftFrame;
                    preView.frame=rightFrame;
                    
                } completion:^(BOOL finished) {
                    
                    [self checkCurrentActiveView];
                    
                }];
            }
            
        }
        else
        {
           // NSLog(@"right direction.");
            
            if (preView.frame.origin.x+containerView.frame.size.width>containerView.frame.size.width/2) {
                activeArrayIndex--;
                nextArrayIndex=activeArrayIndex+1;
                prevArrayIndex=activeArrayIndex-1;
                [UIView animateWithDuration:0.5 animations:^{
                    nextView.frame=leftFrame;
                    currentActiveView.frame=rightFrame;
                    preView.frame=centerFrame;
                } completion:^(BOOL finished) {
                    
                    [self checkCurrentActiveView];
                    
                }];
            }
            else
            {
                [UIView animateWithDuration:0.5 animations:^{
                    nextView.frame=rightFrame;
                    currentActiveView.frame=centerFrame;
                    preView.frame=leftFrame;
                    
                } completion:^(BOOL finished) {
                    
                    [self checkCurrentActiveView];
                    
                }];
            }
        }
        
        
        
    }
    
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

-(void)viewDragged:(UIPanGestureRecognizer *)pn
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
