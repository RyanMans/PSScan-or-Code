//
//  NSString+PS.m
//  PSScanViewController
//
//  Created by Ryan_Man on 16/8/23.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "NSString+PS.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSString (PS)

#pragma mark - 数据处理 -
//MD5加密
- (NSString*)ps_MD5Encoding
{
    const char * utfString = self.UTF8String;
    
    unsigned char  result [16] = {0};
    
    CC_MD5(utfString, (CC_LONG)strlen(utfString), result);
    
    char szOutput[33] = { 0 };
    
    for (int index = 0; index < 16; index++)
    {
        unsigned char src = result[index];
        
        sprintf(szOutput, "%s%02x",szOutput,src);
    }
    return [NSString stringWithUTF8String:szOutput];
}

//转化成nsdata
- (NSData*)ps_ToData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

//提取数字
- (NSString *)ps_OnlyNumbers
{
    if (nil == self) return nil;
    if (0 == self.length) return @"";
    
    unichar c = 0;
    NSMutableString *temp = [NSMutableString stringWithCapacity:self.length];
    for (NSUInteger a = 0; a < self.length; ++a)
    {
        c = [self characterAtIndex:a];
        if (c < '0') continue;
        if (c > '9') continue;
        [temp appendFormat:@"%C", c];
    }
    return temp;
}

//去掉前后的空格
- (NSString *)ps_Trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - 数据判断 -

// 判别是否包含某字符串
- (BOOL)ps_ContainString:(NSString *)string
{
    if ([self rangeOfString:string].location != NSNotFound) return YES;
    return NO;
}

//是否整型
- (BOOL)ps_IsInteger
{
    if (!self || self.length) return NO;
    
    NSScanner * scanner = [NSScanner scannerWithString:self];
    
    return [scanner scanInteger:0] && [scanner isAtEnd];
}

//是否为字符型
- (BOOL)ps_IsCharacter
{
    if (!self || self.length) return NO;

    NSString * limitString = @"[a-zA-z]";
    
    NSPredicate * characterString = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", limitString];
    
    return [characterString evaluateWithObject:self];
}

//是否有效手机号码
- (BOOL)ps_IsValidMobile
{
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    if (!self || self.length != 11) return NO;
    
    NSString * mobileRegex = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate * regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    
    return [regextestmobile evaluateWithObject:self];
}

//是否有效邮箱
- (BOOL)ps_IsEmailAddress
{
    if (!self || self.length) return NO;
    
    NSString * emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate * emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

//是否有效QQ号码
- (BOOL)ps_IsValidQQ
{
    if (!self || self.length) return NO;
    
    NSString * qqRegex = @"[1-9][0-9]\{4,}";
    
    NSPredicate * qqTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", qqRegex];
    
    return [qqTest evaluateWithObject:self];
}

@end
