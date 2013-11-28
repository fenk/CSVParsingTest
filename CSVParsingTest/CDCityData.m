//
//  CDCityData.m
//  CSVParsingTest
//
//  Created by Jacek Grygiel on 26/11/13.
//  Copyright (c) 2013 Jacek Grygiel. All rights reserved.
//

#import "CDCityData.h"

@implementation CDCityData
- (void) fillWithArray:(NSArray*) array{
    self.country = [array objectAtIndex:0];
    self.region = [array objectAtIndex:1];
    self.name = [array objectAtIndex:3];
    self.postal_code = [array objectAtIndex:4];
    self.lat = [[array objectAtIndex:5] doubleValue];
    self.lon = [[array objectAtIndex:6] doubleValue];
}

@end
