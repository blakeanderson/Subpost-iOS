//
//  SPTextPostCreationViewController.h
//  Subpost-iOS
//
//  Created by Blake on 1/8/13.
//  Copyright (c) 2013 Subpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPTextPostCreationViewController : UITableViewController
- (IBAction)publishAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *pageText;
@property (weak, nonatomic) IBOutlet UISwitch *draftSwitch;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;

@end
