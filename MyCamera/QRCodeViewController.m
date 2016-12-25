//
//  QRCodeViewController.m
//  MyCamera
//
//  Created by rong on 2016/12/25.
//  Copyright © 2016年 rong. All rights reserved.
//

#import "QRCodeViewController.h"

@interface QRCodeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *scanImageView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanHeightConstraint;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scanImageView.clipsToBounds = YES;

}

- (void)viewDidAppear:(BOOL)animated {
    [self startAnimation];
}

- (void)startAnimation {
    self.scanTopConstraint.constant = -300;
    [self.view layoutIfNeeded];

    [UIView animateWithDuration:2.0 animations:^{
        [UIView setAnimationRepeatCount:CGFLOAT_MAX];
        self.scanTopConstraint.constant = 300;
        [self.view layoutIfNeeded];
    }];
}



@end
