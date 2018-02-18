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
#import "UIImageView+WebCache.h"

@interface ListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (strong, nonatomic) NSArray *arrayOfData;
@property (strong, nonatomic) ListHeadDataModel *dataModel;
@property (strong, nonatomic) UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIView *erroeView;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpLoadingView];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [self.listTableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshPage:) forControlEvents:UIControlEventValueChanged];

    [self getListOfDataWithSender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                self.erroeView.hidden = YES;
                [self.loadingView removeFromSuperview];
                [self.listTableView reloadData];
            } else {
                self.listTableView.hidden = YES;
                self.erroeView.hidden = NO;
                self.errorLabel.text = error.localizedDescription;
                [self.loadingView removeFromSuperview];
            }
            if (sender){
                [sender endRefreshing];
            }
        });
    }];
}

#pragma mark - Button action

- (IBAction)btnRefreshTapped:(id)sender {
    [self setUpLoadingView];
    [self getListOfDataWithSender:nil];
}

#pragma Tableview datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListDataModel *data = (ListDataModel *)[self.arrayOfData objectAtIndex:indexPath.row];
    ListViewCell *cell = (ListViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ListViewCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lblTitle.text = data.strTitle;
    cell.lblDescription.text = data.strDescription;
    [cell.imgView setImageWithURL:[NSURL URLWithString:data.imgUrl] placeholderImage:[UIImage imageNamed:@"noimage"] options:0];
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
    return UITableViewAutomaticDimension;
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

@end
