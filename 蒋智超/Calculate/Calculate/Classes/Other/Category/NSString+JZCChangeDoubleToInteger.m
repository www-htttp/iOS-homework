//
//  NSString+JZCChangeDoubleToInteger.m
//  Calculate
//
//  Created by miracle on 2017/4/20.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import "NSString+JZCChangeDoubleToInteger.h"

@implementation NSString (JZCChangeDoubleToInteger)

- (NSString *)jzcChangeDoubleValueStringToInteger {
    if ([self doubleValue] == [self integerValue]) {
        return [NSString stringWithFormat:@"%ld", [self integerValue]];
    } else {
        return self;
    }
}


@end
