//
//  ListHeadDataModel.h
//  AboutCanada
//
//  Created by Sathish on 2018-02-11.
//  Copyright © 2018 Sathish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListHeadDataModel : NSObject

@property (strong,nonatomic) NSString *strMainTitle;
@property (strong,nonatomic) NSArray *arrListData;
-(void)configureModelWithDictionary:(NSDictionary *)dictionary;

@end
