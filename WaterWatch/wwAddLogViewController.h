//
//  wwAddLogViewController.h
//  WaterWatch
//
//  Created by Sunny Pruthi on 4/19/16.
//  Copyright © 2016 SanilPruthi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "DownPicker.h"

@interface wwAddLogViewController : UIViewController

@property (strong, nonatomic) DownPicker *downPicker;
@property(strong, nonatomic) IBOutlet UITextField *usageTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *startDate;
@property (strong, nonatomic) IBOutlet UIDatePicker *endDate;
@property (strong, nonatomic) IBOutlet UITextView *description;


@end
