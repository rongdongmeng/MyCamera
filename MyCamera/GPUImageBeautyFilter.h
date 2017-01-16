//
//  GPUImageBeautyFilter.h
//  MyCamera
//
//  Created by rong on 2017/1/16.
//  Copyright © 2017年 rong. All rights reserved.
//

#import <GPUImage/GPUImage.h>
#import "GPUImageCombinationFilter.h"

@interface GPUImageBeautyFilter : GPUImageFilterGroup

@property (nonatomic, strong) GPUImageBilateralFilter *bilateralFilter;
@property (nonatomic, strong) GPUImageCannyEdgeDetectionFilter *cannyEdgeFilter;
@property (nonatomic, strong) GPUImageCombinationFilter *combinationFilter;
@property (nonatomic, strong) GPUImageHSBFilter *hsbFilter;

@end
