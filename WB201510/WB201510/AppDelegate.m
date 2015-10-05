//
//  AppDelegate.m
//  WB201510
//
//  Created by wwwbbat on 15/10/5.
//  Copyright © 2015年 wwwbbat. All rights reserved.
//

#import "AppDelegate.h"
#import "WBWelcomeVC.h"
#import "WBFirstUseNVC.h"
#import <IQKeyboardManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self loadFirstUseViewControllers];
    
    IQKeyboardManager *km = [IQKeyboardManager sharedManager];
    km.enable = YES;
    km.shouldResignOnTouchOutside = YES;
    km.enableAutoToolbar = YES;
    km.shouldPlayInputClicks = YES;
    
    return YES;
}

- (void)loadFirstUseViewControllers{
    WBWelcomeVC *vc = [[WBWelcomeVC alloc] init];
    WBFirstUseNVC *nvc = [[WBFirstUseNVC alloc] initWithRootViewController:vc];
    self.window.rootViewController = nvc;
}

@end
