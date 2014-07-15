//
//  City+DAO.m
//  MyFlickr
//
//  Created by Florian BUREL on 10/07/2014.
//  Copyright (c) 2014 florian burel. All rights reserved.
//

#import "City+DAO.h"
#import "AppDelegate.h"

#import "Localizer.h"

@implementation City (DAO)

+ (NSManagedObjectContext *)context
{
    static NSManagedObjectContext * __Context;
    
    if(!__Context)
    {
        AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
        __Context = appDelegate.managedObjectContext;
    }
    return __Context;
}

+ (City *)new
{
    City * city = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:[self context]];
    
    
    /* 
     LOCALISATION + REVERSE GEOCODING
     */
    Localizer * l = [Localizer sharedInstance];
    [l startUpdatingLocationForCity:city];
    
    return city;
}

+ (void)delete:(City *)city
{
    [[self context] deleteObject:city];
}

+ (NSArray *) allCities
{
    NSFetchRequest * request = [[NSFetchRequest alloc]initWithEntityName:@"City"];
    return [[self context] executeFetchRequest:request error:nil];
}
@end
