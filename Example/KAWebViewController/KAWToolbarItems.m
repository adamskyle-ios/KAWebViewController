//
//  KAWToolbarItems.m
//  KAWebViewController
//
//  Created by Kyle Adams on 12-04-14.
//  Copyright (c) 2014 Kyle Adams. All rights reserved.
//

#import "KAWToolbarItems.h"
#import "KAWebViewController.h"

@interface KAWToolbarItems ()

@property (nonatomic) id target;

@end

@implementation KAWToolbarItems

- (instancetype)initWithTarget:(id)target
{
    self = [super init];
    if (self) {
        if ([target isKindOfClass:[KAWebViewController class]]) {
            self.target = target;
        }
    }
    return self;
}

#define SYSTEM_VERSION_BELOW_IOS7 ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedAscending)

- (UIBarButtonItem *)space
{
    if (!_space) {
        _space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self.target action:nil];
    }
    return _space;
}

- (UIBarButtonItem *)backButton
{
    if (!_backButton) {
        if (SYSTEM_VERSION_BELOW_IOS7) {
            _backButton = [[UIBarButtonItem alloc] initWithTitle:@"◀︎"
                                                           style:UIBarButtonItemStylePlain
                                                          target:self.target
                                                          action:nil];
        } else {
            _backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"KAWBack"]
                                                           style:UIBarButtonItemStylePlain
                                                          target:self.target
                                                          action:nil];
        }
       
    }
    return _backButton;
}

- (UIBarButtonItem *)forwardButton
{
    if (!_forwardButton) {
        if (SYSTEM_VERSION_BELOW_IOS7) {
            _forwardButton = [[UIBarButtonItem alloc] initWithTitle:@"▶︎"
                                                              style:UIBarButtonItemStylePlain
                                                             target:self.target
                                                             action:nil];
        } else {
            _forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"KAWForward"]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self.target
                                                             action:nil];
        }
    }
    return _forwardButton;
}

- (UIBarButtonItem *)refreshButton
{
    if (!_refreshButton) {
        _refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                       target:self.target
                                                                       action:nil];
    }
    return _refreshButton;
}

- (UIBarButtonItem *)stopButton
{
    if (!_stopButton) {
        _stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                    target:self.target
                                                                    action:nil];
    }
    return _stopButton;
}

- (UIBarButtonItem *)actionButton
{
    if (!_actionButton) {
        _actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                      target:self.target
                                                                      action:nil];
    }
    return _actionButton;
}

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
        if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) {
            return @[self.backButton,
                      self.forwardButton,
                      self.refreshButton,
                      self.actionButton];
        } else {
            return @[self.backButton,
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

@end
