//
//  ListViewCell.h
//  AboutCanada
//
//  Created by Sathish on 2018-02-11.
//  Copyright © 2018 Sathish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *lblTitle;
@property (strong, nonatomic) UILabel *lblDescription;

- (void)setTitle:(NSString *)title description:(NSString *)description imgageUrl:(NSString *)imgUrl;
- (CGFloat)calculateCellHeight;

@end
