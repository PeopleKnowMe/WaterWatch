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
 //   self.navigationController.navigationItem.leftBarButtonItem = nil;
    self.navigationController.navigationBarHidden = NO;
    
//    self.startLabel.layer.borderColor = [UIColor whiteColor].CGColor;
//    
//    self.endLabel.layer.borderColor = [UIColor whiteColor].CGColor;
//    
//    self.startLabel.layer.borderWidth = 1.0;
//    
//    self.endLabel.layer.borderWidth = 0.5;
    
//      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismissPressed)];
//    
//    self.navigationItem.rightBarButtonItem.enabled = YES; 
    NSMutableArray* useArray = [[NSMutableArray alloc] init];
    
    // add some sample data
    [useArray addObject:@"Faucet"];
    [useArray addObject:@"Shower"];
    [useArray addObject:@"Toilet"];
    [useArray addObject:@"Bath"];
    [useArray addObject:@"Kitchen Sink"];
    
    NSMutableArray* pressureArray = [[NSMutableArray alloc] init];
    
    // add some sample data
    [pressureArray addObject:@"Low"];
    [pressureArray addObject:@"Medium"];
    [pressureArray addObject:@"High"];
    
    // bind yourTextField to DownPicker
    self.downPicker = [[DownPicker alloc] initWithTextField:self.usageTextField withData:useArray];
    
    self.downPicker2 = [[DownPicker alloc] initWithTextField:self.pressureTextField withData:pressureArray];

}

- (IBAction)dismissPressed:(id)sender
{
      [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)dismiss:(id)sender
{
//    if([self.usageTextField.text  isEqualToString: @"Type of Usage"])
//    {
//        UIAlertController * alert=   [UIAlertController
//                                      alertControllerWithTitle:@"Invalid Usage"
//                                      message:@"Please Specify Usage"
//                                      preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction* ok = [UIAlertAction
//                             actionWithTitle:@"OK"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * action)
//                             {
//                                 [alert dismissViewControllerAnimated:YES completion:nil];
//                                 
//                             }];
//        
//        [alert addAction:ok];
//        
//        [self presentViewController:alert animated:YES completion:nil];
//    }
    NSDate *start = self.startDate.date;
    NSDate *end = self.endDate.date;
    //NSLog(@"start %@ end %@", start, end);
    //NSLog(@"%ld", (long)[start compare:end]);
    if (([start compare:end] == NSOrderedAscending))
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
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        //alert for dates
        UIAlertController * dateAlert=   [UIAlertController
                                      alertControllerWithTitle:@"Invalid Dates"
                                      message:@"End date must be later than start date"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [dateAlert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [dateAlert addAction:ok];
        
        [self presentViewController:dateAlert animated:YES completion:nil];
        NSLog(@"date1 is later than date2");
    }
}

@end