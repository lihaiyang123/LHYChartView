//
//  LHYChartView.m
//  LHYChartView
//
//  Created by lreson on 16/7/21.
//  Copyright © 2016年 lreson. All rights reserved.
//

#import "LHYChartView.h"
#import "YJYTouchCollectionView.h"
#import "YJYTouchScroll.h"
#import "YJYLinesCell.h"
#import "LHYLinesPaoPaoView.h"
#define btnW 12
#define kPaoPaoWidth 75.f
#define chartViewHeight self.bounds.size.height - 30
#define KCircleRadius 3 //线条上圆圈半径
#define KCircleRadius1 5 //线条上圆圈半径
//-------------------------------使用方法(双边多条数据)-----------------------------------
//    NSArray *tempDataArrOfY = @[@[@"400",@"600",@"500",@"800",@"600",@"700",@"500"]];
//    NSArray *tempDataArrOfY1 = @[@[@"30",@"50",@"30",@"90",@"40",@"50",@"40"]];
//
//    _incomeChartLineView = [[LHYChartView alloc]initWithFrame:CGRectMake(0, 40, Main_Screen_Width, 300)];
//    //设置X轴坐标字体大小
//    _incomeChartLineView.x_Font = [UIFont systemFontOfSize:10];
//    //设置X轴坐标字体颜色
//    _incomeChartLineView.x_Color = [UIColor colorWithHexString:@"0x999999"];
//    //设置Y轴坐标字体大小
//    _incomeChartLineView.y_Font = [UIFont systemFontOfSize:10];
//    //设置Y轴坐标字体颜色
//    _incomeChartLineView.y_Color = [UIColor colorWithHexString:@"0x999999"];
//    //设置X轴数据间隔
//    _incomeChartLineView.Xmargin = 50;
//
//    _incomeChartLineView.backgroundColor = [UIColor clearColor];
//    //设置折线样式
//    _incomeChartLineView.chartViewStyle = LHYChartViewLeftRightLine;
//    //设置X轴字体大小
//    _incomeChartLineView.x_Font = [UIFont systemFontOfSize:10];
//    //设置X轴字体颜色
//    _incomeChartLineView.x_Color = [UIColor colorWithHexString:@"0x999999"];
//    //泡泡是否根据折线浮动
//    _incomeChartLineView.isFloating = YES;
//    //折线图数据
//    _incomeChartLineView.leftDataArr = tempDataArrOfY;
//    _incomeChartLineView.rightDataArr = tempDataArrOfY1;
//    //设置图层效果
//    _incomeChartLineView.chartLayerStyle = LHYChartProjection;
//
//    _incomeChartLineView.leftColorStrArr = @[@"#febf83"];
//    _incomeChartLineView.rightColorStrArr = @[@"#53d2f8"];
//
//    //底部日期
//    _incomeChartLineView.dataArrOfX = @[@"01-13",@"01-14",@"01-15",@"01-16",@"01-17",@"01-18",@"01-19"];//拿到X轴坐标
//
//    [_incomeChartLineView show];
//    [self.view addSubview:_incomeChartLineView];
//--------------------------使用方法(单边多条)--------------------------------
//    NSArray *tempDataArrOfY = @[@[@"400",@"600",@"500",@"800",@"600",@"700",@"500",@"500",@"500",@"500"],@[@"300",@"500",@"400",@"700",@"500",@"600",@"400",@"400",@"400",@"400"],@[@"500",@"800",@"300",@"600",@"400",@"500",@"300",@"300",@"300",@"300"]];
//
//    DLog(@"%f---------------",Main_Screen_Width);
//    _incomeChartLineView = [[LHYChartView alloc]initWithFrame:CGRectMake(0, 40, Main_Screen_Width, 300)];
//
//
//    //是否可以浮动
//    _incomeChartLineView.isFloating = YES;
//    //设置X轴坐标字体大小
//    _incomeChartLineView.x_Font = [UIFont systemFontOfSize:10];
//    //设置X轴坐标字体颜色
//    _incomeChartLineView.x_Color = [UIColor colorWithHexString:@"0x999999"];
//    //设置Y轴坐标字体大小
//    _incomeChartLineView.y_Font = [UIFont systemFontOfSize:10];
//    //设置Y轴坐标字体颜色
//    _incomeChartLineView.y_Color = [UIColor colorWithHexString:@"0x999999"];
//    //设置X轴数据间隔
//    _incomeChartLineView.Xmargin = 50;
//    //设置背景颜色
//    _incomeChartLineView.backgroundColor = [UIColor clearColor];
//    //是否根据折线数据浮动泡泡
//    //_incomeChartLineView.isFloating = YES;
//    //折线图数据
//    _incomeChartLineView.leftDataArr = tempDataArrOfY;
//    //折线图所有颜色
//    _incomeChartLineView.leftColorStrArr = @[@"#febf83",@"#53d2f8",@"#7211df"];
//    //设置折线样式
//    _incomeChartLineView.chartViewStyle = LHYChartViewMoreClickLine;
//    //设置图层效果
//    _incomeChartLineView.chartLayerStyle = LHYChartProjection;
//    //设置折现效果
//    _incomeChartLineView.lineLayerStyle = LHYLineLayerNone;
//    //渐变效果的颜色组
//    _incomeChartLineView.colors = @[@[[UIColor colorWithHexString:@"#febf83"],[UIColor greenColor]],@[[UIColor colorWithHexString:@"#53d2f8"],[UIColor blueColor]],@[[UIColor colorWithHexString:@"#7211df"],[UIColor redColor]]];
//    //渐变开始比例
//    _incomeChartLineView.proportion = 0.5;
//    //底部日期
//    _incomeChartLineView.dataArrOfX = @[@"01-13",@"01-14",@"01-15",@"01-16",@"01-17",@"01-18",@"01-19",@"01-20",@"01-21",@"01-22"];
//    //开始画图
//    [_incomeChartLineView show];
//    [self.view addSubview:_incomeChartLineView];

@interface LHYChartView ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CAAnimationDelegate>
{
    CGPoint lastPoint;//最后一个坐标点
    CGFloat titleWOfY;
}

@property (nonatomic,strong)YJYTouchScroll *chartScrollView;//折线图滑动的scrollview
@property (nonatomic,strong)YJYTouchCollectionView * xAxiCollectionView;//底部日期滑动的collectionview
@property (nonatomic,strong)UIPageControl *pageControl;//分页
@property (nonatomic,strong)NSMutableArray *leftPointArr;//左边的数据源
@property (nonatomic,strong)NSMutableArray *rightPointArr;//左边的数据源
@property (nonatomic,strong)NSMutableArray *leftBtnArr;//左边按钮
@property (nonatomic,strong)NSMutableArray *leftScaleViewArr;//左边的点击显示图
@property (nonatomic,assign)CGFloat leftJiange;//左侧坐标系的间距
@property (nonatomic,assign)CGFloat rightJiange;//右侧坐标系的间距
@property (nonatomic,assign)BOOL showSelect;
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,strong)UIView *selectView;
@property (nonatomic,strong)LHYLinesPaoPaoView * paopaoView;
@property (nonatomic,strong)NSMutableArray *charCircleViewArr;
@property (strong,nonatomic) UIBezierPath *circlePath;
@property (strong,nonatomic) CAGradientLayer *gradientlayer;
@property (strong,nonatomic) CAShapeLayer *percentLayer;
@property (nonatomic,strong) UIView * circleView;
@property (nonatomic,assign) NSInteger indexPathIndex;
@property (nonatomic,strong) NSMutableArray * markArray;
@property (nonatomic,strong) CAShapeLayer * dashLayer;
//最后点击
@property (nonatomic,assign) NSInteger lastIndex;
//是否是刷新
@property (nonatomic,assign) BOOL reLoading;
//记录滚动位置
@property (nonatomic,assign) CGPoint contentOffset;
//最后一次点击的坐标
@property (nonatomic,strong) NSValue * lastValue;
//选中的泡泡Tag
@property (nonatomic,assign) NSInteger selectTag;

