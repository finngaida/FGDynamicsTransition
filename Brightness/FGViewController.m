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
}

- (void)upd {
    volume.text = [NSString stringWithFormat:@"%.f%%", [UIScreen mainScreen].brightness*100];
}

- (void)viewDidAppear:(BOOL)animated {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    volume.text = [NSString stringWithFormat:@"%.f%%", [UIScreen mainScreen].brightness*100];
    
    // Launch tutorial
    //if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kApplicationDidLaunchForTheVeryFirstTime"] == NO) {
    
        // Display FGWalkthrough
        walkthrough = [[FGWalkthrough alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
        [bg insertSubview:walkthrough atIndex:0];
    
    //}
    
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
