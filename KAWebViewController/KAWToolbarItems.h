//
//  KAWToolbarItems.h
//  KAWebViewController
//
//  Created by Kyle Adams on 12-04-14.
//  Copyright (c) 2014 Kyle Adams. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KAWToolbarItems : NSObject

@property (strong, nonatomic) UIBarButtonItem *space;
@property (strong, nonatomic) UIBarButtonItem *refreshButton;
@property (strong, nonatomic) UIBarButtonItem *backButton;
@property (strong, nonatomic) UIBarButtonItem *forwardButton;
@property (strong, nonatomic) UIBarButtonItem *stopButton;
@property (strong, nonatomic) UIBarButtonItem *actionButton;

@property (strong, nonatomic) NSArray *toolBarItemsWhenLoading;
@property (strong, nonatomic) NSArray *toolBarItemsWhenDoneLoading;

- (instancetype)initWithTarget:(id)target;

@end
