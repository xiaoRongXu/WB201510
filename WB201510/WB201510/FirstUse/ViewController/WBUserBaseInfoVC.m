//
//  WBUserBaseInfoVC.m
//  WB201510
//
//  Created by wwwbbat on 15/10/5.
//  Copyright © 2015年 wwwbbat. All rights reserved.
//

#import "WBUserBaseInfoVC.h"
#import <IQKeyboardManager/IQKeyboardReturnKeyHandler.h>

@interface WBUserBaseInfoVC ()<UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ganderTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UITextField *hospitalTextField;
@property (weak, nonatomic) IBOutlet UITextField *doctorTextField;

@property (strong, nonatomic) IQKeyboardReturnKeyHandler *IQKeyboardHandler;

@end

@implementation WBUserBaseInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initUI];
    [self _setupTextField];
}

- (void)_initUI{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"填写信息";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
}

- (void)_setupTextField{
    self.IQKeyboardHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.IQKeyboardHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    self.IQKeyboardHandler.toolbarManageBehaviour = IQAutoToolbarByPosition;
    
    [self.IQKeyboardHandler addTextFieldView:self.nicknameTextField];
    [self.IQKeyboardHandler addTextFieldView:self.passwordTextField];
    [self.IQKeyboardHandler addTextFieldView:self.usernameTextField];
    [self.IQKeyboardHandler addTextFieldView:self.ganderTextField];
    [self.IQKeyboardHandler addTextFieldView:self.birthdayTextField];
    [self.IQKeyboardHandler addTextFieldView:self.phoneTextField];
    [self.IQKeyboardHandler addTextFieldView:self.emailTextField];
    [self.IQKeyboardHandler addTextFieldView:self.weightTextField];
    [self.IQKeyboardHandler addTextFieldView:self.heightTextField];
    [self.IQKeyboardHandler addTextFieldView:self.hospitalTextField];
    [self.IQKeyboardHandler addTextFieldView:self.doctorTextField];
    self.IQKeyboardHandler.delegate = self;
}

- (void)done:(id)sender{
    [self.view endEditing:YES];
    NSLog(@"%@",sender);
}

- (void)dealloc{
    self.IQKeyboardHandler = nil;
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    if (textField == self.ganderTextField) {
//        [self.phoneTextField becomeFirstResponder];
//        return NO;
//    }
//    if (textField == self.birthdayTextField) {
//        [self.phoneTextField becomeFirstResponder];
//        return NO;
//    }
//    if (textField == self.hospitalTextField) {
//        [self.doctorTextField becomeFirstResponder];
//        return NO;
//    }
    return YES;
}

@end
