//
//  ViewController.m
//  chartTest
//
//  Created by lihaiyang on 2018/10/23.
//  Copyright © 2018 lihaiyang. All rights reserved.
//

#import "ViewController.h"
#import "LHYChartView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addFirstChartView];
    [self addSecondChartView];
}

-(void)addFirstChartView{
    LHYChartView *incomeChartLineView = [[LHYChartView alloc]initWithFrame:CGRectMake(20, 50, [UIScreen mainScreen].bounds.size.width - 40, 300)];
    //是否默认选中第一个
    incomeChartLineView.isShowFirstPaoPao = YES;
    //是否有网格
    incomeChartLineView.isGrid = YES;
    //是否可以浮动
    incomeChartLineView.isFloating = NO;
    //显示多少行
    incomeChartLineView.row = 6;
    //显示多少列
    incomeChartLineView.xRow = 6;
    //设置X轴坐标字体大小
    incomeChartLineView.x_Font = [UIFont systemFontOfSize:10];
    //设置X轴坐标字体颜色
    incomeChartLineView.x_Color = [UIColor colorWithHexString:@"#999999"];
    //设置Y轴坐标字体大小
    incomeChartLineView.y_Font = [UIFont systemFontOfSize:10];
    //设置Y轴坐标字体颜色
    incomeChartLineView.y_Color = [UIColor colorWithHexString:@"#999999"];
    //设置背景颜色
    incomeChartLineView.backgroundColor = [UIColor whiteColor];
    //边框标线颜色
    incomeChartLineView.borderLineColor = [UIColor colorWithHexString:@"#999999"];
    //中间标线颜色
    incomeChartLineView.middleLineColor = [UIColor colorWithHexString:@"#cbcbcb" andAlpha:0.5];
    //边框三角颜色
    incomeChartLineView.borderTriangleColor = [UIColor colorWithHexString:@"#999999"];
    //设置泡泡背景颜色
    incomeChartLineView.paopaoBackGroundColor = [UIColor colorWithHexString:@"#000000" andAlpha:0.85];
    incomeChartLineView.markColor = [UIColor colorWithHexString:@"#333333"];
    //设置泡泡的标题颜色
    incomeChartLineView.paopaoTitleColor = [UIColor whiteColor];
    //设置折线样式
    incomeChartLineView.chartViewStyle = LHYChartViewMoreClickLine;
    //设置图层效果
    incomeChartLineView.chartLayerStyle = LHYChartProjection;
    //设置折现效果
    incomeChartLineView.lineLayerStyle = LHYLineLayerNone;
    incomeChartLineView.paopaoBackGroundColor = [UIColor colorWithHexString:@"#111111" andAlpha:0.8];
    //渐变效果的颜色组
    //渐变开始比例
    incomeChartLineView.proportion = 0.5;
    //折线图是否从零点开始画
    incomeChartLineView.hiddenZreo = YES;
    //设置颜色
    incomeChartLineView.leftColorStrArr = @[@"#6dd89c",@"#00a1eb",@"#bc69e0",@"#385af0"];
    //是否显示Y轴零位
    incomeChartLineView.isShowZero = YES;
    //折线图数据
    incomeChartLineView.leftDataArr = @[@[@"-9999.4",@"30907",@"32010",@"33450",@"30069",@"31574",@"30692",@"33156",@"29808",@"31846",@"29772",@"29630"],@[@"46175",@"44915",@"36228",@"50473",@"28811",@"11876",@"23213",@"26847",@"27905",@"9562",@"34263",@"25459"],@[@"20549",@"15981",@"23375",@"20516",@"19208",@"15121",@"13776",@"16282",@"30748",@"26531",@"31298",@"33183"],@[@"11053",@"25811"]];
    //底部日期
    incomeChartLineView.dataArrOfX = @[@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月",@"1月",@"2月",@"3月"];
    //泡泡标题
    incomeChartLineView.paopaoTitleArray = @[@"2018-04",@"2018-05",@"2018-06",@"2018-07",@"2018-08",@"2018-09",@"2018-10",@"2018-11",@"2018-12",@"2019-01",@"2019-02",@"2019-03"];
    //泡泡数据
    incomeChartLineView.paopaoDataArray = @[@[@"-10,000元m²",@"30,907元m²",@"32,010元m²",@"33,450元m²",@"30,069元m²",@"31,574元m²",@"30,692元m²",@"33,156元m²",@"29,808元m²",@"31,846元m²",@"29,772元m²",@"29,630元m²"],@[@"46,175元m²",@"44,915元m²",@"36,228元m²",@"50,473元m²",@"28,811元m²",@"11,876元m²",@"23,213元m²",@"26,847元m²",@"27,905元m²",@"9,562元m²",@"34,263元m²",@"25,459元m²"],@[@"20,549元m²",@"15,981元m²",@"23,375元m²",@"20,516元m²",@"19,208元m²",@"15,121元m²",@"13,776元m²",@"16,282元m²",@"30,748元m²",@"26,531元m²",@"31,298元m²",@"33,183元m²"],@[@"11,053元m²",@"25,811元m²"]];
    //开始画图
    [incomeChartLineView show];
    [self.view addSubview:incomeChartLineView];
}

-(void)addSecondChartView{
    LHYChartView *incomeChartLineView = [[LHYChartView alloc]initWithFrame:CGRectMake(20, 350, [UIScreen mainScreen].bounds.size.width - 40, 300)];
    //是否默认选中第一个
    incomeChartLineView.isShowFirstPaoPao = YES;
    //是否有网格
    incomeChartLineView.isGrid = YES;
    //是否可以浮动
    incomeChartLineView.isFloating = NO;
    //显示多少行
    incomeChartLineView.row = 6;
    //显示多少列
    incomeChartLineView.xRow = 6;
    //设置X轴坐标字体大小
    incomeChartLineView.x_Font = [UIFont systemFontOfSize:10];
    //设置X轴坐标字体颜色
    incomeChartLineView.x_Color = [UIColor colorWithHexString:@"#999999"];
    //设置Y轴坐标字体大小
    incomeChartLineView.y_Font = [UIFont systemFontOfSize:10];
    //设置Y轴坐标字体颜色
    incomeChartLineView.y_Color = [UIColor colorWithHexString:@"#999999"];
    //设置背景颜色
    incomeChartLineView.backgroundColor = [UIColor whiteColor];
    //边框标线颜色
    incomeChartLineView.borderLineColor = [UIColor colorWithHexString:@"#999999"];
    //中间标线颜色
    incomeChartLineView.middleLineColor = [UIColor colorWithHexString:@"#cbcbcb" andAlpha:0.5];
    //边框三角颜色
    incomeChartLineView.borderTriangleColor = [UIColor colorWithHexString:@"#999999"];
    //设置泡泡背景颜色
    incomeChartLineView.paopaoBackGroundColor = [UIColor colorWithHexString:@"#000000" andAlpha:0.85];
    incomeChartLineView.markColor = [UIColor colorWithHexString:@"#333333"];
    //设置泡泡的标题颜色
    incomeChartLineView.paopaoTitleColor = [UIColor whiteColor];
    //设置折线样式
    incomeChartLineView.chartViewStyle = LHYChartViewMoreClickLine;
    //设置图层效果
    incomeChartLineView.chartLayerStyle = LHYChartGradient;
    //设置折现效果
    incomeChartLineView.lineLayerStyle = LHYLineLayerNone;
    incomeChartLineView.paopaoBackGroundColor = [UIColor colorWithHexString:@"#111111" andAlpha:0.8];
    //渐变效果的颜色组
    //渐变开始比例
    incomeChartLineView.proportion = 0.5;
    //折线图是否从零点开始画
    incomeChartLineView.hiddenZreo = YES;
    //折线为0的时候，不偏移
    incomeChartLineView.showChartOffset = NO;
    //设置颜色
    incomeChartLineView.leftColorStrArr = @[@"#6dd89c",@"#00a1eb",@"#bc69e0",@"#385af0"];
    //显示折线为直线
    incomeChartLineView.isShowBezier = NO;
    //折线图数据
    incomeChartLineView.leftDataArr = @[@[@"25000",@"30907",@"32010",@"33450",@"30069",@"31574",@"30692",@"33156",@"29808",@"31846",@"29772",@"29630"],@[@"46175",@"44915",@"36228",@"50473",@"28811",@"11876",@"23213",@"26847",@"27905",@"9562",@"34263",@"25459"],@[@"20549",@"15981",@"23375",@"20516",@"19208",@"15121",@"13776",@"16282",@"30748",@"26531",@"31298",@"33183"],@[@"11053",@"25811"]];
    //底部日期
    incomeChartLineView.dataArrOfX = @[@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月",@"1月",@"2月",@"3月"];
    //泡泡标题
    incomeChartLineView.paopaoTitleArray = @[@"2018-04",@"2018-05",@"2018-06",@"2018-07",@"2018-08",@"2018-09",@"2018-10",@"2018-11",@"2018-12",@"2019-01",@"2019-02",@"2019-03"];
    //泡泡数据
    incomeChartLineView.paopaoDataArray = @[@[@"25,000元m²",@"30,907元m²",@"32,010元m²",@"33,450元m²",@"30,069元m²",@"31,574元m²",@"30,692元m²",@"33,156元m²",@"29,808元m²",@"31,846元m²",@"29,772元m²",@"29,630元m²"],@[@"46,175元m²",@"44,915元m²",@"36,228元m²",@"50,473元m²",@"28,811元m²",@"11,876元m²",@"23,213元m²",@"26,847元m²",@"27,905元m²",@"9,562元m²",@"34,263元m²",@"25,459元m²"],@[@"20,549元m²",@"15,981元m²",@"23,375元m²",@"20,516元m²",@"19,208元m²",@"15,121元m²",@"13,776元m²",@"16,282元m²",@"30,748元m²",@"26,531元m²",@"31,298元m²",@"33,183元m²"],@[@"11,053元m²",@"25,811元m²"]];
    //开始画图
    [incomeChartLineView show];
    [self.view addSubview:incomeChartLineView];
}
@end
