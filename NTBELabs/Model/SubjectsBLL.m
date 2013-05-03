//
//  SubjectsBLL.m
//  NTBELabs
//
//  Created by dai yun on 13-5-1.
//  Copyright (c) 2013年 alexday. All rights reserved.
//

#import "SubjectsBLL.h"

@interface SubjectsBLL()

//@property(nonatomic,strong)SQLiteFMDBHelper *_SQLiteFMDBHelper;

@end

@implementation SubjectsBLL

/* local constants */

NSString *const SQL_SELECT_SubjectsData = @"select %@ from TBL_SubjectsProfile order by DateCreated desc ";
NSString *const SQL_SELECT_WithCondition_SubjectsData = @"select %@ from TBL_SubjectsProfile where 1=1 and %@ ";

NSString *const SQL_INSERT_SubjectsData = @"insert into TBL_SubjectsProfile (%@) VALUES(%@) ";

NSString *const sFields_Subjects = @"SubjectID,CodeID,PatientTag,PatientID,Name,NameAbbr,SituationType,Gender,Birthdate,Age,HomeAddress,ZipCode,HomePhoneNumber,HomePhoneNumberSecond,MobilePhoneNumber,Contact,Relationship,EthnicGroup,EduMonths,EduYears,EduLevel,IsRetired,Occupation,LaborType,ResidentsType,Remark,DateCreated,DateLastModified";

NSString *const sFields_SubjectsProfile = @"";
NSString *const sFields_SubjectsProfileExtend = @"";

NSString *const SchemaVersionFormatString = @"Schema_Version_%d";

#pragma mark - init
- (id)init
{
    self  = [super init];
    if (self)
    {
        SQLiteFMDBHelper *__SQLiteFMDBHelper = [SQLiteFMDBHelper sharedAppUtil];
        
        [__SQLiteFMDBHelper setDBName:AppDBName WithFilePath:PATH_OF_DOCUMENT];
        _SQLiteFMDBHelper = __SQLiteFMDBHelper;
    }
    
    return self;
}


#pragma mark - operator

/* 获得所有受试者数据(基本资料，非全部) */
- (NSMutableArray *)getAllSubjects
{
    NSMutableArray *DataArray = [[NSMutableArray alloc]init];
    
    /*NSMutableDictionary *dict =[@{ @"HomeAddress": @"",
                                @"ZipCode": @"",
                                @"HomePhoneNumber": @"" } mutableCopy];
    
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"dict[%@] = %@", key, dict[key]);
    }];
      */
    
    NSString *cmdSQL = [NSString stringWithFormat:SQL_SELECT_SubjectsData
                        , sFields_Subjects ];
    
    //SLLog(@"%@",cmdSQL);
    
    [_SQLiteFMDBHelper inDataBase:^(FMDatabase *fmdb){
        
        FMResultSet *resultSet = [fmdb executeQuery:cmdSQL];
        
        while ([resultSet next])
        {
            Subjects *_Subjects = [[Subjects alloc]init];
            
            _Subjects.SubjectID = [resultSet intForColumn:@"SubjectID"];
            _Subjects.CodeID = [resultSet stringForColumn:@"CodeID"];
            _Subjects.Name = [resultSet stringForColumn:@"Name"];
            _Subjects.NameAbbr = [resultSet stringForColumn:@"NameAbbr"];
            _Subjects.SituationType = [resultSet stringForColumn:@"SituationType"];
            _Subjects.Gender = [resultSet stringForColumn:@"Gender"];
            _Subjects.Birthdate = [resultSet stringForColumn:@"Birthdate"];
            _Subjects.Age = [resultSet stringForColumn:@"Age"];
            _Subjects.EduMonths = [resultSet intForColumn:@"EduMonths"];
            _Subjects.EduYears = [resultSet intForColumn:@"EduYears"];
            _Subjects.DateCreated = [resultSet dateForColumn:@"DateCreated"];
            
            //_Subjects.BasicProfile = [NSMutableDictionary dictionary];
            
            //[_Subjects.BasicProfile setObject:@"123" forKey:@"HomeAddress"];
            
            
            // _Subjects.BasicProfile = dict;
            
            //_Subjects.BasicProfile[@"HomeAddress"] = @"123";
            
            [DataArray addObject:_Subjects];
        
        }
        
        [resultSet close];
        
    }];
    
    //SLLog(@"DataArray count: %d", [DataArray count]);
    
    return DataArray;
}

/* 新增受试者 */
- (int)addSubjects:(NSMutableDictionary *)record
{
    int result = -1; 
       
    NSString *currentDate = [AppUtil getDate];
    
    NSString *_Fields = @"CodeID,Name,NameAbbr,SituationType,Gender,Birthdate,Age,EduYears,EduMonths,DateCreated,DateLastModified";
    NSString *_FieldValues = [NSString stringWithFormat:@"\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\", \"%@\" ", [ record objectForKey:@"CodeID"], [ record objectForKey:@"Name"], [ record objectForKey:@"NameAbbr"], [ record objectForKey:@"SituationType"], [ record objectForKey:@"Gender"], [ record objectForKey:@"Birthdate"], [ record objectForKey:@"Age"], [ record objectForKey:@"EduYears"], [ record objectForKey:@"EduMonths"], currentDate, currentDate ];
    
    //SLog(@"_FieldValues : %@",_FieldValues);
    
    
    NSString *cmdSQL = [NSString stringWithFormat:SQL_INSERT_SubjectsData, _Fields, _FieldValues];
 
    __block int lastInsertRowID = 0;
    __block BOOL isSucceed = NO;
    
    
    [_SQLiteFMDBHelper inDataBase:^(FMDatabase *fmdb){
        isSucceed = [fmdb executeUpdate:cmdSQL];
        lastInsertRowID = fmdb.lastInsertRowId;
        
    }];
    
    if (isSucceed == YES)
    {
        result = lastInsertRowID;
    }
    
    
    return result;
}

/* 根据subjectID获得Subjects */
- (Subjects *)getSubjectsByID:(int)subjectID
{
    Subjects *_Subjects = [[Subjects alloc]init];
    
    NSString *sqlWithCondition =  [NSString stringWithFormat:@"SubjectID = %d",subjectID];
    
    NSString *cmdSQL = [NSString stringWithFormat:SQL_SELECT_WithCondition_SubjectsData, sFields_Subjects, sqlWithCondition];
    
    [_SQLiteFMDBHelper inDataBase:^(FMDatabase *fmdb){
        
        FMResultSet *resultSet = [fmdb executeQuery:cmdSQL];
        
        if ([resultSet next])
        {
            
            _Subjects.SubjectID = [resultSet intForColumn:@"SubjectID"];
            _Subjects.CodeID = [resultSet stringForColumn:@"CodeID"];
            _Subjects.Name = [resultSet stringForColumn:@"Name"];
            _Subjects.NameAbbr = [resultSet stringForColumn:@"NameAbbr"];
            _Subjects.SituationType = [resultSet stringForColumn:@"SituationType"];
            _Subjects.Gender = [resultSet stringForColumn:@"Gender"];
            _Subjects.Birthdate = [resultSet stringForColumn:@"Birthdate"];
            _Subjects.Age = [resultSet stringForColumn:@"Age"];
            _Subjects.EduMonths = [resultSet intForColumn:@"EduMonths"];
            _Subjects.EduYears = [resultSet intForColumn:@"EduYears"];
            _Subjects.DateCreated = [resultSet dateForColumn:@"DateCreated"];
            
        }
        
        [resultSet close];
        
    }];
    
    return _Subjects;
}

@end
