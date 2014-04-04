//
//  FMFourSquareSessionManager.m
//  World Traveler
//
//  Created by Fredrick Myers on 4/3/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "FMFourSquareSessionManager.h"
static NSString *const kFMFourSquareBaseURLString = @"https://api.foursquare.com/v2/";

@implementation FMFourSquareSessionManager

+ (instancetype)sharedClient
{
    static FMFourSquareSessionManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[FMFourSquareSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kFMFourSquareBaseURLString]];
    });
    return _sharedClient;
}

@end
