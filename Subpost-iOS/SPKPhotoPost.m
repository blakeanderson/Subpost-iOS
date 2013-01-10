//
//  SPKPhotoPost.m
//  Subpost-iOS
//
//  Created by Blake on 1/9/13.
//  Copyright (c) 2013 Subpost. All rights reserved.
//

#import "SPKPhotoPost.h"
#import "SPKDefines.h"

@implementation SPKPhotoPost

@synthesize filePath, fileContents, source, caption, image;

- (id)init
{
	self = [super init];
	if (self){
		self.type = kSPKPhotoPostType;
	}
	return self;
}

@end
