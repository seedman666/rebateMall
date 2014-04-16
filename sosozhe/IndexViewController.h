//
//  IndexViewController.h
//  sosozhe
//
//  Created by seed on 14-4-16.
//  Copyright (c) 2014年 sosozhe. All rights reserved.
//

#import "ViewController.h"
#import "CustomTextField.h"

@interface IndexViewController : ViewController
@property (weak, nonatomic) IBOutlet UITabBarItem *indexTabBar;
@property (weak, nonatomic) IBOutlet CustomTextField *searchText;
@property (weak, nonatomic) IBOutlet UIView *bannerView;

@end
