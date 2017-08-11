//
//  TamAlertTableView.h
//  TamAlertTableViewDemo
//
//  Created by xin chen on 2017/8/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectBlock)(NSString *selStr,NSInteger selRow);
typedef void(^ClickDelBtnBlock)(NSInteger index);

@interface TamAlertTableView : UIView

@property(nonatomic,strong)UITableView *tableView;//自定义边框
@property(nonatomic,copy)UIFont *textFont;//字体大小
@property(nonatomic,copy)UIColor *textColor;//字体颜色
@property(nonatomic,strong)NSArray *dataArr;//字符串数组
@property(nonatomic,assign)BOOL isNeedBorder;//是否需要边框

@property(nonatomic,copy)ClickDelBtnBlock clickDelBtnBlock;//删除事件

/**
 *  简单的tableView弹框
 *
 *  @param sender         要添加到哪个视图上
 *  @param rect           x,y,w为tableView的frame h为单个cell的高度
 *  @param arr            字符串数组 显示的文字
 *  @param viewMaxHeight  视图最大高度
 *  @param isShowBgkView  是否显示背景色[isEnableBgk为NO 这个属性就没用]
 *  @param isShowLineView 是否需要线条隔开
 *  @param isEnableBgk    是否能使用背景
 *  @param isShowWithY    YES时向上展示 NO向下展示
 *  @param selectBlock    点击传递事件
 *
 *  @return 自己
 */
+(TamAlertTableView *)alertTableViewInView:(UIView *)sender rect:(CGRect)rect arr:(NSArray *)arr viewMaxHeight:(CGFloat)viewMaxHeight isShowBgkView:(BOOL)isShowBgkView isShowLineView:(BOOL)isShowLineView isEnableBgk:(BOOL)isEnableBgk isShowWithY:(BOOL)isShowWithY selectBlock:(SelectBlock)selectBlock;
-(void)dismissAlertTableView;
-(void)updateTableView;

@end

@protocol TamAlertTableViewCellDelegate <NSObject>

@optional
-(void)clickDelBtn:(UIButton *)sender;

@end

@interface TamAlertTableViewCell : UITableViewCell

@property(nonatomic,strong)id<TamAlertTableViewCellDelegate> delegate;
@property(nonatomic,strong)UILabel *titleLabel;
+(instancetype)alertTableViewCellWithTableView:(UITableView *)tableView isShowLineView:(BOOL)isShowLineView;

@end

