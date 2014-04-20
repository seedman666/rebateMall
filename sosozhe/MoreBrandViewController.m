//
//  MoreBrandViewController.m
//  sosozhe
//
//  Created by seed on 14-4-20.
//  Copyright (c) 2014年 sosozhe. All rights reserved.
//

#import "MoreBrandViewController.h"
#import <AFNetworking.h>
#import "Header.h"
#import "BrandView.h"


@interface MoreBrandViewController ()

@end

@implementation MoreBrandViewController

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
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *parameters = @{@"page": @"2", @"num" : @"9"};
    [manager POST:@"http://api.sosozhe.com.cn/index.php?mod=ajax&act=malls" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
            
            [[self scrollView] addSubview:brandView];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

-(void) brandViewClick:(UITapGestureRecognizer *) gesture{
    [self performSegueWithIdentifier:@"brandDetailWebView" sender:self];
    BrandView *view=(BrandView *)gesture.view;
    NSString *url=view.url;
    NSLog(@"1%@", url);
    //NSDictionary *dicts = [NSDictionary dictionaryWithObjectsAndKeys:@"url",url, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"webviewParamNotification" object:url];
    
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
