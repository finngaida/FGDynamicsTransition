//
//  FGWalkthrough.m
//  SunUp
//
//  Created by Finn Gaida on 13.05.13.
//  Copyright (c) 2013 Finn Gaida. All rights reserved.
//

#import "FGWalkthrough.h"

@implementation FGWalkthrough

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        scrollView = [[UIScrollView alloc] initWithFrame:frame];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.scrollEnabled = YES;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        scrollView.contentSize = CGSizeMake(1280, frame.size.height);
        [self addSubview:scrollView];
        
        
        pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(140, 140, 40, 10)];
        pagecontrol.pageIndicatorTintColor = [UIColor grayColor];
        pagecontrol.currentPageIndicatorTintColor = [UIColor lightGrayColor];
        pagecontrol.numberOfPages = 4;
        pagecontrol.currentPage = 0;
        [self insertSubview:pagecontrol atIndex:0];
        
        explanationlabel0 = [[UILabel alloc] initWithFrame:CGRectMake(320*0+ 15, 5, 300, frame.size.height)];
        explanationlabel0.backgroundColor = [UIColor clearColor];
        explanationlabel0.textColor = [UIColor blackColor];
        explanationlabel0.font = [UIFont fontWithName:@"Open Sans" size:25];
        explanationlabel0.text = NSLocalizedString(@"Hi! Danke, dass du Helligkeit runtergeladen hast. So geht's:", nil);
        explanationlabel0.numberOfLines = 0;
        [scrollView addSubview:explanationlabel0];
        
        NSTimer *goTo1Timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(goToPage1) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:goTo1Timer forMode:NSRunLoopCommonModes];
        
        explanationlabel1 = [[UILabel alloc] initWithFrame:CGRectMake(320*1+ 15, 5, 300, frame.size.height)];
        explanationlabel1.backgroundColor = [UIColor clearColor];
        explanationlabel1.textColor = [UIColor blackColor];
        explanationlabel1.font = [UIFont fontWithName:@"Open Sans" size:25];
        explanationlabel1.text = NSLocalizedString(@"Ziehen sie den Kreis hoch und runter um die Helligkeit einzustellen.", nil);
        explanationlabel1.numberOfLines = 0;
        [scrollView addSubview:explanationlabel1];
        
        explanationlabel2 = [[UILabel alloc] initWithFrame:CGRectMake(320*2+ 15, 5, 300, frame.size.height)];
        explanationlabel2.backgroundColor = [UIColor clearColor];
        explanationlabel2.textColor = [UIColor blackColor];
        explanationlabel2.font = [UIFont fontWithName:@"Open Sans" size:25];
        explanationlabel2.text = NSLocalizedString(@"Tippen sie auf den Kreis um den Hoch, /-Tiefpunkt zu erreichen.", nil);
        explanationlabel2.numberOfLines = 0;
        [scrollView addSubview:explanationlabel2];
        
        explanationlabel3 = [[UILabel alloc] initWithFrame:CGRectMake(320*3+ 15, 5, 300, frame.size.height)];
        explanationlabel3.backgroundColor = [UIColor clearColor];
        explanationlabel3.textColor = [UIColor blackColor];
        explanationlabel3.font = [UIFont fontWithName:@"Open Sans" size:25];
        explanationlabel3.text = NSLocalizedString(@"Das wars! Viel Spaß mit Helligkeit und folgenden Updates!", nil);
        explanationlabel3.numberOfLines = 0;
        [scrollView addSubview:explanationlabel3];
        
    }
    return self;
}

- (void)goToPage0 {
    //[scrollView scrollRectToVisible:CGRectMake(320*0, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
}

- (void)goToPage1 {
    //[scrollView scrollRectToVisible:CGRectMake(320*1, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
}

- (void)goToPage2 {
    //[scrollView scrollRectToVisible:CGRectMake(320*2, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
}

- (void)goToPage3 {
    //[scrollView scrollRectToVisible:CGRectMake(320*3, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    //NSTimer *hide = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(hide) userInfo:nil repeats:NO];
    //[[NSRunLoop currentRunLoop] addTimer:hide forMode:NSRunLoopCommonModes];
}


- (void)hide {
    [UIView animateWithDuration:.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)sv {
    pagecontrol.currentPage = sv.contentOffset.x/320;
    
    if (sv.contentOffset.x >= 320*3-1) {
        NSTimer *hide = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(hide) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:hide forMode:NSRunLoopCommonModes];
    }
}

@end
