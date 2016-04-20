//
//  wwAddLogViewController.m
//  WaterWatch
//
//  Created by Sunny Pruthi on 4/19/16.
//  Copyright © 2016 SanilPruthi. All rights reserved.
//

#import "wwAddLogViewController.h"

@implementation wwAddLogViewController

@synthesize description;


-(void)viewDidAppear:(BOOL)animated
{
    self.navigationItem.leftBarButtonItem = nil;
    NSMutableArray* useArray = [[NSMutableArray alloc] init];
    
    // add some sample data
    [useArray addObject:@"Faucet"];
    [useArray addObject:@"Shower"];
    [useArray addObject:@"Toilet"];
    [useArray addObject:@"Bath"];
    [useArray addObject:@"Kitchen Sink"];
    
    // bind yourTextField to DownPicker
    self.downPicker = [[DownPicker alloc] initWithTextField:self.usageTextField withData:useArray];
}

- (IBAction)dismiss:(id)sender
{
    NSLog(@"test");
    //save values to parse
    PFObject *log = [PFObject objectWithClassName:@"log"];
    log[@"user"] = [PFUser currentUser];
    log[@"description"] = self.description.text;
    log[@"startdate"] = self.startDate.date;
    log[@"enddate"] = self.endDate.date;
    log[@"type"] = self.usageTextField.text;
    [log saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
        } else {
            // There was a problem, check error.description
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end