//
//  ViewController.m
//  CountdownButton
//
//  Created by Wayn on 13-7-6.
//  Copyright (c) 2013年 Wayn. All rights reserved.
//

#import "ViewController.h"
#import "CountdownButton.h"

@interface ViewController ()

- (IBAction)countDownButtonClicked:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)countDownButtonClicked:(id)sender
{
    [(CountdownButton *)sender startCountDown];
}

@end
