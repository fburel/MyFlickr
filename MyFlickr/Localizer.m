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

@interface Localizer () <CLLocationManagerDelegate>

@property (strong, nonatomic) City * city;
@property (strong, nonatomic) CLLocationManager * locationManager;

@end



@implementation Localizer

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}

- (void)startUpdatingLocationForCity:(City *)city
{
    
    self.city = city;
    
    [self.locationManager  startUpdatingLocation];
    
}

- (CLLocationManager *)locationManager
{
    if(!_locationManager)
    {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    }
    
    return _locationManager;

}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation * lastLocation = [locations lastObject];
    
    self.city.longitude = @(lastLocation.coordinate.longitude);
    self.city.latitude = @(lastLocation.coordinate.latitude);
    
    [self.locationManager stopUpdatingLocation];
    
    
    // GEOCODING
    
    CLGeocoder * gc = [CLGeocoder new];
    [gc reverseGeocodeLocation:lastLocation
             completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark * placemark = [placemarks lastObject];
        self.city.name = placemark.locality;

    }];
}

@end
















