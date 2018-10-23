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

@property (nonatomic,strong) LHYChartView * incomeChartLineView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [self colorWithHexString:@"1c1d20"];
    NSArray *tempDataArrOfY = @[@[@"400",@"600",@"500",@"800",@"600",@"700",@"500",@"500",@"500",@"500"],@[@"300",@"500",@"400",@"700",@"500",@"600",@"400",@"400",@"400",@"400"],@[@"500",@"800",@"300",@"600",@"400",@"500",@"300",@"300",@"300",@"300"]];
    
    _incomeChartLineView = [[LHYChartView alloc]initWithFrame:CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 40, 300)];
    //是否默认显示第一个点
    _incomeChartLineView.isShowFirstPaoPao = YES;
    //是否可以浮动
    _incomeChartLineView.isFloating = YES;
    //设置X轴坐标字体大小
    _incomeChartLineView.x_Font = [UIFont systemFontOfSize:10];
    //设置X轴坐标字体颜色
    _incomeChartLineView.x_Color = [self colorWithHexString:@"0x999999"];
    //设置Y轴坐标字体大小
    _incomeChartLineView.y_Font = [UIFont systemFontOfSize:10];
    //设置Y轴坐标字体颜色
    _incomeChartLineView.y_Color = [self colorWithHexString:@"0x999999"];
    //设置X轴数据间隔
    _incomeChartLineView.Xmargin = 50;
    //设置背景颜色
    _incomeChartLineView.backgroundColor = [UIColor clearColor];
    //是否根据折线数据浮动泡泡
    //_incomeChartLineView.isFloating = YES;
    //折线图数据
    _incomeChartLineView.leftDataArr = tempDataArrOfY;
    //折线图所有颜色
    _incomeChartLineView.leftColorStrArr = @[@"#febf83",@"#53d2f8",@"#7211df"];
    //设置折线样式
    _incomeChartLineView.chartViewStyle = LRSChartViewMoreClickLine;
    //设置图层效果
    _incomeChartLineView.chartLayerStyle = LRSChartGradient;
    //设置折现效果
    _incomeChartLineView.lineLayerStyle = LRSLineLayerNone;
    //泡泡背景颜色
    _incomeChartLineView.paopaoBackGroundColor = [self colorWithHexString:@"00b6b0"];
    //渐变效果的颜色组
    _incomeChartLineView.colors = @[@[[self colorWithHexString:@"#febf83"],[UIColor greenColor]],@[[self colorWithHexString:@"#53d2f8"],[UIColor blueColor]],@[[self colorWithHexString:@"#7211df"],[UIColor redColor]]];
    //渐变开始比例
    _incomeChartLineView.proportion = 0.5;
    //底部日期
    _incomeChartLineView.dataArrOfX = @[@"01-13",@"01-14",@"01-15",@"01-16",@"01-17",@"01-18",@"01-19",@"01-20",@"01-21",@"01-22"];
    //开始画图
    [_incomeChartLineView show];
    [self.view addSubview:_incomeChartLineView];
}

-(UIColor*)colorWithHexString:(NSString*)stringToConvert{
    if([stringToConvert hasPrefix:@"#"])
    {
        stringToConvert = [stringToConvert substringFromIndex:1];
    }
    NSScanner*scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if(![scanner scanHexInt:&hexNum])
    {
        return nil;
    }
    return [self colorWithRGBHex:hexNum];
}

- (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}
@end
