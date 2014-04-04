//
//  FMMapViewController.h
//  World Traveler
//
//  Created by Fredrick Myers on 4/3/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"

@interface FMMapViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) Venue *venue;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

- (IBAction)showDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
