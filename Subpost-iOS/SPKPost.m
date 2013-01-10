//
//  SPKPost.m
//  SubpostKit
//
//  Created by Blake on 1/8/13.
//  Copyright (c) 2013 subpost. All rights reserved.
//

#import "SPKDefines.h"
#import "SPKPost.h"

@implementation SPKPost

@synthesize date, state, format, slug, page, type;

- (id)init
{
  self = [super init];
  if (self){
    // Set defaults
    self.type = kSPKTextPostType;
    self.state = @"published";
    self.format = @"markdown";
  }
  return self;
}

@end
