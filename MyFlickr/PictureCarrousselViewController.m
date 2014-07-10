//
//  PictureCarrousselViewController.m
//  MyFlickr
//
//  Created by Florian BUREL on 09/07/2014.
//  Copyright (c) 2014 florian burel. All rights reserved.
//

#import "PictureCarrousselViewController.h"
#import "ReaderView.h"
#import "Picture.h"
#import "FlickrPictureFetcher.h"

@interface PictureCarrousselViewController ()
<ReaderViewDelegate>

@property (weak, nonatomic) IBOutlet ReaderView *readerView;
@property (strong, nonatomic) NSArray * pictures;

@end

@implementation PictureCarrousselViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    PictureFetcherLocation location;
    location.latitude = self.city.latitude.doubleValue;
    location.longitude = self.city.longitude.doubleValue;
    
    self.readerView.hidden = YES;
    
    // Recuperation de la liste des photos
    FlickrPictureFetcher * fetcher = [FlickrPictureFetcher new];
    [fetcher pictureAroundLocation:location completion:^(NSArray *pictures)
    {
        self.pictures = pictures;
        
        self.readerView.hidden = NO;
        
        [self.readerView displayPageAtIndex:0 animated:NO];
    }];
    
    self.readerView.delegate = self;

}

- (int)numberOfPages
{
    return self.pictures.count;
}

- (UIView *)viewForPageAtIndex:(NSInteger)idx
{
    Picture * p = self.pictures[idx];
    NSData * imageData = [NSData dataWithContentsOfURL:p.url]; // telechargement!
    UIImage * emile = [UIImage imageWithData:imageData];
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:emile];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return imageView;
}

@end


















