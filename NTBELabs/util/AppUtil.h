//
//  AppUtil.h
//  FMDBSample
//
//  Created by dai yun on 13-4-12.
//  Copyright (c) 2013年 alexday dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUtil : NSObject{
    NSUInteger *activityCount;
}

+ (AppUtil *) sharedAppUtil;

+ (NSString *) appFullName;
+ (NSString *) appVersion;


#pragma mark - Database path
+ (NSString *) getAppDBPath;


#pragma mark - network activity indicator management
- (void) refreshNetworkIndicator;
- (void) startNetworkAction;
- (void) endNetworkAction;
+ (BOOL) isConnected;

#pragma mark - Error and alert Functions

- (void) receivedException:(NSException *)e;
- (void) receivedAPIError:(NSError *)error;
- (void) internalError:(NSError *)error;

#pragma mark - Misc utility functions
+ (NSString *) truncateURL:(NSString *)url;
+ (NSString *) trimWhiteSpaceFromString:(NSString *)source;
+ (BOOL) isEmpty:(id) thing;
+ (BOOL) stringIsEmpty:(NSString *) thing;
+ (NSArray *) randomSubsetFromArray:(NSArray *)original ofSize:(int)size;
+ (NSString *) SQLDatetimeFromDate:(NSDate *)date isDateTime:(BOOL)isDateTime;
+ (NSDate *) dateFromSQLDatetime:(NSString *)datetime;
+ (NSString *)stringWithDate:(NSDate *)date;
+ (NSArray *) filterRecords:(NSArray *)records dateField:(NSString *)dateField withDate:(NSDate *)date createdAfter:(BOOL)createdAfter;
+ (NSArray *)sortArray:(NSArray *)toSort;
+ (NSString *)relativeTime:(NSDate *)sinceDate;

void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight);

+ (NSString *) stripHTMLTags:(NSString *)str;
+ (NSString *) stringByDecodingEntities:(NSString *)str;

+ (NSString *)getIPAddress;



//获得指定目录下所有文件名
+ (NSArray *)getFileNamesWithDir:(NSString *)Dir;

@end
