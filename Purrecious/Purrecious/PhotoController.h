//
//  PhotoController.h
//  Purrecious
//
//  Created by Jaken Herman on 5/22/14.
//  Copyright (c) 2014 Jaken Herman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoController : NSObject

+ (void)imageForPhoto: (NSDictionary *)photo size:(NSString *)size completion:(void(^)(UIImage *image))completion;

@end
