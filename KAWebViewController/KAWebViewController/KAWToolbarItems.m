//
//  KAWToolbarItems.m
//  KAWebViewController
//
//  Created by Kyle Adams on 12-04-14.
//  Copyright (c) 2014 Kyle Adams. All rights reserved.
//

#import "KAWToolbarItems.h"
#import "KAWebViewController.h"

typedef NS_ENUM(NSInteger, UIToolBarButtonType)
{
    UIToolBarButtonTypeBack,
    UIToolBarButtonTypeForward,
};

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
        _space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self.target action:nil];
    }
    return _space;
}

- (UIBarButtonItem *)backButton
{
    if (!_backButton) {
        _backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:[self buttonForType:UIToolBarButtonTypeBack]]
                                                       style:UIBarButtonItemStylePlain
                                                      target:self.target
                                                      action:nil];
    }
    return _backButton;
}

- (UIBarButtonItem *)forwardButton
{
    if (!_forwardButton) {
        _forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:[self buttonForType:UIToolBarButtonTypeForward]]
                                                          style:UIBarButtonItemStylePlain
                                                         target:self.target
                                                         action:nil];
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

#define SYSTEM_VERSION_BELOW_IOS7 ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedAscending)

- (NSString *)buttonForType:(NSInteger)type
{
    if (type == UIToolBarButtonTypeForward) {
        return SYSTEM_VERSION_BELOW_IOS7 ? @"KAW6Forward" : @"KAWForward";
    } else {
        return SYSTEM_VERSION_BELOW_IOS7 ? @"KAW6Back" : @"KAWBack";
    }
}

@end
