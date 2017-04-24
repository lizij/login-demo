//
//  RegisterViewController.m
//  学习视频
//
//  Created by IOS on 17/4/23.
//  Copyright © 2017年 IOS. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *authpassword;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background.png"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    if (self.username.text.length >= 1 && self.password.text.length >=1 && [self.password.text isEqualToString:self.authpassword.text]) {
        [self dismissViewControllerAnimated:YES completion:^{
            NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:self.username.text, @"username", nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RegisterCompletionNotification" object:nil userInfo:datadic];
        }];
    }
}
- (IBAction)backgroundTap:(id)sender {
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    [self.authpassword resignFirstResponder];
}
@end
