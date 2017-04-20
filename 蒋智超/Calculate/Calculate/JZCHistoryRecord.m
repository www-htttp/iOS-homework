//
//  JZCHistoryRecord.m
//  Calculate
//
//  Created by miracle on 2017/4/18.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import "JZCHistoryRecord.h"

@implementation JZCHistoryRecord

- (instancetype)initWithOneNum:(NSString *)one another:(NSString *)another operation:(NSString *)op result:(NSString *)result {
    if (self = [super init]) {
        _oneNum = [one jzcChangeDoubleValueStringToInteger];
        _anotherNum = [another jzcChangeDoubleValueStringToInteger];
        _operation = op;
        _resultNum = [result jzcChangeDoubleValueStringToInteger];
        _record = [[[[_oneNum stringByAppendingString:_operation] stringByAppendingString:_anotherNum] stringByAppendingString:@"="] stringByAppendingString:_resultNum];
    }
    
    return self;
}


@end
