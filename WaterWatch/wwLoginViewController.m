//
//  wwLoginViewController.m
//  WaterWatch
//
//  Created by Sunny Pruthi on 4/18/16.
//  Copyright © 2016 SanilPruthi. All rights reserved.
//

#import "wwLoginViewController.h"

@interface wwLoginViewController ()

@property (strong, nonatomic) NSDictionary *launchOptions;

@end

@implementation wwLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.loginButton.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.loginButton.layer setBorderWidth:1.0];
}

-(void)viewDidAppear:(BOOL)animated
{
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    //     [FBSDKProfileDidChangeNotification:YES];
    if(FBSDKAccessToken.currentAccessToken != nil)
    {
        //NSLog(@"Token is %@ ", FBSDKAccessToken.currentAccessToken.userID);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonTouchHandler:(id)sender  {
    // Set permissions required from the facebook user account
    [self.loginButton setHidden:YES];
    NSArray *permissionsArray = @[@"email", @"public_profile", @"user_about_me"];
    
    //  dispatch_async(dispatch_get_main_queue(), ^{
    //  });
    dispatch_async(dispatch_get_main_queue(), ^{
        //   dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [PFFacebookUtils logInInBackgroundWithReadPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
            
            if (!user)
            {
                NSString *errorMessage = nil;
                if (!error) {
                    //NSLog(@"Facebook Login was cancelled.");
                    errorMessage = @"Facebook Login was cancelled.";
                    //need to take it back to the login screen
                } else {
                    //NSLog(@"Facebook Login error occurred: %@", error);
                    errorMessage = [error localizedDescription];
                }
                [self.loginButton setHidden: NO];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:nil cancelButtonTitle:nil
                                                      otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
            else
            {
                if (user.isNew) {
                    //NSLog(@"User with facebook signed up and logged in!");
                } else {
                    //NSLog(@"User with facebook logged in!");
                }
                if (![PFFacebookUtils isLinkedWithUser:user]) {
                    [PFFacebookUtils linkUserInBackground:user withReadPermissions:nil block:^(BOOL succeeded, NSError *error) {
                        if (succeeded) {
                            //NSLog(@"Woohoo, user is linked with Facebook!");
                        }
                    }];
                }
                [self getFacebookData];
            }
            
        }];
        
    });
}

-(void)getFacebookData
{
    
    //NSLog(@"Facebook Data method run");
    //   if ([FBSDKAccessToken currentAccessToken])
    {
        //NSLog(@"Token ID is %@ ", FBSDKAccessToken.currentAccessToken.userID);
        //        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
        //         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
        //        {
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                      initWithGraphPath:@"me"
                                      parameters:@{@"fields": @"id, name, gender, email"}
                                      HTTPMethod:@"GET"];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                              id result,
                                              NSError *error) {
            if (!error) {
                //NSLog(@"fetched user");
                [self submitParseData:result];
            }
            else if(error)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
                                                                message:@"Failed to get user profile credentials"
                                                               delegate:nil
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"Dismiss", nil];
                [alert show];
                //NSLog(@"%@", error);
                //                 [mecoUtilitiesAlertViewController showAlert:@"Error!" withMessage:[error localizedDescription]];
                [self.loginButton setHidden: NO];
                
            }
        }];
    }
}

-(void)submitParseData:(id)result
{
    //NSLog(@"Data is parsing");
    PFUser *currentUser = [PFUser currentUser];
    NSDictionary *userData = (NSDictionary *)result;
    NSString *facebookID = userData[@"id"];
    NSString *name = userData[@"name"];
    //NSLog(@"Name is: %@", userData[@"name"]);
    //NSLog(@"Location is: %@", userData[@"location"]);
    NSString *gender = userData[@"gender"];
    
    
    NSString *email = userData[@"email"];
    
    //  NSURL *coverURL = [NSURL URLWithString:[NSString stringWithFormat:@""]];
    if(facebookID != nil)
        currentUser[@"fbID"] = facebookID;
    //  if(currentUser[@"name"] == nil)
    //     {
    if(name != nil)
        currentUser[@"name"] = name;
    
    if(gender != nil)
        currentUser[@"gender"] = gender;
    
    if(email != nil)
        currentUser[@"email"] = email;
    
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshFeed" object:self userInfo:@{@"refresh" : @YES }];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {

        }
        
    }];
}

@end
