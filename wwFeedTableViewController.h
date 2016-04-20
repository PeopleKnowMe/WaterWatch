//
//  wwFeedTableViewController.h
//  WaterWatch
//
//  Created by Sunny Pruthi on 4/18/16.
//  Copyright © 2016 SanilPruthi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface wwFeedTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *feedArray;
@property (strong, nonatomic) NSMutableSet *feedSet; 


@end
