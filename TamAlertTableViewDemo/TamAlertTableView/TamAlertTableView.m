//
//  TamAlertTableView.m
//  TamAlertTableViewDemo
//
//  Created by xin chen on 2017/8/11.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "TamAlertTableView.h"
#import "TamBgkView.h"
#import "UIView+Tam.h"

static const int DefMaxH = 200;//最高tableView的高度
static const int DefRowH = 40;//默认cell高

@interface TamAlertTableView()<UITableViewDelegate,UITableViewDataSource,TamAlertTableViewCellDelegate>

@property(nonatomic,copy)SelectBlock selectBlock;
@property(nonatomic,assign)CGFloat rowH;
@property(nonatomic,assign)BOOL isShowLineView;

@property(nonatomic,assign)float viewMaxHeight;
@property(nonatomic,assign)BOOL isShowWithY;//通过改变y来显示动画（当在按钮上方显示时可能需要使用） 【默认高度】

@end

@implementation TamAlertTableView

+(TamAlertTableView *)alertTableViewInView:(UIView *)sender rect:(CGRect)rect arr:(NSArray *)arr viewMaxHeight:(CGFloat)viewMaxHeight isShowBgkView:(BOOL)isShowBgkView isShowLineView:(BOOL)isShowLineView isEnableBgk:(BOOL)isEnableBgk isShowWithY:(BOOL)isShowWithY selectBlock:(SelectBlock)selectBlock
{
    for (id sub in sender.subviews) {
        if ([sub isKindOfClass:[TamAlertTableView class]]) {
            TamAlertTableView *isHaveAlertView = sub;
            [isHaveAlertView dismissAlertTableView];
            return isHaveAlertView;
            break;
        }
    }
    
    TamAlertTableView *_alertTableView = [[TamAlertTableView alloc]init];
    
    //防止数组中为整形
    NSMutableArray *newArr = [[NSMutableArray alloc]init];
    newArr = [arr mutableCopy];
    [newArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[NSString class]]) {
            [newArr replaceObjectAtIndex:idx withObject:[NSString stringWithFormat:@"%d",[obj intValue]]];
        }
    }];
    arr = newArr;
    
    if (isEnableBgk) {
        TamBgkView *bgkView = [TamBgkView showBgkViewInView:sender isEnable:YES isTouchHidden:NO touchBgkViewBlock:^{
            [_alertTableView dismissAlertTableView];
        }];
        if (!isShowBgkView) {
            bgkView.backgroundColor = [UIColor clearColor];
        }
        
    }
    _alertTableView.clipsToBounds = YES;
    _alertTableView.backgroundColor = [UIColor whiteColor];
    _alertTableView.isShowLineView = isShowLineView;
    _alertTableView.dataArr = arr;
    _alertTableView.selectBlock = selectBlock;
    _alertTableView.viewMaxHeight = viewMaxHeight;
    _alertTableView.isShowWithY = isShowWithY;
    
    _alertTableView.tableView.contentOffset = CGPointMake(0, 0);
    _alertTableView.rowH = DefRowH;
    
    if (rect.size.height != 0) {
        _alertTableView.rowH = rect.size.height;
    }
    
    CGFloat maxValue = viewMaxHeight == 0 ? DefMaxH : viewMaxHeight;
    
    if (isShowWithY) {
        CGFloat y = rect.origin.y+arr.count*_alertTableView.rowH;
        CGFloat newY = y-maxValue;
        _alertTableView.frame = CGRectMake(rect.origin.x, MAX(rect.origin.y, newY)+MIN(arr.count*_alertTableView.rowH, maxValue), rect.size.width, 0);
    }else{
        _alertTableView.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 0);
    }
    
    [sender addSubview:_alertTableView];
    
    if (isShowWithY) {
        CGFloat y = rect.origin.y+arr.count*_alertTableView.rowH;
        CGFloat newY = y-maxValue;
        [UIView animateWithDuration:0.5 animations:^{
            _alertTableView.y = MAX(rect.origin.y, newY);
            _alertTableView.height = MIN(arr.count*_alertTableView.rowH, maxValue);
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _alertTableView.height = MIN(arr.count*_alertTableView.rowH, maxValue);
        }];
    }
    
    
    return _alertTableView;
}

-(void)dismissAlertTableView
{
    [TamBgkView hiddenBgkViewInView:self.superview];
    
    if (self.isShowWithY) {
        [UIView animateWithDuration:0.5 animations:^{
            self.y = self.y+self.height;
            self.height = 0;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.height = 0;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView flashScrollIndicators];
        [self addSubview:_tableView];
        
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableView]-0-|" options:0 metrics:nil views:@{@"_tableView":_tableView}]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_tableView]-0-|" options:0 metrics:nil views:@{@"_tableView":_tableView}]];
        
//        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self);
//        }];
    }
    return _tableView;
}

-(void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    [self.tableView reloadData];
}

-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self.tableView reloadData];
}

-(void)setIsNeedBorder:(BOOL)isNeedBorder
{
    _isNeedBorder = isNeedBorder;
    if (_isNeedBorder) {
        self.tableView.layer.masksToBounds = YES;
        self.tableView.layer.cornerRadius = 3;
        self.tableView.layer.borderWidth = 1;
        self.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }else{
        self.tableView.layer.cornerRadius = 0;
        self.tableView.layer.borderWidth = 0;
    }
}

-(void)updateTableView
{
    [self.tableView reloadData];
    CGFloat maxValue = self.viewMaxHeight == 0 ? DefMaxH : self.viewMaxHeight;
    self.height = MIN(self.dataArr.count*self.rowH, maxValue);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TamAlertTableViewCell *cell = [TamAlertTableViewCell alertTableViewCellWithTableView:tableView isShowLineView:self.isShowLineView];
    cell.delegate = self;
    cell.titleLabel.text = self.dataArr[indexPath.row];
    if (_textFont) {
        cell.titleLabel.font = _textFont;
    }
    if (_textColor) {
        cell.titleLabel.textColor = _textColor;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectBlock) {
        self.selectBlock(self.dataArr[indexPath.row],indexPath.row);
    }
    [self dismissAlertTableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowH;
}

@end

@implementation TamAlertTableViewCell

+(instancetype)alertTableViewCellWithTableView:(UITableView *)tableView isShowLineView:(BOOL)isShowLineView
{
    static NSString *cellId = @"alertCell";
    TamAlertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[TamAlertTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor clearColor];
        if (isShowLineView) {
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:lineView];
            lineView.translatesAutoresizingMaskIntoConstraints = NO;
            [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[lineView]-0-|" options:0 metrics:nil views:@{@"lineView":lineView}]];
            [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lineView(0.5)]-0-|" options:0 metrics:nil views:@{@"lineView":lineView}]];
    
        }
        
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

/**
 *  初始化UI
 */
-(void)setupUI
{
    UILabel *titleLabel = [[UILabel alloc]init];
    self.titleLabel = titleLabel;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[titleLabel]-0-|" options:0 metrics:nil views:@{@"titleLabel":titleLabel}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[titleLabel]-0-|" options:0 metrics:nil views:@{@"titleLabel":titleLabel}]];
    
}

@end
