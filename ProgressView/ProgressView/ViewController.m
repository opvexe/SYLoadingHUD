//
//  ViewController.m
//  ProgressView
//
//  Created by FaceBooks on 2019/1/7.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ViewController.h"
#import "SYLoadingHUD.h"
@interface ViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property(nonatomic,strong)SYLoadingHUD *progressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *bt  = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(100, 100, 100, 40);
    bt.backgroundColor = [UIColor redColor];
    [self.view addSubview:bt];
    [bt addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
}

-(void)Click{
    self.progressView = [SYLoadingHUD showLoading:@"正在下载，请稍等..."];
    self.progressView.progressWidth = 3.0f;
    [self addTimer];
}

- (void)addTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction{
    self.progressView.progress += 0.02;
    if (self.progressView.progress > 0.8) {
        NSLog(@"22");
        [_timer invalidate];
        _timer = nil;
    }
}

@end
