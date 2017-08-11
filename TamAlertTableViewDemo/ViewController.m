//
//  ViewController.m
//  TamAlertTableViewDemo
//
//  Created by xin chen on 2017/8/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "ViewController.h"

#import "TamAlertTableView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)downAction:(UIButton *)sender {
    CGRect fromRect = [self.view convertRect:sender.bounds fromView:sender];
    NSArray *arr = @[@"楼主帅的一批",@"楼主单身已久",@"楼主缺女票"];
    TamAlertTableView *alertTableView = [TamAlertTableView alertTableViewInView:self.view rect:CGRectMake(fromRect.origin.x, CGRectGetMaxY(fromRect), fromRect.size.width, 60) arr:arr viewMaxHeight:0 isShowBgkView:YES isShowLineView:NO isEnableBgk:YES isShowWithY:NO selectBlock:^(NSString *selStr, NSInteger selRow) {
        NSLog(@"%@-%ld",selStr,selRow);
    }];
    alertTableView.textFont = [UIFont systemFontOfSize:14];
    alertTableView.textColor = [UIColor redColor];
    alertTableView.isNeedBorder = NO;
}

- (IBAction)upAction:(UIButton *)sender {
    CGRect fromRect = [self.view convertRect:sender.bounds fromView:sender];
    NSArray *arr = @[@"楼主帅的一批",@"楼主单身已久",@"楼主缺女票"];
    TamAlertTableView *alertTableView = [TamAlertTableView alertTableViewInView:self.view rect:CGRectMake(fromRect.origin.x, fromRect.origin.y-arr.count*40, fromRect.size.width, 40) arr:arr viewMaxHeight:0 isShowBgkView:NO isShowLineView:YES isEnableBgk:NO isShowWithY:YES selectBlock:^(NSString *selStr, NSInteger selRow) {
            NSLog(@"%@-%ld",selStr,selRow);
    }];
    alertTableView.textFont = [UIFont systemFontOfSize:14];
    alertTableView.isNeedBorder = YES;
    [self.view insertSubview:sender aboveSubview:alertTableView];
}

@end
