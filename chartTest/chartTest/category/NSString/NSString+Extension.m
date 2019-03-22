//
//  NSString+Extension.m
//  SCH
//
//  Created by SCH_YUH on 2017/1/10.
//  Copyright © 2017年 SCH_YUH. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
+ (instancetype)getDateUnqueDescription{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mdYHMSF"];
    return [formatter stringFromDate:now];
}

#pragma mark 字符串空判断
- (BOOL)isEmpty
{
    
    return  [[NSNull null] isEqual:self] || [self isEqualToString:@""] || [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqual:@""]||self==NULL;
}
-(BOOL)isNull{
    if (self == nil) {
        return YES;
    }
    if ([self isEqualToString:@""]) {
        return YES;
    }
    return NO;
}
+ (BOOL) isNullOrEmpty:(NSString *)string
{
    return string == nil
    || [string isEqual: (id)[NSNull null]]
    || [string isKindOfClass:[NSString class]] == NO
    || [@"" isEqualToString:string]
    || [[string stringByReplacingOccurrencesOfString:@" " withString:@""] length] == 0U
    || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0U;
}

#pragma mark 邮箱判断
-(BOOL)verifyEmail{
    NSString *emailRegex = @"[A-Z0-9a-z_%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
#pragma mark 手机号判断
-(BOOL)isPhoneNumber{
    
    //    NSString *phoneRegex = @"^((14[5,7])|(13[0-9])|(15[0-9])|(17[0-9])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^((1[0-9]))\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
    
}
#pragma mark - 座机
-(BOOL)isTelephoneNumber{
    ///八位或11位数字 座机号码
    NSString *telephoneNumberRegex = @"^\\d{8}$|^\\d{11}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telephoneNumberRegex];
    return [predicate evaluateWithObject:self];
}

/**
 *返回值是该字符串所占一行的width
 *font : 该字符串所用的字体(字体大小不一样,显示出来的面积也不同)
 */
-(CGFloat)getSingleLineTextSizeWithFont: (UIFont*)font {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
}
-(void)call{
    NSString *str = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *calUrl = [NSString stringWithFormat:@"tel:%@",str];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:calUrl]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:calUrl]];
    }
}



+ (NSString *)pictureNaming {
    
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    //随机字符串32位
    NSString *str=[[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    //当前时间戳
    NSString *DateTime = [NSString getDateUnqueDescription];
    str=[NSString stringWithFormat:@"%@%@",str,DateTime];
    return str;
}

+(NSString *)roundUpNum:(CGFloat )num unit:(NSString *)unit{
    
    NSString *numStr = @"";
    if (num < 1000) {
        numStr = [NSString stringWithFormat:@"%.0f%@",num,unit];
        return numStr;
    }else{
        
        numStr = [NSString stringWithFormat:@"%.1fk%@",ceil(num/1000 *10)/10,unit];
        return numStr;
    }
}
+(NSString *)roundUpFloorfNum:(CGFloat )num unit:(NSString *)unit{
    
    NSString *numStr = @"";
    if (num < 1000) {
        numStr = [NSString stringWithFormat:@"%.0f%@",num,unit];
        return numStr;
    }else{
        float f = num/1000;
        
        NSString *fStr = [NSString stringWithFormat:@"%f",f];
        // 点的位置
        NSUInteger ponitLoc = [fStr rangeOfString:@"."].location;
        // 需要改变的区间
        NSRange range = NSMakeRange(0,ponitLoc);
        NSRange secRange;
        if (fStr.length>ponitLoc+2) {
            secRange = NSMakeRange(ponitLoc, 2);
        }else{
            secRange = NSMakeRange(ponitLoc,fStr.length-ponitLoc);
        }
        
        NSString *firstComponent = [fStr substringWithRange:range];
        NSString *secondComponent = [fStr substringWithRange:secRange];
        
        if ([secondComponent isEqualToString:@".0"]) {
            secondComponent = @"";
        }
        
        numStr = [NSString stringWithFormat:@"%@%@k%@", firstComponent, secondComponent, unit];
        return numStr;
    }
}
+(CGSize)getAttributeSizeWithText:(NSString *)text fontSize:(int)fontSize
{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    
    return size;
}

+(NSDictionary *)dic_roundUpNum:(CGFloat )num unit:(NSString *)unit{
    NSString *numStr = @"";
    if (num < 1000) {
        numStr = [NSString stringWithFormat:@"%.0f%@",num,unit];
        return @{@"num":[NSString stringWithFormat:@"%.0f",num],
                 @"unit":unit
                 };
    }else{
        
        numStr = [NSString stringWithFormat:@"%.1fk%@",ceil(num/1000 *10)/10,unit];
        return @{@"num":[NSString stringWithFormat:@"%.1f",ceil(num/1000 *10)/10],
                 @"unit":[NSString stringWithFormat:@"k%@",unit]
                 };
    }
}
+(NSString *)dic_roundUpNum:(NSDictionary *)dic{
    if (dic[@"num"] != nil) {
        return dic[@"num"];
    }
    return @"";
}
+(NSString *)dic_roundUpUnit:(NSDictionary *)dic{
    if (dic[@"unit"] != nil) {
        return dic[@"unit"];
    }
    return @"";
}

+ (float)measureSinglelineStringWidth:(NSString*)str andFont:(UIFont*)wordFont {
    if (str == nil) return 0;
    CGSize measureSize = [str boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:wordFont, NSFontAttributeName, nil] context:nil].size;
    return ceil(measureSize.width);
}

+ (float)measureMultilineStringHeight:(NSString*)str andFont:(UIFont*)wordFont andWidth:(CGFloat)width {
    if (str == nil) {
        return 0;
    }
    CGSize measureSize = [str boundingRectWithSize:CGSizeMake(width, [wordFont pointSize] * 3) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:wordFont, NSFontAttributeName, nil] context:nil].size;
    return ceil(measureSize.height);
}

+ (NSString *)stringChangeMoneyWithStr:(NSString *)str numberStyle:(NSNumberFormatterStyle)numberStyle {
    
    // 判断是否null 若是赋值为0 防止崩溃
    if (([str isEqual:[NSNull null]] || str == nil)) {
        str = 0;
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle = numberStyle;
    // 注意传入参数的数据长度，可用double
    NSString *money = [formatter stringFromNumber:[NSNumber numberWithDouble:[str doubleValue]]];
    
    return money;
}

+ (NSString *)stringChangeMoneyWithDouble:(double)number {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.positiveFormat = @",###.##"; // 正数格式
    // 注意传入参数的数据长度，可用double
    NSString *money = [formatter stringFromNumber:@(number)];
    //    money = [NSString stringWithFormat:@"￥%@", money];
    
    return money;
}

+ (NSString *)replaceNullString:(NSString *)string {
    if (!string) {
        return @"";
    }
    return string;
}

@end
