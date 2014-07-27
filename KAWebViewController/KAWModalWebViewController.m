//
//  KAWModalWebViewController.m
//  KAWebViewController
//
//  Created by Kyle Adams on 12-04-14.
//  Copyright (c) 2014 Kyle Adams. All rights reserved.
//

#import "KAWModalWebViewController.h"
#import "KAWebViewController.h"

@interface KAWModalWebViewController () <UINavigationControllerDelegate>

@property (strong, nonatomic) KAWebViewController *webViewController;
@property (strong, nonatomic) UIBarButtonItem *doneButton;

@end

@implementation KAWModalWebViewController

- (void)awakeFromNib
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUrl:(NSURL *)url
{
    _url = url;
    self.webViewController.url = url;
    self.viewControllers = @[self.webViewController];
}

- (KAWebViewController *)webViewController
{
    if (!_webViewController) {
        _webViewController = [[KAWebViewController alloc] init];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            _webViewController.navigationItem.leftBarButtonItem = self.doneButton;
        } else {
            _webViewController.navigationItem.rightBarButtonItem = self.doneButton;
        }
    }
    return _webViewController;
}

- (UIBarButtonItem *)doneButton
{
    if (!_doneButton) {
        _doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissView)];
    }
    return _doneButton;
}

- (void)dismissView
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.webViewController = nil;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}

@end
