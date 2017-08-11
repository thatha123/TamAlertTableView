//
//  TamBgkView.h
//  TamCalendarTest
//
//  Created by xin chen on 2017/8/7.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TamScreenH [UIScreen mainScreen].bounds.size.height
#define TamScreenW [UIScreen mainScreen].bounds.size.width

#define key_window [UIApplication sharedApplication].keyWindow

typedef void(^touchBgkViewBlock)();

@interface TamBgkView : UIView

/**
 *  显示背景
 *
 *  @param sender            添加到哪个视图上
 *  @param isEnable          显示视图时是否能点击［设置为NO后可以调用setBgkViewEnable方法设为YES
 *  @param isTouchHidden     点击视图时隐藏掉本视图
 *  @param touchBgkViewBlock 点击视图事件
 */
+(TamBgkView *)showBgkViewInView:(UIView *)sender isEnable:(BOOL)isEnable isTouchHidden:(BOOL)isTouchHidden touchBgkViewBlock:(touchBgkViewBlock)touchBgkViewBlock;
/**
 *  隐藏背景
 *
 *  @param sender 隐藏某个视图上的背景
 */
+(void)hiddenBgkViewInView:(UIView *)sender;

+(void)setBgkViewEnable;//如果isEnable为NO记住使用这个方法 不然无法点击屏幕


@end
