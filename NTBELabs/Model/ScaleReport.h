//
//  ScaleReport.h
//  NTBELabs
//
//  Created by dai yun on 13-5-3.
//  Copyright (c) 2013年 alexday. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface ScaleReport : NSObject




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