@property (nonatomic,assign) CGFloat minValue;
@end

@implementation LHYChartView

#pragma mark --------初始化-----------
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initNew];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initNew];
}

-(instancetype)init{
    if (self = [super init]) {
        [self initNew];
    }
    return self;
}

-(void)initNew{
    _precisionScale = 1;
    _indexPathIndex = -1;
    self.leftPointArr = [NSMutableArray array];
    self.rightPointArr = [NSMutableArray array];
    self.leftBtnArr = [NSMutableArray array];
    self.leftScaleViewArr = [NSMutableArray array];
    self.markArray = [NSMutableArray array];
    self.borderLineColor = [UIColor colorWithRed:224/255.0f green:224/255.0f blue:224/255.0f alpha:1];
    self.borderTriangleColor = [UIColor colorWithRed:224/255.0f green:224/255.0f blue:224/255.0f alpha:1];
    self.showSelect = NO;
    self.isFloating = NO;
    self.chartViewStyle = 0;
    self.chartLayerStyle = 0;
    self.lineLayerStyle = 0;
    self.minValue = 0;
    self.proportion = 0.5;
    self.colors = [NSArray array];
    self.lineWidth = 1;
    self.isShow = NO;
    self.paopaoBackGroundColor = [UIColor whiteColor];
    self.markColor = [UIColor whiteColor];
    self.paopaoDataArray = [NSArray new];
    self.unitStyle = LHYUnitDefault;
    self.paopaoTitleArray = [NSArray array];
    self.isSelect = YES;
    self.leftJiange = 1;
    self.rightJiange = 1;
    self.xRow = 7;
    self.isShowYtext = YES;
    self.isShowFirstPaoPao = NO;
    self.unitName = @"";
    self.selectTag = -1;
    self.showChartOffset = YES;
    self.middleLineColor = [UIColor colorWithHexString:@"e0e0e0"];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick:)];
    [self addGestureRecognizer:tap];
    titleWOfY = 0;
    _Xmargin = 50;
    _row = 5;
}

-(NSMutableArray *)charCircleViewArr{
    if (!_charCircleViewArr) {
        _charCircleViewArr = [NSMutableArray new];
    }
    return _charCircleViewArr;
}

-(YJYTouchCollectionView *)xAxiCollectionView{
    if (!_xAxiCollectionView) {
        UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
        collectionViewLayout.minimumInteritemSpacing = 0;
        collectionViewLayout.minimumLineSpacing = 0;
        collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 4, 0, 0);
        collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _xAxiCollectionView = [[YJYTouchCollectionView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_chartScrollView.frame), CGRectGetMaxY(_chartScrollView.frame) + 10, CGRectGetWidth(_chartScrollView.frame) + CGRectGetWidth(_chartScrollView.frame) / (_xRow - 1), 20) collectionViewLayout:collectionViewLayout];
        _xAxiCollectionView.backgroundColor = [UIColor clearColor];
        [_xAxiCollectionView registerNib:[UINib nibWithNibName:@"YJYLinesCell" bundle:nil] forCellWithReuseIdentifier:@"YJYLinesCell"];
        _xAxiCollectionView.delegate = self;
        _xAxiCollectionView.dataSource = self;
        _xAxiCollectionView.bounces = NO;
        _xAxiCollectionView.showsHorizontalScrollIndicator = NO;
        _xAxiCollectionView.userInteractionEnabled = YES;
        [self addSubview:_xAxiCollectionView];
    }
    return _xAxiCollectionView;
}

- (UIView *)selectView {
    if (!_selectView) {
        _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, self.chartScrollView.frame.size.height)];
        _selectView.backgroundColor = _markColor;
        [self.chartScrollView addSubview:_selectView];
    }
    return _selectView;
}

-(void)setMarkColor:(UIColor *)markColor{
    _markColor = markColor;
}

-(LHYLinesPaoPaoView *)paopaoView{
    if (!_paopaoView) {
        _paopaoView = [[LHYLinesPaoPaoView alloc] initWithFrame:CGRectZero];
        _paopaoView.backgroundColor = _paopaoBackGroundColor;
        _paopaoView.layer.shadowColor = [UIColor blackColor].CGColor;
        _paopaoView.layer.shadowOffset = CGSizeMake(0, 3);
        _paopaoView.layer.shadowOpacity = 0.5;
        [self.chartScrollView addSubview:_paopaoView];
    }
    return _paopaoView;
}

#pragma -mark -------------scrollViewDelegate----------------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.contentOffset = scrollView.contentOffset;
    if (scrollView == _chartScrollView) {
        _xAxiCollectionView.contentOffset = scrollView.contentOffset;
    }else{
        _chartScrollView.contentOffset = scrollView.contentOffset;
    }
    for (UIView * markCrossView in self.markArray) {
        CGRect frame = markCrossView.frame;
        frame.origin.x = scrollView.contentOffset.x;
        [markCrossView setFrame:frame];
    }
}
#pragma -mark --------------collViewDelegate----------------
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataArrOfX.count > 0) {
        return self.dataArrOfX.count + 2;
    }
    return self.dataArrOfX.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YJYLinesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YJYLinesCell" forIndexPath:indexPath];
    if (indexPath.row == _indexPathIndex + 1) {
        if (self.x_Select_Font) {
            cell.titleLB.font = self.x_Select_Font;
        }else{
            cell.titleLB.font = self.x_Font;
        }
        if (self.x_Select_Color) {
            cell.titleLB.textColor = self.x_Select_Color;
        }else{
            cell.titleLB.textColor = self.x_Color;
        }
    }else{
        cell.titleLB.font = self.x_Font;
        cell.titleLB.textColor = self.x_Color;
    }
    if (indexPath.row == 0 || indexPath.row == self.dataArrOfX.count + 1) {
        cell.titleLB.text = @"";
    }else{
        cell.titleLB.text = self.dataArrOfX[indexPath.row - 1];
    }
    cell.titleLB.textAlignment=NSTextAlignmentCenter;
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == self.dataArrOfX.count + 1) {
        return CGSizeMake(CGRectGetWidth(_chartScrollView.frame) / (_xRow - 1) / 2, 20);
    }else{
        return CGSizeMake(CGRectGetWidth(self.chartScrollView.frame) / (self.xRow - 1), 20);
    }
    
}

-(void)setLeftDataArr:(NSArray *)leftDataArr{
    _leftDataArr = leftDataArr;
}

