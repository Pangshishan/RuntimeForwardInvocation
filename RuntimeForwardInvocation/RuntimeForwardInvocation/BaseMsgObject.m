//
//  BaseMsgObject.m
//  RuntimeForwardInvocation
//
//  Created by 庞仕山 on 2019/3/11.
//  Copyright © 2019年 庞仕山. All rights reserved.
//

#import "BaseMsgObject.h"
#import <objc/runtime.h>



//enum {
//    VVBLOCK_HAS_COPY_DISPOSE =  (1 << 25), // compiler
//    VVBLOCK_HAS_SIGNATURE  =    (1 << 30), // compiler
//};
//
//struct VVBlock_descriptor {
//    uintptr_t reserved;
//    uintptr_t size;
//    // requires BLOCK_HAS_COPY_DISPOSE
//    void (*copy)(void *dst, const void *src);
//    void (*dispose)(const void *);
//    // requires BLOCK_HAS_SIGNATURE
//    const char *signature;
//    const char *layout;
//};
//
//struct VVBlock_layout {
//    void *isa;
//    volatile int32_t flags; // contains ref count
//    int32_t reserved;
//    void (*invoke)(void *, ...);
//    struct VVBlock_descriptor *descriptor;
//    // imported variables
//};

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


//// 5. block调用
//- (void)invokeBlock {
//    void(^block)(NSString *string) = ^(NSString *string) {
//        NSLog(@"%@", string);
//    };
//    
//    //    struct VVBlock_layout *myBlock = (__bridge struct VVBlock_layout *)block;
//    //    myBlock->invoke(myBlock, @"hello block");
//    
//    // v@?@
//    NSMethodSignature *signature = [self signatureWithBlock:block];
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//    invocation.target = block;
//    NSString *str = @"hello block";
//    [invocation setArgument:&str atIndex:1];
//    [invocation invoke];
//}
//
//- (NSMethodSignature *)signatureWithBlock:(id)block {
//    struct VVBlock_layout *myBlock = (__bridge struct VVBlock_layout *)block;
//    if (myBlock->flags & VVBLOCK_HAS_SIGNATURE) {
//        void *discriptor = myBlock->descriptor;
//        discriptor += 2 * sizeof(uintptr_t);
//        if (myBlock->flags & VVBLOCK_HAS_COPY_DISPOSE) {
//            discriptor += sizeof(void (*)(void *dst, const void *src));
//            discriptor += sizeof(void (*)(const void *));
//        }
//        const char *sign = *((const char **)discriptor);
//        NSMethodSignature *signature = [NSMethodSignature signatureWithObjCTypes:sign];
//        return signature;
//    }
//    return nil;
//}

@end
