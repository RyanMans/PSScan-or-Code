//
//  NSObject+PS.m
//  PSScanViewController
//
//  Created by Ryan_Man on 16/8/23.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "NSObject+PS.h"
#import <AVFoundation/AVFoundation.h>
@implementation NSObject (PS)

//将数组或者字典转化成 二进制数据
- (NSData*)ps_toJsonData
{
    NSError * error;

    if (([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSDictionary class]]) == NO) return nil;

    NSData *  data = [NSJSONSerialization dataWithJSONObject:self options:(NSJSONWritingPrettyPrinted) error:&error];
    
    if (error)
    {
        NSLog(@"fun:tojsonData error: %@",error);
    }

    return data;
}

//将数组或者字典 转化成 JSON字符串
- (NSString*)ps_toJsonString
{
    if (![NSJSONSerialization isValidJSONObject:self])return nil;
    
    if (([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSDictionary class]]) == NO) return nil;
    
    NSError * error;
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:self options:(NSJSONWritingPrettyPrinted) error:&error];
    
    if (jsonData.length == 0) return nil;
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//json to dictionary
- (NSDictionary *)ps_toDictionaryWithJSON:(id)json
{
    if (!json || json == (id)kCFNull) return nil;
    NSDictionary * dict = nil;
    NSData * jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]])
    {
        dict = json;
    }
    else if ([json isKindOfClass:[NSString class]])
    {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    }
    else if ([json isKindOfClass:[NSData class]])
    {
        jsonData = json;
    }
    if (jsonData)
    {
        dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dict isKindOfClass:[NSDictionary class]]) dict = nil;
    }
    return dict;
}

//jsonString to Object
- (id)ps_JsonToObject
{
    if ([self isKindOfClass:[NSString class]] == NO) return nil;
    
    NSString * jsonStr = (NSString*)self;
    
    NSError *error = nil;
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    
    if (!jsonData) {
        return nil;
    }
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        return nil;
    }
    return obj;
}


#pragma mark - safe Object -
// 保证是字符串
- (NSString*)ps_IsSafeString:(id)object
{
    if (!object || [object isKindOfClass:[NSNull class]])return @"";
    
    if ([object isKindOfClass:[NSString class]])
    {
        NSString * value = (NSString*)object;
        return value.length ? value : @"";
    }
    else if ([object isKindOfClass:[NSNumber class]])
    {
        NSNumber * value = (NSNumber*)object;
        return [NSString stringWithFormat:@"%@",value];
    }
    return @"";
}

//保证是nsnumber
- (NSNumber*)ps_IsSafeNumber:(id)object
{

    if (!object || [object isKindOfClass:[NSNull class]])return @0;
    
    if ([object isKindOfClass:[NSNumber class]])
    {
        return (NSNumber*)object;
    }
    else if ([object isKindOfClass:[NSString class]])
    {
        NSString * value = (NSString*)object;
        
        return [NSNumber numberWithInteger:value.integerValue];
    }
    return @0;
}

#pragma mark - 常见方法 -
//获取文件大小转换值
- (NSString*)ps_fileSizeWithInteger:(NSInteger)fileSize
{
    // 1k = 1024, 1m = 1024k
    if (fileSize < 1024)
    {
        // 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)fileSize];
    }
    else if (fileSize < 1024 * 1024)
    {
        // 小于1m
        CGFloat aFloat = fileSize/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }
    else if (fileSize < 1024 * 1024 * 1024)
    {
        // 小于1G
        CGFloat aFloat = fileSize/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }
    else
    {
        CGFloat aFloat = fileSize/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

- (BOOL)ps_IsCameraValid
{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus != AVAuthorizationStatusAuthorized)return NO;
        return YES;
    }
    return NO;
}

@end
