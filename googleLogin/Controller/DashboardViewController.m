//
//  DashboardViewController.m
//  googleLogin
//
//  Created by Deepakraj Murugesan on 09/10/15.
//  Copyright © 2015 tecsol. All rights reserved.
//

#import "DashboardViewController.h"
#import "UIImageView+WebCache.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import "ViewController.h"
#import "MBProgressHUD.h"

@interface DashboardViewController (){
    //parameters of Name, id, email, imageURL
    NSString* GmailName;
    NSString* Gmailid;
    NSString* GmailEmail;
    NSURL* GmailProPic;
}
@property (strong, nonatomic) IBOutlet UIImageView *profilePicture;
@property (strong, nonatomic) IBOutlet UILabel *Name;
@property (strong, nonatomic) IBOutlet UILabel *googleID;
@property (strong, nonatomic) IBOutlet UILabel *Email;
@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //calling up settingUserDefaults & outletDetails
    [self settingUserDefaults];
    [self outletDetails];
}
//setting the NSUserDefaults to the variables or parameters
-(void)settingUserDefaults{
    GmailName = [[NSUserDefaults standardUserDefaults]valueForKey:@"name"];
    Gmailid = [[NSUserDefaults standardUserDefaults]valueForKey:@"id"];
    GmailEmail = [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
    GmailProPic = [[NSUserDefaults standardUserDefaults]valueForKey:@"imageURL"];
}

//setting the value to the outlets...
-(void)outletDetails{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.Name.text = [@"Name:" stringByAppendingString:[@" " stringByAppendingString:GmailName]];
    self.googleID.text = [@"GoogleID:" stringByAppendingString:[@" " stringByAppendingString:Gmailid]];
    self.Email.text =[@"EmailID:" stringByAppendingString:[@" " stringByAppendingString:GmailEmail]];
    [self.profilePicture sd_setImageWithURL:GmailProPic
                           placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.profilePicture.layer.cornerRadius = 50;
    self.profilePicture.layer.masksToBounds = YES;
    [self.profilePicture.layer setBorderColor:[[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:0.75]CGColor]];
    [self.profilePicture.layer setBorderWidth:4.0];
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//When Logout button is clicked...
- (IBAction)logoutButtonClicked:(id)sender {
    UIAlertController * alertLogout = [UIAlertController alertControllerWithTitle:@"Logout" message:@"Are you sure you want to Logout" preferredStyle:UIAlertControllerStyleAlert];
    
    //if YES...
    [alertLogout addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self Logoutaction];
    }]];
    
    //if NO...
    [alertLogout addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Logout Cancelled");
    }]];
    [self presentViewController:alertLogout animated:YES completion:nil];
}

//Logout action will be perfomed with this funciton...
-(void)Logoutaction
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[GIDSignIn sharedInstance] signOut];//Google signout instance
    ViewController *home = [self.storyboard instantiateViewControllerWithIdentifier:@"home"];
    [self presentViewController:home animated:NO completion:nil];
    NSLog(@"logout successfully");
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"LoginType"];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
@end
