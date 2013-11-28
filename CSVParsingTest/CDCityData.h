//
//  CDCityData.h
//  CSVParsingTest
//
//  Created by Jacek Grygiel on 26/11/13.
//  Copyright (c) 2013 Jacek Grygiel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDCityData : NSObject
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * postal_code;
@property (nonatomic) double lat;
@property (nonatomic) double lon;
@property (nonatomic, retain) NSString * area_code;
- (void) fillWithArray:(NSArray*) array;
@end
