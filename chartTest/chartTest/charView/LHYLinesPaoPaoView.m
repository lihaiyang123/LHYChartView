//
//  YJYLinesPaoPaoView.m
//  YJYLinesView
//
//  Created by lihaiyang on 2018/10/23.
//  Copyright © 2018 lihaiyang. All rights reserved.
//

#import "LHYLinesPaoPaoView.h"
#import "LinesSelectCell.h"
@interface LHYLinesPaoPaoView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *listTb;
@property (assign, nonatomic) CGFloat maxLeftTitleWidth;
@property (assign, nonatomic) CGFloat maxRightTitleWidth;
/** 遮罩 */
@property (nonatomic, strong) CAShapeLayer *maskLayer;
/** 路径 */
@property (nonatomic, strong) UIBezierPath *borderPath;
@end

@implementation LHYLinesPaoPaoView {
    
    NSArray *_dataArr;
    
    NSArray *_colorArr;
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _beyondLeft = NO;
        _beyondRight = NO;
        [self setUp];
    }
    return self;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    bgImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgImageView];
//    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.right.equalTo(self);
//    }];
    [self addSubview:self.listTb];
//    [self.listTb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.right.equalTo(self);
//    }];
}

-(void)setFrame:(CGRect)frame{
    super.frame = frame;
    [self.listTb setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
}

- (void)show:(NSArray *)dataArr and:(NSString *)title andTitleColor:(UIColor *)titleColor colorArr:(NSArray *)color {
    self.maxLeftTitleWidth = 0;
    NSMutableArray *titleArray = [NSMutableArray array];
    for (int i = 0; i < dataArr.count; i++) {
        id obj = dataArr[i];
        NSMutableArray * marr = [NSMutableArray array];
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *dataTitle = dataArr[i];
            float titleWidth= 0;
            titleWidth = [LHYLinesPaoPaoView measureSinglelineStringWidth:dataTitle andFont:[UIFont systemFontOfSize:13]];
            self.maxLeftTitleWidth = titleWidth + 5 > self.maxLeftTitleWidth ? titleWidth + 5 : self.maxLeftTitleWidth;
            [marr addObject:dataTitle];
        }else if([obj isKindOfClass:[NSArray class]]){
            NSArray * arr = obj;
            for (int o = 0 ; o < arr.count ; o++) {
                NSString * dataTitle = arr[o];
                float titleWidth= 0;
                if (o == 0) {
                    titleWidth = [LHYLinesPaoPaoView measureSinglelineStringWidth:dataTitle andFont:[UIFont systemFontOfSize:13]];
                    self.maxLeftTitleWidth = titleWidth + 5 > self.maxLeftTitleWidth ? titleWidth + 5 : self.maxLeftTitleWidth;
                }else{
                    titleWidth = [LHYLinesPaoPaoView measureSinglelineStringWidth:dataTitle andFont:[UIFont systemFontOfSize:13]];
                    self.maxRightTitleWidth = titleWidth + 5 > self.maxRightTitleWidth ? titleWidth + 5 : self.maxRightTitleWidth;
                }
                [marr addObject:dataTitle];
            }
        }
        [titleArray addObject:marr];
    }
    _dataArr = titleArray;
    _colorArr = color;
    if (title && title.length > 0) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 23.5)];
        UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 6.5, CGRectGetWidth(view.frame) - 20, 17)];
        titleLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        titleLab.textColor = [UIColor colorWithHexString:@"#d3d3d3"];
        titleLab.text = title;
        titleLab.textColor = titleColor;
        [view addSubview:titleLab];
        self.listTb.tableHeaderView = view;
    }else{
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 6.5)];
        self.listTb.tableHeaderView = view;
    }
    self.listTb.rowHeight = 17;
    [self.listTb reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LinesSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LinesSelectCell"];
    if (!cell) {
        cell = [[LinesSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LinesSelectCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftWidth = self.maxLeftTitleWidth;
        cell.rightWith = self.maxRightTitleWidth;
    }
    NSArray * arr = _dataArr[indexPath.row];
    if (arr.count == 1) {
        [cell showTitle:arr[0] andTitleColor:_colorArr[indexPath.row] andTitleFont:[UIFont fontWithName:@"Helvetica-Bold" size:13] andDescTile:nil andDescTileColor:nil andDescTitleFont:nil];
    }else if (arr.count == 2){
        [cell showTitle:arr[0] andTitleColor:_colorArr[indexPath.row] andTitleFont:[UIFont fontWithName:@"Helvetica-Bold" size:13] andDescTile:arr[1] andDescTileColor:_colorArr[indexPath.row] andDescTitleFont:[UIFont systemFontOfSize:12]];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 17;
}
+(CGSize)getWidthAndHeight:(NSArray *)dataArray{
    CGFloat width = 0;
    CGFloat height = 0;
    if (dataArray.count > 0) height = 17 * (dataArray.count + 1);
    for (int i = 0; i < dataArray.count; i++) {
        id obj = dataArray[i];
        if ([obj isKindOfClass:[NSString class]]) {
            float sizeWidth = [LHYLinesPaoPaoView measureSinglelineStringWidth:(NSString *)obj andFont:[UIFont systemFontOfSize:13]];
            sizeWidth = sizeWidth + 5 < 80 ? 80 : sizeWidth + 5;
            width = sizeWidth > width ? sizeWidth : width;
        }else if ([obj isKindOfClass:[NSArray class]]){
            NSArray * arr = obj;
            if (arr.count > 0) width += (arr.count - 1) * 10;
            for (int i = 0; i < arr.count; i++) {
                float sizeWidth = [LHYLinesPaoPaoView measureSinglelineStringWidth:(NSString *)obj andFont:[UIFont systemFontOfSize:13]];
                sizeWidth = sizeWidth + 5 < 80 ? 80 : sizeWidth + 5;
                width = sizeWidth > width ? sizeWidth : width;
            }
        }
    }
    if (width < 80) width = 80;
    width += 20;
    return CGSizeMake(width, height);
}
- (UITableView *)listTb {
    if (!_listTb) {
        _listTb = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) style:UITableViewStylePlain];
        _listTb.backgroundColor = [UIColor clearColor];
        _listTb.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTb.allowsSelection = NO;
        _listTb.bounces = NO;
        _listTb.dataSource = self;
        _listTb.delegate = self;
//        [self addSubview:_listTb];
    }
    return _listTb;
}
#pragma mark ---------画边框并填充颜色-------------
-(void)drawBoxWithDirection:(Direction)direction{
    UIView * view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = self.backgroundColor;
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:view];
    [self bringSubviewToFront:self.listTb];
    // 初始化遮罩
    self.maskLayer = [CAShapeLayer layer];
    // 设置遮罩
    [view.layer setMask:self.maskLayer];
    // 初始化路径
    self.borderPath = [UIBezierPath bezierPath];
    // 遮罩层frame
    self.maskLayer.frame = view.bounds;
    CGFloat pathX = 0;
    if (_beyondLeft) {
        pathX = _pointX;
    }else if (_beyondRight) {
        pathX = self.bounds.size.width - (self.chartContentWidth - _pointX);
    }else{
        pathX = self.bounds.size.width/2;
    }
    if (direction == directionTop) {
        CGRect frame = self.listTb.frame;
        frame.origin.y = 0;
        [self.listTb setFrame:frame];
//        [self.listTb mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(0);
//        }];
        // 设置path起点
        [self.borderPath moveToPoint:CGPointMake(5, 5)];
        // 左上角的圆角
        [self.borderPath addQuadCurveToPoint:CGPointMake(10, 0) controlPoint:CGPointMake(5, 0)];
        // 直线，到右上角
        [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width - 10, 0)];
        // 右上角的圆角
        [self.borderPath addQuadCurveToPoint:CGPointMake(self.bounds.size.width -5, 5) controlPoint:CGPointMake(self.bounds.size.width - 5, 0)];
        // 直线，到右下角
        [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width - 5, self.bounds.size.height - 10)];
        // 右下角的圆角
        [self.borderPath addQuadCurveToPoint:CGPointMake(self.bounds.size.width - 10, self.bounds.size.height - 5) controlPoint:CGPointMake(self.bounds.size.width - 5, self.bounds.size.height - 5)];
        // 底部的小三角形
        [self.borderPath addLineToPoint:CGPointMake(pathX + 5, self.bounds.size.height - 5)];
        [self.borderPath addLineToPoint:CGPointMake(pathX, self.bounds.size.height)];
        [self.borderPath addLineToPoint:CGPointMake(pathX - 5, self.bounds.size.height - 5)];
        
        // 直线，到左下角
        [self.borderPath addLineToPoint:CGPointMake(10, self.bounds.size.height - 5)];
        // 左下角的圆角
        [self.borderPath addQuadCurveToPoint:CGPointMake(5, self.bounds.size.height - 10) controlPoint:CGPointMake(5, self.bounds.size.height - 5)];
        // 直线，回到起点
        [self.borderPath addLineToPoint:CGPointMake(5, 5)];
    }else{
        CGRect frame = self.listTb.frame;
        frame.origin.y = 5;
        [self.listTb setFrame:frame];
//        [self.listTb mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(5);
//        }];
        // 设置path起点
        [self.borderPath moveToPoint:CGPointMake(5, 10)];
        // 左上角的圆角
        [self.borderPath addQuadCurveToPoint:CGPointMake(10, 5) controlPoint:CGPointMake(5, 5)];
        // 顶部的小三角形
        [self.borderPath addLineToPoint:CGPointMake(pathX - 5, 5)];
        [self.borderPath addLineToPoint:CGPointMake(pathX, 0)];
        [self.borderPath addLineToPoint:CGPointMake(pathX + 5, 5)];
        // 直线，到右上角
        [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width - 10, 5)];
        // 右上角的圆角
        [self.borderPath addQuadCurveToPoint:CGPointMake(self.bounds.size.width - 5, 10) controlPoint:CGPointMake(self.bounds.size.width - 5, 5)];
        // 直线，到右下角
        [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width - 5, self.bounds.size.height - 5)];
        // 右下角的圆角
        [self.borderPath addQuadCurveToPoint:CGPointMake(self.bounds.size.width - 10, self.bounds.size.height) controlPoint:CGPointMake(self.bounds.size.width - 5, self.bounds.size.height)];
        // 直线，到左下角
        [self.borderPath addLineToPoint:CGPointMake(10, self.bounds.size.height)];
        // 左下角的圆角
        [self.borderPath addQuadCurveToPoint:CGPointMake(5, self.bounds.size.height - 5) controlPoint:CGPointMake(5, self.bounds.size.height)];
        // 直线，回到起点
        [self.borderPath addLineToPoint:CGPointMake(5, 10)];
    }
    // 将这个path赋值给maskLayer的path
    self.maskLayer.path = self.borderPath.CGPath;
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
    return [UIColor colorWithRGBHex:hexNum];
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

+ (float)measureSinglelineStringWidth:(NSString*)str andFont:(UIFont*)wordFont {
    if (str == nil) return 0;
    CGSize measureSize = [str boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:wordFont, NSFontAttributeName, nil] context:nil].size;
    return ceil(measureSize.width);
}

@end
