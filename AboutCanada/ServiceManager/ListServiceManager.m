//
//  ListServiceManager.m
//  AboutCanada
//
//  Created by Sathish on 2018-02-11.
//  Copyright © 2018 Sathish. All rights reserved.
//

#import "ListServiceManager.h"

#define LIST_URL @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

@interface ListServiceManager () <NSURLConnectionDelegate>

@property (strong, nonatomic) NSMutableData *responseData;

@end

@implementation ListServiceManager

-(void)getListOfDatawithCompltionHandler :(void(^)(id resultData, NSError *error))completion {
    
    NSURL *url = [NSURL URLWithString:LIST_URL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];

/*    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *jsonResponse;
        if (!error) {
            NSString *outputStrData = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSData *outputData = [outputStrData dataUsingEncoding:NSUTF8StringEncoding];
            jsonResponse = [NSJSONSerialization JSONObjectWithData:outputData
                                                           options:kNilOptions
                                                             error:&error];
        }
        completion(jsonResponse, error);
    }];
    
    [dataTask resume];
  */
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSDictionary *jsonResponse;
        if (!error) {
            NSString *outputStrData = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSData *outputData = [outputStrData dataUsingEncoding:NSUTF8StringEncoding];
            jsonResponse = [NSJSONSerialization JSONObjectWithData:outputData
                                                           options:kNilOptions
                                                             error:&error];
        }
        completion(jsonResponse, error);
    }];
}

@end
