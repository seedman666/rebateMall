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
#import "MBProgressHUD.h"
#import "BrandView.h"
#import "AppDelegate.h"

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

    NSDictionary *parameters = @{@"page": @"1", @"num" : @"8"};
    [manager POST:@"http://api.sosozhe.com.cn/index.php?mod=ajax&act=malls" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [HUD removeFromSuperview];
        NSArray *array=(NSArray *) responseObject;
        for (int i=0; i<[array count]; i=i+1) {
            NSDictionary *dict=[array objectAtIndex:i];
            int j=(i/3)%3;
            
            NSString *imgUrl=[dict objectForKey:@"img"];
            NSString *title=[[dict objectForKey:@"title"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSString *fanRation=[dict objectForKey:@"fan"];
            NSString *url=[dict objectForKey:@"url"];
            
            BrandView *brandView=[[BrandView alloc] initWithFrame:CGRectMake(9+100*(i%3), 29+76*(j%3), 77, 65)];
            brandView.url=url;
            UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(brandViewClick:)];
            [brandView addGestureRecognizer:tapGesture];
            
            
            
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 77, 40)];
            UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 41, 50, 25)];
            UILabel *fanLabel=[[UILabel alloc] initWithFrame:CGRectMake(60, 41, 30, 25)];
           
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]]];
            [imageView setImage:image];
            [titleLabel setText:title];
            [titleLabel setFont:[UIFont systemFontOfSize:10]];
            [fanLabel setText:fanRation];
            [fanLabel setFont:[UIFont systemFontOfSize:10]];
            [fanLabel setTextColor:[UIColor orangeColor]];
            
            [brandView addSubview:imageView];
            [brandView addSubview:titleLabel];
            [brandView addSubview:fanLabel];
            
            [[self hotStoreView] addSubview:brandView];
        }
        
        BrandView *brandView=[[BrandView alloc] initWithFrame:CGRectMake(9+100*2, 29+76*2, 77, 65)];
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 41, 50, 25)];
        [titleLabel setText:@"查看更多"];
        [titleLabel setFont:[UIFont systemFontOfSize:10]];
        [brandView addSubview:titleLabel];
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreBrandViewClick:)];
        [brandView addGestureRecognizer:tapGesture];
        [[self hotStoreView] addSubview:brandView];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [HUD removeFromSuperview];
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
    [self performSegueWithIdentifier:@"brandDetailWebView" sender:self];
}

-(void) brandViewClick:(UITapGestureRecognizer *) gesture{
    [self performSegueWithIdentifier:@"brandDetailWebView" sender:self];
    BrandView *view=(BrandView *)gesture.view;
    NSString *url=view.url;
    NSLog(@"1%@", url);
    //NSDictionary *dicts = [NSDictionary dictionaryWithObjectsAndKeys:@"url",url, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"webviewParamNotification" object:url];
    
}

-(void) moreBrandViewClick:(UITapGestureRecognizer *) gesture{
    AppDelegate *thisAppDelegate = [[UIApplication sharedApplication] delegate];
    [(UITabBarController *)thisAppDelegate.window.rootViewController setSelectedIndex:2];
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
