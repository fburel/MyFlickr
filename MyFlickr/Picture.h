//
//  Picture.h
//  MyFlickr
//
//  Created by Florian BUREL on 09/07/2014.
//  Copyright (c) 2014 florian burel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Picture : NSObject

@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSURL * url;

@end
