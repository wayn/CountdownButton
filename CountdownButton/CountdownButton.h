//
//  CountdownButton.h
//  CountdownButton
//
//  Created by Wayn on 13-7-6.
//  Copyright (c) 2013年 Wayn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountdownButton : UIButton
{
    BOOL    useAnimation;
    int     seconds;
    CGPoint offset;
}

// Use animation during button state transitions.
@property (nonatomic, assign) BOOL useAnimation;

// Seconds for count down.
@property (nonatomic, assign) int seconds;

// Offset from count down lable to button title label.
@property (nonatomic, assign) CGPoint offset;

// Manually start fucntion.
- (void)startCountDown;

@end
