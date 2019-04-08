//
//  LHYChartView.h
//  LHYChartView
//
//  Created by lreson on 16/7/21.
//  Copyright © 2016年 lreson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+expanded.h"
#import "NSString+Extension.h"
#define NS_ENUM(...) CF_ENUM(__VA_ARGS__)


typedef NS_ENUM(NSInteger,LHYChartViewStyle){
    LHYChartViewMoreNoClickLine, //多条折现不可以点击 暂时没做
    LHYChartViewMoreClickLine,  //多条折现可以点击
    LHYChartViewLeftRightLine,  //左右两种不同数据
};

typedef NS_ENUM(NSInteger,LHYChartLayerStyle){
    LHYChartNone,   //没有
    LHYChartGradient, //渐变
    LHYChartProjection,  //投影
};

typedef NS_ENUM(NSInteger,LHYLineLayerStyle){
    LHYLineLayerNone,   //没有
    LHYLineLayerGradient, //渐变
};

typedef NS_ENUM(NSInteger,LHYUnitStyle){
    LHYUnitGe,   //个
    LHYUnitThousand,   //千
    LHYUnitWan, //万
    LHYUnitMillion, //亿
    LHYUnitMoneyDefault,
    LHYUnitMoneyPercentage,//百分比，最大100%
    LHYUnitMoneyPercentageDefault,//百分比，有多大显示多大
    LHYUnitDefault  //默认自适应
};

@interface LHYChartView : UIView
/** X轴坐标数据 */
@property (nonatomic, strong) NSArray *dataArrOfX;
/** Y轴左边数据 */
@property (nonatomic,strong) NSArray *leftDataArr;
/** Y轴右边数据 没有不用传递 */
@property (nonatomic,strong) NSArray *rightDataArr;
/** X轴标题 */
@property (nonatomic, strong) UILabel *titleOfX;
/** Y轴标题 */
@property (nonatomic, strong) UILabel *titleOfY;
//线条宽度，默认为1
@property (nonatomic, assign) CGFloat lineWidth;
// 计算精度,10,100,1000,默认是1
@property (nonatomic,assign)NSInteger precisionScale;
//折线图样式 默认不可点击
@property (nonatomic,assign)LHYChartViewStyle chartViewStyle;
//点否可以点击弹出泡泡
@property (nonatomic,assign) BOOL isSelect;
//气泡是否根据折线位置可以浮动，默认不可以
@property (nonatomic,assign)BOOL isFloating;
//图层样式 默认没有
@property (nonatomic,assign) LHYChartLayerStyle chartLayerStyle;
//左侧标注折线颜色组可传二进制字符串，可传UIColor
@property (nonatomic, strong) NSArray *leftColorStrArr;
//右侧标注折线颜色组
@property (nonatomic, strong) NSArray *rightColorStrArr;
//X轴坐标字体大小
@property (nonatomic, strong) UIFont *x_Font;
//X轴坐标选中字体大小
@property (nonatomic, strong) UIFont *x_Select_Font;
//X轴坐标选中字体颜色
@property (nonatomic, strong) UIColor *x_Select_Color;
//X轴坐标字体颜色
@property (nonatomic, strong) UIColor *x_Color;
//Y轴坐标字体大小
@property (nonatomic, strong) UIFont *y_Font;
//Y轴坐标字体颜色
@property (nonatomic, strong) UIColor *y_Color;
//X轴间隔大小
@property (nonatomic, assign) CGFloat Xmargin;
//折现样式  默认没有
@property (nonatomic, assign) LHYLineLayerStyle lineLayerStyle;
//折现渐变颜色组
@property (nonatomic, strong) NSArray * colors;
//渐变比例 0-1  初始化0.5
@property (nonatomic, assign) CGFloat proportion;
//显示多少行 默认2行
@property (nonatomic,assign)NSInteger row;
//是否显示所有点 默认不显示
@property (nonatomic, assign)BOOL isShow;
//设置泡泡的背景色
@property (nonatomic, strong) UIColor *paopaoBackGroundColor;
//设置标线颜色
@property (nonatomic,strong) UIColor * markColor;
//泡泡的标题颜色
@property (nonatomic,strong) UIColor * paopaoTitleColor;
//泡泡的数据颜色组
@property (nonatomic,strong) NSArray * paopaoDataColors;
//泡泡的显示数据组
@property (nonatomic,strong) NSArray * paopaoDataArray;
//小数点千位还是万位，没有单位。如不设置此参数，默认大于1000以k表示，如1500，显示为1.5k。
@property (nonatomic,assign) LHYUnitStyle unitStyle;
//泡泡标题组，如果不传，将默认不显示titile。
@property (nonatomic, strong) NSArray *paopaoTitleArray;
//是否显示网格
@property (nonatomic,assign) BOOL isGrid;
//x坐标初始显示多少列
@property (nonatomic,assign) NSInteger xRow;
//边框标线颜色
@property (nonatomic,strong) UIColor * borderLineColor;
//中间标线颜色
@property (nonatomic,strong) UIColor * middleLineColor;
//边框三角颜色
@property (nonatomic,strong) UIColor * borderTriangleColor;
//渐变比例组
@property (nonatomic,strong) NSArray * locations;
//是否显示Y坐标轴 默认为YES显示
@property (nonatomic,assign) BOOL isShowYtext;
//是否显示第一个泡泡，默认为NO不显示。
@property (nonatomic,assign) BOOL isShowFirstPaoPao;
//是否显示最后一个泡泡，默认为NO不显示。
@property (nonatomic,assign) BOOL isShowLastPaoPao;
//选中状态的圆，外圆是否是白色
@property (nonatomic,assign) BOOL isShowCircleOutWhite;
//折线图是否从零点开始画  YES为从1点开始画  NO为从零点开始画  默认为NO
@property (nonatomic,assign) BOOL hiddenZreo;
//最大值
@property (nonatomic,assign) CGFloat max;
//最小值 不传的话，默认从数据中获取最小值，如果数据中最小值大于0，则为0。  传的话，以传入的最小值为准。
@property (nonatomic,strong) NSString *min;
//是否显示Y轴的零位   YES显示  NO不显示
@property (nonatomic,assign) BOOL isShowZero;
/**
 Y轴单位
 */
@property (nonatomic,strong) NSString * unitName;

/**
 折线为0的时候，是否向上偏移，默认偏移。不偏移传NO
 */
@property (nonatomic,assign) BOOL showChartOffset;
-(void)show;
//初始化
-(void)initNew;
@end
