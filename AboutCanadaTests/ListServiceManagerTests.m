//
//  ListServiceManagerTests.m
//  AboutCanadaTests
//
//  Created by Sathish on 2018-02-14.
//  Copyright © 2018 Sathish. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ListServiceManager.h"

@interface ListServiceManagerTests : XCTestCase

@property(strong, nonatomic) ListServiceManager *listManager;

@end

@implementation ListServiceManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.listManager = [ListServiceManager new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.listManager = nil;
    [super tearDown];
}

- (void)testServiceCall {
    XCTestExpectation *exp = [self expectationWithDescription:@"getdata"];
    
    [self.listManager getListOfDatawithCompltionHandler:^(id resultData, NSError *error) {
        if (!resultData) {
            XCTFail(@"getting data failed");
        }
        [exp fulfill];
    }];
    [self waitForExpectationsWithTimeout:1 handler:nil];;
}

@end
