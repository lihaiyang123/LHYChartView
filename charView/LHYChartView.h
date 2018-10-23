//
//  LRSChartView.h
//  LRSChartView
//
//  Created by lihaiyang on 2018/10/23.
//  Copyright © 2018 lihaiyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NS_ENUM(...) CF_ENUM(__VA_ARGS__)


typedef NS_ENUM(NSInteger,LRSChartViewStyle){
    LRSChartViewMoreNoClickLine, //多条折现不可以点击 暂时没做
    LRSChartViewMoreClickLine,  //多条折现可以点击
    LRSChartViewLeftRightLine,  //左右两种不同数据
};

typedef NS_ENUM(NSInteger,LRSChartLayerStyle){
    LRSChartNone,   //没有
    LRSChartGradient, //渐变
    LRSChartProjection,  //投影
};

typedef NS_ENUM(NSInteger,LRSLineLayerStyle){
    LRSLineLayerNone,   //没有
    LRSLineLayerGradient, //渐变
};

typedef NS_ENUM(NSInteger,LRSUnitStyle){
    LRSUnitGe,   //个
    LRSUnitThousand,   //千
    LRSUnitWan, //万
    LRSUnitMillion, //亿
    LRSUnitMoneyDefault,
    LRSUnitMoneyPercentage,//百分比
    LRSUnitDefault  //默认自适应
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
@property (nonatomic,assign)LRSChartViewStyle chartViewStyle;
//点否可以点击弹出泡泡
@property (nonatomic,assign) BOOL isSelect;
//气泡是否根据折线位置可以浮动，默认不可以
@property (nonatomic,assign)BOOL isFloating;
//图层样式 默认没有
@property (nonatomic,assign) LRSChartLayerStyle chartLayerStyle;
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
@property (nonatomic, assign) LRSLineLayerStyle lineLayerStyle;
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
@property (nonatomic,assign) LRSUnitStyle unitStyle;
//泡泡标题组，如果不传，将默认不显示titile。
@property (nonatomic, strong) NSArray *paopaoTitleArray;
//是否显示网格
//@property (nonatomic,assign) BOOL isGrid;
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
//选中状态的圆，外圆是否是白色
@property (nonatomic,assign) BOOL isShowCircleOutWhite;
-(void)show;
//初始化
-(void)initNew;
@end
