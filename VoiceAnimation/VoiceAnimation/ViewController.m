//
//  ViewController.m
//  VoiceAnimation
//
//  Created by Zhang Hailing on 2018/6/6.
//  Copyright © 2018年 HeeronChang. All rights reserved.
//

#import "ViewController.h"
#import "HCVoiceInputView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    HCVoiceInputView *microphoneView = [[HCVoiceInputView alloc] initWithFrame:CGRectMake(20, 200, 200, 200) lineWidth:3 lineColor:[UIColor orangeColor] filleColor:[UIColor orangeColor]];
    [self.view addSubview:microphoneView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
