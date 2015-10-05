//
//  WBWelcomeVC.m
//  WB201510
//
//  Created by wwwbbat on 15/10/5.
//  Copyright © 2015年 wwwbbat. All rights reserved.
//

#import "WBWelcomeVC.h"
#import "WBUserBaseInfoVC.h"

@interface WBWelcomeVC ()

@end

@implementation WBWelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (IBAction)start:(id)sender{
    WBUserBaseInfoVC *vc = [WBUserBaseInfoVC instanceFromStoryboard];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
