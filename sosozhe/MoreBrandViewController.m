//
//  MoreBrandViewController.m
//  sosozhe
//
//  Created by seed on 14-4-19.
//  Copyright (c) 2014年 sosozhe. All rights reserved.
//

#import "MoreBrandViewController.h"

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"webviewParamNotification" object:nil];
    
    //NSURL *url = [[NSURL alloc]initWithString:@"http://www.sina.com"];
    //[self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

-(void) notificationHandler:(NSNotification *) notification{
    
    NSString *urlStr = [notification object];
    NSLog(@"%@", urlStr);
    NSURL *url=[[NSURL alloc] initWithString:urlStr];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)press:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
