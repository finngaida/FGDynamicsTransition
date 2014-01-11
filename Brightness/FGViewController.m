//
//  FGViewController.m
//  SunUp
//
//  Created by Finn Gaida on 11.04.13.
//  Copyright (c) 2013 Finn Gaida. All rights reserved.
//

#import "FGViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation FGViewController
@synthesize mid, volume, status;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    bg = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds]; bg.backgroundColor = [UIColor clearColor];
    bg.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:1 alpha:1];
    [self.view addSubview:bg];
        
    self.mid = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
    
    // The white Button in the Middle
    display = [[UIButton alloc] initWithFrame:CGRectMake(self.mid.x-80, self.mid.y-80, 160, 160)];
    display.layer.cornerRadius = 80.0;
    display.layer.masksToBounds = YES;
    display.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:.2 alpha:1];
    [bg insertSubview:display atIndex:4];
    [display addTarget:self action:@selector(setHighLow) forControlEvents:UIControlEventTouchUpInside];
    
    UIPanGestureRecognizer *panner = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [display addGestureRecognizer:panner];
    
    // Label on top of button
    volume = [[UILabel alloc] initWithFrame:CGRectMake(self.mid.x-75, self.mid.y-75, 150, 150)];
    volume.textAlignment = NSTextAlignmentCenter;
    volume.backgroundColor = [UIColor clearColor];
    volume.textColor = [UIColor whiteColor];
    volume.font = [UIFont fontWithName:@"Open Sans" size:38];
    volume.text = [NSString stringWithFormat:@"%.f%%", [UIScreen mainScreen].brightness*100];
    [bg insertSubview:volume atIndex:5];
    
    // update
    NSTimer *rpt = [NSTimer timerWithTimeInterval:.1 target:self selector:@selector(upd) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:rpt forMode:NSRunLoopCommonModes];
    
    // info button
    UIButton *info = [UIButton buttonWithType:UIButtonTypeInfoDark];
    info.frame = CGRectMake(280, self.view.frame.size.height-40, 40, 40);
    [info addTarget:self action:@selector(showInfoScreen:) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:info];
    
    // todo ios 6 check
    if ([self ios7])
        animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    showingInfo = NO;
}

- (void)showInfoScreen:(BOOL)animated {
    
    UIView *bgInfo = [[UIView alloc] initWithFrame:self.view.frame];
    bgInfo.backgroundColor = [UIColor colorWithWhite:.3 alpha:1];
    [self.view insertSubview:bgInfo atIndex:0];
    
    UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:bgInfo.frame];
    scroller.contentSize = CGSizeMake(320, 500);
    [bgInfo addSubview:scroller];
    
    UILabel *sample = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 280, 50)];
    sample.backgroundColor = [UIColor clearColor];
    sample.textColor = [UIColor whiteColor];
    sample.textAlignment = NSTextAlignmentCenter;
    sample.font = [UIFont fontWithName:@"Helvetica" size:30];
    sample.text = NSLocalizedString(@"Made by Finn", nil);
    [scroller addSubview:sample];
    
    UILabel *sample2 = [[UILabel alloc] initWithFrame:CGRectMake(40, 150, 240, 350)];
    sample2.backgroundColor = [UIColor clearColor];
    sample2.textColor = [UIColor whiteColor];
    sample2.textAlignment = NSTextAlignmentLeft;
    sample2.font = [UIFont fontWithName:@"Helvetica" size:15];
    sample2.text = NSLocalizedString(@"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.", nil);
    sample2.numberOfLines = 0;
    [scroller addSubview:sample2];
    
    
    if ([self ios7] && !showingInfo) {
/*        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[bg]];
        gravity.gravityDirection = CGVectorMake(0, -1);
        [animator addBehavior:gravity];
        
        UIDynamicItemBehavior *item = [[UIDynamicItemBehavior alloc] initWithItems:@[bg]];
        item.elasticity = .5;
        [animator addBehavior:item];
        
        UIAttachmentBehavior *attach = [[UIAttachmentBehavior alloc] initWithItem:bg offsetFromCenter:UIOffsetMake(0, bg.frame.size.height/2) attachedToAnchor:CGPointMake(155, self.view.frame.size.height-200)];
        [animator addBehavior:attach];
        
        UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[bg]];
        collision.translatesReferenceBoundsIntoBoundary = NO;
        [collision addBoundaryWithIdentifier:@"Top" fromPoint:CGPointMake(-50, -self.view.frame.size.height+80) toPoint:CGPointMake(370, -self.view.frame.size.height+80)];
        [animator addBehavior:collision];*/
        
        [animator removeAllBehaviors];
        
        UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:bg snapToPoint:CGPointMake(159, -self.view.frame.size.height/2+64)];
        [animator addBehavior:snap];
        
        showingInfo = YES;
    } else if ([self ios7] && showingInfo) {
        
        [animator removeAllBehaviors];
        
        UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:bg snapToPoint:CGPointMake(160, self.view.frame.size.height/2)];
        [animator addBehavior:snap];
        
        showingInfo = NO;
    }
}

