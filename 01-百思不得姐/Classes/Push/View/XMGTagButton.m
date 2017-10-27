
//
//  XMGTagButton.m
//  01-百思不得姐
//
//  Created by Tb on 16/9/5.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTagButton.h"

@implementation XMGTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.backgroundColor = XMGTagBg;
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    
    self.width += 3 * XMGTagMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = XMGTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + XMGTagMargin;
}
@end