-(void)setRightDataArr:(NSArray *)rightDataArr{
    _rightDataArr = rightDataArr;
    self.pageControl.numberOfPages = 1;
}
// 获取数据最大值,并计算每一行间隔值
- (CGFloat)spaceValue:(NSArray *)array{
    CGFloat minValue = MAXFLOAT;
    CGFloat maxValue = -MAXFLOAT;
    for (int i = 0; i < [array count]; i++) {
        if ([array[i] floatValue] * _precisionScale> maxValue) {
            maxValue = [array[i] floatValue] * _precisionScale;
        }
        if ([array[i] floatValue] * _precisionScale < minValue) {
            minValue = [array[i] floatValue] * _precisionScale;
        }
    }
    NSInteger max = [self getNumber:maxValue];
    if (!self.min && !self.min.length) {
        NSInteger min = [self getMinNumber:minValue];
        self.minValue = min < self.minValue ? min : self.minValue;
    }else{
        self.minValue = [self.min floatValue];
    }
    max = max - self.minValue;
    if (_unitStyle == LHYUnitMillion) {
        NSInteger maxValueInterger = max / 100000000.f + 0.99;
        NSInteger xMaxValue = maxValueInterger % (_row - 1);
        if (xMaxValue != 0) {
            xMaxValue = (_row - 1) - xMaxValue + maxValueInterger;
        }else{
            xMaxValue = maxValueInterger;
        }
        return xMaxValue / (_row - 1) * 100000000.f;
    }else if (_unitStyle == LHYUnitWan) {
        NSInteger maxValueInterger = max / 10000.f + 0.99;
        NSInteger xMaxValue = maxValueInterger % (_row - 1);
        if (xMaxValue != 0) {
            xMaxValue = (_row - 1) - xMaxValue + maxValueInterger;
        }else{
            xMaxValue = maxValueInterger;
        }
        return xMaxValue / (_row - 1) * 10000.f;
    }else if (_unitStyle == LHYUnitThousand) {
        NSInteger maxValueInterger = max / 1000.f + 0.99;
        NSInteger xMaxValue = maxValueInterger % (_row - 1);
        if (xMaxValue != 0) {
            xMaxValue = (_row - 1) - xMaxValue + maxValueInterger;
        }else{
            xMaxValue = maxValueInterger;
        }
        return xMaxValue / (_row - 1) * 1000.f;
    }else if (_unitStyle == LHYUnitMoneyDefault) {
        if (max == 0) {
            return 10000.f;
        }
        NSInteger maxValueInterger = 0;
        if (max < 100000000) {
            maxValueInterger = max / 1000.f + 0.999;
        }else{
            maxValueInterger = max / 10000000.f + 0.9999999;
        }
        NSInteger xMaxValue = maxValueInterger % (_row - 1);
        if (xMaxValue != 0) {
            xMaxValue = (_row - 1) - xMaxValue + maxValueInterger;
        }else{
            if (maxValueInterger == 0) {
                xMaxValue = _row - 1;
            }else{
                xMaxValue = maxValueInterger;
            }
        }
        if (max >= 100000000) {
            return xMaxValue / (_row - 1) * 10000000.f;
        }
        return xMaxValue / (_row - 1) * 1000.f;
    }else{
        NSInteger maxValueInterger = 0;
        if (max >= 1000) {
            maxValueInterger = max / 100.f + 0.99;
        }else{
            maxValueInterger = max;
        }
        NSInteger xMaxValue = maxValueInterger % (_row - 1);
        if (xMaxValue != 0) {
            xMaxValue = (_row - 1) - xMaxValue + maxValueInterger;
        }else{
            xMaxValue = maxValueInterger;
        }
        if (max >= 1000) {
            return xMaxValue / (_row - 1) * 100;
        }
        return xMaxValue / (_row - 1);
    }
}
// 只取小数点之前的数字
- (CGFloat)getNumber:(CGFloat)value{
    CGFloat upValue = ceil(value);
    NSString *string = [NSString stringWithFormat:@"%.0f",upValue];
    return [string integerValue];
}

// 只取小数点之前的数字
- (CGFloat)getMinNumber:(CGFloat)value{
    CGFloat upValue = floor(value);
    NSString *string = [NSString stringWithFormat:@"%.0f",upValue];
    return [string integerValue];
}
#pragma mark ----------显示---------------
-(void)show{
    self.reLoading = NO;
    self.contentOffset = CGPointMake(0, 0);
    self.lastIndex = 0;
    [self onLoading];
}

-(void)reShow{
    self.reLoading = YES;
    self.selectIndex = -1;
    [self onLoading];
}

-(void)onLoading{
    if (_dashLayer) {
        [_dashLayer removeFromSuperlayer];
        _dashLayer = nil;
    }
    [self.chartScrollView removeFromSuperview];
    [self.xAxiCollectionView removeFromSuperview];
    [self.paopaoView removeFromSuperview];
    self.chartScrollView = nil;
    self.xAxiCollectionView = nil;
    self.paopaoView = nil;
    [self colorConversion];
    self.selectView = nil;
    ////添加连线
    [self addDetailViews];
    [self.xAxiCollectionView reloadData];
    switch (_chartViewStyle) {
        case 0:
            [self showLeftRightView];
            break;
        case 1:
            [self showLeftRightView];
            break;
        case 2:
            [self showLeftRightView];
            break;
        default:
            break;
    }
    [_chartScrollView setContentOffset:self.contentOffset];
    if (!self.reLoading) {
        if (self.leftPointArr.count > 0) {
            NSArray * pointArray = self.leftPointArr[0];
            if (self.isShowFirstPaoPao && pointArray.count > 0) {
                NSValue * pointValue = pointArray[0];
                CGPoint point = [pointValue CGPointValue];
                point.x += titleWOfY;
                [self viewClick:[NSValue valueWithCGPoint:point]];
                if (self.paopaoView.hidden) {
                    [self viewClick:[NSValue valueWithCGPoint:point]];
                }
            }
            if (self.isShowLastPaoPao && pointArray.count > 0) {
                CGFloat contentSizeWidth = self.chartScrollView.contentSize.width;
                CGFloat offsetX = contentSizeWidth - CGRectGetWidth(self.chartScrollView.frame);
                CGPoint contentPoint = CGPointMake(offsetX < 0 ? 0 : offsetX, 0);
                [self.chartScrollView setContentOffset:contentPoint];
            }
        }
    }else{
        if (self.leftPointArr.count > 0) {
            if (self.lastIndex) {
                CGPoint point = self.lastValue.CGPointValue;
                self.lastValue = [NSValue valueWithCGPoint:point];
                point.x -= titleWOfY;
                if (self.selectTag >= 0) {
                    [self drawOtherLin:self.selectTag AndPoint:point];
                }
            }
        }
    }
}

