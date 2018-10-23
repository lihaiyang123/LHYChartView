//
//  LinesSelectCell.m
//  LRSChartView
//
//  Created by lihaiyang on 2018/10/23.
//  Copyright © 2018 lihaiyang. All rights reserved.
//

#import "LinesSelectCell.h"

@interface LinesSelectCell ()
//←lab
@property (nonatomic ,strong) UILabel * titlesLab;
//→lab
@property (nonatomic ,strong) UILabel * descsLab;
@end

@implementation LinesSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        _titlesLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 17)];
        [self addSubview:_titlesLab];
        _descsLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 17)];
        [self addSubview:_descsLab];
    }
    return self;
}

-(void)setLeftWidth:(CGFloat)leftWidth{
    _leftWidth = leftWidth;
    if (leftWidth < 50) {
        leftWidth = 50;
    }
    [_titlesLab setFrame:CGRectMake(10, 0, leftWidth, 17)];
}

-(void)setRightWith:(CGFloat)rightWith{
    _rightWith = rightWith;
    if (rightWith < 50 && rightWith != 0) {
        rightWith = 50;
    }
    [_descsLab setFrame:CGRectMake(CGRectGetMaxX(_titlesLab.frame) + 10, 0, rightWith, 17)];
}

-(void)showTitle:(NSString *)title andTitleColor:(UIColor *)titleColor andTitleFont:(UIFont *)titleFont andDescTile:(NSString *)descTitle andDescTileColor:(UIColor *)descTileColor andDescTitleFont:(UIFont *)DescTitleFont{
    _titlesLab.text = title;
    _titlesLab.textColor = titleColor;
    _titlesLab.font = titleFont;
    if (descTitle) _descsLab.text = descTitle;
    if (descTileColor) _descsLab.textColor = descTileColor;
    if (DescTitleFont) _descsLab.font = DescTitleFont;
    
}
@end
