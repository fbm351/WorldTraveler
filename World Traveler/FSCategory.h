//
//  FSCategory.h
//  World Traveler
//
//  Created by Fredrick Myers on 4/3/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FMRecord.h"

@class Venue;

@interface FSCategory : FMRecord

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Venue *venue;

@end
