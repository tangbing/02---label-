//
//  XMGTopicPictureView.h
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/29.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//  图片帖子中间的内容

#import <UIKit/UIKit.h>
@class XMGTopic;

@interface XMGTopicPictureView : UIView

/** 帖子数据 */
@property (nonatomic, strong) XMGTopic *topic;
@end
