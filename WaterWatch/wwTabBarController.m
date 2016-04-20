//
//  wwTabBarController.m
//  WaterWatch
//
//  Created by Sunny Pruthi on 4/18/16.
//  Copyright © 2016 SanilPruthi. All rights reserved.
//

#import "wwTabBarController.h"

@interface wwTabBarController ()

@end

@implementation wwTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBar.tintColor = [UIColor colorWithRed:(64/255.0) green:(165/255.0) blue:(130/255.0) alpha:1.0];
    self.tabBar.barTintColor = [UIColor whiteColor];
    if(![PFUser currentUser])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        wwLoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"wwLoginViewController"];
        [loginVC setModalPresentationStyle:UIModalPresentationFullScreen];
        UIViewController *top = [UIApplication sharedApplication].keyWindow.rootViewController;
        [top presentViewController:loginVC animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"Selected INDEX OF TAB-BAR ==> %lu", (unsigned long)tabBarController.selectedIndex);
}



@end
