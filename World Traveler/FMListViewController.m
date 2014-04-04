//
//  FMViewController.m
//  World Traveler
//
//  Created by Fredrick Myers on 4/2/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMListViewController.h"
#import "FMFourSquareSessionManager.h"
#import "AFMMRecordResponseSerializationMapper.h"
#import "AFMMRecordResponseSerializer.h"
#import "Venue.h"
#import "Location.h"
#import "FMMapViewController.h"

static NSString *const kClIENTID = @"4NNURVFGN2LJN1SQD3IXMZDMZ4PQYEUL30QMU5YOZXNATFGL";
static NSString *const kCLIENTSECRET = @"L1OFQYSG4IAAB25QSC0SBN4EJBQ42J4KZ3GYK43SB0VSMPR3";

#define lattitudeOffset 0.01
#define longitudeOffset 0.01

@interface FMListViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) NSArray *venues;
@property (strong, nonatomic) CLLocationManager *locationManager;


@end

@implementation FMListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 10.0;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    FMFourSquareSessionManager *sessionManager = [FMFourSquareSessionManager sharedClient];
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    AFHTTPResponseSerializer *HTTPResponseSerializer = [AFJSONResponseSerializer serializer];
    AFMMRecordResponseSerializationMapper *mapper = [[AFMMRecordResponseSerializationMapper alloc] init];
    [mapper registerEntityName:@"Venue" forEndpointPathComponent:@"venues/search?"];
    AFMMRecordResponseSerializer *serializer = [AFMMRecordResponseSerializer serializerWithManagedObjectContext:context responseObjectSerializer:HTTPResponseSerializer entityMapper:mapper];
    
    sessionManager.responseSerializer = serializer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)refreshBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self.locationManager startUpdatingLocation];
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.venues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Venue *venue = self.venues[indexPath.row];
    cell.textLabel.text = venue.name;
    cell.detailTextLabel.text = venue.location.address;
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"listToMapSegue" sender:indexPath];
}

#pragma mark - CLLocationManager Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
    [self.locationManager stopUpdatingLocation];
    
    [[FMFourSquareSessionManager sharedClient] GET:[NSString stringWithFormat:@"venues/search?ll=%f,%f", location.coordinate.latitude + lattitudeOffset, location.coordinate.longitude + longitudeOffset] parameters:@{@"client_id" : kClIENTID, @"client_secret" : kCLIENTSECRET, @"v" : @"20140416"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *venues = responseObject;
        self.venues = venues;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = sender;
    Venue *venue = self.venues[indexPath.row];
    FMMapViewController *destinationVC = segue.destinationViewController;
    destinationVC.venue = venue;
}

@end
