//
//  Subjects.h
//  NTBELabs
//
//  Created by dai yun on 13-5-1.
//  Copyright (c) 2013年 alexday. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Subjects : NSObject

@property(nonatomic) NSUInteger SubjectID;
@property(nonatomic, strong) NSString *Name; //受访者姓名
@property(nonatomic, strong) NSString *NameAbbr; //受访者姓名缩写
@property(nonatomic, strong) NSString *SituationType; //现况类型
@property(nonatomic, strong) NSString *Gender; //性别
@property(nonatomic, strong) NSString *Birthdate; //出生年月日
@property(nonatomic, strong) NSString *Age; //年龄
@property(nonatomic) NSUInteger EduYears; //受教育年数
@property(nonatomic) NSUInteger EduMonths; //受教育月数
@property(nonatomic, strong) NSMutableDictionary *BasicProfile; //基本资料信息
@property(nonatomic, strong) NSMutableDictionary *ExtendProfile; //扩展资料信息


@end
