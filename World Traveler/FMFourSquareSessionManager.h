//
//  FMFourSquareSessionManager.h
//  World Traveler
//
//  Created by Fredrick Myers on 4/3/14.
//  Copyright (c) 2014 Fredrick Myers. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface FMFourSquareSessionManager : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
