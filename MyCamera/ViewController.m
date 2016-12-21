//
//  ViewController.m
//  MyCamera
//
//  Created by rong on 2016/12/21.
//  Copyright © 2016年 rong. All rights reserved.
//

#import "ViewController.h"
#import "BeautifulViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (IBAction)makeBeautiful:(UIButton *)sender {

    BeautifulViewController *controller = [[BeautifulViewController alloc] initWithNibName:@"BeautifulViewController" bundle:nil];
    [self presentViewController:controller animated:YES completion:nil];
}


@end
