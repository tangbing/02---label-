
//
//  XMGPlaceholderTextView.m
//  01-百思不得姐
//
//  Created by Tb on 16/8/7.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPlaceholderTextView.h"

@interface XMGPlaceholderTextView()
@property (nonatomic,strong)UILabel *placeHolderLabel;

@end

@implementation XMGPlaceholderTextView

- (UILabel *)placeHolderLabel
{
    if (_placeHolderLabel == nil) {
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.text = self.placeholder;
        _placeHolderLabel.numberOfLines = 0;
        self.placeHolderLabel.x = 4;
        self.placeHolderLabel.y =7;
        XMGLog(@"placeHolderLabel%@",NSStringFromCGRect(self.placeHolderLabel.frame));

        _placeHolderLabel.textColor = self.placeholderColor;
    }
    return _placeHolderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        XMGLog(@"initWithFrame%@",NSStringFromCGRect(self.frame));
        // 垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        // 默认字体
        self.font = [UIFont systemFontOfSize:15];
        
        // 默认的占位文字颜色
        self.placeholderColor = [UIColor grayColor];
        
        // 监听文字改变
        [XMGNoteCenter addObserver:self selector:@selector(textViewChange) name:UITextViewTextDidChangeNotification object:nil];
        
        // 添加label
        [self addSubview:self.placeHolderLabel];
    }
    return self;
}

// 更新占位文字的尺寸
- (void)updatePlaceHolderSize
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = self.font;
    
    
    CGSize maxSize = CGSizeMake(XMGScreenW - 2 * self.placeHolderLabel.x, MAXFLOAT);
   self.placeHolderLabel.size = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}
- (void)textViewChange
{
    self.placeHolderLabel.hidden = self.hasText;
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeHolderLabel.text = placeholder;
    [self updatePlaceHolderSize];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeHolderLabel.textColor = placeholderColor;

}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeHolderLabel.font = font;
    
    [self updatePlaceHolderSize];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    self.placeHolderLabel.text = text;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
  self.placeHolderLabel.attributedText = attributedText;
}

- (void)dealloc
{
    [XMGNoteCenter removeObserver:self];
}
@end
