//
//  BeachLocation.m
//  BHRoutingExample
//
//  Created by Craig Vanderzwaag on 6/1/14.
//  Copyright (c) 2014 blueHula Studios. All rights reserved.
//

#import "BeachLocation.h"

@interface BeachLocation ()


@end

@implementation BeachLocation

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
        
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    
    return _address;
}

@end
