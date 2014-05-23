//
//  PhotosViewController.m
//  Purrecious
//
//  Created by Jaken Herman on 5/21/14.
//  Copyright (c) 2014 Jaken Herman. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoCell.h"
#import "DetailViewController.h"

#import <SimpleAuth/SimpleAuth.h>

@interface PhotosViewController ()

@property (nonatomic) NSString *accessToken;
@property (nonatomic) NSArray *photos;

@end

@implementation PhotosViewController

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(106.0, 106.0);
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    return (self = [super initWithCollectionViewLayout:layout]);
};

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"photo"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Purrecious";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.accessToken = [userDefaults objectForKey:@"accessToken"];
    
    if (self.accessToken == nil){
    
        [SimpleAuth authorize:@"instagram" options:@{@"scope": @[@"likes"]} completion:^(NSDictionary *responseObject, NSError *error)
    
    {
        
        self.accessToken = responseObject[@"credentials"][@"token"];
        [userDefaults setObject:self.accessToken forKey:@"accessToken"];
        [userDefaults synchronize];
        
        [self refresh];
        
    }];
    
    }
    else{
        [self refresh];
           }
}

- (void) refresh{
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/tags/cats/media/recent?access_token=%@", self.accessToken];
     NSString *urlString2 = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/tags/Purrecious/media/recent?access_token=%@", self.accessToken];
    
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSURL *url2 = [[NSURL alloc]initWithString:urlString2];

    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLRequest *request2 = [[NSURLRequest alloc]initWithURL:url2];

    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data =[[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        self.photos = [responseDictionary valueForKeyPath:@"data"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
    }];
    NSURLSessionDownloadTask *task2 = [session downloadTaskWithRequest:request2 completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data2 =[[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data2 options:kNilOptions error:nil];
        
        self.photos = [responseDictionary valueForKeyPath:@"data"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
    }];
    [task resume];
    [task2 resume];
    

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.photos count];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.photo = self.photos[indexPath.row];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *photo = self.photos[indexPath.row];
    DetailViewController *viewController = [[DetailViewController alloc] init];
    viewController.photo = photo;
    
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
