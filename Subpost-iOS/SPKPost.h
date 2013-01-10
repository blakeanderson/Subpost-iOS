//
//  SPKPost.h
//  SubpostKit
//
//  Created by Blake on 1/8/13.
//  Copyright (c) 2013 subpost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPKPost : NSObject

@property(nonatomic, strong) NSDate *date;
@property(nonatomic, strong) NSString *state;
@property(nonatomic, strong) NSString *format;
@property(nonatomic, strong) NSString *slug;
@property(nonatomic, strong) NSString *page;
@property(nonatomic, strong) NSString *type;

@end
