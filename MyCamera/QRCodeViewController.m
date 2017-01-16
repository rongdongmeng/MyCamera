//
//  QRCodeViewController.m
//  MyCamera
//
//  Created by rong on 2016/12/25.
//  Copyright © 2016年 rong. All rights reserved.
//

#import "QRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreFoundation/CoreFoundation.h>

#define ScanImageHeight     300.0

@interface QRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *scanImageView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanTopConstraint;

@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureDeviceInput *inputDevice;
@property (strong, nonatomic) AVCaptureMetadataOutput *ouputData;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic) CALayer *drawLayer;

@end

@implementation QRCodeViewController

- (void)loadView {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLayer];
    [self setupCapture];
}


- (void)viewDidAppear:(BOOL)animated {
    [self startAnimation];
}

- (void)startAnimation {
    self.scanTopConstraint.constant = -ScanImageHeight;
    [self.view layoutIfNeeded];

    [UIView animateWithDuration:2.0 animations:^{
        [UIView setAnimationRepeatCount:CGFLOAT_MAX];
        self.scanTopConstraint.constant = ScanImageHeight;
        [self.view layoutIfNeeded];
    }];
}

- (void)setupCapture {
    _session = [[AVCaptureSession alloc] init];

    if ([_session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        _session.sessionPreset = AVCaptureSessionPreset1280x720;
    }
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    _inputDevice = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    _ouputData = [[AVCaptureMetadataOutput alloc] init];

    if (![_session canAddInput:_inputDevice]) {
        return;
    }

    if (![_session canAddOutput:_ouputData]) {
        return;
    }
    [_session addInput:_inputDevice];
    [_session addOutput:_ouputData];
    // 设置检测数据类型：检测所有支持的数据格式
    _ouputData.metadataObjectTypes = _ouputData.availableMetadataObjectTypes;
    [_ouputData setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    _previewLayer.frame = self.view.bounds;
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer insertSublayer:_previewLayer atIndex:0];

    [_session startRunning];
}

- (void)setupLayer {
    _drawLayer = [CALayer layer];
    _drawLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:_drawLayer atIndex:0];
}

- (void)drawCorners:(AVMetadataMachineReadableCodeObject *)codeObject {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 4;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = [[self createPath:codeObject.corners] CGPath];
    [_drawLayer addSublayer:shapeLayer];
}

- (UIBezierPath *)createPath:(NSArray *)corners {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint point;
    CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)corners[0], &point);
    [path moveToPoint:point];

    for (NSInteger index = 1; index<corners.count; index++) {
        CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)corners[index], &point);
        [path addLineToPoint:point];
    }

    //关闭路径
    [path closePath];

    return path;
}

- (void)clearDrawLayers {
    if (_drawLayer == nil) {
        return;
    }

    for (CALayer *layer in _drawLayer.sublayers) {
        [layer removeFromSuperlayer];
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {

    [self clearDrawLayers];
    for (AVMetadataObject *object in metadataObjects) {
        AVMetadataMachineReadableCodeObject *codeObject = (AVMetadataMachineReadableCodeObject *)[_previewLayer transformedMetadataObjectForMetadataObject:object];
        [self drawCorners:codeObject];
        _resultLabel.text = codeObject.stringValue;
    }
}


@end
