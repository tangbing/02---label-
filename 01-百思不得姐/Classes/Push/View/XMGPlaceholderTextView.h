//
//  XMGPlaceholderTextView.h
//  01-百思不得姐
//
//  Created by Tb on 16/8/7.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGPlaceholderTextView : UITextView
/** 占位文字 */
@property (nonatomic,copy)NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic,strong)UIColor *placeholderColor;
@end
