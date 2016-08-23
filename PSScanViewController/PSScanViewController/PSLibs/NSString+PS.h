//
//  NSString+PS.h
//  PSScanViewController
//
//  Created by Ryan_Man on 16/8/23.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PS)

#pragma mark - 数据处理 -

/**
 *  MD5加密
 *
 *  @return
 */
- (NSString*)ps_MD5Encoding;

/**
 *  转换成NSData
 *
 *  @return
 */
- (NSData*)ps_ToData;

/**
 *  提取数字
 *
 *  @return 仅有数字的字符串
 */
- (NSString *)ps_OnlyNumbers;

/**
 *  去掉前后的空格
 *
 *  @return 前后无空格后的字符串
 */
- (NSString *)ps_Trim;

#pragma mark - 数据判断-

/**
 *  判别是否包含某字符串
 *
 *  @param str
 *
 *  @return
 */
- (BOOL)ps_ContainString:(NSString*)string;

/**
 *  是否整型
 *
 *  @return 
 */
- (BOOL)ps_IsInteger;

/**
 *  是否为字符型
 *
 *  @return
 */
- (BOOL)ps_IsCharacter;

/**
 *  判断是否是有效的手机号码
 *
 *  @return
 */
- (BOOL)ps_IsValidMobile;

/**
 *  判断是否是有效邮箱字符串
 *
 *  @return
 */
- (BOOL)ps_IsEmailAddress;

/**
 *  判断是否是有效的qq
 *
 *  @return
 */
- (BOOL)ps_IsValidQQ;


@end
