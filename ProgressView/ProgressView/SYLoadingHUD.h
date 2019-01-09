//
//  XFProgressView.h
//  CEBBankHospital
//
//  Created by FaceBook on 2019/1/7.
//  Copyright © 2019年 XuefengHan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYLoadingHUD : UIView
/*
 下载进度
 */
@property (nonatomic, assign) CGFloat progress;
/*
 进度条宽度 默认 10
 */
@property (nonatomic, assign) CGFloat progressWidth;
/*
 进度条背景颜色
 */
@property(nonatomic,strong) UIColor *progressViewBgColor;
/*
 进度条颜色
 */
@property(nonatomic,strong) UIColor *progressBarColor;

#pragma mark Privite
+(SYLoadingHUD *)showLoading:(NSString *)text;
+(SYLoadingHUD *)showLoading:(NSString *)text inView:(UIView *)view;
- (void)dismissWithAnimation:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
