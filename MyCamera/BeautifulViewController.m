//
//  BeautifulViewController.m
//  MyCamera
//
//  Created by rong on 2016/12/21.
//  Copyright © 2016年 rong. All rights reserved.
//

#import "BeautifulViewController.h"
#import <GPUImage/GPUImage.h>

@interface BeautifulViewController ()

@property (nonatomic, strong) GPUImageBilateralFilter *bilaterFilter;
@property (nonatomic, strong) GPUImageBrightnessFilter *brightFilter;
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageView *captureVideoView;

@end

@implementation BeautifulViewController


- (IBAction)bilaterValueChanged:(UISlider *)sender {

    CGFloat maxValue = 10.0;

    // 值越小，磨皮效果越好
    //_bilaterFilter.distanceNormalizationFactor = (maxValue - sender.value);
    [_bilaterFilter setDistanceNormalizationFactor:(maxValue - sender.value)];
}

- (IBAction)brightValueChanged:(UISlider *)sender {

    _brightFilter.brightness = sender.value;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建视频源
    _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    // 设置照相机方向
    _videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    // 设置这个，YES 代表摄像头前置的时候不是镜像
    _videoCamera.horizontallyMirrorFrontFacingCamera = YES;

    // 最终预览的UIImageView
    _captureVideoView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_captureVideoView];
    [self.view insertSubview:_captureVideoView atIndex:0];

    // 创建GPUImage的滤镜组合
    GPUImageFilterGroup *groupFilter = [[GPUImageFilterGroup alloc] init];

    // 磨皮滤镜：双边滤波
    _bilaterFilter = [[GPUImageBilateralFilter alloc] init];
    _bilaterFilter.distanceNormalizationFactor = 10.0;
    [groupFilter addTarget:_bilaterFilter];

    // 美白滤镜：亮度
    _brightFilter = [[GPUImageBrightnessFilter alloc] init];
    _brightFilter.brightness = 0.0;
    [groupFilter addTarget:_brightFilter];

    // 设置滤镜组链
    [_bilaterFilter addTarget:_brightFilter];
    [groupFilter setInitialFilters:@[_bilaterFilter]];
    groupFilter.terminalFilter = _brightFilter;

    // 设置GPUImage处理链，数据源 => 滤镜 => 最终界面显示效果
    [_videoCamera addTarget:groupFilter];
    [groupFilter addTarget:_captureVideoView];

    // 底层把采集到的视频源，渲染到 GPUImageView 中，就能显示了
    // 开始采集视频
    [_videoCamera startCameraCapture];

}


@end