//转换颜色
-(void)colorConversion{
    NSMutableArray * colorArray = [NSMutableArray array];
    for (id obj in _leftColorStrArr) {
        UIColor * color;
        if ([obj isKindOfClass:[UIColor class]]) {
            color = obj;
        }else{
            NSString * colorStr = obj;
            color = [UIColor colorWithHexString:colorStr];
        }
        [colorArray addObject:color];
    }
    _leftColorStrArr = [NSArray arrayWithArray:colorArray];
    [colorArray removeAllObjects];
    for (id obj in _rightColorStrArr) {
        UIColor * color;
        if ([obj isKindOfClass:[UIColor class]]) {
            color = obj;
        }else{
            NSString * colorStr = obj;
            color = [UIColor colorWithHexString:colorStr];
        }
        [colorArray addObject:color];
    }
    //    for (id obj in _colors) {
    //        UIColor * color;
    //        if ([obj isKindOfClass:[UIColor class]]) {
    //            color = obj;
    //        }else{
    //            NSString * colorStr = obj;
    //            color = [UIColor colorWithHexString:colorStr];
    //        }
    //        [colorArray addObject:color];
    //    }
    _rightColorStrArr = [NSArray arrayWithArray:colorArray];
}
//显示左右两种标线
-(void)showLeftRightView{
    [self.leftPointArr removeAllObjects];
    
    if (_leftDataArr.count > 0) {
        if (!self.reLoading) {
            if (_unitStyle == LHYUnitThousand) {
                _leftJiange = 1000;
            }else if (_unitStyle == LHYUnitWan){
                _leftJiange = 10000;
            }else if (_unitStyle == LHYUnitMillion){
                _leftJiange = 100000000;
            }else{
                _leftJiange = 1;
            }
        }
        if (!self.min || !self.min.length) {
            self.minValue = 0;
        }else{
            self.minValue = [self.min floatValue];
        }
        if (self.max) {
            CGFloat jiange = [self spaceValue:@[[NSString stringWithFormat:@"%f",self.max]] ];
            if (jiange > _leftJiange) {
                _leftJiange = jiange;
            }
        }else{
            for (int i = 0; i < _leftDataArr.count; i++) {
                CGFloat jiange = [self spaceValue:_leftDataArr[i]];
                if (jiange > _leftJiange) {
                    _leftJiange = jiange;
                }
            }
        }
        [self addLeftViews];
        [self setChartViewContentSize];
        if (!_rightDataArr || _rightDataArr.count == 0) {
            [self calculateLeftLabelMaxWidth];
            [self addLines1With:self.chartScrollView];
        }
        NSMutableArray * pointMarray = [NSMutableArray array];
        for (int i = 0; i < _leftDataArr.count; i++) {
            NSArray * dataArray = _leftDataArr[i];
            [pointMarray addObject:[self addDataPointWith:self.chartScrollView andArr:dataArray andInterval:_leftJiange]];//添加点
        }
        //添加点
        [self.leftPointArr addObjectsFromArray:pointMarray];
        for (int i = 0; i<pointMarray.count; i++) {
            NSArray * colorArray = [NSArray array];
            if (i < _colors.count) {
                colorArray = _colors[i];
            }
            [self addBezierPoint:pointMarray[i] andColor:_leftColorStrArr[i<_leftColorStrArr.count?i:_leftColorStrArr.count-1] andColors:colorArray];
        }
    }
    if (_rightDataArr.count > 0) {
        if (self.max) {
            CGFloat jiange = [self spaceValue:@[[NSString stringWithFormat:@"%f",self.max]]];
            if (jiange > _leftJiange) {
                _leftJiange = jiange;
            }
        }else{
            for (int i = 0; i < _rightDataArr.count; i++) {
                if (_unitStyle == LHYUnitThousand) {
                    _rightJiange = 1000;
                }else if (_unitStyle == LHYUnitWan){
                    _rightJiange = 10000;
                }else if (_unitStyle == LHYUnitMillion){
                    _rightJiange = 100000000;
                }else{
                    _rightJiange = 1;
                }
                CGFloat jiange = [self spaceValue:_rightDataArr[i]];
                if (jiange > _rightJiange) {
                    _rightJiange = jiange;
                }
            }
        }
        
        [self addLeftViews];
        [self setChartViewContentSize];
        [self calculateLeftLabelMaxWidth];
        [self addLines1With:self.chartScrollView];
        NSMutableArray * pointMarray = [NSMutableArray array];
        for (int i = 0; i < _rightDataArr.count; i++) {
            NSArray * dataArray = _rightDataArr[i];
            [pointMarray addObject:[self addDataPointWith:self.chartScrollView andArr:dataArray andInterval:_rightJiange]];//添加点
        }
        [self.leftPointArr addObjectsFromArray:pointMarray];
        for (int i = 0; i<pointMarray.count; i++) {
            NSArray * colorArray = [NSArray array];
            if (i < _colors.count) {
                colorArray = _colors[i];
            }
            [self addBezierPoint:pointMarray[i] andColor:_rightColorStrArr[i<_rightColorStrArr.count?i:_rightColorStrArr.count-1] andColors:colorArray];
        }
        ////添加连线
        [self addRightViews];
    }
    
    if (_leftDataArr.count <= 0 && _rightDataArr.count <= 0) {
        [self addLeftViews];
        [self setChartViewContentSize];
        [self addLines1With:self.chartScrollView];
    }
    if (self.leftPointArr.count > 0) {
        for (int i = 0; i < self.leftPointArr.count; i++) {
            NSMutableArray * pointMarray = [NSMutableArray arrayWithArray:self.leftPointArr[i]];
            if (pointMarray.count > 2 && pointMarray.count == self.dataArrOfX.count) {
                [pointMarray removeObjectAtIndex:pointMarray.count - 1];
                [pointMarray removeObjectAtIndex:0];
            }else if (pointMarray.count > 0){
                [pointMarray removeObjectAtIndex:0];
            }
            self.leftPointArr[i] = pointMarray;
        }
    }
    [self addBottomViewsWith:self.chartScrollView];
}

-(void)setChartViewContentSize{
    CGFloat chartScrollViewwidth = _chartViewStyle == LHYChartViewLeftRightLine ? self.bounds.size.width-titleWOfY * 2 :self.bounds.size.width-titleWOfY;
    CGFloat xMargin = chartScrollViewwidth / (_xRow - 1);
    if (self.dataArrOfX.count > 0) {
        self.chartScrollView.contentSize = CGSizeMake(xMargin*(self.dataArrOfX.count + 1), 0);
    }
}

-(void)setIsShowYtext:(BOOL)isShowYtext{
    _isShowYtext = isShowYtext;
    titleWOfY = isShowYtext ? titleWOfY : 0;
}
#pragma mark *******************数据源************************
-(void)setDataArrOfX:(NSArray *)dataArrOfX{
    _dataArrOfX = dataArrOfX;
}
#pragma mark *******************分割线************************
-(void)addDetailViews{
    CGFloat width = 0;
    width = _chartViewStyle == LHYChartViewLeftRightLine ? self.bounds.size.width-titleWOfY * 2 :self.bounds.size.width-titleWOfY;
    self.chartScrollView = [[YJYTouchScroll alloc]initWithFrame:CGRectMake(titleWOfY, 0, width, chartViewHeight)];
    self.chartScrollView.backgroundColor = [UIColor clearColor];
    self.chartScrollView.bounces = NO;
    self.chartScrollView.delegate = self;
    self.chartScrollView.showsHorizontalScrollIndicator = NO;
    self.chartScrollView.userInteractionEnabled = YES;
    [self addSubview:self.chartScrollView];
    [self addSubview:self.xAxiCollectionView];
}
#pragma mark 渐变线条
-(void)buildBGCircleLayer:(NSArray *)colors
{
    CAShapeLayer *bgCircleLayer = [CAShapeLayer layer];
    bgCircleLayer.path = _circlePath.CGPath;
    bgCircleLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    bgCircleLayer.fillColor = [UIColor clearColor].CGColor;
    bgCircleLayer.lineWidth = _lineWidth;
    bgCircleLayer.lineCap = kCALineCapRound; // 截面形状
    [self addShowPercentLayer:colors];
    [self percentAnimation];
}

