//
//  SPTextPostCreationViewController.m
//  Subpost-iOS
//
//  Created by Blake on 1/8/13.
//  Copyright (c) 2013 Subpost. All rights reserved.
//

#import "SPTextPostCreationViewController.h"

@interface SPTextPostCreationViewController ()

@end

@implementation SPTextPostCreationViewController

@synthesize titleText, pageText, draftSwitch, bodyTextView;

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

- (IBAction)publishAction:(id)sender {
  SPKTextPost *post = [[SPKTextPost alloc] init];
  NSLog(@"%@", [[self titleText] text]);
  post.title = self.titleText.text;
  post.page = self.pageText.text;
  post.body = self.bodyTextView.text;
  
  [[SPKHTTPClient sharedClient] publishTextPost:post success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //
    NSLog(@"Success");
    NSLog(@"%@", responseObject);
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Success"
                                                      message:[NSString stringWithFormat:@"%@", responseObject]
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //
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
