//
//  DemoViewController.m
//  KAWebViewController
//
//  Created by Kyle Adams on 09-04-14.
//  Copyright (c) 2014 Kyle Adams. All rights reserved.
//

#import "DemoViewController.h"
#import "KAWebViewController.h"

@interface DemoViewController ()

@property (strong, nonatomic) NSURL *url;

@property (nonatomic) BOOL modal;

@end

@implementation DemoViewController

- (void)setUrl:(NSURL *)url
{
    _url = url;
    
    if (self.modal) {
        [self performSegueWithIdentifier:@"Show Website Modal" sender:self];
    } else {
        [self performSegueWithIdentifier:@"Show Website Push" sender:self];
    }
}

- (IBAction)buttonPressed:(UIButton *)sender
{
    NSString *domain;
    if ([sender.titleLabel.text isEqualToString:@"Google"]) {
        domain = @"google";
    }
    if ([sender.titleLabel.text isEqualToString:@"Bing"]) {
        domain = @"bing";
    }
    if ([sender.titleLabel.text isEqualToString:@"Yahoo"]) {
        domain = @"yahoo";
    }
    if ([sender.titleLabel.text isEqualToString:@"Modal"]) {
        domain = @"google";
        self.modal = YES;
    }
    NSString *urlString = [NSString stringWithFormat:@"http://www.%@.com", domain];
    self.url = [NSURL URLWithString:urlString];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Website Push"]) {
        if ([segue.destinationViewController isKindOfClass:[KAWebViewController class]]) {
            KAWebViewController *kaw = (KAWebViewController *)segue.destinationViewController;
            kaw.url = self.url;
        }
    }
    
    if ([segue.identifier isEqualToString:@"Show Website Modal"]) {
        if ([segue.destinationViewController isKindOfClass:[KAWModalWebViewController class]]) {
            KAWModalWebViewController *modalkaw = (KAWModalWebViewController *)segue.destinationViewController;
            modalkaw.url = self.url;
        }
    }
}

@end