-(void)addShowPercentLayer:(NSArray *)colors
{
    _gradientlayer = (id)[CAGradientLayer layer];
    if (colors && colors.count > 0) {
        NSMutableArray * colorMarray = [NSMutableArray array];
        for (int i = 0; i < colors.count; i++) {
            UIColor * color = colors[i];
            [colorMarray addObject:(id)color.CGColor];
        }
        _gradientlayer.colors = colorMarray;
    }else{
        _gradientlayer.colors = [NSArray arrayWithObjects:(id)[[UIColor redColor]CGColor],(id)[[UIColor blueColor]CGColor], nil];
    }
    _gradientlayer.startPoint= CGPointMake(0.10, 1);
    _gradientlayer.endPoint = CGPointMake(0.90, 1);
    if (_locations && _locations.count > 0) {
        _gradientlayer.locations = _locations;
    }else{
        _gradientlayer.locations = @[[NSNumber numberWithFloat:_proportion]];
    }
    _gradientlayer.frame = CGRectMake(0, 0, self.chartScrollView.contentSize.width, CGRectGetHeight(self.chartScrollView.frame));
    _percentLayer = [CAShapeLayer layer];
    _percentLayer.path = _circlePath.CGPath;
    _percentLayer.strokeColor = [UIColor redColor].CGColor;
    _percentLayer.fillColor = [UIColor clearColor].CGColor;
    _percentLayer.lineWidth = _lineWidth;
    _percentLayer.strokeStart = 0;
    _percentLayer.strokeEnd = 1;
    _percentLayer.lineCap = kCALineCapRound;
    if (_chartLayerStyle == 2) {
        _percentLayer.shadowColor = [UIColor redColor].CGColor;
        _percentLayer.shadowOffset = CGSizeMake(0,5);
        _percentLayer.shadowOpacity = 0.5;
    }
    [_gradientlayer setMask:_percentLayer];
    [self.chartScrollView.layer addSublayer:_gradientlayer];
    
}
-(void)percentAnimation
{
    CABasicAnimation *strokeAnmi = [CABasicAnimation animation];
    strokeAnmi.keyPath = @"strokeEnd";
    strokeAnmi.fromValue = [NSNumber numberWithFloat:0];
    strokeAnmi.toValue = [NSNumber numberWithFloat:1.0f];
    strokeAnmi.duration =2.0f;
    strokeAnmi.delegate = self;
    strokeAnmi.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeAnmi.autoreverses = NO;
    if (!self.reLoading) [_percentLayer addAnimation:strokeAnmi forKey:@"stroke"];
}
//等动画结束之后的操作
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (_isShow) {
        [self drawCircleArr:self.leftPointArr color:self.leftColorStrArr];
    }
    //是否动画结束后显示最后一条数据
    if (!self.leftPointArr || !self.leftPointArr.count) return;
    NSArray * pointArray = self.leftPointArr[0];
    if (self.isShowLastPaoPao && pointArray.count > 0) {
        CGPoint point = [pointArray[pointArray.count - 1] CGPointValue];
        if (point.x >= CGRectGetWidth(self.chartScrollView.frame)) {
            point.x = [pointArray[self.xRow - 3] CGPointValue].x;
        }
        point.x += titleWOfY;
        NSValue * value = [NSValue valueWithCGPoint:point];
        if (!self.paopaoView || !CGRectGetWidth(self.paopaoView.frame) || self.paopaoView.hidden) {
            [self viewClick:value];
        }
    }
}
#pragma mark ----------绘画折现----------------
-(void)addBezierPoint:(NSArray *)pointArray andColor:(UIColor *)color andColors:(NSArray *)colors{
    if (pointArray.count <= 0) {
        return;
    }
    //取得起始点
    CGPoint startP = CGPointMake(0, 0);
    if (!self.hiddenZreo) {
        startP = [[pointArray objectAtIndex:0] CGPointValue];
    }else{
        startP = [[pointArray objectAtIndex:1] CGPointValue];
    }
    //直线的连线
    UIBezierPath *lineBeizer = [UIBezierPath bezierPath];
    [lineBeizer moveToPoint:startP];
    _circlePath = lineBeizer;
    //遮罩层的形状
    UIBezierPath *shelterBezier = [UIBezierPath bezierPath];
    shelterBezier.lineCapStyle = kCGLineCapRound;
    shelterBezier.lineJoinStyle = kCGLineJoinMiter;
    [shelterBezier moveToPoint:startP];
    for (int i = 0;i<pointArray.count;i++ ) {
        if (!self.hiddenZreo) {
            if (i > 0) {
                CGPoint prePoint = [[pointArray objectAtIndex:i-1] CGPointValue];
                CGPoint nowPoint = [[pointArray objectAtIndex:i] CGPointValue];
                //            [beizer addLineToPoint:point];
                [lineBeizer addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x+prePoint.x)/2, prePoint.y) controlPoint2:CGPointMake((nowPoint.x+prePoint.x)/2, nowPoint.y)];
                if (_chartLayerStyle == LHYChartGradient) [shelterBezier addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x+prePoint.x)/2, prePoint.y) controlPoint2:CGPointMake((nowPoint.x+prePoint.x)/2, nowPoint.y)];
                if (i == pointArray.count-1) {
                    [lineBeizer moveToPoint:nowPoint];//添加连线
                    lastPoint = nowPoint;
                }
            }
        }else{
            if (pointArray.count > 2) {
                if (i > 1) {
                    CGPoint prePoint = [[pointArray objectAtIndex:i-1] CGPointValue];
                    CGPoint nowPoint = [[pointArray objectAtIndex:i] CGPointValue];
                    //            [beizer addLineToPoint:point];
                    [lineBeizer addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x+prePoint.x)/2, prePoint.y) controlPoint2:CGPointMake((nowPoint.x+prePoint.x)/2, nowPoint.y)];
                    if (_chartLayerStyle == LHYChartGradient) [shelterBezier addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x+prePoint.x)/2, prePoint.y) controlPoint2:CGPointMake((nowPoint.x+prePoint.x)/2, nowPoint.y)];
                    if (i == pointArray.count-1) {
                        [lineBeizer moveToPoint:nowPoint];//添加连线
                        lastPoint = nowPoint;
                    }
                }
            }else{
                if (i > 0) {
                    CGPoint prePoint = [[pointArray objectAtIndex:i] CGPointValue];
                    CGPoint nowPoint = [[pointArray objectAtIndex:i] CGPointValue];
                    nowPoint.x +=1;
                    [lineBeizer addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x+prePoint.x)/2, prePoint.y) controlPoint2:CGPointMake((nowPoint.x+prePoint.x)/2, nowPoint.y)];
                    if (_chartLayerStyle == LHYChartGradient) [shelterBezier addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x+prePoint.x)/2, prePoint.y) controlPoint2:CGPointMake((nowPoint.x+prePoint.x)/2, nowPoint.y)];
                    if (i == pointArray.count-1) {
                        [lineBeizer moveToPoint:nowPoint];//添加连线
                        lastPoint = nowPoint;
                    }
                }
            }
        }
    }
    
    CGFloat bgViewHeight = self.chartScrollView.bounds.size.height;
    //获取最后一个点的X值
    CGFloat lastPointX = lastPoint.x;
    //最后一个点对应的X轴的值
    CGPoint lastPointX1 = CGPointMake(lastPointX, bgViewHeight);
    [shelterBezier addLineToPoint:lastPointX1];
    //回到原点
    [shelterBezier addLineToPoint:CGPointMake(startP.x, bgViewHeight)];
    [shelterBezier addLineToPoint:startP];
    if (_lineLayerStyle == 1) {
        if (_chartLayerStyle == 1) {
            [self addGradientWithBezierPath:shelterBezier andColor:color];
        }
        [self buildBGCircleLayer:colors];
        return;
    }
    //    //*****************添加动画连线******************//
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = lineBeizer.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.lineWidth = 3;
    switch (_chartLayerStyle) {
        case 0:
            break;
        case 1:
            [self addGradientWithBezierPath:shelterBezier andColor:color];
            break;
        case 2:
#pragma mark ------------阴影投影---------------
            shapeLayer.shadowOffset = CGSizeMake(0, 10);
            shapeLayer.shadowColor = color.CGColor;
            shapeLayer.shadowOpacity = 0.5;
            break;
        default:
            break;
    }
    [self.chartScrollView.layer addSublayer:shapeLayer];
    CABasicAnimation *strokeAnmi = [CABasicAnimation animation];
    strokeAnmi.keyPath = @"strokeEnd";
    strokeAnmi.fromValue = [NSNumber numberWithFloat:0];
    strokeAnmi.toValue = [NSNumber numberWithFloat:1.0f];
    strokeAnmi.duration =2.0f;
    strokeAnmi.delegate = self;
    strokeAnmi.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeAnmi.autoreverses = NO;
    if (!self.reLoading) [shapeLayer addAnimation:strokeAnmi forKey:@"stroke"];
}
#pragma mark    ------------渐变图层---------------
-(void)addGradientWithBezierPath:(UIBezierPath *)beizer andColor:(UIColor *)color{
    //遮罩层
    CAShapeLayer *shadeLayer = [CAShapeLayer layer];
    shadeLayer.path = beizer.CGPath;
    shadeLayer.fillColor = [UIColor greenColor].CGColor;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 0, self.chartScrollView.bounds.size.height);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.cornerRadius = 5;
    gradientLayer.masksToBounds = YES;
    gradientLayer.colors = @[(__bridge id)[color colorWithAlphaComponent:0.3].CGColor,(__bridge id)[color colorWithAlphaComponent:0].CGColor];
    gradientLayer.locations = @[@(0.5f)];
    CALayer *baseLayer = [CALayer layer];
    [baseLayer addSublayer:gradientLayer];
    [baseLayer setMask:shadeLayer];
    [self.chartScrollView.layer addSublayer:baseLayer];
    CABasicAnimation *boundsAnmi = [CABasicAnimation animation];
    boundsAnmi.keyPath = @"bounds";
    boundsAnmi.duration = self.reLoading ? 0.0001f : 2.f;
    boundsAnmi.toValue = [NSValue valueWithCGRect:CGRectMake(5, 0, 2*lastPoint.x, self.chartScrollView.bounds.size.height)];
    boundsAnmi.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    boundsAnmi.fillMode = kCAFillModeForwards;
    boundsAnmi.delegate = self;
    boundsAnmi.autoreverses = NO;
    boundsAnmi.removedOnCompletion = NO;
    [gradientLayer addAnimation:boundsAnmi forKey:@"bounds"];
    
}
#pragma mark ----------获取所有坐标点-------------
-(NSMutableArray *)addDataPointWith:(UIView *)view andArr:(NSArray *)DataArr andInterval:(CGFloat)interval{
    CGFloat offset = 0;
    if (self.showChartOffset) {
        offset = 4;
    }
    CGFloat min =  self.minValue <= 0 ? self.minValue + fabs(self.minValue) * 2 : [[NSString stringWithFormat:@"-%f",self.minValue] floatValue];
    CGFloat height = self.chartScrollView.bounds.size.height - 13 - KCircleRadius1 / 2 - offset;
    //初始点
    NSMutableArray *arr = [NSMutableArray arrayWithArray:DataArr];
    NSMutableArray * marr = [NSMutableArray array];
    CGFloat xMargin = CGRectGetWidth(self.chartScrollView.frame) / (_xRow - 1);
    for (int i = 0; i<arr.count; i++) {
        float tempHeight = ([arr[i] floatValue] + min) / (interval * (_row - 1)) ;
        NSValue *point = [NSValue valueWithCGPoint:CGPointMake(xMargin * i + xMargin, (height *(1 - tempHeight) + 13))];
        if (i == 0) {
//            NSValue *point1 = [NSValue valueWithCGPoint:CGPointMake(0 , (height + 13))];
            NSValue *point1 = [NSValue valueWithCGPoint:CGPointMake(0 , (height *(1 - tempHeight) + 13))];
            [marr addObject:point1];
        }
        [marr addObject:point];
    }
    return marr;
}
#pragma mark ---------添加左侧Y轴标注--------------
-(void)addLeftViews{
    CGFloat textWidth = 0;
    CGFloat labelWidth = 0;
    textWidth = [NSString measureSinglelineStringWidth:[self unitValue:_leftJiange * (_row - 1) + self.minValue] andFont:_y_Font];
    textWidth = [NSString measureSinglelineStringWidth:[self unitValue:_leftJiange * 0 + self.minValue] andFont:_y_Font] > textWidth ? [NSString measureSinglelineStringWidth:[self unitValue:_leftJiange * 0 + self.minValue] andFont:_y_Font] : textWidth;
    if (_unitStyle == LHYUnitMoneyPercentage) {
        textWidth = [NSString measureSinglelineStringWidth:@"100%" andFont:_y_Font];
    }
    if (_isShowYtext) labelWidth = textWidth + 2 > labelWidth ? textWidth + 2 : labelWidth;
    titleWOfY = labelWidth;
    [self.markArray removeAllObjects];
    CGFloat topHeight = 13;
    CGFloat chartScrollViewwidth = _chartViewStyle == LHYChartViewLeftRightLine ? self.bounds.size.width-labelWidth * 2 :self.bounds.size.width-labelWidth;
    for (NSInteger i = 0;i< _row ;i++ ) {
        UILabel * leftLabel = [self viewWithTag:1000 + i + 1];
        CGFloat height = CGRectGetHeight(self.chartScrollView.frame) - topHeight;
        if (!leftLabel) {
            leftLabel = [[UILabel alloc]init];
            leftLabel.tag = 1000 + i + 1;
        }
        CGRect frame = CGRectMake(0,topHeight + height- height / (_row - 1) * i - [_y_Font pointSize] / 2, labelWidth, [_y_Font pointSize]);
        [leftLabel setFrame:frame];
        leftLabel.font = _y_Font;
        leftLabel.textColor = _y_Color;
        if (_unitStyle == LHYUnitMoneyPercentage) {
            leftLabel.text = [NSString stringWithFormat:@"%.0f%%",100.0 / (_row - 1) * i];
        }else{
            leftLabel.text = [self unitValue:_leftJiange * i + self.minValue];
        }
        if (i >= !self.isShowZero && self.isShowYtext) [self addSubview:leftLabel];
        if (self.isGrid){
            CGFloat xMargin = chartScrollViewwidth / (_xRow - 1);
            CGFloat width = 0;
            if (xMargin*(self.dataArrOfX.count + 1) < chartScrollViewwidth){
                width = chartScrollViewwidth;
            }else{
                width = xMargin*(self.dataArrOfX.count + 1);
            }
            UIView * crossView = [[UIView alloc] initWithFrame:CGRectMake(0,topHeight + height - height / (_row - 1) * i + 0.5,width, 0.5)];
            crossView.backgroundColor = _middleLineColor;
            [self.chartScrollView addSubview:crossView];
            if (i != 0) {
                UIView * markCrossView = [[UIView alloc] initWithFrame:CGRectMake(0,topHeight + height - height / (_row - 1) * i + 0.5,8, 0.5)];
                markCrossView.backgroundColor = _borderLineColor;
                [self.chartScrollView addSubview:markCrossView];
                [self.markArray addObject:markCrossView];
            }
        }
    }
    if (self.isGrid) {
        if (!self.dataArrOfX || self.dataArrOfX.count == 0 || (self.dataArrOfX.count > 0 && chartScrollViewwidth / (self.xRow - 3)*(self.dataArrOfX.count - 1) <= chartScrollViewwidth + 1)) {
            CGFloat verticalX = 0;
            while (verticalX <= chartScrollViewwidth + 0.5) {
                UIView * vertical = [[UIView alloc] initWithFrame:CGRectMake(verticalX - 0.5,topHeight,0.5, CGRectGetHeight(self.chartScrollView.frame) - topHeight)];
                vertical.backgroundColor = _middleLineColor;
                [self.chartScrollView addSubview:vertical];
                verticalX += chartScrollViewwidth / (self.xRow - 1);
            }
        }else{
            for (int i = 0; i < self.dataArrOfX.count + 2; i++) {
                UIView * vertical = [[UIView alloc] initWithFrame:CGRectMake(chartScrollViewwidth / (self.xRow - 1) * i - 0.5,topHeight,0.5, CGRectGetHeight(self.chartScrollView.frame)- topHeight)];
                vertical.backgroundColor = _middleLineColor;
                [self.chartScrollView addSubview:vertical];
            }
        }
    }
}

