//
//  mecoLoginViewController.h
//  mecoProduction
//
//  Created by Sunny Pruthi on 1/6/15.
//  Copyright (c) 2015 meco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <Parse/Parse.h>
//#import <FacebookSDK/FacebookSDK.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
//#import "MecoInterestsViewController.h"
@interface wwLoginViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *propicdata;
@property (nonatomic, strong) UIImage *propic;
@property (nonatomic, strong) PFFile *imageFile;
@property (nonatomic, strong) PFFile *coverFile;
@property (nonatomic, strong) UIImage *cover;
@property (nonatomic, strong) PFUser *currentUser;
@property (nonatomic, strong) UIActivityIndicatorView * activityView;
@property BOOL shouldSegue;
//@property (nonatomic, strong) FBSDKAccessToken *tokenCopy;

@property (weak, nonatomic) IBOutlet UIButton * loginButton;

@end
