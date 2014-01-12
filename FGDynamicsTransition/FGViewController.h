//
//  FGViewController.h
//  SunUp
//
//  Created by Finn Gaida on 11.04.13.
//  Copyright (c) 2014 Finn Gaida. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FGViewController : UIViewController {
    
    // containers to be animated
    UIView *bg;
    UIView *bgInfo;
    
    UIDynamicAnimator *animator;
    BOOL showingInfo;
    UISwipeGestureRecognizer *swipe;
}

@end
