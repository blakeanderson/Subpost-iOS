//
//  SPMasterViewController.h
//  Subpost-iOS
//
//  Created by Blake on 1/8/13.
//  Copyright (c) 2013 Subpost. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPDetailViewController;

#import <CoreData/CoreData.h>

@interface SPMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) SPDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
