//
//  CountdownButton.m
//  CountdownButton
//
//  Created by Wayn on 13-7-6.
//  Copyright (c) 2013年 Wayn. All rights reserved.
//

#import "CountdownButton.h"

@interface CountdownButton ()

@property (nonatomic, assign) BOOL inCountDown;
@property (nonatomic, assign) int countSeconds;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UILabel *timerLabel;

@end

@implementation CountdownButton

@synthesize useAnimation;
@synthesize seconds;
@synthesize offset;
@synthesize inCountDown;
@synthesize countSeconds;
@synthesize timer = _timer;
@synthesize timerLabel = _timerLabel;

#pragma mark - Default Values

#define DEFAULT_USE_ANIMATION	YES
#define DEFAULT_AUTO_START      YES
#define DEFAULT_SECONDS			15
#define DEFAULT_OFFSET          CGPointMake(5, 0)

#pragma mark - Init Methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        useAnimation = DEFAULT_USE_ANIMATION;
        seconds = DEFAULT_SECONDS;
        offset = DEFAULT_OFFSET;
        
        self.titleLabel.numberOfLines = 0;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        useAnimation = DEFAULT_USE_ANIMATION;
        seconds = DEFAULT_SECONDS;
        offset = DEFAULT_OFFSET;
        
        self.titleLabel.numberOfLines = 0;
    }
    return self;
}

#pragma mark - Actions

- (void)startCountDown
{
    self.enabled = NO;
    
    countSeconds = seconds;
    CGFloat timerWidth = [[NSString stringWithFormat:@"%d", seconds] sizeWithFont:self.titleLabel.font].width;
    
    if (_timerLabel == nil)
        _timerLabel = [[UILabel alloc] init];
    
    CGRect frame = CGRectOffset(self.titleLabel.frame, offset.x + self.titleLabel.frame.size.width, offset.y);
    
    frame.size.width = timerWidth;
    _timerLabel.frame = frame;
    
    _timerLabel.backgroundColor = [UIColor clearColor];
    _timerLabel.font = self.titleLabel.font;
    _timerLabel.textColor = self.titleLabel.textColor;
    
    self.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self addSubview:_timerLabel];
    
    if (useAnimation) {
        
        [UIView animateWithDuration:.3f
                         animations:^{
                             CGRect frame = self.frame;
                             frame.size.width = frame.size.width + offset.x + timerWidth;
                             frame.size.height = frame.size.height + offset.y;
                             
                             self.frame = frame;
                         }];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, (-offset.x - timerWidth)/2, 0, 0);
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
}

#pragma mark - Functions

- (void)countDownStoped
{
    self.enabled = YES;
    
    self.titleEdgeInsets = UIEdgeInsetsZero;
    
    if (_timerLabel.superview) {
        [_timerLabel removeFromSuperview];
    }
    if (useAnimation) {
        
        [UIView animateWithDuration:.3f
                         animations:^{
                             CGRect frame = self.frame;
                             frame.size.width = frame.size.width - offset.x - _timerLabel.frame.size.width;
                             frame.size.height = frame.size.height - offset.y;
                             
                             self.frame = frame;
                         }
         ];
    }
}

- (void)timerRun
{
    countSeconds = countSeconds - 1;
    
    _timerLabel.text = [NSString stringWithFormat:@"%d", countSeconds];
    
    if (countSeconds <= 0) {
        [self countDownStoped];
        [_timer invalidate];
        _timer = nil;
        
        countSeconds = seconds;
    }
}

@end
