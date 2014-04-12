//
//  FGViewController.m
//  SunUp
//
//  Created by Finn Gaida on 11.04.13.
//  Copyright (c) 2013 Finn Gaida. All rights reserved.
//

#import "FGViewController.h"

@implementation FGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // container setup
    bg = [[UIView alloc] initWithFrame:self.view.frame];
    bg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bg];
    
    // info container setup
    bgInfo = [[UIView alloc] initWithFrame:self.view.frame];
    bgInfo.backgroundColor = [UIColor colorWithWhite:.3 alpha:1];
    [self.view insertSubview:bgInfo atIndex:0];
    
    // some text
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 280, 250)];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = bg.center;
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName:@"Helvetica" size:20];
    label.text = @"FGDynamicsTransition is a drop-in example of using iOS 7's UIKit Dynamics for some fluid transitions.";
    [bg addSubview:label];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 280, 250)];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.center = bg.center;
    label3.numberOfLines = 0;
    label3.font = [UIFont boldSystemFontOfSize:22];
    label3.text = @"\n\n\n\n\nWatch the video for a demo!";
    [bg addSubview:label3];
    
    // some other text
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.center = bgInfo.center;
    label2.text = @"Some other text";
    [bgInfo addSubview:label2];
    
    // add the info button
    UIButton *info = [UIButton buttonWithType:UIButtonTypeInfoDark];
    info.frame = CGRectMake(280, self.view.frame.size.height-40, 40, 40);
    [info addTarget:self action:@selector(showInfoScreen) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:info];
    
    // some setup
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    showingInfo = NO;
    swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showInfoScreen)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
}

- (void)showInfoScreen {
    
    // clean up
    [animator removeAllBehaviors];
    
    if (showingInfo) {
        
        // add the behaviour
        UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:bg snapToPoint:CGPointMake(160, self.view.frame.size.height/2)];
        [animator addBehavior:snap];
        
        showingInfo = NO;
        [bg removeGestureRecognizer:swipe];
    } else {
        
        // add the behaviour
        UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:bg snapToPoint:CGPointMake(159, -self.view.frame.size.height/2+64)];
        [animator addBehavior:snap];
        
        showingInfo = YES;
        [bg addGestureRecognizer:swipe];
    }
}

// optional runtime check for availability of UIDynamics
- (BOOL)ios7 {return ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7);}

- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}

@end
