//
//  FlickrPictureFetcher.h
//  MyFlickr
//
//  Created by Florian BUREL on 09/07/2014.
//  Copyright (c) 2014 florian burel. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef struct {
    double longitude;
    double latitude;
} PictureFetcherLocation;

typedef void(^CompletionBlock)(NSArray * pictures);

@interface FlickrPictureFetcher : NSObject

- (void) pictureAroundLocation:(PictureFetcherLocation)location completion:(CompletionBlock)completion;

@end
