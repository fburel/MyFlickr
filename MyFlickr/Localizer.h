//
//  Localizer.h
//  MyFlickr
//
//  Created by Florian BUREL on 15/07/2014.
//  Copyright (c) 2014 florian burel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class City;

@interface Localizer : NSObject

+ (instancetype) sharedInstance;

- (void)startUpdatingLocationForCity:(City *)city;

@end
