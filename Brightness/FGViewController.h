//
//  FGViewController.h
//  SunUp
//
//  Created by Finn Gaida on 11.04.13.
//  Copyright (c) 2013 Finn Gaida. All rights reserved.
//

typedef enum {
    FGBrightnessStatusOn,
    FGBrightnessStatusOff
} FGBrightnessStatus;

#import <UIKit/UIKit.h>
#import "FGWalkthrough.h"


@interface FGViewController : UIViewController <UIScrollViewDelegate> {
    UIButton *display;
    UIView *bg;
    
    CGFloat startVolume;
    
    FGWalkthrough *walkthrough;
    
    UIDynamicAnimator *animator;
    BOOL showingInfo;
}

@property CGPoint mid;
@property (nonatomic) UILabel *volume;
@property FGBrightnessStatus status;

@end
