//
//  ViewController.m
//  BHRoutingExample
//
//  Created by Craig Vanderzwaag on 6/1/14.
//  Copyright (c) 2014 blueHula Studios. All rights reserved.
//

#import "ViewController.h"
#import "BeachLocation.h"

#define METERS_PER_MILE 1609.344

@interface ViewController ()

@property (nonatomic, strong) NSArray *beachLocations;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude =  35.281137;
    zoomLocation.longitude= -120.660484;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 50*METERS_PER_MILE, 50*METERS_PER_MILE);

    [_areaView setRegion:viewRegion animated:YES];
    
    CLLocationCoordinate2D morroStrand;
    morroStrand.latitude = 35.399284;
    morroStrand.longitude = -120.867930;
    
    CLLocationCoordinate2D avilaBeach;
    avilaBeach.latitude = 35.178535;
    avilaBeach.longitude = -120.733929;
    
    CLLocationCoordinate2D pismoBeach;
    pismoBeach.latitude = 35.135388;
    pismoBeach.longitude = -120.640977;
    
    
    BeachLocation *morro = [[BeachLocation alloc]initWithName:@"Morro Strand State Beach" address:@"Hwy 1 @ Beachcomber Dr" coordinate:morroStrand];
    BeachLocation *avila = [[BeachLocation alloc] initWithName:@"Avila Beach" address:@"San Miguel x Front St." coordinate:avilaBeach];
    BeachLocation *pismo = [[BeachLocation alloc] initWithName:@"Pismo Beach" address:@"End of Addie St." coordinate:pismoBeach];
    
    _beachLocations = [[NSArray alloc] initWithObjects:morro, avila, pismo, nil];

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *annotationIdentifier = @"AnnotationIdentifier";
    
    BeachLocation *pinView = (BeachLocation *) [_areaView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    
    if (!pinView)
    {
        pinView = [[BeachLocation alloc]
                    initWithAnnotation:annotation
                    reuseIdentifier:annotationIdentifier];
        
        [pinView setPinColor:MKPinAnnotationColorRed];
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 19)];
        [button setImage:[UIImage imageNamed:@"16-car.png"] forState:UIControlStateNormal];
        pinView.rightCalloutAccessoryView = button;
        
        
    }
    else 
    {
        pinView.annotation = annotation;
    }
    
    return pinView; 
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    CLLocationCoordinate2D endingCoord;
    endingCoord.latitude = [[_areaView.selectedAnnotations objectAtIndex:0]coordinate].latitude;
    endingCoord.longitude = [[_areaView.selectedAnnotations objectAtIndex:0]coordinate].longitude;
    
    MKPlacemark *endLocation = [[MKPlacemark alloc] initWithCoordinate:endingCoord addressDictionary:nil];
    
    MKMapItem *endingItem = [[MKMapItem alloc] initWithPlacemark:endLocation];
    endingItem.name = [[_areaView.selectedAnnotations objectAtIndex:0]name];
    
    //using Apple Maps
    NSMutableDictionary *launchOptions = [[NSMutableDictionary alloc] init];
    [launchOptions setObject:MKLaunchOptionsDirectionsModeDriving forKey:MKLaunchOptionsDirectionsModeKey];
    [endingItem openInMapsWithLaunchOptions:launchOptions];
            
}


- (BOOL)openMapsWithItems:(NSArray *)mapItems launchOptions:(NSDictionary *)launchOptions{
    [MKMapItem openMapsWithItems:mapItems launchOptions:launchOptions];
    return YES;
    
}

-(void)zoomToFitAnnotations {
    
    
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in _areaView.annotations)
        
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    
    double inset = -zoomRect.size.width * 0.2;
    [_areaView setVisibleMapRect:MKMapRectInset(zoomRect, inset, inset) animated:YES];
  //  [_areaView setVisibleMapRect:zoomRect animated:YES];
    
}

-(void)zoomToFitUserLocation{
    
    MKMapRect zoomRect = MKMapRectNull;

        MKMapPoint annotationPoint = MKMapPointForCoordinate(_areaView.userLocation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    
    double inset = -zoomRect.size.width * 0.5;
    [_areaView setVisibleMapRect:MKMapRectInset(zoomRect, inset, inset) animated:YES];

    
    
}


-(IBAction)clearPins:(id)sender {
    
    [_areaView removeAnnotations:_beachLocations];
    [self zoomToFitUserLocation];
}

-(IBAction)dropPins:(id)sender {
    
    [_areaView addAnnotations:_beachLocations];
    [self zoomToFitAnnotations];
    
}

- (void)locationUpdate:(CLLocation*)location {
    
}

@end
