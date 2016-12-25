//
//  ViewController.m
//  MyCamera
//
//  Created by rong on 2016/12/21.
//  Copyright © 2016年 rong. All rights reserved.
//

#import "ViewController.h"
#import "BeautifulViewController.h"
#import "AdvancedBeautifulViewController.h"
#import "QRCodeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

// 美颜
- (IBAction)makeBeautiful:(UIButton *)sender {

    BeautifulViewController *controller = [[BeautifulViewController alloc] initWithNibName:@"BeautifulViewController" bundle:nil];
    [self presentViewController:controller animated:YES completion:nil];
}

// 高级美颜
- (IBAction)makeAdvancedBeautiful:(UIButton *)sender {
    AdvancedBeautifulViewController *controller = [[AdvancedBeautifulViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}

// 二维码识别
- (IBAction)qrCode:(UIButton *)sender {
    QRCodeViewController *controller = [[QRCodeViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}


@end