-(void)calculateLeftLabelMaxWidth{
    for (NSInteger i = 0;i< _row ;i++ ) {
        NSString * str = @"";
        switch (_chartViewStyle) {
            case 0:
                str = [self unitValue:_leftJiange * i];
                break;
            case 1:
                str = [self unitValue:_leftJiange * i];
                break;
            case 2:
                str = [self unitValue:_leftJiange * i];
                break;
            default:
                break;
        }
    }
    CGFloat width = _chartViewStyle == LHYChartViewLeftRightLine ? self.bounds.size.width-titleWOfY * 2 :self.bounds.size.width-titleWOfY;
    [_chartScrollView setFrame:CGRectMake(titleWOfY, 0, width, chartViewHeight)];
    [_xAxiCollectionView setFrame:CGRectMake(CGRectGetMinX(_chartScrollView.frame), CGRectGetMaxY(_chartScrollView.frame) + 10, CGRectGetWidth(self.frame) - CGRectGetMinX(_chartScrollView.frame), 20)];
}

-(NSString *)unitValue:(CGFloat)value{
    CGFloat returnValue = 0;
    if (_unitStyle == LHYUnitGe || _unitStyle == LHYUnitDefault) {
        returnValue = value;
    }else if (_unitStyle == LHYUnitMoneyPercentageDefault){
        return [NSString stringWithFormat:@"%.0f%%",value];
    }else if (_unitStyle == 1) {
        returnValue = value / 1000;
    }else if (_unitStyle == 2){
        returnValue = value / 10000;
    }else if (_unitStyle == 3){
        returnValue = value / 100000000;
    }else if (_unitStyle == 4){
        if (value >= 100000000 || returnValue <= 100000000) {
            return [NSString stringWithFormat:@"%.1f亿%@",value / 100000000,self.unitName];
        }else{
            return [NSString stringWithFormat:@"%.1f万%@",value / 10000,self.unitName];
        }
    }
    if ((returnValue >= 1000 || returnValue <= 1000) && (self.leftJiange * (self.row - 1) >= 1000)) {
        return [NSString stringWithFormat:@"%.1fk%@",returnValue / 1000,self.unitName];
    }
    return [NSString stringWithFormat:@"%.0f%@",returnValue,self.unitName];
}
#pragma mark ---------添加右侧Y轴标注--------------
-(void)addRightViews{
    for (NSInteger i = 0;i< _row ;i++ ) {
        CGFloat height = CGRectGetHeight(_chartScrollView.frame);
        CGFloat jiange = (height - _row * 15) / (_row - 1);
        CGRect frame = CGRectMake(CGRectGetWidth(self.frame) - titleWOfY + 5, height - 15*(i + 1) - jiange * i , titleWOfY - 5, 15);
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:frame];
        leftLabel.font = [UIFont systemFontOfSize:10.0f];
        leftLabel.textColor = [UIColor colorWithHexString:@"0x999999"];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        leftLabel.text = [NSString stringWithFormat:@"%.0f",_rightJiange * i];
        [self addSubview:leftLabel];
    }
}

