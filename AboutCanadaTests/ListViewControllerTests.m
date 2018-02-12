//
//  ListViewControllerTests.m
//  AboutCanadaTests
//
//  Created by Sathish on 2018-02-11.
//  Copyright © 2018 Sathish. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ListViewController.h"

@interface ListViewController (test) <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
- (IBAction)btnLogoutTapped:(id)sender;

@end

@interface ListViewControllerTests : XCTestCase

@property (nonatomic, strong) ListViewController *listViewController;

@end

@implementation ListViewControllerTests

- (void)setUp {
    [super setUp];
    UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.listViewController = [homeStoryBoard instantiateViewControllerWithIdentifier:@"ListViewController"];
        for (UIView *view in self.listViewController.view.subviews) {
            if ([view isKindOfClass:[UITableView class]]){
                self.listViewController.listTableView = (UITableView *)view;
                break;
            }
        }
}

- (void)tearDown {
    self.listViewController = nil;
    [super tearDown];
}

-(void)testThatTableViewLoads {
    [self.listViewController.listTableView reloadData];
    XCTAssertNotNil(self.listViewController.listTableView, @"TableView not initiated");
}

- (void)testTableViewHasDataSource {
    XCTAssertNotNil(self.listViewController.listTableView.dataSource, @"Table datasource cannot be nil");
}

- (void)testTableViewIsConnectedToDelegate {
    XCTAssertNotNil(self.listViewController.listTableView.delegate, @"Table delegate cannot be nil");
}

- (void)testReuseIdentifierCubaWarningCell {
    UITableViewCell *cell = [self.listViewController tableView:self.listViewController.listTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *expectedReuseIdentifier = @"ListViewCell";
    XCTAssertTrue([cell.reuseIdentifier isEqualToString:expectedReuseIdentifier], @"Table does not create reusable cells");
}

@end
