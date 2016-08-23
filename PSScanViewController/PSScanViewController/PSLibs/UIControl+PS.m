//
//  UIControl+PS.m
//  PSScanViewController
//
//  Created by Ryan_Man on 16/8/23.
//  Copyright © 2016年 Ryan_Man. All rights reserved.
//

#import "UIControl+PS.h"
#import <objc/runtime.h>

@implementation UIControl (PS)
static char OperationKey;

//处理事件响应
- (void)ps_HandleControlEvent:(UIControlEvents)event withBlock:(void (^)(id))block
{
    
    NSString *methodName = [UIControl ps_EventName:event];
    
    NSMutableDictionary *opreations = (NSMutableDictionary*)objc_getAssociatedObject(self, &OperationKey);
    
    if(opreations == nil)
    {
        opreations = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &OperationKey, opreations, OBJC_ASSOCIATION_RETAIN);
    }
    [opreations setObject:block forKey:methodName];
    
    [self addTarget:self action:NSSelectorFromString(methodName) forControlEvents:event];
    
}

- (void)ps_RemoveHandlerForEvent:(UIControlEvents)event
{
    
    NSString *methodName = [UIControl ps_EventName:event];
    NSMutableDictionary *opreations = (NSMutableDictionary*)objc_getAssociatedObject(self, &OperationKey);
    
    if(opreations == nil)
    {
        opreations = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &OperationKey, opreations, OBJC_ASSOCIATION_RETAIN);
    }
    [opreations removeObjectForKey:methodName];
    [self removeTarget:self action:NSSelectorFromString(methodName) forControlEvents:event];
}


-(void)UIControlEventTouchDown{[self ps_CallActionBlock:UIControlEventTouchDown];}
-(void)UIControlEventTouchDownRepeat{[self ps_CallActionBlock:UIControlEventTouchDownRepeat];}
-(void)UIControlEventTouchDragInside{[self ps_CallActionBlock:UIControlEventTouchDragInside];}
-(void)UIControlEventTouchDragOutside{[self ps_CallActionBlock:UIControlEventTouchDragOutside];}
-(void)UIControlEventTouchDragEnter{[self ps_CallActionBlock:UIControlEventTouchDragEnter];}
-(void)UIControlEventTouchDragExit{[self ps_CallActionBlock:UIControlEventTouchDragExit];}
-(void)UIControlEventTouchUpInside{[self ps_CallActionBlock:UIControlEventTouchUpInside];}
-(void)UIControlEventTouchUpOutside{[self ps_CallActionBlock:UIControlEventTouchUpOutside];}
-(void)UIControlEventTouchCancel{[self ps_CallActionBlock:UIControlEventTouchCancel];}
-(void)UIControlEventValueChanged{[self ps_CallActionBlock:UIControlEventValueChanged];}
-(void)UIControlEventEditingDidBegin{[self ps_CallActionBlock:UIControlEventEditingDidBegin];}
-(void)UIControlEventEditingChanged{[self ps_CallActionBlock:UIControlEventEditingChanged];}
-(void)UIControlEventEditingDidEnd{[self ps_CallActionBlock:UIControlEventEditingDidEnd];}
-(void)UIControlEventEditingDidEndOnExit{[self ps_CallActionBlock:UIControlEventEditingDidEndOnExit];}
-(void)UIControlEventAllTouchEvents{[self ps_CallActionBlock:UIControlEventAllTouchEvents];}
-(void)UIControlEventAllEditingEvents{[self ps_CallActionBlock:UIControlEventAllEditingEvents];}
-(void)UIControlEventApplicationReserved{[self ps_CallActionBlock:UIControlEventApplicationReserved];}
-(void)UIControlEventSystemReserved{[self ps_CallActionBlock:UIControlEventSystemReserved];}
-(void)UIControlEventAllEvents{[self ps_CallActionBlock:UIControlEventAllEvents];}


- (void)ps_CallActionBlock:(UIControlEvents)event
{
    
    NSMutableDictionary *opreations = (NSMutableDictionary*)objc_getAssociatedObject(self, &OperationKey);
    
    if(opreations == nil) return;
    void(^block)(id sender) = [opreations objectForKey:[UIControl ps_EventName:event]];
    
    if (block) block(self);
    
}

