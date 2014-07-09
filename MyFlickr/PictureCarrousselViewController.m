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
    
    // Temporaire : creation d'une position par défaut
    PictureFetcherLocation kazantip;
    kazantip.latitude = 45.29194;
    kazantip.longitude = 33.03833;
    
    // Recuperation de la liste des photos
    FlickrPictureFetcher * fetcher = [FlickrPictureFetcher new];
    self.pictures = [fetcher picturesAroundLocation:kazantip];
    
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
    
    return imageView;
}

@end


















