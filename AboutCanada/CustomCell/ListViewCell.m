//
//  ListViewCell.m
//  AboutCanada
//
//  Created by Sathish on 2018-02-11.
//  Copyright © 2018 Sathish. All rights reserved.
//

#import "ListViewCell.h"
#import "UIImageView+WebCache.h"

#define kLeadingSpace 10
#define kTrailingSpace 10
#define kTopSpace 10
#define kImgWidth 100
#define kPadding 20

@implementation ListViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.contentView addSubview:self.imgView];
    
    self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.lblTitle.numberOfLines = 0;
    [self.contentView addSubview:self.lblTitle];
    
    self.lblDescription = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.lblDescription.numberOfLines = 0;
    [self.contentView addSubview:self.lblDescription];
}

- (void)setFrameFoeSubviews {
    self.imgView.frame = CGRectMake(kLeadingSpace, kTopSpace, kImgWidth, kImgWidth);
    int titleStartPos = self.imgView.frame.origin.x+kImgWidth+kPadding;
    self.lblTitle.frame = CGRectMake(titleStartPos, kTopSpace, [UIScreen mainScreen].bounds.size.width - titleStartPos - kTrailingSpace, 20);
    self.lblDescription.frame = CGRectMake(titleStartPos, kTopSpace + self.lblTitle.frame.size.height + kPadding +10, [UIScreen mainScreen].bounds.size.width - titleStartPos - kTrailingSpace, 20);
    [self.lblTitle sizeToFit];
    [self.lblDescription sizeToFit];
}

- (void)setTitle:(NSString *)title description:(NSString *)description imgageUrl:(NSString *)imgUrl {
    self.lblTitle.text = title;
    self.lblDescription.text = description;
    [self.imgView setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"noimage"] options:0];
    [self setFrameFoeSubviews];
}

- (CGFloat )calculateCellHeight {
    CGFloat height = kTopSpace + self.lblTitle.frame.size.height + kPadding + self.lblDescription.frame.size.height + kTopSpace ;
    if (height < kTopSpace + kImgWidth + kTopSpace) {
        height = kTopSpace + kImgWidth + kTopSpace;
    }
    return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
