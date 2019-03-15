//
//  ViewController.m
//  RuntimeForwardInvocation
//
//  Created by 庞仕山 on 2019/3/11.
//  Copyright © 2019年 庞仕山. All rights reserved.
//

#import "ViewController.h"
#import "MsgObject.h"
#import <objc/runtime.h>
#import <objc/message.h>

/*
 1. 实例对象，类对象，源码结构
 2. 消息转发流程
 3. 实例方法 消息转发
 4. 类方法 消息转发
 5. 调用方法的几种方式
 6. NSInvocation 方式调用block
 7.
 */


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
//    MsgObject *msgObj = [[MsgObject alloc] init];
//    objc_msgSend(msgObj, NSSelectorFromString(@"sendMsg:"), @"hello");
    
//    objc_msgSend([MsgObject class], NSSelectorFromString(@"sendMsg:"),  @"hello");
    
    //[self invokeFunc];
//    [self invokeBlock];
}

// 4. 调用方法的集中方
- (void)invokeFunc {
    MsgObject *msgObj = [[MsgObject alloc] init];
    // 1. []
    // 2. objcMsgsend
    // 3. performSelector
    // [msgObj performSelector:NSSelectorFromString(@"sendMsg:") withObject:@"hello"];
    
    
    // 4. NSInvocation
    NSMethodSignature *signature = [msgObj methodSignatureForSelector:NSSelectorFromString(@"sendMsg:")];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = msgObj;
    invocation.selector = NSSelectorFromString(@"sendMsg:");
    NSString *str = @"hello";
    [invocation setArgument:&str atIndex:2];
    [invocation invoke];
}

- (void)invokeBlock {
    
}



@end

