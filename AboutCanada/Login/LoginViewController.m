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

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction method
- (IBAction)loginButtonTapped:(id)sender {
    UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListViewController *listVC = [homeStoryBoard instantiateViewControllerWithIdentifier:@"ListViewController"];
    [self presentViewController:listVC animated:YES completion:nil];
}

@end
