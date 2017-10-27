
//
//  XMGAddTargetToolbar.m
//  01-百思不得姐
//
//  Created by Tb on 16/9/3.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAddTargetToolbar.h"
#import "XMGAddTagViewController.h"

@implementation XMGAddTargetToolbar

- (void)awakeFromNib
{
    [super awakeFromNib];
    // 添加一个加号按钮
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
   // addButton.size = [UIImage imageNamed:@"tag_add_icon"].size;
    //addButton.size = [addButton imageForState:UIControlStateNormal].size;
    addButton.x = XMGTopicCellMargin;
    addButton.size = addButton.currentImage.size;
    [addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:addButton];
}
- (void)add
{
   // [a pushViewController:b animated:Yes]
   // a presentedViewController -> b
   // b presentingViewController - a
    
    XMGAddTagViewController *addTag = [[XMGAddTagViewController alloc] init];

    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *Nav = (UINavigationController *) root.presentedViewController;
    XMGLog(@"add%@",root.presentedViewController);
    [Nav pushViewController:addTag animated:YES];

}
 
@end
