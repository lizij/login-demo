//
//  LoginViewController.m
//  学习视频
//
//  Created by IOS on 17/4/23.
//  Copyright © 2017年 IOS. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)forgetpass:(id)sender;
- (IBAction)login:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RegisterCompletion:) name:@"RegisterCompletionNotification" object:nil];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background.png"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)RegisterCompletion:(NSNotification *) notification{
    NSDictionary *datadic = [notification userInfo];
    NSString *username = [datadic objectForKey:@"username"];
    [self.username setText:username];
    [self.password setText:@""];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)forgetpass:(id)sender {
}

- (IBAction)login:(id)sender {
    if (self.username.text.length > 0 && self.password.text.length > 0) {
        __block UIAlertView *alert =
        [[UIAlertView alloc]
         initWithTitle:@"登录成功"
         message:nil
         delegate:nil
         cancelButtonTitle:nil
         otherButtonTitles:nil];
        [alert show];
        
        // Hide the alert
        double delayInSeconds = 1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [alert dismissWithClickedButtonIndex:0 animated:YES];
        });
        [self performSegueWithIdentifier:@"ShowList" sender:self];
    }else{
        __block UIAlertView *alert =
        [[UIAlertView alloc]
         initWithTitle:@"登录失败"
         message:@"用户名或密码不正确"
         delegate:nil
         cancelButtonTitle:nil
         otherButtonTitles:nil];
        [alert show];
        
        // Hide the alert
        double delayInSeconds = 2;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [alert dismissWithClickedButtonIndex:0 animated:YES];
        });
    }
}

//#pragma mark - UITextView Delegate Method
//- (BOOL)textView:(UITextView *) textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}
- (IBAction)backgroundTap:(id)sender {
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}
@end