-(void)addBottomViewsWith:(UIView *)View{
    NSArray *bottomArr;
    if (View == self.chartScrollView) {
        bottomArr = _dataArrOfX;
        
    }else{
    }
}

-(void)TopBtnAction:(UIButton *)sender{
    for (UIButton*btn in _leftBtnArr) {
        if (sender.tag == btn.tag) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
}

#define mark - 点击屏幕事件
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//}
-(void)viewClick:(id)sender{
    if (!_isSelect) return;
    [self colorConversion];
    CGPoint point;
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        point = [sender locationInView:self];
        self.lastValue = [NSValue valueWithCGPoint:point];
        point.x -= titleWOfY;
    }else{
        NSValue * value = sender;
        point = value.CGPointValue;
        self.lastValue = [NSValue valueWithCGPoint:point];
        point.x -= titleWOfY;
    }
    CGFloat xMargin = CGRectGetWidth(self.chartScrollView.frame) / (_xRow - 1);
    if (point.x > xMargin / 2 && point.x < CGRectGetMaxX(self.chartScrollView.frame) && point.y > CGRectGetMinY(self.chartScrollView.frame) && point.y < CGRectGetMaxY(self.chartScrollView.frame)) {
        point.x = point.x + self.chartScrollView.contentOffset.x;
        point.y = point.y + self.chartScrollView.contentOffset.y;
        NSInteger index = point.x / xMargin - 1;
        float indexF = point.x - xMargin * (index + 1);
        if (indexF>xMargin / 2) {
            index = index + 1;
        }
        self.selectTag = index;
        [self drawOtherLin:index AndPoint:point];
        return;
    }
    if (point.x > xMargin / 2 && point.x < CGRectGetMaxX(self.xAxiCollectionView.frame) && point.y > CGRectGetMinY(self.xAxiCollectionView.frame) && point.y < CGRectGetMaxY(self.xAxiCollectionView.frame)) {
        point.x = point.x + self.xAxiCollectionView.contentOffset.x;
        point.y = point.y + self.xAxiCollectionView.contentOffset.y;
        NSInteger index = point.x / xMargin - 1;
        float indexF = point.x - xMargin * (index + 1);
        if (indexF>xMargin / 2) {
            index = index + 1;
        }
        [self drawOtherLin:index AndPoint:point];
        return;
    }
}
//点击之后画出重点线以及数值
-(void)drawOtherLin:(NSInteger)index AndPoint:(CGPoint)touchpoint{
    if(index >= self.dataArrOfX.count || index<0 || self.dataArrOfX.count == 0){
        return ;
    }
    [self.paopaoView removeFromSuperview];
    self.paopaoView = nil;
    if (self.showSelect && self.selectIndex== index) {
        self.lastIndex = 0;
        self.selectTag = -1;
        self.selectView.hidden = YES;
        self.paopaoView.hidden = YES;
        self.indexPathIndex = -1;
        for (UIView *view in self.charCircleViewArr) {
            [view removeFromSuperview];
        }
        self.showSelect = NO;
        [_xAxiCollectionView reloadData];
        return;
    }
    self.lastIndex = index + 1;
    self.showSelect = YES;
    self.selectIndex = index;
    self.indexPathIndex = index;
    [_xAxiCollectionView reloadData];
    [self setPaopaoUI:index];
}

-(void)setPaopaoUI:(NSInteger)index{
    CGFloat xMargin = CGRectGetWidth(self.chartScrollView.frame) / (_xRow - 1);
    [self.chartScrollView bringSubviewToFront:self.selectView];
    self.selectView.hidden = NO;
    self.selectView.backgroundColor = _markColor;
    if (xMargin*index + self.selectView.frame.size.width > self.chartScrollView.contentSize.width) {
        self.selectView.frame = CGRectMake(xMargin*index+xMargin, 0, self.selectView.frame.size.width, self.selectView.frame.size.height);
    }else{
        self.selectView.frame = CGRectMake(xMargin*index+xMargin, 0, self.selectView.frame.size.width, self.selectView.frame.size.height);
    }
    [self.chartScrollView bringSubviewToFront:self.paopaoView];
    self.paopaoView.hidden = NO;
    [self.chartScrollView bringSubviewToFront:self.selectView];
    NSMutableArray *dataArr = [NSMutableArray new];
    if (_chartViewStyle == LHYChartViewLeftRightLine) {
        if (self.paopaoDataArray.count > 0){
            [self.paopaoDataArray enumerateObjectsUsingBlock:^(NSArray<NSArray *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (index < obj.count) {
                    [dataArr addObject:obj[index]];
                }
            }];
        }else{
            [self.leftDataArr enumerateObjectsUsingBlock:^(NSArray<NSArray *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (index < obj.count) {
                    [dataArr addObject:obj[index]];
                }
            }];
            [self.rightDataArr enumerateObjectsUsingBlock:^(NSArray<NSArray *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (index < obj.count) {
                    [dataArr addObject:obj[index]];
                }
            }];
        }
    }else{
        if (self.paopaoDataArray.count > 0){
            [self.paopaoDataArray enumerateObjectsUsingBlock:^(NSArray<NSArray *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (index < obj.count) {
                    [dataArr addObject:obj[index]];
                }
            }];
        }else{
            [self.leftDataArr enumerateObjectsUsingBlock:^(NSArray<NSArray *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (index < obj.count) {
                    [dataArr addObject:obj[index]];
                }
            }];
        }
    }
    NSMutableArray *colorArr = [NSMutableArray array];
    for (int i = 0; i < self.leftColorStrArr.count; i++) {
        [colorArr addObject:self.leftColorStrArr[i]];
    }
    for (int i = 0; i < self.rightColorStrArr.count ; i++) {
        [colorArr addObject:self.rightColorStrArr[i]];
    }
    CGSize size = [LHYLinesPaoPaoView getWidthAndHeight:dataArr];
    float paopao_x = index * xMargin + xMargin - size.width * 0.5;
    if (self.paopaoTitleArray.count == 0) {
        size.height -= 17;
    }
    size.height += 13;
    if (paopao_x < 0) {
        paopao_x = 0;
    }else if (paopao_x > self.chartScrollView.contentSize.width - size.width && paopao_x > self.chartScrollView.frame.size.width - size.width) {
        paopao_x = self.chartScrollView.contentSize.width - size.width;
    }
    self.paopaoView.frame = CGRectMake(paopao_x, self.paopaoView.frame.origin.y, size.width, size.height + 5);
    self.paopaoView.margin = xMargin;
    if (paopao_x == 0 && size.width > xMargin) {
        self.paopaoView.beyondLeft = YES;
    }else if ((index + 1) * xMargin + size.width * 0.5 > self.chartScrollView.contentSize.width && size.width > _Xmargin && (index + 1) * xMargin + size.width * 0.5 > self.chartScrollView.frame.size.width){
        self.paopaoView.beyondRight = YES;
    }
    NSArray * colorArray = _paopaoDataColors ? _paopaoDataColors : colorArr;
    UIColor* titleColor = _paopaoTitleColor ? _paopaoTitleColor : [UIColor colorWithHexString:@"0x999999"];
    self.paopaoView.chartContentWidth = self.chartScrollView.contentSize.width;
    NSMutableArray * colorMarray = [NSMutableArray array];
    if (colorArray.count != dataArr.count) {
        for (int s = 0; s < self.leftDataArr.count; s++) {
            NSArray * arr = self.leftDataArr[s];
            if (arr.count > index) {
                [colorMarray addObject:colorArr[s]];
            }
        }
    }else{
        [colorMarray addObjectsFromArray:colorArray];
    }
    if (self.paopaoTitleArray.count > 0) {
        NSArray * pointArray = self.leftPointArr[0];
        for (NSArray * arr in self.leftPointArr) {
            if (index < arr.count) {
                pointArray = arr;
                break;
            }
        }
        CGPoint showPoint = [pointArray[index] CGPointValue];
        self.paopaoView.pointX = showPoint.x;
        [self.paopaoView show:dataArr and:self.paopaoTitleArray[index] andTitleColor:titleColor colorArr:colorMarray];
    }else{
        NSArray * pointArray = self.leftPointArr[0];
        for (NSArray * arr in self.leftPointArr) {
            if (index < arr.count) {
                pointArray = arr;
                break;
            }
        }
        CGPoint showPoint = [pointArray[index] CGPointValue];
        self.paopaoView.pointX = showPoint.x;
        [self.paopaoView show:dataArr and:@"" andTitleColor:titleColor colorArr:colorMarray];
    }
    [self addCircle:index];
}
//圆圈
- (void)addCircle:(NSInteger)index{
    for (UIView *circleView in self.charCircleViewArr) {
        [circleView removeFromSuperview];
    }
    NSMutableArray * leftColorArr = [NSMutableArray array];
    switch (_chartViewStyle) {
        case 0:
            for (int i = 0; i < _leftColorStrArr.count; i++) {
                [leftColorArr addObject:_leftColorStrArr[i]];
            }
            [self.charCircleViewArr removeAllObjects];
            [self drawCircle:index arr:self.leftPointArr color:leftColorArr];
            break;
        case 1:
            for (int i = 0; i < _leftColorStrArr.count; i++) {
                [leftColorArr addObject:_leftColorStrArr[i]];
            }
            [self.charCircleViewArr removeAllObjects];
            [self drawCircle:index arr:self.leftPointArr color:leftColorArr];
            break;
        case 2:
            for (int i = 0; i < _leftColorStrArr.count; i++) {
                [leftColorArr addObject:_leftColorStrArr[i]];
            }
            for (int i = 0; i < _rightColorStrArr.count; i++) {
                [leftColorArr addObject:_rightColorStrArr[i]];
            }
            [self.charCircleViewArr removeAllObjects];
            [self drawCircle:index arr:self.leftPointArr color:leftColorArr];
            break;
        default:
            break;
    }
}

