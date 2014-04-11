//
//  KAWViewController.m
//  KAWebViewController
//
//  Created by Kyle Adams on 08-04-14.
//  Copyright (c) 2014 Kyle Adams. All rights reserved.
//

#import "KAWebViewController.h"

#define FORWARD_BUTTON @"KAWForward"
#define BACK_BUTTON @"KAWBack"
#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@interface KAWebViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@property (strong, nonatomic) UIBarButtonItem *space;
@property (strong, nonatomic) UIBarButtonItem *refreshButton;
@property (strong, nonatomic) UIBarButtonItem *backButton;
@property (strong, nonatomic) UIBarButtonItem *forwardButton;
@property (strong, nonatomic) UIBarButtonItem *stopButton;
@property (strong, nonatomic) UIBarButtonItem *actionButton;

@property (strong, nonatomic) NSArray *toolBarItemsWhenLoading;
@property (strong, nonatomic) NSArray *toolBarItemsWhenDoneLoading;

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

- (NSArray *)toolBarItemsWhenLoading
{
    if (!_toolBarItemsWhenLoading) {
        if (IPAD) {
            _toolBarItemsWhenLoading = @[self.backButton,
                                         self.forwardButton,
                                         self.stopButton,
                                         self.actionButton];
        } else {
            _toolBarItemsWhenLoading = @[self.backButton,
                                         self.space,
                                         self.forwardButton,
                                         self.space,
                                         self.stopButton,
                                         self.space,
                                         self.actionButton];
        }
    }
    return _toolBarItemsWhenLoading;
}

- (NSArray *)toolBarItemsWhenDoneLoading
{
    if (!_toolBarItemsWhenDoneLoading) {
        if (IPAD) {
            _toolBarItemsWhenDoneLoading = @[self.backButton,
                                         self.forwardButton,
                                         self.refreshButton,
                                         self.actionButton];
        } else {
            _toolBarItemsWhenDoneLoading = @[self.backButton,
                                         self.space,
                                         self.forwardButton,
                                         self.space,
                                         self.refreshButton,
                                         self.space,
                                         self.actionButton];
        }
    }
    return _toolBarItemsWhenDoneLoading;
}

- (UIBarButtonItem *)space
{
    if (!_space) {
        _space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    }
    return _space;
}

- (UIBarButtonItem *)backButton
{
    if (!_backButton) {
        _backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:BACK_BUTTON]
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(previousPage)];
    }
    return _backButton;
}

- (UIBarButtonItem *)forwardButton
{
    if (!_forwardButton) {
        _forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:FORWARD_BUTTON]
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(forwardPage)];
    }
    return _forwardButton;
}

- (UIBarButtonItem *)refreshButton
{
    if (!_refreshButton) {
        _refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                       target:self
                                                                       action:@selector(refreshPage)];
    }
    return _refreshButton;
}

- (UIBarButtonItem *)stopButton
{
    if (!_stopButton) {
        _stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                    target:self
                                                                    action:@selector(stopRefresh)];
    }
    return _stopButton;
}

- (UIBarButtonItem *)actionButton
{
    if (!_actionButton) {
        _actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                      target:self
                                                                      action:@selector(actionPressed)];
    }
    return _actionButton;
}

- (void)setUrl:(NSURL *)url
{
    _url = url;
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
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
    NSArray *actionItems = @[self.webView.request.URL];
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:actionItems applicationActivities:nil];
    
    [self presentViewController:avc animated:YES completion:nil];
    

}

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.toolbar.tintColor = self.navigationController.navigationBar.tintColor;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //for a snappy UI
    self.view = self.webView;
}

- (void)updateUI
{
    [self setToolbarItemsForState:self.webView.loading];
    
    self.backButton.enabled = self.webView.canGoBack ? YES : NO;
    self.forwardButton.enabled = self.webView.canGoForward? YES : NO;
    
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
            self.toolbarItems = self.toolBarItemsWhenLoading;
        } else {
            self.navigationItem.rightBarButtonItems = self.toolBarItemsWhenLoading.reverseObjectEnumerator.allObjects;
        }
        
    } else {
        
        if (!IPAD) {
            self.toolbarItems = self.toolBarItemsWhenDoneLoading;
        } else {
            self.navigationItem.rightBarButtonItems = self.toolBarItemsWhenDoneLoading.reverseObjectEnumerator.allObjects;
        }
        
        self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    }
}

- (void)viewWillDisappear:(BOOL)animated
{
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
