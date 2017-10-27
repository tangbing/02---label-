//
//  XMGAddTagViewController.m
//  01-百思不得姐
//
//  Created by Tb on 16/9/3.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAddTagViewController.h"
#import "XMGTagButton.h"
@interface XMGAddTagViewController ()
@property (nonatomic,weak)UIView *contentView;
@property (nonatomic,weak)UITextField *textField;
@property (nonatomic,strong)UIButton *addButton;
@property (nonatomic,strong)NSMutableArray *tagButtonsAray;
@end

@implementation XMGAddTagViewController

- (NSMutableArray *)tagButtonsAray
{
    if (_tagButtonsAray == nil) {
        _tagButtonsAray = [NSMutableArray array];
    }
    return _tagButtonsAray;
}
- (UIButton *)addButton
{
    if (!_addButton) {
        _addButton = [[UIButton alloc]init];
        _addButton.width = self.contentView.width;
        _addButton.height = 35;
        _addButton.x = 0;
        _addButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_addButton setContentEdgeInsets:UIEdgeInsetsMake(0, XMGTagMargin, 0, XMGTagMargin)];
        _addButton.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft;        [_addButton addTarget:self action:@selector(addButtonClick) forControlEvents: UIControlEventTouchUpInside];
        
        _addButton.backgroundColor = XMGTagBg;
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_addButton];
    }
    return _addButton;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self setupContentView];
    [self setupTextField];
}
- (void)setupNav
{
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finish)];
    self.view.backgroundColor = [UIColor whiteColor];

}
- (void)setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.x = XMGTagMargin;
    contentView.y = 64;
    contentView.width = XMGScreenW - 2 * contentView.x;
    contentView.height = XMGScreenH;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}
- (void)setupTextField
{
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    textField.width = self.contentView.width;
    textField.height = 25;
    // 利用kvc修改占位文字的颜色，apple采用的是懒加载
    [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField becomeFirstResponder];
    [self.contentView addSubview:textField];
    [textField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    self.textField = textField;
  
}
- (void)addButtonClick
{
    XMGTagButton *tagButton = [XMGTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
  
    tagButton.height = self.textField.height;
    [self.contentView addSubview:tagButton];
    [self.tagButtonsAray addObject:tagButton];
    
    
    [self updateTagButtonFrame];
    self.textField.text = nil;
    self.addButton.hidden = YES;
}
- (void)updateTagButtonFrame
{
    for (int i = 0 ; i < self.tagButtonsAray.count; i++) {
        XMGTagButton *tagButton = self.tagButtonsAray[i];
        if (i == 0) {// 最前面的标签按钮
            tagButton.x = 0;
            tagButton.y = 0;
        } else {// 其他的标签按钮
            XMGTagButton *lastTagButton = self.tagButtonsAray[i -1];
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + XMGTagMargin;
            if (self.contentView.width - leftWidth >= tagButton.width) {
                tagButton.x = leftWidth;
                tagButton.y = lastTagButton.y;
            } else {// 按钮放在下一行
                tagButton.x = 0;
                tagButton.y =  CGRectGetMaxY(lastTagButton.frame) + XMGTagMargin;
            }
        }
    }
    XMGTagButton *lastButton = self.tagButtonsAray.lastObject;
    CGFloat leftWidth = CGRectGetMaxX(lastButton.frame) + XMGTagMargin;
    if (self.contentView.width - leftWidth >= [self textFieldWidth]) {
        self.textField.x = leftWidth;
        self.textField.y = lastButton.y;
        
    } else {
        CGFloat leftY = CGRectGetMaxY(lastButton.frame) + XMGTagMargin;
        self.textField.x = 0;
        self.textField.y =leftY;
    }
   
    
}
- (void)delete:(UIButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtonsAray removeObject:tagButton];
    // 重新更新所用的标签的frame
    [UIView animateWithDuration:0.25 animations:^{
       [self updateTagButtonFrame];
    }];
}

- (void)finish{
    XMGLogFunc;
}
- (void)textChange
{
    if (self.textField.hasText) {// 有文字，就显示
        self.addButton.hidden = NO;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textField.text] forState:UIControlStateNormal];
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + XMGTagMargin;
    } else {// 没有文字，就隐藏
        self.addButton.hidden = YES;
    }
    // 更新标签的frame
    [self updateTagButtonFrame];
}

- (CGFloat)textFieldWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
    return MAX(100, textW);
}

@end
