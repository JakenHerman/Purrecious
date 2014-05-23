//
//  DetailViewController.m
//  Purrecious
//
//  Created by Jaken Herman on 5/22/14.
//  Copyright (c) 2014 Jaken Herman. All rights reserved.
//

#import "DetailViewController.h"
#import "PhotoController.h"

@interface DetailViewController ()
@property (nonatomic) UIImageView *imageView;
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    [self.view addSubview:self.imageView];
    
    [PhotoController imageForPhoto:self.photo size:@"standard_resolution" completion:^ (UIImage *image){
        self.imageView.image=image;
    }];

}
@end
