//
//  SPKTextPost.m
//  SubpostKit
//
//  Created by Blake on 1/8/13.
//  Copyright (c) 2013 subpost. All rights reserved.
//

#import "SPKDefines.h"
#import "SPKTextPost.h"

@implementation SPKTextPost

@synthesize title, body;

- (id)init
{
  self = [super init];
  if (self){
    self.type = kSPKTextPostType;
  }
  return self;
}

@end