- (BOOL)ios7 {
    return ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7);
}

- (void)upd {
    volume.text = [NSString stringWithFormat:@"%.f%%", [UIScreen mainScreen].brightness*100];
}

- (void)viewDidAppear:(BOOL)animated {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    volume.text = [NSString stringWithFormat:@"%.f%%", [UIScreen mainScreen].brightness*100];
    
    // Launch tutorial
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kApplicationDidLaunchForTheVeryFirstTime"] == NO) {
    
        // Display FGWalkthrough
        walkthrough = [[FGWalkthrough alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
        [bg insertSubview:walkthrough atIndex:0];
    
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kApplicationDidLaunchForTheVeryFirstTime"];
}

/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event touchesForView:bg] anyObject];
    CGPoint point = [touch locationInView:bg];
    
    CGFloat angle;
    FGStuffCalculator *calc = [FGStuffCalculator new];
    
    if (point.x < self.mid.x && point.y < self.mid.y) {angle = [calc angleForTriangleInScreenQuarter:FGScreenQuarterTopLeft andTouch:touch inView:self.view];}
    else if (point.x > self.mid.x && point.y < self.mid.y) {angle = [calc angleForTriangleInScreenQuarter:FGScreenQuarterTopRight andTouch:touch inView:self.view];}
    else if (point.x < self.mid.x && point.y > self.mid.y-1) {angle = [calc angleForTriangleInScreenQuarter:FGScreenQuarterBottomLeft andTouch:touch inView:self.view];}
    else //if (point.x > self.mid.x && point.y > self.mid.y)// {angle = [calc angleForTriangleInScreenQuarter:FGScreenQuarterBottomRight andTouch:touch inView:self.view];}
    
    [UIScreen mainScreen].brightness = angle/360;
    
    // Anzeigen auf dem Alarm-Label
    volume.text = [NSString stringWithFormat:@"%.f%%", [UIScreen mainScreen].brightness*100];
    
    // Aand for the walkthrough
    [walkthrough goToPage2];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}
*/

- (void)handlePan:(UIPanGestureRecognizer *)pan {
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {            
            [UIView animateWithDuration:.2 animations:^{
                display.center = CGPointMake(display.center.x,[pan locationInView:self.view].y);
                volume.center = CGPointMake(volume.center.x,[pan locationInView:self.view].y);
            }];
            
            startVolume = [UIScreen mainScreen].brightness;
            
            // Aand for the walkthrough
            [walkthrough goToPage2];
        } break;
        case UIGestureRecognizerStateChanged: {
            display.center = CGPointMake(display.center.x,[pan locationInView:self.view].y);
            volume.center = CGPointMake(volume.center.x,[pan locationInView:self.view].y);
            
            //[UIScreen mainScreen].brightness = (startVolume + 0.5 - [pan locationInView:self.view].y / [UIScreen mainScreen].bounds.size.height);
            [UIScreen mainScreen].brightness = 1- ([pan locationInView:self.view].y / [UIScreen mainScreen].bounds.size.height);
            
            volume.text = [NSString stringWithFormat:@"%.f%%", [UIScreen mainScreen].brightness*100];
            
            //bg.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:[UIScreen mainScreen].brightness alpha:1];
            //display.backgroundColor = [UIColor colorWithHue:0 saturation:1-[UIScreen mainScreen].brightness brightness:0 alpha:1];
            //volume.textColor = bg.backgroundColor;
            
            if ([UIScreen mainScreen].brightness > 0.5) {
                [self setBrightnessStatus:FGBrightnessStatusOn];
            } else if ([UIScreen mainScreen].brightness < 0.5) {
                [self setBrightnessStatus:FGBrightnessStatusOff];
            }
            
        } break;
        case UIGestureRecognizerStateEnded: {
            [UIView animateWithDuration:.8 animations:^{
                display.center = self.mid;
                volume.center = self.mid;
            }];

        }
        case UIGestureRecognizerStateCancelled: break;
        case UIGestureRecognizerStateFailed:    break;
        case UIGestureRecognizerStatePossible:  break;
    }
    
}

- (void)setHighLow {
    if (self.status == FGBrightnessStatusOn) {
        [self setBrightnessStatus:FGBrightnessStatusOff];
        
        volume.text = @"0%";
        
        [UIScreen mainScreen].brightness = 0;
        
    } else {
        [self setBrightnessStatus:FGBrightnessStatusOn];
        
        volume.text = @"100%";
        
        [UIScreen mainScreen].brightness = 1;
    }
    
    // Aand for the walkthrough
    [walkthrough goToPage3];
}

- (void)setBrightnessStatus:(FGBrightnessStatus)state {
    self.status = state;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FGBrightnessStatusChanged" object:[NSString stringWithFormat:@"%u", state]];
}

- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}

@end
