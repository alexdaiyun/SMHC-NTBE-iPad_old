//
//  ScaleReport.h
//  NTBELabs
//
//  Created by dai yun on 13-5-3.
//  Copyright (c) 2013年 alexday. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ScaleReport : NSObject

@property(nonatomic) NSUInteger ScaleReportID; //ID
@property(nonatomic) NSUInteger SubjectID;
@property(nonatomic) ScaleLevelTag scaleLevleTag; //量表标识符
@property(nonatomic, strong) NSDate *reportDate; //测试创建日期
@property(nonatomic) NSUInteger score;
@property(nonatomic, strong) NSString *scaleReportDesc;
@property(nonatomic) NSUInteger questionCount; //题目数
@property(nonatomic, strong) NSMutableArray *answers; //题目回答

@end
