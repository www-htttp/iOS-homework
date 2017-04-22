//
//  JZCHistoryRecord.h
//  Calculate
//
//  Created by miracle on 2017/4/18.
//  Copyright © 2017年 miracle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZCHistoryRecord : NSObject
@property (nonatomic, copy) NSString *oneNum;
@property (nonatomic, copy) NSString *anotherNum;
@property (nonatomic, copy) NSString *operation;
@property (nonatomic, copy) NSString *resultNum;
@property (nonatomic, copy) NSString *record;
- (instancetype)initWithOneNum:(NSString *)one another:(NSString *)another operation:(NSString *)op result:(NSString *)result;

@end
