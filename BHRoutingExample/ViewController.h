//
//  ViewController.h
//  BHRoutingExample
//
//  Created by Craig Vanderzwaag on 6/1/14.
//  Copyright (c) 2014 blueHula Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BHLocationManager.h"

@interface ViewController : UIViewController <MKMapViewDelegate, BHLocationManagerDelegate>

@property (nonatomic, strong) IBOutlet UIButton *dropPins;
@property (nonatomic, strong) IBOutlet UIButton *clearPins;
@property (nonatomic, retain) IBOutlet MKMapView *areaView;

-(IBAction)dropPins:(id)sender;
-(IBAction)clearPins:(id)sender;

@end
