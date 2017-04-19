//
//  ZCCalculateTool.m
//  Calculate
//
//  Created by miracle on 2017/4/17.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import "ZCCalculateTool.h"
#import "HistoryRecord.h"
#define kEndNum @10000

@interface ZCCalculateTool ()

@property (nonatomic, strong) NSMutableArray *numStack;//操作数栈
@property (nonatomic, strong) NSMutableArray *opStack;//操作符栈
@property (nonatomic, strong) NSDictionary *opPriority;//优先度表
@property (nonatomic, copy) NSString *inputStr;//计算式
@property (nonatomic, copy) NSString *errorStr;//错误信息
@property (nonatomic, copy) NSString *outputStr;//计算结果
@property (nonatomic, copy) NSString *numStr;//操作数

@end

@implementation ZCCalculateTool

- (instancetype)init {
    if (self = [super init]) {
        _numStack = [NSMutableArray array];
        _opStack = [[NSMutableArray alloc] initWithObjects:@"#", nil];
        _opPriority = @{@"(":@0, @"x":@1, @"/":@1, @"+":@2, @"-":@2, @")":@3, @"#":kEndNum};
        _records = [NSMutableArray array];
    }
    
    return self;
}

- (NSString *)calculateWithString:(NSString *)string andLastResult:(NSString *)lastResult{
    //连算
    char firstChar = [string characterAtIndex:0];
    BOOL flag = (firstChar == '+') || (firstChar == '-') || (firstChar == 'x') || (firstChar == '/');
    if (lastResult.length && flag) {
        [self.numStack addObject:lastResult];
    }
    
    self.inputStr = [string stringByAppendingString:@"#"];
    
    for (int i = 0; i < self.inputStr.length; i++) {
        char c = [self.inputStr characterAtIndex:i];
        NSString *charStr = [NSString stringWithFormat:@"%c", c];
        NSNumber *opPriorityNum = self.opPriority[charStr];
        switch (c) {
            case '#'://进行计算直到与“#”配对
                [self separateNumStr];
                
                while (![[self.opStack lastObject] isEqualToString:@"#"]) {
                    [self baseCalculate];
                    if (self.errorStr) break;

                }
                
                if (!self.errorStr && (self.numStack.count == 1)) {
                    self.outputStr = [self.numStack lastObject];
                } else {
                    self.errorStr = @"错误";
                }
                
                break;
                
            case '('://直接入栈
                [self separateNumStr];
                [self.opStack addObject:charStr];
                break;
                
            case ')'://进行计算直到与‘(’配对
                [self separateNumStr];
                
                while (![[self.opStack lastObject] isEqualToString:@"("]) {
                    [self baseCalculate];
                    if (self.errorStr) break;
                }
                
                if (!self.errorStr && [[self.opStack lastObject] isEqualToString:@"("]) {
                    [self.opStack removeLastObject];
                } else {
                    self.errorStr = @"错误";
                }
                
                break;
                
            case '+':
            case '-':
            case 'x':
            case '/':
                [self separateNumStr];
                
                //优先级比栈顶低，进行计算直到比栈顶优先级高或者遇到‘(’
                if (opPriorityNum.integerValue >= ((NSNumber *)self.opPriority[[self.opStack lastObject]]).integerValue) {
                    
                    while (![[self.opStack lastObject] isEqualToString:@"("] && (opPriorityNum.integerValue >= ((NSNumber *)self.opPriority[[self.opStack lastObject]]).integerValue)) {
                        
                        [self baseCalculate];
                        
                        if (self.errorStr) break;

                    }
                    
                    if ([[self.opStack lastObject] isEqualToString:@"("] && !self.errorStr) {
                        [self.opStack addObject:charStr];
                    }
                }
                
                //比栈顶优先级高，入栈
                if (opPriorityNum.integerValue < ((NSNumber *)self.opPriority[[self.opStack lastObject]]).integerValue) {
                    [self.opStack addObject:charStr];
                }
    
                break;
                
            default:
                if (!self.numStr) self.numStr = @"";
                self.numStr = [self.numStr stringByAppendingString:charStr];
                break;
        }
        
        if (self.errorStr) break;
    }
    
    if (self.errorStr) {
        self.correct = NO;
        return self.errorStr;
    } else {
        self.correct = YES;
        return self.outputStr;
    }
}

#pragma mark - 基础的两数运算
- (void)baseCalculate {
    NSInteger count = self.numStack.count;
    if (count < 2) {
        self.errorStr = @"错误";
    } else {
        NSString *resultNum = [self calculateOneNum:self.numStack[count - 2] withAnother:self.numStack[count - 1] byOperation:[self.opStack lastObject]];
        
        HistoryRecord *re = [[HistoryRecord alloc] initWithOneNum:self.numStack[count - 2] another:self.numStack[count - 1] operation:[self.opStack lastObject] result:resultNum];
        [self.records addObject:re.record];

        if (![resultNum isEqualToString:@"error"]) {
            [self.numStack removeLastObject];
            [self.numStack removeLastObject];
            [self.numStack addObject:resultNum];
            [self.opStack removeLastObject];
            
        }
        
    }
}

#pragma mark - 分离操作数
- (void)separateNumStr {
    if (self.numStr) {
        [self.numStack addObject:self.numStr];
        self.numStr = nil;
    }

}

#pragma mark - 计算方法
- (NSString *)calculateOneNum:(NSString *)one withAnother:(NSString *)another byOperation:(NSString *)op {
    double oneNum = [one doubleValue];
    double anotherNum = [another doubleValue];
    char c = [op characterAtIndex:0];
    NSString *result = @"error";
    switch (c) {
        case '+':
            result = [NSString stringWithFormat:@"%lf", oneNum + anotherNum];
            break;
        case '-':
            result = [NSString stringWithFormat:@"%lf", oneNum - anotherNum];
            break;
        case 'x':
            result = [NSString stringWithFormat:@"%lf", oneNum * anotherNum];
            break;
        case '/':
            if (anotherNum == 0) {
                self.errorStr = @"错误";
            } else {
                result = [NSString stringWithFormat:@"%lf", oneNum / anotherNum];
            }
            break;
        default:
            self.errorStr = @"错误";
            break;
    }
    
    return result;
}


@end
