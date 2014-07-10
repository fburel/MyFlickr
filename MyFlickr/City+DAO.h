//
//  City+DAO.h
//  MyFlickr
//
//  Created by Florian BUREL on 10/07/2014.
//  Copyright (c) 2014 florian burel. All rights reserved.
//

#import "City.h"

@interface City (DAO)

+ (void) delete:(City *)city;

+ (NSArray *) allCities;

+ (City *) new;

@end
