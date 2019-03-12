//
//  BaseMsgObject.m
//  RuntimeForwardInvocation
//
//  Created by 庞仕山 on 2019/3/11.
//  Copyright © 2019年 庞仕山. All rights reserved.
//

#import "BaseMsgObject.h"
#import <objc/runtime.h>

@implementation BaseMsgObject


//static void sendMsg(id self, SEL _cmd, NSString *msg) {
//    NSLog(@"BaseMsgObject - %@", msg);
//}
//
//// 动态消息解析
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if ([NSStringFromSelector(sel) isEqualToString:@"sendMsg:"]) {
//        class_addMethod([BaseMsgObject class], sel, (IMP)sendMsg, "v@:@");
//    }
//    return [super resolveInstanceMethod:sel];
//}
//// 类方法
//+ (BOOL)resolveClassMethod:(SEL)sel {
//    if ([NSStringFromSelector(sel) isEqualToString:@"sendMsg:"]) {
//        class_addMethod(object_getClass([self class]), sel, (IMP)sendMsg, "v@:@");
//    }
//    return [super resolveInstanceMethod:sel];
//}

@end
