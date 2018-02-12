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

- (IBAction)loginButtonTapped:(id)sender;

@end

@interface LoginViewControllerTests : XCTestCase

@property (nonatomic, strong) LoginViewController *loginViewController;

@end

@implementation LoginViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.loginViewController = [[LoginViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.loginViewController = nil;
    [super tearDown];
}

- (void)testLoginAction {
    [self.loginViewController loginButtonTapped:nil];
}

@end
