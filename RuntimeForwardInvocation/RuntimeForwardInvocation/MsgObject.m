//
//  MsgObject.m
//  RuntimeForwardInvocation
//
//  Created by 庞仕山 on 2019/3/11.
//  Copyright © 2019年 庞仕山. All rights reserved.
//

#import "MsgObject.h"
#import <objc/runtime.h>
#import "SpareWheel.h"


@implementation MsgObject

static void sendMsg(id self, SEL _cmd, NSString *msg) {
    NSLog(@"MsgObject - %@", msg);
}

// 动态消息解析
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if ([NSStringFromSelector(sel) isEqualToString:@"sendMsg:"]) {
        class_addMethod([MsgObject class], sel, (IMP)sendMsg, "v@:@");
    }
    return [super resolveInstanceMethod:sel];
    return NO;
}

// 类方法
//+ (BOOL)resolveClassMethod:(SEL)sel {
//    if ([NSStringFromSelector(sel) isEqualToString:@"sendMsg:"]) {
//        class_addMethod(object_getClass([self class]), sel, (IMP)sendMsg, "v@:@");
//    }
//    return [super resolveInstanceMethod:sel];
//}

// 简单转发
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"sendMsg:"]) {
        return [SpareWheel new];
    }
    return [super forwardingTargetForSelector:aSelector];
}

// 完整转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"sendMsg:"]) {
        NSMethodSignature *sign = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
        return sign;
    }
    return [super methodSignatureForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:[SpareWheel new]];
    [anInvocation invokeWithTarget:[SpareWheel new]];
}



@end


