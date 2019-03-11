//
//  SpareWheel.m
//  RuntimeForwardInvocation
//
//  Created by 庞仕山 on 2019/3/11.
//  Copyright © 2019年 庞仕山. All rights reserved.
//

#import "SpareWheel.h"

@implementation SpareWheel

- (void)sendMsg:(NSString *)msg {
    NSLog(@"备胎 - %@", msg);
}
+ (void)sendMsg:(NSString *)msg {
    NSLog(@"++++ 备胎 - %@", msg);
}

@end