- (void)drawCircle:(NSInteger)index arr:(NSArray *)pointArr color:(NSArray<UIColor *> *)colors{
    CGFloat pointY = 0;
    for (int i = 0; i<pointArr.count; i++) {
        NSArray *arr = pointArr[i];
        if (arr.count > index){
            CGPoint point = [arr[index] CGPointValue];
            UIView * circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KCircleRadius1*2, KCircleRadius1*2)];
            circleView.center = point;
            if (i == 0) {
                pointY = point.y;
            }
            if (self.isFloating) {
                if (point.y < pointY) {
                    pointY = point.y;
                }
            }else if(i == 0){
                [self.paopaoView drawBoxWithDirection:directionTop];
            }
            circleView.backgroundColor = self.isShowCircleOutWhite ? colors[i] : [UIColor whiteColor];
            circleView.layer.cornerRadius = KCircleRadius1;
            circleView.layer.borderColor = self.isShowCircleOutWhite ? [UIColor whiteColor].CGColor : colors[i].CGColor;
            circleView.layer.borderWidth = 2;
            circleView.layer.masksToBounds = YES;
            self.circleView = circleView;
            [self.chartScrollView addSubview:circleView];
            [self.charCircleViewArr addObject:circleView];
        }else{
            [self.paopaoView drawBoxWithDirection:directionTop];
        }
    }
    if (self.isFloating) {
        if (pointY - CGRectGetHeight(self.paopaoView.frame) - KCircleRadius >= 0) {
            CGRect frame = self.paopaoView.frame;
            frame.origin.y = pointY - CGRectGetHeight(self.paopaoView.frame) - KCircleRadius;
            [self.paopaoView setFrame:frame];
            [self.paopaoView drawBoxWithDirection:directionTop];
            
        }else{
            CGRect frame = self.paopaoView.frame;
            frame.origin.y = pointY + KCircleRadius;
            [self.paopaoView setFrame:frame];
            [self.paopaoView drawBoxWithDirection:directionBottom];
        }
    }
    [self.chartScrollView bringSubviewToFront:self.paopaoView];
}

- (void)drawCircleArr:(NSArray *)pointArr color:(NSArray *)colors{
    for (int i = 0; i<pointArr.count; i++) {
        NSArray *arr = pointArr[i];
        for (int o = 0; o <arr.count; o++) {
            CGPoint point = [arr[o] CGPointValue];
            UIView * circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KCircleRadius*2, KCircleRadius*2)];
            circleView.center = point;
            UIColor * color = colors[i];
            circleView.backgroundColor = color;
            circleView.layer.cornerRadius = KCircleRadius;
            circleView.layer.borderColor = [UIColor whiteColor].CGColor;
            circleView.layer.borderWidth = 1;
            circleView.layer.masksToBounds = YES;
            [self.chartScrollView addSubview:circleView];
        }
    }
    [self.chartScrollView bringSubviewToFront:self.circleView];
    [self.chartScrollView bringSubviewToFront:self.paopaoView];
}

-(void)addLines1With:(UIView *)view{
    CAShapeLayer * dashLayer = [CAShapeLayer layer];
    _dashLayer = dashLayer;
    dashLayer.strokeColor = self.borderLineColor.CGColor;
    dashLayer.fillColor = self.borderTriangleColor.CGColor;
    // 默认设置路径宽度为0，使其在起始状态下不显示
    dashLayer.lineWidth = 0.5;
    UIBezierPath * path = [[UIBezierPath alloc]init];
    path.lineWidth = 1.0;
    [path moveToPoint:CGPointMake(titleWOfY, CGRectGetHeight(_chartScrollView.frame))];
    [path addLineToPoint:CGPointMake(titleWOfY,3)];
    [path addLineToPoint:CGPointMake(titleWOfY + 3,3)];
    [path addLineToPoint:CGPointMake(titleWOfY,0)];
    [path addLineToPoint:CGPointMake(titleWOfY - 3,3)];
    [path addLineToPoint:CGPointMake(titleWOfY,3)];
    [path moveToPoint:CGPointMake(titleWOfY, CGRectGetHeight(_chartScrollView.frame))];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(_chartScrollView.frame),CGRectGetHeight(_chartScrollView.frame))];
    if (_chartViewStyle == LHYChartViewLeftRightLine) {
        [path moveToPoint:CGPointMake(CGRectGetMaxX(_chartScrollView.frame) + 1, CGRectGetHeight(_chartScrollView.frame))];
        [path addLineToPoint:CGPointMake(CGRectGetMaxX(_chartScrollView.frame) + 1,0)];
    }else{
        [path addLineToPoint:CGPointMake(CGRectGetMaxX(_chartScrollView.frame),CGRectGetHeight(_chartScrollView.frame) - 3)];
        [path addLineToPoint:CGPointMake(CGRectGetMaxX(_chartScrollView.frame) + 3,CGRectGetHeight(_chartScrollView.frame))];
        [path addLineToPoint:CGPointMake(CGRectGetMaxX(_chartScrollView.frame),CGRectGetHeight(_chartScrollView.frame) + 3)];
        [path addLineToPoint:CGPointMake(CGRectGetMaxX(_chartScrollView.frame),CGRectGetHeight(_chartScrollView.frame))];
    }
    dashLayer.path = path.CGPath;
    [self.layer addSublayer:dashLayer];
}
@end
