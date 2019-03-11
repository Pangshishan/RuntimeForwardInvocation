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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    MsgObject *msgObj = [[MsgObject alloc] init];
    objc_msgSend(msgObj, NSSelectorFromString(@"sendMsg:"), @"hello");
    
//    objc_msgSend([MsgObject class], NSSelectorFromString(@"sendMsg:"),  @"hello");
}




@end

