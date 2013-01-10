//
//  SPOverlayViewController.h
//  Subpost-iOS
//
//  Created by Blake on 1/9/13.
//  Copyright (c) 2013 Subpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OverlayViewControllerDelegate;

@interface SPOverlayViewController : UIViewController <UIImagePickerControllerDelegate>

@property (nonatomic, assign) id <OverlayViewControllerDelegate> delegate;
@property (nonatomic, retain) UIImagePickerController *imagePickerController;

- (void)setupImagePicker:(UIImagePickerControllerSourceType)sourceType;

@end

@protocol OverlayViewControllerDelegate
- (void)didTakePicture:(UIImage *)picture;
- (void)didFinishWithCamera;
@end
