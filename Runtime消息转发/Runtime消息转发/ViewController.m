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
//    // 当方法是setter方法时
//    if (sel == @selector(setName:)) {
//        // 动态给本类添加方法
//        class_addMethod([SomeOtherObject class], sel, (IMP)dynamicMethodIMP, "v@:");
//    }
//
//    return [super resolveInstanceMethod:sel];
//}

#pragma mark - 2. 找个类处理她
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"setName:"]) {
        return [[SomeOtherObject alloc] init];
    }
    return [super forwardingTargetForSelector:aSelector];
}

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
// anInvocation里打包了此类不能处理的selector所有的细节
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    // 将anInvocation里打包的消息，发送给SomeOtherObject处理，如果SomeOtherObject也不能处理，可以在它里面继续转发
    // 这也是变相的实现了多继承，但是消息转发只是将一部分功能放到其他类，并没有多继承造成的代码过于丰富的问题
    [anInvocation invokeWithTarget:[[SomeOtherObject alloc] init]];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.name = @"pangshishan";
}


@end







