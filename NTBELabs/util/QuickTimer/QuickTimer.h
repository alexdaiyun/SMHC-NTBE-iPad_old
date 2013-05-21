//
//  QuickTimer.h
//  TestWebView
//
//  Created by dai yun on 13-5-11.
//  Copyright (c) 2013年 alexday. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    eQuickTimerStateRunning,
    eQuickTimerStateStopped,
    eQuickTimerStatePaused
    
} eQuickTimerState;


/** 以GCD方式运作的NSTimer
 
 */

@interface QuickTimer : NSObject
{
    eQuickTimerState mCurrentState;
    NSTimeInterval mTimeInterval;
}


@property (nonatomic, readonly) eQuickTimerState currentState;
@property (nonatomic, readwrite) NSTimeInterval timeInterval;


+ (QuickTimer *)createTimerWithTimerInterval:(NSTimeInterval)seconds block:(dispatch_block_t)block;


- (void)start;

- (void)stop;

- (void)pause;

- (void)resume;

@end


