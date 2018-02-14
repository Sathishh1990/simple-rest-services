//
//  LoginViewControllerTests.m
//  AboutCanadaTests
//
//  Created by Sathish on 2018-02-11.
//  Copyright © 2018 Sathish. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginViewController.h"

@interface LoginViewController (test)

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
- (IBAction)loginButtonTapped:(id)sender;
-(void)validateInput;

@end

@interface LoginViewControllerTests : XCTestCase <UITextFieldDelegate>

@property (nonatomic, strong) LoginViewController *loginViewController;

@end

@implementation LoginViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.loginViewController = [homeStoryBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.loginViewController = nil;
    [super tearDown];
}

- (void)testValidateInput {
    self.loginViewController.txtUsername.text = @"test";
    self.loginViewController.txtPassword.text = @"12345";
    [self.loginViewController validateInput];
    XCTAssertFalse(self.loginViewController.btnLogin.enabled,@"validation is success");
}

- (void)testValidateExpInput {
    self.loginViewController.txtUsername.text = @"test";
    self.loginViewController.txtPassword.text = @"123456";
    [self.loginViewController validateInput];
    XCTAssertTrue(self.loginViewController,@"validation is success");
}

- (void)testLoginAction {
    [self.loginViewController loginButtonTapped:nil];
}

-(void)testSpecialChar {
    BOOL valid = [self.loginViewController.txtUsername shouldChangeTextInRange:0 replacementText:@"@" ];
    XCTAssertFalse(valid);
}
@end
