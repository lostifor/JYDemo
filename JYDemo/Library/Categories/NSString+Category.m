//
//  NSString+Category.m
//  AFN
//
//  Created by toocmstoocms on 15/5/15.
//  Copyright (c) 2015年 toocmstoocms. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "NSString+Category.h"

@implementation NSString (Category)

#pragma mark - 验证email
/** 验证email */
+ (BOOL) validateEmail:(NSString *)email
{
    return [email validateEmail];
}
/** 验证email */
- (BOOL) validateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

#pragma mark - 验证手机
/** 验手机号码 */
+ (BOOL) validateMobile:(NSString *)mobile
{
    return [mobile validateMobile];
}
/** 验手机号码 */
- (BOOL) validateMobile
{
    NSString *phoneRegex = @"^((13[0-9])|(14[57])|(15[^4,\\D])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

#pragma mark - 车牌号验证
//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}

#pragma mark - 车型
//车型
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}

#pragma mark - 用户名
//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

#pragma mark - 密码
//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-z0-9][a-zA-Z0-9_]{5,17}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
- (BOOL)validatePassword {
    return [NSString validatePassword:self];
}

#pragma mark - 昵称
//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"([a-z0-9[^A-Za-z0-9_\n\t]]{1,8})";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

#pragma mark - 身份证号
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


//获取字符串高度
+ (CGSize)getStringRect:(NSString*)aString fontSize:(CGFloat)fontSize width:(int)stringWidth
{
    return [aString getStringRectWithfontSize:fontSize width:stringWidth];
}

- (CGSize)getStringRectWithfontSize:(CGFloat)fontSize width:(int)stringWidth
{
    CGSize size;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSDictionary* dic = @{NSFontAttributeName:font};
    size = [self boundingRectWithSize:CGSizeMake(stringWidth, 2000)  options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return  size;
}

//设置UIlabel行间距
+ (void)setLabellineSpacing:(UILabel *)label aString:(NSString *)content setLineSpacing:(CGFloat)LineSpacing {
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:15];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    
    [label setAttributedText:attributedString];
    
    [label sizeToFit];
}
/**
 *  根据字符串长度计算label的尺寸
 *
 *  @param text     要计算的字符串
 *  @param fontSize 字体大小
 *  @param maxSize  label允许的最大尺寸
 *
 *  @return label的尺寸
 */
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize

{
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
    
    NSDictionary* attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    labelSize.height=ceil(labelSize.height);
    
    labelSize.width=ceil(labelSize.width);
    
    return labelSize;
    
}

#pragma mark - 移除html标签
//转化html为字符串
+ (NSString *)removeHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    return html;
}

//转化html为字符串
+ (NSString *)removeHTML2:(NSString *)html{
    
    NSArray *components = [html componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    NSMutableArray *componentsToKeep = [NSMutableArray array];
    
    for (int i = 0; i < [components count]; i = i + 2) {
        [componentsToKeep addObject:[components objectAtIndex:i]];
    }
    
    NSString *plainText = [componentsToKeep componentsJoinedByString:@""];
    
    return plainText;
    
}

#pragma mark - MD5加密
+ (NSString *)MD5String:(NSString *)string
{
    return [string MD5String];
}

- (NSString *)MD5String {
    
    NSString *str = [NSString stringWithFormat:@"%@", self];
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr,(unsigned)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
//    //32位MD5加密方式
//    const char *cStr = [self UTF8String];
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    CC_MD5( cStr, (int)self.length, digest );
//    NSMutableString * md5String = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
//        [md5String appendFormat:@"%02x", digest[i]];
//    }
//    //经过这个for循环 已经转化成md5字符串
//    
//    // 再将md5字符串乱序
//    // 1.先遍历字符串，放入数组
//    NSMutableArray * array = [NSMutableArray array];
//    for (int i = 0; i < md5String.length; i++) {
//        NSString * sub = [md5String substringWithRange:NSMakeRange(i, 1)];
//        [array addObject:sub];
//    }
//    // 2.取出部分字符
//    NSString * s1 = array[1];
//    NSString * s3 = array[3];
//    NSString * s5 = array[5];
//    NSString * s10 = array[10];
//    
//    NSString * s20 = array[20];
//    NSString * s26 = array[26];
//    NSString * s28 = array[28];
//    NSString * s30 = array[30];
//    
//    // 3.替换字符串的位置
//    [array replaceObjectAtIndex:1 withObject:s26];
//    [array replaceObjectAtIndex:3 withObject:s28];
//    [array replaceObjectAtIndex:5 withObject:s30];
//    [array replaceObjectAtIndex:10 withObject:s20];
//    [array replaceObjectAtIndex:20 withObject:s10];
//    [array replaceObjectAtIndex:26 withObject:s1];
//    [array replaceObjectAtIndex:28 withObject:s3];
//    [array replaceObjectAtIndex:30 withObject:s5];
//    
//    // 4.将结果取出
//    NSString * result = [array componentsJoinedByString:@""];
//    return result;
}
- (NSString *)formatNumber;
{
    int count = 0;
    long long int a = self.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:self];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

+ (NSString *)formatNumber:(NSString *)numberString
{
    return numberString.formatNumber;
}

#pragma mark Func
NSString * stringWithInt(int number) {
    return [NSString stringWithFormat:@"%d", number];
}
NSString * stringWithInteger(NSInteger number) {
    return [NSString stringWithFormat:@"%zd", number];
}
NSString * stringWithDouble(double number) {
    return [NSString stringWithFormat:@"%.2f", number];
}
NSString * stringWithDoubleAndDecimalCount(double number, unsigned int count) {
    
    switch (count) {
        case 0:
            return [NSString stringWithFormat:@"%.0f", number];
            break;
        case 1:
            return [NSString stringWithFormat:@"%.1f", number];
            break;
        case 2:
            return [NSString stringWithFormat:@"%.2f", number];
            break;
        case 3:
            return [NSString stringWithFormat:@"%.3f", number];
            break;
        case 4:
            return [NSString stringWithFormat:@"%.4f", number];
            break;
        case 5:
            return [NSString stringWithFormat:@"%.5f", number];
            break;
        default:
            return [NSString stringWithFormat:@"%f", number];
            break;
    }
}
@end
