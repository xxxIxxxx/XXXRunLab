//
//  XXXRunLab.h
//  Z
//
//  Created by Z on 2020/3/12.
//  Copyright © 2020 Z. All rights reserved.
//  https://github.com/xxxIxxxx/XXXRunLab

#import <UIKit/UIKit.h>


/// 跑马灯滚动文字展示  文字会自动垂直居中展示
@interface XXXRunLab : UIView



/// 展示内容富文本     **赋值后下面三个属性失效**
@property (nonatomic, copy) NSAttributedString * _Nullable attributedText;

/// 展示文本    **当attributedText赋值时失效**
@property (nonatomic, copy) NSString * _Nullable text;

/// 文本字体    **当attributedText赋值时失效**
@property (nonatomic, strong) UIFont * _Nullable textFont;

/// 文本颜色    **当attributedText赋值时失效**
@property (nonatomic, strong) UIColor * _Nullable textColor;

/// 文本的实际高度       ** 设置过 attributedText 或 textFont 后可获取  **
@property (nonatomic, assign, readonly) CGFloat runLabHeight;


/// 背景色 默认无色 或者直接使用 backgroundColor
@property (nonatomic, strong) UIColor * _Nullable runBackgroundColor;

/// 每秒的移动距离   默认30
@property (nonatomic, assign) CGFloat speed;

/// 俩个相邻的间距 默认10
@property (nonatomic, assign) CGFloat itemSpace;

/// 开启动画
- (void)runFun;
/// 停止动画
- (void)stop;


@end


#define mark - timer

@interface XXXTimer : NSObject

+ (id _Nonnull )runTimer:(NSTimeInterval)interval everyTime:(void(^_Nullable)(void))everyTimeBlock;

@end

#pragma mark - Extension

@interface UIView (copy_YYAdd)

@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.

@end


@interface NSString (copy_YYAdd)


- (CGFloat)widthForFont:(UIFont *_Nonnull)font;

- (CGFloat)heightForFont:(UIFont *_Nonnull)font width:(CGFloat)width;


@end
