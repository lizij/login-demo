//
//  DetailViewController.m
//  login
//
//  Created by Paul Jackson on 21/08/2014.
//  Copyright (c) 2014 Paul Jackson. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
- (IBAction)download:(id)sender;
@end

@implementation DetailViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSLog(@"%@", self.dataDic);
    self.imageView.image = [UIImage imageNamed:[self.dataDic objectForKey:@"image"]];
    self.nameLabel.text = [self.dataDic objectForKey:@"name"];
    self.descriptionView.text = [self.dataDic objectForKey:@"description"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)download:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
}
@end
