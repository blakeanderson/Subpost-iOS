//
//  SPPhotoPostCaptionViewController.m
//  Subpost-iOS
//
//  Created by Blake on 1/9/13.
//  Copyright (c) 2013 Subpost. All rights reserved.
//

#import "SPPhotoPostCaptionViewController.h"

@interface SPPhotoPostCaptionViewController ()

@end

@implementation SPPhotoPostCaptionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)publish:(id)sender
{
	NSLog(@"%@", self.capturedImages);
	
	NSData *imageData = UIImagePNGRepresentation([[self capturedImages] objectAtIndex:0]);
	
	SPKPhotoPost *post = [[SPKPhotoPost alloc] init];
	post.fileContents = imageData;
	post.image = [[self capturedImages] objectAtIndex:0];
	
	
	[[SPKHTTPClient sharedClient] publishPhotoPost:(SPKPhotoPost *)post success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"Success");
		NSLog(@"%@", responseObject);
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Success"
														  message:[NSString stringWithFormat:@"%@", responseObject]
														 delegate:nil
												cancelButtonTitle:@"OK"
												otherButtonTitles:nil];
		[message show];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"Failure");
		NSLog(@"%@", error);
		UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Failure"
														  message:[NSString stringWithFormat:@"%@", error]
														 delegate:nil
												cancelButtonTitle:@"OK"
												otherButtonTitles:nil];
		[message show];
	}];
}

@end
