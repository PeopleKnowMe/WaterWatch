//
//  wwSettingsTableViewController.m
//  WaterWatch
//
//  Created by Sunny Pruthi on 4/28/16.
//  Copyright © 2016 SanilPruthi. All rights reserved.
//

#import "wwSettingsTableViewController.h"
#import "wwLoginViewController.h"
#import <Parse/Parse.h>

@implementation wwSettingsTableViewController

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(buttonIndex) {
        case 0: //"No" pressed
            //do something?
            break;
        case 1: //"Yes" pressed
            //here you pop the viewController
            [PFUser logOut];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            wwLoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"wwLoginViewController"];
            [loginVC setModalPresentationStyle:UIModalPresentationFullScreen];
            self.tabBarController.selectedIndex = 0;
            [self presentViewController:loginVC animated:YES completion:nil];
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //   [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    // //NSLog(@"Path is");
    // Deselect row
    //   [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Declare the view controller

    
    // Determine the row/section on the tapped cell
    switch (indexPath.section) {
         case 1:
            switch(indexPath.row)
        {
            case 0:
            {
                [self logoutButtonWasPressed];
                break;
            }
                
        }
            break;
    }

}

-(void)logoutButtonWasPressed
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log Out"
                                                    message:@"Are you sure you want to log out?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}


@end
