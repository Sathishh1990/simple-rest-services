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
- (void)btnRefreshTapped:(UIButton *)sender;
- (void)refreshPage:(UIRefreshControl *)sender;

@end

@interface ListViewControllerTests : XCTestCase

@property (nonatomic, strong) ListViewController *listViewController;

@end

@implementation ListViewControllerTests

- (void)setUp {
    [super setUp];
    self.listViewController = [[ListViewController alloc] init];
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
    NSString *expectedReuseIdentifier = @"listCell";
    XCTAssertTrue([cell.reuseIdentifier isEqualToString:expectedReuseIdentifier], @"Table does not create reusable cells");
}

- (void)testPrvateMethods {
    [self.listViewController refreshPage:nil];
    [self.listViewController btnRefreshTapped:nil];
}

@end
