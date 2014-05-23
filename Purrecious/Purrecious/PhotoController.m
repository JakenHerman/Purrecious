//
//  PhotoController.m
//  Purrecious
//
//  Created by Jaken Herman on 5/22/14.
//  Copyright (c) 2014 Jaken Herman. All rights reserved.
//

#import "PhotoController.h"
#import <SAMCache/SAMCache.h>

@implementation PhotoController


+ (void)imageForPhoto: (NSDictionary *)photo size:(NSString *)size completion:(void(^)(UIImage *image))completion

{
    
    if (photo == nil || size == nil || completion == nil){
        return;
    }
    
    NSString *key = [[NSString alloc] initWithFormat:@"%@-%@", photo[@"id"], size];
    UIImage *image = [[SAMCache sharedCache] imageForKey:key];
    
    if (image){
        
      completion(image);
        return;
    }
    
    NSURL *url = [[NSURL alloc] initWithString:photo[@"images"][size ][@"url"]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task  = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:[location path]];
        UIImage *image = [[UIImage alloc] initWithData:data];
        [[SAMCache sharedCache] setImage:image forKey:key];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(image);
        });
        
    }];
    
    [task resume];
}

@end


