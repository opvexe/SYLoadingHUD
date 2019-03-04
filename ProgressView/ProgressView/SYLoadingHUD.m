//
//  XFProgressView.m
//  CEBBankHospital
//
//  Created by FaceBook on 2019/1/7.
//  Copyright © 2019年 XuefengHan. All rights reserved.
//

#import "SYLoadingHUD.h"
#define XFColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define KMargin 15
@interface SYLoadingHUD()
/** 百分比文字 */
@property (nonatomic, strong) UILabel *percentTextLabel;
/** 提示文字 */
@property (nonatomic, strong) UILabel *textLabel;
/** 长条样式 */
@property (nonatomic, strong) UIView *rectangleView;
@end

@implementation SYLoadingHUD


-(UILabel *)percentTextLabel{
    if (!_percentTextLabel) {
        _percentTextLabel = [[UILabel alloc]init];
        _percentTextLabel.text = @"0%";
        _percentTextLabel.textColor = _progressBarColor?_progressBarColor:[UIColor whiteColor];
        _percentTextLabel.font = [UIFont systemFontOfSize:13];
        _percentTextLabel.textAlignment = NSTextAlignmentCenter;
        _percentTextLabel.frame = CGRectMake(0, self.bounds.size.height * 0.25 + KMargin-10, self.bounds.size.width, 20);
    }
    return _percentTextLabel;
}


-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.text = @"正在下载...";
        _textLabel.textColor = _progressBarColor?_progressBarColor:[UIColor whiteColor];
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.frame = CGRectMake(0.0f,self.bounds.size.height-20.0f-KMargin, self.bounds.size.width, 20.0f);
    }
    return _textLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.percentTextLabel];
        [self addSubview:self.textLabel];
        
        self.alpha = 0.0f;
        self.layer.cornerRadius = 5.0f;
        self.clipsToBounds = YES;
        self.progressBarColor = [UIColor whiteColor];
        self.progressViewBgColor = XFColor(45, 45, 45);
        self.backgroundColor =_progressViewBgColor;
        self.progressWidth = 5;
    }
    return self;
}

+(SYLoadingHUD *)showLoading:(NSString *)text{
    SYLoadingHUD *show = [[SYLoadingHUD alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-150.0f)/2, ([UIScreen mainScreen].bounds.size.height-120.0f)/2, 150.0f, 120.0f)];
    [[UIApplication sharedApplication].keyWindow addSubview:show];
    [show showWithAnimation:YES];
    return show;
}

+(SYLoadingHUD *)showLoading:(NSString *)text inView:(UIView *)view{
    SYLoadingHUD *show = [[SYLoadingHUD alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-150.0f)/2, ([UIScreen mainScreen].bounds.size.height-120.0f)/2, 150.0f, 120.0f)];
    [view addSubview:show];
    [show showWithAnimation:YES];
    return show;
}

- (void)showWithAnimation:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.5f
                         animations:^{
                             self.alpha = 1.0f;
                         } completion:^(BOOL finished) {
                         }];
    }else{
        self.alpha = 1.0f;
    }
}

- (void)dismissWithAnimation:(BOOL)animated {
    self.progress = 1.0f;
    if (animated) {
        [UIView animateWithDuration:0.0f
                         animations:^{
                             self.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
    } else {
        [self removeFromSuperview];
    }
}

-(void)setProgressWidth:(CGFloat)progressWidth{
    _progressWidth = progressWidth;
    [self setNeedsDisplay];
}

-(void)setProgressViewBgColor:(UIColor *)progressViewBgColor{
    _progressViewBgColor = progressViewBgColor;
}

-(void)setProgressBarColor:(UIColor *)progressBarColor{
    _progressBarColor = progressBarColor;
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.percentTextLabel.text = [NSString stringWithFormat:@"%d%%", (int)floor(progress * 100)];
        if (self.progress >= 1.0) {
            [self dismissWithAnimation:NO];
        } else {
            [self setNeedsDisplay];
        }
    });
}


- (void)drawRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.25 + KMargin;
    
    [_progressBarColor set];
    
    //设置圆环的宽度
    CGContextSetLineWidth(ctx, _progressWidth);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.05; // 初始值0.05
    //半径
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.3 - KMargin;
    CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 0);
    CGContextStrokePath(ctx);
}

@end
