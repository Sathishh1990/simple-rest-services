//
//  ListViewController.m
//  AboutCanada
//
//  Created by Sathish on 2018-02-11.
//  Copyright © 2018 Sathish. All rights reserved.
//

#import "ListViewController.h"
#import "ListViewCell.h"
#import "ListDataModel.h"

@interface ListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (strong, nonatomic) NSArray *arrayOfData;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([ListViewCell class]) bundle:nil];
    [self.listTableView registerNib:cellNib forCellReuseIdentifier:NSStringFromClass([ListViewCell class])];
    
    NSMutableArray *tempArray = [NSMutableArray new];
    for(int i=0; i<5; i++) {
        ListDataModel *model = [ListDataModel new];
        model.strTitle = @"title";
        model.strDescription = @"description";
        [tempArray addObject:model];
    }
    self.arrayOfData = tempArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    cell.imageView.image = [UIImage imageNamed:@"loading"];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrayOfData count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"About Canada";
}

#pragma Tableview delegate methods

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
