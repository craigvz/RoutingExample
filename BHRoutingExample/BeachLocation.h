//
//  BeachLocation.h
//  BHRoutingExample
//
//  Created by Craig Vanderzwaag on 6/1/14.
//  Copyright (c) 2014 blueHula Studios. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface BeachLocation : MKPinAnnotationView

@property (copy) NSString *name;
@property (copy) NSString *address;

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;


@end
