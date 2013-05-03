//
//  ScaleReport.h
//  NTBELabs
//
//  Created by dai yun on 13-5-3.
//  Copyright (c) 2013年 alexday. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScaleReport : NSObject

typedef enum {
    ScaleLevelMMSE, //简明精神状态检查
    ScaleLevelMOCA, //蒙特利尔认知评估
    ScaleLevelNTB,  //成套神经心理测验
    ScaleLevelSAS,  //焦虑自评量表
    ScaleLevelGDS,  //老年抑郁量表
    ScaleLevelLES,  //生活事件量表
    ScaleLevelSSRS  //社会支持评定量表
} ScaleLevelTag;

@property(nonatomic) NSUInteger userID;
@property(nonatomic) NSUInteger scaleReportID;
@property(nonatomic) ScaleLevelTag scaleLevleTag; //量表标识符
@property(nonatomic, strong) NSString *historyDate;
@property(nonatomic, strong) NSDate *reportDate;
@property(nonatomic) NSUInteger score;
@property(nonatomic, strong) NSString *scaleReportDesc;
@property(nonatomic) NSUInteger questionCount; //题目数
@property(nonatomic, strong) NSMutableArray *answers; //题目回答

@end
