//
//  MoreBrandViewController.h
//  sosozhe
//
//  Created by seed on 14-4-20.
//  Copyright (c) 2014年 sosozhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

@interface MoreBrandViewController : UIViewController
@property (weak, nonatomic) IBOutlet CustomTextField *searchText;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
