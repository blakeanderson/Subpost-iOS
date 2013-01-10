//
//  SPPhotoPostCreationViewController.m
//  Subpost-iOS
//
//  Created by Blake on 1/9/13.
//  Copyright (c) 2013 Subpost. All rights reserved.
//

#import "SPPhotoPostCreationViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface SPPhotoPostCreationViewController ()

@end

@implementation SPPhotoPostCreationViewController

@synthesize imageView, toolbar, captionText, popoverController;

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
	
	UIStoryboard *storyboard;
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
	} else {
		storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
	}
	

	SPOverlayViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"OverlayView"];
	self.overlayViewController = vc;
	
	// as a delegate we will be notified when pictures are taken and when to dismiss the image picker
    self.overlayViewController.delegate = self;
  
    self.capturedImages = [[NSMutableArray alloc] init];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
	self.imageView = nil;
	self.toolbar = nil;
	
	self.capturedImages = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Toolbar Actions

- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType sender:(id)sender
{
    if (self.imageView.isAnimating)
        [self.imageView stopAnimating];
	
    if (self.capturedImages.count > 0)
        [self.capturedImages removeAllObjects];
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType])
    {

		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		UIImagePickerController *imagePicker =
		[[UIImagePickerController alloc] init];
		imagePicker.delegate = self;
		imagePicker.sourceType =
		UIImagePickerControllerSourceTypePhotoLibrary;
		imagePicker.mediaTypes = [NSArray arrayWithObjects:
									  (NSString *) kUTTypeImage,
									  nil];
		imagePicker.allowsEditing = NO;
		
		self.popoverController = [[UIPopoverController alloc]
								  initWithContentViewController:imagePicker];
		
		self.popoverController.delegate = self;
		
		[self.popoverController
		 presentPopoverFromBarButtonItem:sender
		 permittedArrowDirections:UIPopoverArrowDirectionUp
		 animated:YES];
		} else {
			[self.overlayViewController setupImagePicker:sourceType];
			[self presentModalViewController:self.overlayViewController.imagePickerController animated:YES];
		}
    }
}

- (IBAction)photoLibararyAction:(id)sender
{
	[self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary sender:sender];
}

- (IBAction)publish:(id)sender
{
	NSLog(@"%@", self.capturedImages);
	
	NSData *imageData = UIImagePNGRepresentation([[self capturedImages] objectAtIndex:0]);
	
	SPKPhotoPost *post = [[SPKPhotoPost alloc] init];
	post.image = [[self capturedImages] objectAtIndex:0];
	post.caption = [[self captionText] text];
	post.page = [[self pageText] text];
	
	

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

#pragma mark -
#pragma mark OverlayViewControllerDelegate

// as a delegate we are being told a picture was taken
- (void)didTakePicture:(UIImage *)picture
{
    [self.capturedImages addObject:picture];
}

// as a delegate we are told to finished with the camera
- (void)didFinishWithCamera
{
    [self dismissModalViewControllerAnimated:YES];
    
    if ([self.capturedImages count] > 0)
    {
        if ([self.capturedImages count] == 1)
        {
            // we took a single shot
            [self.imageView setImage:[self.capturedImages objectAtIndex:0]];
        }
        else
        {
            // we took multiple shots, use the list of images for animation
            self.imageView.animationImages = self.capturedImages;
            
            if (self.capturedImages.count > 0)
                // we are done with the image list until next time
                [self.capturedImages removeAllObjects];
            
            self.imageView.animationDuration = 5.0;    // show each captured photo for 5 seconds
            self.imageView.animationRepeatCount = 0;   // animate forever (show all photos)
            [self.imageView startAnimating];
        }
    }
}


#pragma mark ImagePickerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.popoverController dismissPopoverAnimated:true];
	
    NSString *mediaType = [info
						   objectForKey:UIImagePickerControllerMediaType];
    [self dismissModalViewControllerAnimated:YES];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info
						  objectForKey:UIImagePickerControllerOriginalImage];
		
        imageView.image = image;
		[self didTakePicture:image];
        
    }
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle: @"Save failed"
							  message: @"Failed to save image"\
							  delegate: nil
							  cancelButtonTitle:@"OK"
							  otherButtonTitles:nil];
        [alert show];
    }
}

@end
