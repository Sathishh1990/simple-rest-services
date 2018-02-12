//
//  ListServiceManager.h
//  AboutCanada
//
//  Created by Sathish on 2018-02-11.
//  Copyright © 2018 Sathish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListServiceManager : NSObject

/*
 Method to get all list of data
 */

-(void)getListOfDatawithCompltionHandler :(void(^)(id resultData, NSError *error))completion;

@end
