//
//  ZCCalculateTool.h
//  Calculate
//
//  Created by miracle on 2017/4/17.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCCalculateTool : NSObject

@property (nonatomic, strong) NSMutableArray *records;//计算记录
@property (nonatomic, assign, getter=isCorrected) BOOL correct;//计算成功标志

- (NSString *)calculateWithString:(NSString *)string andLastResult:(NSString *)lastResult;


@end
