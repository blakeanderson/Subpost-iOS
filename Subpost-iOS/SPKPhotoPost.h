//
//  SPKPhotoPost.h
//  Subpost-iOS
//
//  Created by Blake on 1/9/13.
//  Copyright (c) 2013 Subpost. All rights reserved.
//

#import "SPKPost.h"

@interface SPKPhotoPost : SPKPost

@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSData *fileContents;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) UIImage *image;

@end
