//
//  JRCPhotoCell.m
//  Purrecious
//
//  Created by Jaken School Work on 11/23/14.
//  Copyright (c) 2014 Jolly Roger Company. All rights reserved.
//

#import "JRCPhotoCell.h"

@implementation JRCPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.image = [UIImage imageNamed: @"Icon-72"];
        [self.contentView addSubview:self.imageView];
    }
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;
}

@end
