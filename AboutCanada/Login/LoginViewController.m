//
//  LoginViewController.m
//  AboutCanada
//
//  Created by Sathish on 2018-02-11.
//  Copyright © 2018 Sathish. All rights reserved.
//

#import "LoginViewController.h"
#import "ListViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self validateInput];
}

#pragma mark - Private method

-(void)validateInput {
    if (self.txtUsername.text.length && self.txtPassword.text.length >= 5) {
        self.btnLogin.enabled = YES;
        self.btnLogin.backgroundColor = [UIColor orangeColor];
    } else {
        self.btnLogin.enabled = NO;
        self.btnLogin.backgroundColor = [UIColor lightGrayColor];
    }
}

#pragma mark - IBAction method
- (IBAction)loginButtonTapped:(id)sender {
    UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListViewController *listVC = [homeStoryBoard instantiateViewControllerWithIdentifier:@"ListViewController"];
    [self presentViewController:listVC animated:YES completion:nil];
}

#pragma mark - UITextFielddelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self validateInput];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL isHaveSpecialChar = NO;
    if (textField == self.txtUsername) {
        NSString *customStr = @"~`!@#$%^&*()+=-/;:\"\'{}[]<>^?, ";
        NSCharacterSet *alphaSet = [NSCharacterSet characterSetWithCharactersInString:customStr];
        isHaveSpecialChar = [[string stringByTrimmingCharactersInSet:alphaSet] isEqualToString:@""];
    }
    [self validateInput];
    return !isHaveSpecialChar;
}

@end
