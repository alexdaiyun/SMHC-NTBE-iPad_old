//
//  SQLiteFMDBHelper.h
//  FMDBSample
//
//  Created by dai yun on 13-4-26.
//  Copyright (c) 2013年 alexday dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMResultSet.h"

//@class FMDatabase;
//@class FMDatabaseQueue;
//@class FMResultSet;


@interface SQLiteFMDBHelper : NSObject
{
    
}

+ (SQLiteFMDBHelper *) sharedAppUtil;

- (void)setDBName:(NSString *)fileName WithFilePath:(NSString *)filePath;
- (FMDatabaseQueue *)getBindingQueue;


@end


@interface SQLiteFMDBHelper(DatabaseManager)
{
    
}

+(NSString*)toDBType:(NSString*)type;

- (void)inDataBase:(void (^)(FMDatabase *fmdb))block;

- (void)dropAllTable;
- (NSArray *)getTableNames;

@end

@interface SQLiteFMDBHelper(DatabaseExecute)
{
    
}

//- (FMResultSet *)ExecuteQuery:(NSString *)cmdSQL;

@end

