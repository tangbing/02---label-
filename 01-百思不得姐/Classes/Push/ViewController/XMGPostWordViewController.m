

//
//  XMGPostWordViewController.m
//  01-百思不得姐
//
//  Created by Tb on 16/8/6.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPostWordViewController.h"
#import "XMGPlaceholderTextView.h"
#import "XMGAddTargetToolbar.h"
@interface XMGPostWordViewController ()<UITextViewDelegate>
@property (nonatomic,strong)XMGPlaceholderTextView *textView;
@property (nonatomic,strong)XMGAddTargetToolbar *toolbar;
@end

@implementation XMGPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTextView];
    [self setupToolbar];
    
    [XMGNoteCenter addObserver:self selector:@selector(KeyboardDidChangeFrameNotification:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)setupToolbar
{
    XMGAddTargetToolbar *toolbar = [XMGAddTargetToolbar viewFromXib];
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

- (void)KeyboardDidChangeFrameNotification:(NSNotification *)note
{
    CGFloat duration = [[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect endRect = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, endRect.origin.y - XMGScreenH);
    }];
    
}
- (void)setupNav
{
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cacel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    //这里设置了enable为no,却没有Disable的状态,因为渲染问题，在viewDidAppear设置却可以，但界面出现两种颜色,要强制刷新
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)setupTextView
{
    XMGPlaceholderTextView *textView = [[XMGPlaceholderTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    [self.view addSubview:textView];
    self.textView = textView;
    self.textView.delegate = self;
 
    // 监听文字改变
    [XMGNoteCenter addObserver:self selector:@selector(textViewChange) name:UITextViewTextDidChangeNotification object:self.textView];

}
- (void)textViewChange
{
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length !=0);
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
       [self.textView becomeFirstResponder];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //self.navigationItem.rightBarButtonItem.enabled = NO;

}
- (void)post
{
    XMGLogFunc;
}

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//[self.textView resignFirstResponder];
[self.view endEditing:YES];
}

- (void)cacel
{
 [self dismissViewControllerAnimated:YES completion:nil];
}
@end
