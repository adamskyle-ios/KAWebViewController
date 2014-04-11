//
//  KAWViewController.h
//  KAWebViewController
//
//  Created by Kyle Adams on 08-04-14.
//  Copyright (c) 2014 Kyle Adams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KAWebViewController : UIViewController

@property (strong, nonatomic) NSURL *url;

//designated initializer, however the url can also be set by property
- (instancetype)initWithURL:(NSURL *)url;

@end
