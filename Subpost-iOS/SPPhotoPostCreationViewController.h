//
//  SPPhotoPostCreationViewController.h
//  Subpost-iOS
//
//  Created by Blake on 1/9/13.
//  Copyright (c) 2013 Subpost. All rights reserved.
//

#import "SPOverlayViewController.h"
#import <UIKit/UIKit.h>

@interface SPPhotoPostCreationViewController : UIViewController <UIImagePickerControllerDelegate, UIPopoverControllerDelegate, OverlayViewControllerDelegate>
{
    UIPopoverController *popoverController;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) NSMutableArray *capturedImages;
@property (strong, nonatomic) SPOverlayViewController *overlayViewController;
@property (weak, nonatomic) IBOutlet UITextField *captionText;
@property (weak, nonatomic) IBOutlet UITextField *pageText;
@property (nonatomic, strong) UIPopoverController *popoverController;

- (IBAction)photoLibararyAction:(id)sender;
- (IBAction)publish:(id)sender;


@end
