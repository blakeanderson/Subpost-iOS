//
//  SPDetailViewController.h
//  Subpost-iOS
//
//  Created by Blake on 1/8/13.
//  Copyright (c) 2013 Subpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
