//
//  ViewController.m
//  Runtime消息转发
//
//  Created by 山和霞 on 17/3/24.
//  Copyright © 2017年 庞仕山. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "SomeOtherObject.h"

@interface ViewController ()

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *age;

@end

@implementation ViewController

// 告诉编译器，不要生成set 和 get方法，但是调用get 和set也不会出错
@dynamic name;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
#pragma mark - 1.重定向方法，在本类里进行方法重定向处理
//void dynamicMethodIMP(id self, SEL _cmd)
//{
//    NSLog(@"dynamicMethodIMP -- %@", NSStringFromSelector(_cmd));
//}
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    NSLog(@"sel is %@", NSStringFromSelector(sel));
//    if (sel == @selector(setName:)) {
//        class_addMethod([SomeOtherObject class], sel, (IMP)dynamicMethodIMP, "v@:");
//    }
//
//    return [super resolveInstanceMethod:sel];
//}

#pragma mark - 2. 找个类处理她
//- (id)forwardingTargetForSelector:(SEL)aSelector
//{
//    if ([NSStringFromSelector(aSelector) isEqualToString:@"setName:"]) {
//        return [[SomeOtherObject alloc] init];
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}

#pragma mark - 3. 最后一步，把selector的所有细节包程NSInvocation, invocation对象负责分发消息给其他对象，这一步是完整的转发机制
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    // (1)
//    if ([NSStringFromSelector(aSelector) isEqualToString:@"setName:"]) {
//        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//    }
//    return [super methodSignatureForSelector:aSelector];
    // (2)
    NSMethodSignature *signature = [super methodSignatureForSelector: aSelector];
    if (signature == nil) {
        if ([SomeOtherObject instancesRespondToSelector:aSelector]) {
            signature = [SomeOtherObject instanceMethodSignatureForSelector:aSelector];
        }
    }
    return signature; // 只有当返回值不是空的时候才能转发成功
}
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [anInvocation invokeWithTarget:[[SomeOtherObject alloc] init]];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.name = @"pangshishan";
    
    
//    NSString *str = @"123456789";
//    NSLog(@"=%d, =%d", [str hasPrefix:@"1234"], [str hasSuffix:@"6789"]);
}


@end







