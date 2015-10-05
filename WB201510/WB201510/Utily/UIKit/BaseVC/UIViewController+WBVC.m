//
//  UIViewController+WBVC.m
//  WB201510
//
//  Created by wwwbbat on 15/10/5.
//  Copyright © 2015年 wwwbbat. All rights reserved.
//

#import "UIViewController+WBVC.h"

@implementation UIViewController (WBVC)

+ (instancetype)instanceFromStoryboard
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    return vc;
}

@end
