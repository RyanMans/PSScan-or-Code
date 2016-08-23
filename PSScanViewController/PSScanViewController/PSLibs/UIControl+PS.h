//
//  UIControl+PS.h
//  PSScanViewController
//
//  Created by Ryan_Man on 16/8/23.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (PS)

/**
 *  UIControl添加UIControlEvents事件的block
 *
 *  @param event 事件
 *  @param block
 */
- (void)ps_HandleControlEvent:(UIControlEvents)event withBlock:(void(^)(id sender))block;

/**
 *  删除事件
 *
 *  @param event
 */
- (void)ps_RemoveHandlerForEvent:(UIControlEvents)event;
@end
