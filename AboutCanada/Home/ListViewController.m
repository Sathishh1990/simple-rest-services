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

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([ListViewCell class]) bundle:nil];
    [self.listTableView registerNib:cellNib forCellReuseIdentifier:NSStringFromClass([ListViewCell class])];
    
    self.loadingView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.loadingView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
    self.loadingView.alpha = 0.7f;
    [self.view addSubview:self.loadingView];
    
    
    [self getListOfData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Fetch data

- (void)getListOfData {
    ListServiceManager *listManager = [[ListServiceManager alloc] init];
    [listManager getListOfDatawithCompltionHandler:^(id resultData, NSError *error) {

        self.dataModel = [ListHeadDataModel new];
        if (resultData) {
            [self.dataModel configureModelWithDictionary:resultData];
        } else {
            [self.loadingView removeFromSuperview];
        }
        
        self.arrayOfData = self.dataModel.arrListData;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loadingView removeFromSuperview];
            [self.listTableView reloadData];
        });
    }];
}

#pragma mark - Button action

- (IBAction)btnLogoutTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    [cell.imgView setImageWithURL:[NSURL URLWithString:data.imgUrl] placeholderImage:[UIImage imageNamed:@"loading"] options:0];
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

@end
