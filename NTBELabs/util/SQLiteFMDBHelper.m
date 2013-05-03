//
//  SQLiteFMDBHelper.m
//  FMDBSample
//
//  Created by dai yun on 13-4-26.
//  Copyright (c) 2013年 alexday dev. All rights reserved.
//

#import "SQLiteFMDBHelper.h"


//定义默认数据库名及路径
#define SQLiteDBDefaultName @"Sample.sqlite"

@interface SQLiteFMDBHelper()

@property (nonatomic, strong) FMDatabaseQueue *bindingQueue;
@property (nonatomic, strong) NSString *dbName;
@property (nonatomic, strong) NSString *dbFilePath;

@end

@implementation SQLiteFMDBHelper

@synthesize dbName = _dbName;
@synthesize dbFilePath = _dbFilePath;

#pragma mark - Singleton pattern
+ (SQLiteFMDBHelper *)sharedAppUtil
{
    static SQLiteFMDBHelper *_SQLiteFMDBHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _SQLiteFMDBHelper = [[self alloc] init];
    });
    return _SQLiteFMDBHelper;
}

#pragma mark - init 
- (id)init
{
    self  = [super init];
    if (self)
    {
        //初始化，默认为当前Bundle
        [self setDBName:SQLiteDBDefaultName WithFilePath:@""];
    }
    
    return self;
}

//更改数据库文件及目录
- (void)setDBName:(NSString *)fileName WithFilePath:(NSString *)filePath
{
    if ([ _dbName isEqualToString:fileName] == NO)
    {
        //数据库文件有变更，则更新
        _dbName = fileName;
    }
    /*
     //数据库后缀默认为.sqlite
     if (![fileName hasSuffix:@".sqlite"])
     {
     _dbName = [NSString stringWithFormat:@"%@.sqlite",fileName];
     
     }
     */
    
    
    
    if ([filePath isEqualToString:@""] == NO)
    {
        //文件路径不为空
        _dbFilePath = filePath;
    }
    else
    {
        //文件路径为空，则设为当前Bundle路径
        _dbFilePath = [[NSBundle mainBundle] resourcePath];
    }
    
    [self.bindingQueue close];
    
    //根据文件路径及文件名
    NSString *dbFullPath = [_dbFilePath stringByAppendingPathComponent:fileName];
    
    //NSLog(@"%@",dbFullPath);
    
    //检查数据库文件是否存在
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL success = [fileManager fileExistsAtPath:dbFullPath];
    
    //open db
    if (success)
    {
        //文件存在则加载
        self.bindingQueue = [[FMDatabaseQueue alloc] initWithPath:dbFullPath];
    }
    else {
        [self.bindingQueue close];
    }

    

}

- (FMDatabaseQueue *)getBindingQueue
{
    return self.bindingQueue;
}

//当 NSDictionary 的value 是NSArray 类型时  使用 in 语句   where  name in (value1,value2)
-(NSString*)dictionaryToSqlWhere:(NSDictionary*)dic andValues:(NSMutableArray*)values
{
    NSMutableString* wherekey = [NSMutableString stringWithCapacity:0];
    if(dic != nil && dic.count >0 )
    {
        NSArray* keys = dic.allKeys;
        for (int i=0; i< keys.count;i++) {
            
            NSString* key = [keys objectAtIndex:i];
            id va = [dic objectForKey:key];
            if([va isKindOfClass:[NSArray class]])
            {
                if(wherekey.length > 0)
                {
                    [wherekey appendString:@" and "];
                }
                [wherekey appendFormat:@" %@ in(",key];
                NSArray* vlist = va;
                for (int j=0; j<vlist.count; j++) {
                    [wherekey appendString:@" ? "];
                    if(j != vlist.count-1)
                    {
                        [wherekey appendString:@","];
                    }
                    else
                    {
                        [wherekey appendString:@") "];
                    }
                    [values addObject:[vlist objectAtIndex:j]];
                }
            }
            else
            {
                if(wherekey.length > 0)
                {
                    [wherekey appendFormat:@" and %@ = ? ",key];
                }
                else
                {
                    [wherekey appendFormat:@" %@ = ? ",key];
                }
                [values addObject:va];
            }
            
        }
    }
    return wherekey;
}

@end

@implementation SQLiteFMDBHelper(DatabaseManager)
const static NSString *normaltypestring = @"floatdoublelongshort";
const static NSString *inttypesstring = @"intcharshort";
const static NSString *blobtypestring = @"NSDataUIImage";

//把Object-c 类型 转换为sqlite 类型
+(NSString *)toDBType:(NSString *)type
{
    if([inttypesstring rangeOfString:type].location != NSNotFound)
    {
        return @"integer";
    }
    if ([normaltypestring rangeOfString:type].location != NSNotFound) {
        return @"float";
    }
    if ([blobtypestring rangeOfString:type].location != NSNotFound) {
        return @"blob";
    }
    return @"text";
}

#pragma mark - FMDatabaseQueue inDatabase block
- (void)inDataBase:(void (^)(FMDatabase *fmdb))block
{
    __block BOOL lock = YES;
    [ self.bindingQueue inDatabase:^(FMDatabase *fmdb){
        block(fmdb);
        lock = NO;
        
    }];
    while (lock){}
}

- (void)dropAllTable
{
    /*[self.bindingQueue inDatabase:^(FMDatabase *fmdb){

    }];
    */
    
    [self inDataBase:^(FMDatabase *fmdb){
        FMResultSet *resultSet = [fmdb executeQuery:@"select name from sqlite_master where type='table'"];
        NSMutableArray* dropTables = [NSMutableArray arrayWithCapacity:0];
        while ([resultSet next]) {
            [dropTables addObject:[resultSet stringForColumnIndex:0]];
        }
        [resultSet close];
        for (NSString* tableName in dropTables) {
            NSString* dropTable = [NSString stringWithFormat:@"drop table %@",tableName];
            [fmdb executeUpdate:dropTable];
        }
    }];

}

//获得所有表名
- (NSArray *)getTableNames
{
    __block NSMutableArray *tableNames = nil;
    
    [self inDataBase:^(FMDatabase *fmdb){
        FMResultSet *resultSet = [fmdb executeQuery:@"select distinct tbl_name from sqlite_master"];
        tableNames = [NSMutableArray arrayWithCapacity:0];
        while ([resultSet next]) {
            [tableNames addObject:[resultSet stringForColumnIndex:0]];
        }
        [resultSet close];
        
        
    }];
    
    
    return tableNames;
}


@end

@implementation SQLiteFMDBHelper(DatabaseExecute)


#pragma mark - SQL operator
- (BOOL)ExecuteNonQuery:(NSString *)cmdSQL
{
    __block BOOL effect = NO;

    [self inDataBase:^(FMDatabase *fmdb){
        effect = [fmdb executeUpdate:cmdSQL];
    }];
    
    return effect;
}

//- (FMResultSet *)ExecuteQuery:(NSString *)cmdSQL
//{
//    __block FMResultSet *_resultSet = nil;
//    
//    [self inDataBase:^(FMDatabase *fmdb){
//
//        
//       _resultSet = [fmdb executeQuery:cmdSQL];
//    }];
//    
//    return _resultSet;
//}

 

@end
