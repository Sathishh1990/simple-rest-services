//
//  ListHeadDataModel.m
//  AboutCanada
//
//  Created by Sathish on 2018-02-11.
//  Copyright © 2018 Sathish. All rights reserved.
//

#import "ListHeadDataModel.h"
#import "ListDataModel.h"

@implementation ListHeadDataModel

-(void)configureModelWithDictionary:(NSDictionary *)dictionary {
    self.strMainTitle = dictionary[@"title"];
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSDictionary *dict in dictionary[@"rows"]) {
        ListDataModel *model = [ListDataModel new];
        if ([dict[@"title"] isKindOfClass:[NSString class]]) {
            model.strTitle = dict[@"title"];
        } else {
            model.strTitle = @"";
        }
        if ([dict[@"description"] isKindOfClass:[NSString class]]) {
            model.strDescription = dict[@"description"];
        } else {
            model.strDescription = @"";
        }
        if ([dict[@"imageHref"] isKindOfClass:[NSString class]]) {
            model.imgUrl = dict[@"imageHref"];
        } else {
            model.imgUrl = @"";
        }
        [tempArr addObject:model];
    }
    self.arrListData = tempArr;
}

@end
