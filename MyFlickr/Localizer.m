//
//  Localizer.m
//  MyFlickr
//
//  Created by Florian BUREL on 15/07/2014.
//  Copyright (c) 2014 florian burel. All rights reserved.
//

#import "Localizer.h"

#import "City.h"
@import CoreLocation;

@implementation Localizer


+ (instancetype)sharedInstance {
    static id __SharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __SharedInstance = [[self alloc] init];
    });
    return __SharedInstance;
}

- (void)startUpdatingLocationForCity:(City *)city
{
    
}
@end
