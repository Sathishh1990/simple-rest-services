//
//  ListViewController.m
//  AboutCanada
//
//  Created by Sathish on 2018-02-11.
//  Copyright © 2018 Sathish. All rights reserved.
//

#import "ListViewController.h"
#import "ListViewCell.h"
#import "ListHeadDataModel.h"
#import "ListServiceManager.h"
#import "ListDataModel.h"

@interface ListViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *listTableView;
@property (strong, nonatomic) NSArray *arrayOfData;
@property (strong, nonatomic) ListHeadDataModel *dataModel;
@property (strong, nonatomic) UIView *loadingView;
@property (strong, nonatomic) UILabel *errorLabel;
@property (strong, nonatomic) UIButton *btnRefresh;
@property (strong, nonatomic) NSMutableDictionary *dictCellHeight;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.dictCellHeight = [NSMutableDictionary dictionary];
    
    self.btnRefresh = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnRefresh.frame = CGRectMake(0, 20, 100, 30);
    [self.btnRefresh addTarget:self action:@selector(btnRefreshTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnRefresh setTitle:@"Refresh" forState:UIControlStateNormal];
    [self.view addSubview:self.btnRefresh];
    
    self.listTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    [self.view addSubview:self.listTableView];
    
    self.listTableView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leftSpace = [NSLayoutConstraint constraintWithItem:self.listTableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *topSpace = [NSLayoutConstraint constraintWithItem:self.listTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:50];
    NSLayoutConstraint *rightSpace = [NSLayoutConstraint constraintWithItem:self.listTableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bottomSpace = [NSLayoutConstraint constraintWithItem:self.listTableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.view addConstraints:@[leftSpace, topSpace, rightSpace, bottomSpace]];

    self.listTableView.estimatedRowHeight = 100.0f;
    self.listTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self setUpLoadingView];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.listTableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshPage:) forControlEvents:UIControlEventValueChanged];

    [self getListOfDataWithSender:nil];
    
    self.errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.btnRefresh.frame.origin.y + self.btnRefresh.frame.size.height + 10, self.listTableView.frame.size.width-20, 20)];
    self.errorLabel.textColor = [UIColor redColor];
    self.errorLabel.numberOfLines = 0;
    [self.view addSubview:self.errorLabel];
    self.errorLabel.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:)    name:UIDeviceOrientationDidChangeNotification  object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

#pragma mark - Fetch data

- (void)getListOfDataWithSender:(UIRefreshControl *)sender {
    ListServiceManager *listManager = [[ListServiceManager alloc] init];
    [listManager getListOfDatawithCompltionHandler:^(id resultData, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataModel = [ListHeadDataModel new];
            if (resultData) {
                [self.dataModel configureModelWithDictionary:resultData];
                self.arrayOfData = self.dataModel.arrListData;
                self.listTableView.hidden = NO;
                self.errorLabel.hidden = YES;
                [self.loadingView removeFromSuperview];
                [self.listTableView reloadData];
            } else {
                self.listTableView.hidden = YES;
                self.errorLabel.hidden = NO;
                self.errorLabel.text = [error.localizedDescription stringByAppendingString:@"\n Please try again later"];
                [self.errorLabel sizeToFit];
                [self.loadingView removeFromSuperview];
            }
            if (sender){
                [sender endRefreshing];
            }
        });
    }];
}

#pragma Tableview datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListDataModel *data = (ListDataModel *)[self.arrayOfData objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"listCell";
    ListViewCell *cell = (ListViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setTitle:data.strTitle description:data.strDescription imgageUrl:data.imgUrl];
    CGFloat height = [cell calculateCellHeight];
    
    [self.dictCellHeight setValue:@(height) forKey:[@(indexPath.row) stringValue]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrayOfData count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.dataModel.strMainTitle;
}

#pragma Tableview delegate methods

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [[self.dictCellHeight objectForKey:[@(indexPath.row) stringValue]] floatValue];
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.backgroundView.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:128.0f/255.0f blue:0.0f/255.0f alpha:1.0f];;
    header.textLabel.textColor = [UIColor whiteColor];
    header.textLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - private method

- (void)btnRefreshTapped:(UIButton *)sender {
    [self getListOfDataWithSender:nil];
}

- (void)setUpLoadingView {
    self.loadingView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.loadingView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:0.8f];
    self.loadingView.alpha = 0.7f;
    UILabel *lblLoading = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    lblLoading.text = @"Loading...";
    lblLoading.textColor = [UIColor whiteColor];
    lblLoading.center = self.loadingView.center;
    [self.loadingView addSubview:lblLoading];
    
    [self.view addSubview:self.loadingView];
}

- (void)refreshPage:(UIRefreshControl *)sender {
    [self getListOfDataWithSender:sender];
}

- (void) orientationChanged:(UIInterfaceOrientation) orientation {
    [self.listTableView reloadData];
}

@end
