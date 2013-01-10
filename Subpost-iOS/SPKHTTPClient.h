//
//  SPKHTTPClient.h
//  SubpostKit
//
//  Created by Blake on 1/8/13.
//  Copyright (c) 2013 banderson. All rights reserved.
//

#import "SPKTextPost.h"
#import "SPKPhotoPost.h"
#import "AFNetworking.h"
#import "AFHTTPClient.h"

typedef void (^SPKHTTPClientSuccess)(AFJSONRequestOperation *operation, id responseObject);
typedef void (^SPKHTTPClientFailure)(AFJSONRequestOperation *operation, NSError *error);

@interface SPKHTTPClient : AFHTTPClient

+ (SPKHTTPClient *)sharedClient;

// User
- (void)signInWithEmail:(NSString *)email password:(NSString *)password success:(void (^)(AFJSONRequestOperation *operation, id responseObject))success failure:(void (^)(AFJSONRequestOperation *operation, NSError *error))failure;

- (void)publishTextPost:(SPKTextPost *)post success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)publishPhotoPost:(SPKPhotoPost *)post success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
