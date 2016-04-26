//
//  wwFeedTableViewCell.h
//  WaterWatch
//
//  Created by Sunny Pruthi on 4/19/16.
//  Copyright © 2016 SanilPruthi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wwFeedTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *type;

@property (strong, nonatomic) IBOutlet UILabel *start;
@property (strong, nonatomic) IBOutlet UILabel *end;
@property (strong, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (strong, nonatomic) IBOutlet UIImageView *image;

@end
