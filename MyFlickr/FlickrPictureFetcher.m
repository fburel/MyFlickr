//
//  FlickrPictureFetcher.m
//  MyFlickr
//
//  Created by Florian BUREL on 09/07/2014.
//  Copyright (c) 2014 florian burel. All rights reserved.
//

#import "FlickrPictureFetcher.h"
#import "Picture.h"


#define     API_KEY     @"edd17c0c4d413be050ffdba18c74c0e1"

@implementation FlickrPictureFetcher

- (NSArray *)picturesAroundLocation:(PictureFetcherLocation)location
{
    // generer l'url
    NSString * baseURL = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&lat=%g&lon=%g&format=json&nojsoncallback=1", API_KEY, location.latitude, location.longitude];
    NSURL * url = [NSURL URLWithString:baseURL];
    
    // Téléchargement de la réponse
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    // Conversion au format JSON
    NSDictionary * jsonAnswer = [NSJSONSerialization JSONObjectWithData:data
                                                    options:0
                                                      error:nil];
    
    // Parsing du json - Création du tableau de picture

    NSMutableArray * pictures = [NSMutableArray new];
    for(NSDictionary * item in jsonAnswer[@"photos"][@"photo"])
    {
        Picture * p = [Picture new];
        p.title = item[@"title"];
        
        NSString * urlAsString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", item[@"farm"], item[@"server"], item[@"id"], item[@"secret"]];
        
        p.url = [NSURL URLWithString:urlAsString];
        
        [pictures addObject:p];
    }
    
    
    
    return [pictures copy];
}

- (void)pictureAroundLocation:(PictureFetcherLocation)location completion:(CompletionBlock)completion
{
    
    dispatch_queue_t backGroundQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_async(backGroundQ, ^{
        
        NSArray * pictures = [self picturesAroundLocation:location];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(pictures);
        });
        

    });
    
    
}
@end





