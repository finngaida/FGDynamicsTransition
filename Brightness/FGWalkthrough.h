//
//  FGWalkthrough.h
//  SunUp
//
//  Created by Finn Gaida on 13.05.13.
//  Copyright (c) 2013 Finn Gaida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

@interface FGWalkthrough : UIView <UIScrollViewDelegate> {
    UIScrollView *scrollView;
    UILabel *explanationlabel0;
    UILabel *explanationlabel1;
    UILabel *explanationlabel2;
    UILabel *explanationlabel3;

    UIPageControl *pagecontrol;
}

- (void)goToPage0;
- (void)goToPage1;
- (void)goToPage2;
- (void)goToPage3;


@end
