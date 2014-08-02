//
//  KAWViewController.m
//  KAWebViewController
//
//  Created by Kyle Adams on 08-04-14.
//  Copyright (c) 2014 Kyle Adams. All rights reserved.
//

#import "KAWebViewController.h"
#import "KAWToolbarItems.h"

#define FORWARD_BUTTON @"KAWForward"
#define BACK_BUTTON @"KAWBack"
#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@interface KAWebViewController () <UIWebViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) KAWToolbarItems *toolbar;

@end

@implementation KAWebViewController

- (instancetype)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}

#pragma mark - Properties

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}

- (KAWToolbarItems *)toolbar
{
    if (!_toolbar) {
        _toolbar = [[KAWToolbarItems alloc] initWithTarget:self];
        [self setButtonActions];
    }
    return _toolbar;
}

- (void)setUrl:(NSURL *)url
{
    _url = url;
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (void)setButtonActions
{
    self.toolbar.refreshButton.action = @selector(refreshPage);
    self.toolbar.stopButton.action = @selector(stopRefresh);
    self.toolbar.backButton.action = @selector(previousPage);
    self.toolbar.forwardButton.action = @selector(forwardPage);
    self.toolbar.actionButton.action = @selector(actionPressed);
}

#pragma mark - Target Actions

-(void)previousPage
{
    [self.webView goBack];
}

-(void)forwardPage
{
    [self.webView goForward];
}

- (void)refreshPage
{
    [self.webView reload];
}

- (void)stopRefresh
{
    [self.webView stopLoading];
    [self updateUI];
}

- (void)actionPressed
{
    //needs some work
    NSArray *actionItems = @[self.webView.request.URL];
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:actionItems applicationActivities:nil];
    
    [self presentViewController:avc animated:YES completion:nil];
}

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.navigationController.toolbar.barTintColor = self.navigationController.navigationBar.tintColor;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.view = self.webView;
}

- (void)updateUI
{
    [self setToolbarItemsForState:self.webView.loading];
    
    self.toolbar.backButton.enabled = self.webView.canGoBack ? YES : NO;
    self.toolbar.forwardButton.enabled = self.webView.canGoForward? YES : NO;
    
    if (!IPAD) {
        if (self.navigationController.toolbar.hidden) {
            [self.navigationController setToolbarHidden:NO animated:NO];
        }
    }
}

- (void)setToolbarItemsForState:(BOOL)loading
{
    if (loading) {
        if (!IPAD) {
            self.toolbarItems = self.toolbar.toolBarItemsWhenLoading;
        } else {
            self.navigationItem.rightBarButtonItems = self.toolbar.toolBarItemsWhenLoading.reverseObjectEnumerator.allObjects;
        }
        
    } else {
        if (!IPAD) {
            self.toolbarItems = self.toolbar.toolBarItemsWhenDoneLoading;
        } else {
            self.navigationItem.rightBarButtonItems = self.toolbar.toolBarItemsWhenDoneLoading.reverseObjectEnumerator.allObjects;
        }
        
        self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setToolbarHidden:YES animated:YES];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self updateUI];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateUI];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateUI];
}

@end
