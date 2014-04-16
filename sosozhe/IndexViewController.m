//
//  IndexViewController.m
//  sosozhe
//
//  Created by seed on 14-4-16.
//  Copyright (c) 2014年 sosozhe. All rights reserved.
//

#import "IndexViewController.h"
#import "SGFocusImageItem.h"
#import "SGFocusImageFrame.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[self searchText] setPlaceholder:@"adadss"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self indexTabBar] setFinishedSelectedImage:[UIImage imageNamed:@"tab_index_2_s"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_index_1_s"]];
    SGFocusImageItem *item1 = [[SGFocusImageItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"banner1"] tag:0];
    SGFocusImageItem *item2 = [[SGFocusImageItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"banner3"] tag:1];
    SGFocusImageItem *item3 = [[SGFocusImageItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"banner3"] tag:2];
    SGFocusImageFrame *imageFrame = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0, 0, self.bannerView.bounds.size.width, self.bannerView.bounds.size.height)
                                                                    delegate:self
                                                             focusImageItems:item1, item2, item3,
                                     nil];
    [[self bannerView] addSubview:imageFrame];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
