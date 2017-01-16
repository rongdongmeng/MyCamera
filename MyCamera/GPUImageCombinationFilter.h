//
//  GPUImageCombinationFilter.h
//  MyCamera
//
//  Created by rong on 2017/1/16.
//  Copyright © 2017年 rong. All rights reserved.
//

#import <GPUImage/GPUImage.h>

@interface GPUImageCombinationFilter : GPUImageThreeInputFilter {
    GLint smoothDegreeUniform;
}

@property (nonatomic, assign) CGFloat intensity;

@end
