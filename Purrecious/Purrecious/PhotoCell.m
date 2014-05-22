//
//  PhotoCell.m
//  Purrecious
//
//  Created by Jaken Herman on 5/21/14.
//  Copyright (c) 2014 Jaken Herman. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]init];
        self.imageView.image = [UIImage imageNamed:@"filler"];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}


- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
