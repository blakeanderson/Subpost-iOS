//
//  SPKHTTPClient.m
//  SubpostKit
//
//  Created by Blake on 1/8/13.
//  Copyright (c) 2013 banderson. All rights reserved.
//

#import "SPKHTTPClient.h"
#import "SPKDefines.h"

@implementation SPKHTTPClient{
  NSString *_hostname;
}

#pragma mark - Singleton

+ (SPKHTTPClient *)sharedClient {
	static SPKHTTPClient *sharedClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedClient = [[self alloc] init];
	});
	return sharedClient;
}

- (id)init {
  _hostname = @"blake";
	NSURL *base = nil;
  base = [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@/%@/", kSPKAPIScheme, kSPKAPIHost, kSPKAPIVersion]];
	
	if ((self = [super initWithBaseURL:base])) {
		// Use JSON
		[self registerHTTPOperationClass:[AFJSONRequestOperation class]];
		[self setDefaultHeader:@"Accept" value:@"application/json"];
	}
	return self;
}


#pragma mark - User
- (void)signInWithEmail:(NSString *)email password:(NSString *)password success:(void (^)(AFJSONRequestOperation *operation, id responseObject))success failure:(void (^)(AFJSONRequestOperation *operation, NSError *error))failure {
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                          email, @"email",
                          password, @"password",
                          nil];
  
  [self clearAuthorizationHeader];
  
	[self postPath:kSPKAPIAccountVerifyCredentials parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           if (success) {
             success((AFJSONRequestOperation *)operation, responseObject);
           }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           if (failure) {
             failure((AFJSONRequestOperation *)operation, error);
           }
         }];
}

#pragma mark - Generic

- (void)getRequestToPath:(NSString*)path params:(NSDictionary*)params success:(void (^)(AFJSONRequestOperation *operation, id responseObject))success failure:(void (^)(AFJSONRequestOperation *operation, NSError *error))failure
{
  [self getPath:path parameters:params
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if (success) {
            success((AFJSONRequestOperation *)operation, responseObject);
          }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
            failure((AFJSONRequestOperation *)operation, error);
          }
        }];
}

- (void)postRequestToPath:(NSString*)path params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
  [self postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    if (success) {
      success((AFHTTPRequestOperation *)operation, responseObject);
    }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    if (failure) {
      failure((AFHTTPRequestOperation *)operation, error);
    }
  }];
}

#pragma mark - Posts
- (void)publishTextPost:(SPKTextPost *)post success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
	NSString *path = [NSString stringWithFormat:@"%@/post", _hostname];
	NSLog(@"%@", path);
	SPKTextPost *textPost = (SPKTextPost *)post;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
							post.state, @"state",
							post.format, @"format",
							post.page, @"page",
							textPost.title, @"title",
							textPost.body, @"body",
							post.type, @"type",
							nil];
	NSLog(@"%@", params);
	return [self postRequestToPath:path params:params success:success failure:failure];
}

- (void)publishPhotoPost:(SPKPhotoPost *)post success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
	NSString *path = [NSString stringWithFormat:@"%@/post", _hostname];
	NSLog(@"%@", path);
	
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
			  post.state, @"state",
			  post.format, @"format",
			  post.caption, @"caption",
			  @"Travels", @"page",
			  post.type, @"type",
			  nil];
	
	
	NSLog(@"%@", params);
	
	NSData *imageData = UIImageJPEGRepresentation(post.image, 0.5);
	NSMutableURLRequest *request = [[SPKHTTPClient sharedClient] multipartFormRequestWithMethod:@"POST" path:path parameters:params constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
		[formData appendPartWithFileData:imageData name:@"image" fileName:@"image" mimeType:@"image/jpeg"];
	}];
	
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	[operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
		NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
	}];
		
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		success(operation, responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		failure(operation, error);
	}];
	[operation start];
	
}


@end
