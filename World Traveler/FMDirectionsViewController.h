//
//  FMDirectionsViewController.h
//  World Traveler
//
//  Created by Fredrick Myers on 4/3/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"
#import "Location.h"

@interface FMDirectionsViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *directionsMap;

@property (strong, nonatomic) Venue *venue;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray *steps;

- (IBAction)listDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
