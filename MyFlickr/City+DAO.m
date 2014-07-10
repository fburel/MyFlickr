//
//  City+DAO.m
//  MyFlickr
//
//  Created by Florian BUREL on 10/07/2014.
//  Copyright (c) 2014 florian burel. All rights reserved.
//

#import "City+DAO.h"
#import "AppDelegate.h"

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
    
    if(random() % 2 == 0)
    {
        city.name = @"Kazantip";
        city.longitude = @(33.03833);
        city.latitude = @(45.29194);
    }
    else
    {
        city.name = @"Londres";
        city.longitude = @(-0.07857);
        city.latitude = @(51.504872);
    }
    
    
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
