//
//  NSObject+PS.h
//  PSScanViewController
//
//  Created by Ryan_Man on 16/8/23.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PS)

#pragma mark - json 数据处理 -

/**
 *  将数组或者字典转化成 二进制数据
 *
 *  @return 
 */
- (NSData*)ps_toJsonData;

/**
 *  将数组或者字典 转化成 JSON字符串
 *
 *  @return JSON字符串
 */
- (NSString*)ps_toJsonString;

/**
 *  json to dictionary
 *
 *  @param json
 *
 *  @return
 */
- (NSDictionary *)ps_toDictionaryWithJSON:(id)json;


/**
 *  json字符串转对象
 *
 *  @return NSArray或NSDictionary
 */

- (id)ps_JsonToObject;


#pragma mark - safe object  -

/**
 *  保证是字符串
 *
 *  @param object
 *
 *  @return
 */
- (NSString*)ps_IsSafeString:(id)object;

/**
 *  保证是nsnumber
 *
 *  @param object
 *
 *  @return
 */
- (NSNumber*)ps_IsSafeNumber:(id)object;

#pragma mark - 常见方法 -

/**
 *  获取文件大小 转换值
 *
 *  @param size
 *
 *  @return
 */
- (NSString*)ps_fileSizeWithInteger:(NSInteger)fileSize;

/**
 *  相机是否有访问权限
 *
 *  @return
 */
- (BOOL)ps_IsCameraValid;

@end
