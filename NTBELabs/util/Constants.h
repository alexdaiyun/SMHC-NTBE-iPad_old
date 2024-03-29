//
//  Constants.h
//  NTBELabs
//
//  Created by dai yun on 13-5-3.
//  Copyright (c) 2013年 alexday. All rights reserved.
//

#ifndef NTBELabs_Constants_h
#define NTBELabs_Constants_h


#define ScaleLevel_FilePath     @"ScaleLevel"
#define ScaleLevel_ConfigFile   @"Config_ScaleLevel.plist"


#endif

typedef enum {
    ScaleLevelMMSE, //简明精神状态检查
    ScaleLevelMOCA, //蒙特利尔认知评估
    ScaleLevelNTB,  //成套神经心理测验
    ScaleLevelSAS,  //焦虑自评量表
    ScaleLevelGDS,  //老年抑郁量表
    ScaleLevelLES,  //生活事件量表
    ScaleLevelSSRS  //社会支持评定量表
} ScaleLevelTag; //量表Tag

typedef enum {
    QTText
    
} QuestionType; //题目类型