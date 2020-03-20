//
//  XXXRunLab.m
//  Z
//
//  Created by Z on 2020/3/12.
//  Copyright © 2020 Z. All rights reserved.
//  https://github.com/xxxIxxxx/XXXRunLab

#import "XXXRunLab.h"

@interface XXXRunLab ()

///单个文本的宽度
@property (nonatomic, assign) CGFloat itemW;
///文本的高度
@property (nonatomic, assign) CGFloat itemH;
///当前屏幕的最大边长
@property (nonatomic, assign) CGFloat maxWidth;

///滚动中的lab Arr
@property (nonatomic, strong) NSMutableArray<UILabel *> *itemRunArr;
///静止的lab Arr
@property (nonatomic, strong) NSMutableArray<UILabel *> *itemStopArr;
///计时器
@property (nonatomic, strong) dispatch_source_t timer;

///当前滚动状态
@property (nonatomic, assign) BOOL isRun;

@end



@implementation XXXRunLab

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.speed = 30.0;
        self.itemSpace = 10.0;
        self.layer.masksToBounds = YES;
        self.textFont = [UIFont systemFontOfSize:18];
        self.textColor = UIColor.blackColor;
        self.itemRunArr = @[].mutableCopy;
        self.itemStopArr = @[].mutableCopy;
        
        self.maxWidth = (UIScreen.mainScreen.bounds.size.width > UIScreen.mainScreen.bounds.size.height)?UIScreen.mainScreen.bounds.size.width:UIScreen.mainScreen.bounds.size.height;
    }
    return self;
}


- (CGFloat)runLabHeight {
    return self.itemH;
}

- (void)setRunBackgroundColor:(UIColor *)runBackgroundColor {
    _runBackgroundColor = runBackgroundColor;
    self.backgroundColor = runBackgroundColor;
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    self.itemH = textFont.lineHeight;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedText = [attributedText copy];
    UILabel *lab = UILabel.new;
    lab.attributedText = attributedText;
    [lab sizeToFit];
    self.itemW = lab.size.width;
    self.itemH = lab.size.height;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.attributedText) {
        self.itemW = [self.text widthForFont:self.textFont];
    }
    NSInteger itemCount = self.maxWidth/self.itemW + 5;
    
    if (self.itemRunArr.count > 0 || self.itemStopArr.count > 0) {
        for (UILabel *lab in self.itemRunArr) {
            [self updateItem:lab];
        }
        for (UILabel *lab in self.itemStopArr) {
            [self updateItem:lab];
        }
        return;
    }
    
    for (NSInteger i = 0; i < itemCount; i++) {
        UILabel *lab = [UILabel new];
        [self addSubview:lab];
        [self updateItem:lab];
        if (lab.left > self.maxWidth || lab.right < 0) {
            [self.itemStopArr addObject:lab];
            lab.left = self.maxWidth + self.itemSpace;
            lab.hidden = YES;
        }else {
            lab.left = self.itemRunArr.lastObject?self.itemRunArr.lastObject.right:-self.itemSpace + self.itemSpace;
            [self.itemRunArr addObject:lab];
        }
    }
}


- (void)updateItem:(UILabel *)lab {
    if (self.attributedText) {
        lab.attributedText = self.attributedText;
    }else{
        lab.text = self.text;
        lab.font = self.textFont;
        lab.textColor = self.textColor;
    }
    lab.width = self.itemW;
    lab.height = self.itemH;
    lab.top = (self.height - self.itemH)/2.0;
}


- (void)runFun {
    if (self.isRun) return;
    self.isRun = YES;
    CGFloat runX = self.speed / 60.0;
    __weak typeof(self) weakSelf = self;
    self.timer = [XXXTimer runTimer:1/60.0 everyTime:^{
        
        weakSelf.itemRunArr.firstObject.left = weakSelf.itemRunArr.firstObject.left - runX;
        UILabel *berforeLab = weakSelf.itemRunArr.firstObject;
        for (NSInteger i = 1; i < weakSelf.itemRunArr.count; i++) {
            weakSelf.itemRunArr[i].left = berforeLab.right + weakSelf.itemSpace;
            berforeLab = weakSelf.itemRunArr[i];
        }
        
        if (weakSelf.itemRunArr.lastObject.right < weakSelf.maxWidth && weakSelf.itemStopArr.count > 0) {
            
            UILabel *lab = weakSelf.itemStopArr.firstObject;
            [weakSelf.itemStopArr removeObjectAtIndex:0];
            [weakSelf.itemRunArr addObject:lab];
            lab.hidden = NO;
        }
        
        if (weakSelf.itemRunArr.firstObject.right < 0 && weakSelf.itemRunArr.count > 0) {
            
            UILabel *lab = weakSelf.itemRunArr.firstObject;
            [weakSelf.itemRunArr removeObjectAtIndex:0];
            [weakSelf.itemStopArr addObject:lab];
            lab.left = weakSelf.maxWidth + weakSelf.itemSpace;
            lab.hidden = YES;
        }
    }];
}


- (void)stop {
    self.isRun = NO;
    if (self.timer) dispatch_cancel(self.timer);
}


- (void)dealloc {
    if (self.timer) dispatch_cancel(self.timer);
}

@end

















#define mark - timer
@implementation XXXTimer

+ (id)runTimer:(NSTimeInterval)interval everyTime:(void(^)(void))everyTimeBlock {
    NSTimeInterval period = interval; //设置时间间隔
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (everyTimeBlock) {
            everyTimeBlock();
        }
    });
    dispatch_resume(_timer);
    return _timer;
}

@end


#pragma mark - Extension

@implementation UIView (copy_YYAdd)


- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end


@implementation NSString (copy_YYAdd)


- (CGFloat)widthForFont:(UIFont *)font {
    CGSize size = [self sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

@end
