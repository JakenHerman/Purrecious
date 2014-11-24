//
//  JRCPhotosViewControllerCollectionViewController.m
//  Purrecious
//
//  Created by Jaken School Work on 11/23/14.
//  Copyright (c) 2014 Jolly Roger Company. All rights reserved.
//

#import "JRCPhotosViewControllerCollectionViewController.h"
#import "JRCPhotoCell.h"

@interface JRCPhotosViewControllerCollectionViewController ()

@end

@implementation JRCPhotosViewControllerCollectionViewController

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(106.0, 106.0);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    
    return (self = [super initWithCollectionViewLayout:layout]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Purrecious";
    
    [self.collectionView registerClass:[JRCPhotoCell class] forCellWithReuseIdentifier:@"photo"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [[NSURL alloc] initWithString: @"http://jaken.me"];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSString *text = [[NSString alloc] initWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
       
        NSLog(@"Response: %@", text);
    }];
    [task resume];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    
    return cell;
}

@end
