//
//  SubjectsBLL.h
//  NTBELabs
//
//  Created by dai yun on 13-5-1.
//  Copyright (c) 2013年 alexday. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUtil.h"
#import "SQLiteFMDBHelper.h"
#import "Subjects.h"

/* 受试者逻辑处理 新增/获取  */

@class SubjectsBLL;

@interface SubjectsBLL : NSObject
{
    SQLiteFMDBHelper *_SQLiteFMDBHelper;
}

- (NSMutableArray *)getAllSubjects;

- (int)addSubjects:(NSMutableDictionary *)record;

- (Subjects *)getSubjectsByID:(int)subjectID;


@end
