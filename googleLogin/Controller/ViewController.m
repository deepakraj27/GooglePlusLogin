//
//  ViewController.m
//  googleLogin
//
//  Created by Deepakraj Murugesan on 09/10/15.
//  Copyright © 2015 tecsol. All rights reserved.
//

#import "ViewController.h"
#import "DashboardViewController.h"
#import "MBProgressHUD.h"

@interface ViewController ()<GIDSignInUIDelegate, GIDSignInDelegate>{
       GIDSignIn * signIn;
        NSString *LoginuserId;
        NSString *LoginidToken;
        NSString *Loginname;
        NSString *Loginemail;
        NSURL * LoginimageURL;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self googleLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*Google Signin delegate...*/
-(void)googleLogin{
    signIn = [GIDSignIn sharedInstance];
    signIn.shouldFetchBasicProfile = YES;
    signIn.delegate = self;
    signIn.uiDelegate = self;
    
}
/*Google Signin button Click...*/
- (IBAction)sampleGmail:(id)sender {
    [[GIDSignIn sharedInstance] signIn];
}


/*gmail signin with google id name and email and gender....*/
//
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    /*When cancel button is clicked on G+ login page...*/
    if (error) {
        NSLog(@"clicked on cancel");
    }
    /*When the user name and password entered and clicked on sign in...*/
    else {
        // Perform any operations on signed in user here.
        
        //Saving the login type as gmail in order to open to the same page when the app is closed and opened
        [[NSUserDefaults standardUserDefaults] setObject:@"Gmail" forKey:@"LoginType"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        //setting the user details such as name, id, token, email, image to variable
        Loginemail = user.profile.email;
        LoginidToken = user.authentication.idToken;
        Loginname = user.profile.name;
        LoginuserId = user.userID;
        
        //setting the user details such as name, id, token, email, image to NSUserDefaults
        [[NSUserDefaults standardUserDefaults]setObject:Loginname forKey:@"name"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:Loginemail forKey:@"email"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:LoginuserId forKey:@"id"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        if (![GIDSignIn sharedInstance].currentUser.profile.hasImage) {
            // There is no Profile Image to be loaded.
            return;
        }
        // Load avatar image asynchronously, in background
        LoginimageURL =[[GIDSignIn sharedInstance].currentUser.profile imageURLWithDimension:200];
        
        [[NSUserDefaults standardUserDefaults]setObject:[LoginimageURL absoluteString]  forKey:@"imageURL"];
        [[NSUserDefaults standardUserDefaults]synchronize];
     
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        //perform segue to the dashboard screen..
        [self performSegueWithIdentifier:@"googleLogin" sender:nil];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
     
        
    }
    
}

//when the gmail login got disconnected...this function will get called...
- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
    if (error) {
        NSLog(@"error occured");
    }
}


@end
