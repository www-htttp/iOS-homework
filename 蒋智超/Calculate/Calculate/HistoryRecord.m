//
//  HistoryRecord.m
//  Calculate
//
//  Created by miracle on 2017/4/18.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import "HistoryRecord.h"

@implementation HistoryRecord

- (instancetype)initWithOneNum:(NSString *)one another:(NSString *)another operation:(NSString *)op result:(NSString *)result {
    if (self = [super init]) {
        _oneNum = one;
        _anotherNum = another;
        _operation = op;
        _resultNum = result;
        _record = [[[[one stringByAppendingString:op] stringByAppendingString:another] stringByAppendingString:@"="] stringByAppendingString:result];
    }
    
    return self;
}

@end
