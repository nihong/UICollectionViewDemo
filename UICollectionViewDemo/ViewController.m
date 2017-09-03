//
//  ViewController.m
//  UICollectionViewDemo
//
//  Created by ios-02 on 2017/9/1.
//  Copyright © 2017年 qqq. All rights reserved.
//

#import "ViewController.h"
#import "RGHomePageActivityCVC.h"
#import "RGActivityFlowLayout.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:customBtn];
    customBtn.frame = CGRectMake(0, 0, 140, 75);
    [customBtn setTitle:@"点我啊" forState:UIControlStateNormal];
    customBtn.backgroundColor = [UIColor redColor];
    [customBtn addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clicked{
    RGHomePageActivityCVC *activityVC = [[RGHomePageActivityCVC alloc]initWithCollectionViewLayout:[[RGActivityFlowLayout alloc]init]];
    UINavigationController * nav =[[UINavigationController alloc]initWithRootViewController:activityVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}


@end