+ (NSString *)ps_EventName:(UIControlEvents)event
{
    switch (event) {
        case UIControlEventTouchDown:          return @"UIControlEventTouchDown";
        case UIControlEventTouchDownRepeat:    return @"UIControlEventTouchDownRepeat";
        case UIControlEventTouchDragInside:    return @"UIControlEventTouchDragInside";
        case UIControlEventTouchDragOutside:   return @"UIControlEventTouchDragOutside";
        case UIControlEventTouchDragEnter:     return @"UIControlEventTouchDragEnter";
        case UIControlEventTouchDragExit:      return @"UIControlEventTouchDragExit";
        case UIControlEventTouchUpInside:      return @"UIControlEventTouchUpInside";
        case UIControlEventTouchUpOutside:     return @"UIControlEventTouchUpOutside";
        case UIControlEventTouchCancel:        return @"UIControlEventTouchCancel";
        case UIControlEventValueChanged:       return @"UIControlEventValueChanged";
        case UIControlEventEditingDidBegin:    return @"UIControlEventEditingDidBegin";
        case UIControlEventEditingChanged:     return @"UIControlEventEditingChanged";
        case UIControlEventEditingDidEnd:      return @"UIControlEventEditingDidEnd";
        case UIControlEventEditingDidEndOnExit:return @"UIControlEventEditingDidEndOnExit";
        case UIControlEventAllTouchEvents:     return @"UIControlEventAllTouchEvents";
        case UIControlEventAllEditingEvents:   return @"UIControlEventAllEditingEvents";
        case UIControlEventApplicationReserved:return @"UIControlEventApplicationReserved";
        case UIControlEventSystemReserved:     return @"UIControlEventSystemReserved";
        case UIControlEventAllEvents:          return @"UIControlEventAllEvents";
        default:
            return @"description";
    }
    return @"description";
}

+ (UIControlEvents)ps_EventWithName:(NSString *)name
{
    if([name isEqualToString:@"UIControlEventTouchDown"])           return UIControlEventTouchDown;
    if([name isEqualToString:@"UIControlEventTouchDownRepeat"])     return UIControlEventTouchDownRepeat;
    if([name isEqualToString:@"UIControlEventTouchDragInside"])     return UIControlEventTouchDragInside;
    if([name isEqualToString:@"UIControlEventTouchDragOutside"])    return UIControlEventTouchDragOutside;
    if([name isEqualToString:@"UIControlEventTouchDragEnter"])      return UIControlEventTouchDragEnter;
    if([name isEqualToString:@"UIControlEventTouchDragExit"])       return UIControlEventTouchDragExit;
    if([name isEqualToString:@"UIControlEventTouchUpInside"])       return UIControlEventTouchUpInside;
    if([name isEqualToString:@"UIControlEventTouchUpOutside"])      return UIControlEventTouchUpOutside;
    if([name isEqualToString:@"UIControlEventTouchCancel"])         return UIControlEventTouchCancel;
    if([name isEqualToString:@"UIControlEventTouchDown"])           return UIControlEventTouchDown;
    if([name isEqualToString:@"UIControlEventValueChanged"])        return UIControlEventValueChanged;
    if([name isEqualToString:@"UIControlEventEditingDidBegin"])     return UIControlEventEditingDidBegin;
    if([name isEqualToString:@"UIControlEventEditingChanged"])      return UIControlEventEditingChanged;
    if([name isEqualToString:@"UIControlEventEditingDidEnd"])       return UIControlEventEditingDidEnd;
    if([name isEqualToString:@"UIControlEventEditingDidEndOnExit"]) return UIControlEventEditingDidEndOnExit;
    if([name isEqualToString:@"UIControlEventAllTouchEvents"])      return UIControlEventAllTouchEvents;
    if([name isEqualToString:@"UIControlEventAllEditingEvents"])    return UIControlEventAllEditingEvents;
    if([name isEqualToString:@"UIControlEventApplicationReserved"]) return UIControlEventApplicationReserved;
    if([name isEqualToString:@"UIControlEventSystemReserved"])      return UIControlEventSystemReserved;
    if([name isEqualToString:@"UIControlEventAllEvents"])           return UIControlEventAllEvents;
    return UIControlEventAllEvents;
}
@end
