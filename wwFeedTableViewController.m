//
//  wwFeedTableViewController.m
//  WaterWatch
//
//  Created by Sunny Pruthi on 4/18/16.
//  Copyright © 2016 SanilPruthi. All rights reserved.
//

#import "wwFeedTableViewController.h"
#import "wwFeedTableViewCell.h"
#import "wwAddLogViewController.h"

@implementation wwFeedTableViewController

-(void)viewDidLoad
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add Event" style:UIBarButtonItemStylePlain target:self action:@selector(plusPressed)];
//    PFUser *currentUser = [PFUser currentUser];
    self.feedArray = [[NSMutableArray alloc] init];
    self.feedSet = [[NSMutableSet alloc] init];
//    if(currentUser)
//    {
//    PFQuery *feedQuery = [PFQuery queryWithClassName:@"log"];
//    [feedQuery whereKey:@"user" equalTo:currentUser];
//    [feedQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            // The find succeeded.
//            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
//            // Do something with the found objects
//            for (PFObject *object in objects) {
//                [self.feedArray addObject:object];
//                NSLog(@"%@", object.objectId);
//            }
//        } else {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];
//    }
}

-(void)viewDidAppear:(BOOL)animated
{
  //  [self.feedArray removeAllObjects];
    [self loadParseData];
}

-(void)loadParseData
{
    PFUser *currentUser = [PFUser currentUser];
    if(currentUser)
    {
        PFQuery *feedQuery = [PFQuery queryWithClassName:@"log"];
        [feedQuery whereKey:@"user" equalTo:currentUser];
        [feedQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                // The find succeeded.
                NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
                // Do something with the found objects
                for (PFObject *object in objects) {
                    NSString *usageID = object.objectId;
                    BOOL isDuplicateState = [self.feedSet containsObject:usageID];
                    if (!isDuplicateState) {
                        [self.feedArray addObject:object];
                        [self.feedSet addObject:usageID];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }

}

-(void)plusPressed
{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    wwAddLogViewController *addLogVC = [storyboard instantiateViewControllerWithIdentifier:@"wwAddLogViewController"];
    [addLogVC setModalPresentationStyle:UIModalPresentationFullScreen];
//    [self presentViewController:addLogVC animated:YES completion:nil];
    [self.navigationController pushViewController:addLogVC animated:YES];
    return;
}


- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationFullScreen;
}

- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style {
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: controller.presentedViewController];
    return navController;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //NSLog(@"Number of Sections in Table: %lu", (unsigned long)self.eventArray.count);
    if (self.feedArray.count > 0) {
        self.tableView.backgroundView = nil;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return self.feedArray.count;
    } else {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"No events are currently available in the feed.\n Please pull down to refresh!";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Avenir" size:16];
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"wwFeedTableViewCell";
    
    wwFeedTableViewCell *cell = (wwFeedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[wwFeedTableViewCell alloc] init];
    }

    
    PFObject *usage = [self.feedArray objectAtIndex:indexPath.section];
    
//    [useArray addObject:@"Faucet"];
//    [useArray addObject:@"Shower"];
//    [useArray addObject:@"Toilet"];
//    [useArray addObject:@"Bath"];
//    [useArray addObject:@"Kitchen Sink"];
//    
    
    if ([usage[@"type"] isEqualToString:@"Shower"])
    {
        cell.image.image = [UIImage imageNamed:@"shower"];
    }
    
    else if ([usage[@"type"] isEqualToString:@"Faucet"])
    {
        cell.image.image = [UIImage imageNamed:@"bathroom_sink"];
    }
    
    else if ([usage[@"type"] isEqualToString:@"Toilet"])
    {
        cell.image.image = [UIImage imageNamed:@"toilet"];
    }
    
    else if ([usage[@"type"] isEqualToString:@"Bath"])
    {
        cell.image.image = [UIImage imageNamed:@"bath"];
    }
    
    else if ([usage[@"type"] isEqualToString:@"Kitchen Sink"])
    {
        cell.image.image = [UIImage imageNamed:@"kitchen_sink"];   
    }
    
    cell.image.clipsToBounds = YES; 


    cell.type.text = usage[@"type"];
    
    cell.desc.text = usage[@"description"];
//
    cell.start.numberOfLines = 0;
    cell.end.numberOfLines = 0; 
//    //format and set date
    NSDate *startDate = usage[@"startdate"];
    NSDate *endDate = usage[@"enddate"];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"MMM dd 'at' h:mm a"];
    cell.start.text = [df stringFromDate:startDate];
    
    NSDateFormatter *df2 = [NSDateFormatter new];
    [df2 setDateFormat:@"MMM dd 'at' h:mm a"];
    cell.end.text = [df stringFromDate:endDate];
//
//    //add gradient layer
//    if(cell.eventImageView.layer.sublayers == nil){
//        CAGradientLayer * gradientLayer = [CAGradientLayer layer];
//        gradientLayer.frame = cell.eventImageView.bounds;
//        gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.05] CGColor], (id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75] CGColor], nil];
//        gradientLayer.locations = [NSArray arrayWithObjects: [NSNumber numberWithFloat:0.50f], [NSNumber numberWithFloat:0.65], nil];
//        [cell.eventImageView.layer addSublayer: gradientLayer];
//    }
//    
//    //retrieve image
//    if(event[@"imageurl"] != NULL)
//    {
//        [cell.eventImageView sd_setImageWithURL:[NSURL URLWithString:event[@"imageurl"]]];
//        cell.eventImageView.contentMode = UIViewContentModeScaleAspectFill;
//        cell.eventImageView.clipsToBounds = YES;
//    }
//    else
//    {
//        PFFile * userImageFile = event[@"image"];
//        [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
//            if (!error) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    cell.eventImageView.image = [UIImage imageWithData:imageData];
//                    cell.eventImageView.contentMode = UIViewContentModeScaleAspectFill;
//                    cell.eventImageView.clipsToBounds = YES;
//                });
//            }
//        }];
//    }
    return cell;
}



@end
