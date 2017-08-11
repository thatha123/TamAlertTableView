//
//  TamBgkView.m
//  TamCalendarTest
//
//  Created by xin chen on 2017/8/7.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "TamBgkView.h"

@interface TamBgkView()

@property(nonatomic,copy)touchBgkViewBlock touchBgkViewBlock;
@property(nonatomic,assign)BOOL isTouchHidden;//是否点击view时隐藏掉

@end

@implementation TamBgkView

+(TamBgkView *)showBgkViewInView:(UIView *)sender isEnable:(BOOL)isEnable isTouchHidden:(BOOL)isTouchHidden touchBgkViewBlock:(touchBgkViewBlock)touchBgkViewBlock
{
    [self hiddenBgkViewInView:sender];
    
    TamBgkView *bgkView = [[TamBgkView alloc]init];
    bgkView.isTouchHidden = isTouchHidden;
    bgkView.touchBgkViewBlock = touchBgkViewBlock;
    bgkView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    bgkView.frame = CGRectMake(0, 0, TamScreenW, TamScreenH);
    [sender addSubview:bgkView];
    key_window.userInteractionEnabled = isEnable;
    return bgkView;
}

+(void)hiddenBgkViewInView:(UIView *)sender
{
    for (id sub in sender.subviews) {
        if ([sub isMemberOfClass:[TamBgkView class]]) {
            TamBgkView *bgkView = (TamBgkView *)sub;
            [UIView animateWithDuration:0.3 animations:^{//去除闪屏效果
                bgkView.backgroundColor = [UIColor clearColor];
            } completion:^(BOOL finished) {
                [bgkView removeFromSuperview];
            }];
            
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isTouchHidden) {
        [TamBgkView hiddenBgkViewInView:self.superview];
    }
    self.touchBgkViewBlock();
}

+(void)setBgkViewEnable
{
    key_window.userInteractionEnabled = YES;
}

@end
