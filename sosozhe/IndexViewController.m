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
#import <AFNetworking.h>
#import "Header.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    UITapGestureRecognizer *tapGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(vipClick:)];
    UITapGestureRecognizer *tapGesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkInClick:)];
    UITapGestureRecognizer *tapGesture3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addFriendClick:)];
    [[self vipView] addGestureRecognizer:tapGesture1];
    [[self checkInView] addGestureRecognizer:tapGesture2];
    [[self addFriendView] addGestureRecognizer:tapGesture3];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    NSDictionary *parameters = @{@"page": @"1", @"num" : @"9"};
    [manager POST:@"http://api.sosozhe.com.cn/index.php?mod=ajax&act=malls" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSError *error;
//        NSLog(@"JSON: %@", responseObject);
//        NSDictionary *data2 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        //NSLog(@"%@", [data2 objectForKey:@"title"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    if (!IS_IPHONE5){
        [[self scrollView] setFrame:CGRectMake(0, 0, 320, 480)];
        [[self scrollView] setContentSize:CGSizeMake(320, 568)];
        [[self scrollView] setContentOffset:CGPointMake(0, 0)];
        [[self scrollView] setContentInset:UIEdgeInsetsMake(0 , 0, 0, 0)];
        self.scrollView.bounces=FALSE;
    }
}

- (void)vipClick:(UITapGestureRecognizer *)gesture{
    NSLog(@"%@", gesture.view);
}

- (void)checkInClick:(UITapGestureRecognizer *)gesture{
    NSLog(@"%@", gesture.view);
}

- (void)addFriendClick:(UITapGestureRecognizer *)gesture{
    NSLog(@"%@", gesture.view);
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
