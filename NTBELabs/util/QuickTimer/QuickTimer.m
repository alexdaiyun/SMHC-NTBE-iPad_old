//
//  QuickTimer.m
//  TestWebView
//
//  Created by dai yun on 13-5-11.
//  Copyright (c) 2013年 alexday. All rights reserved.
//

#import "QuickTimer.h"

@interface QuickTimer()

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
// iOS 6.0 or later
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, readwrite, strong) dispatch_source_t source;
#else
@property (nonatomic) dispatch_queue_t queue;
@property (nonatomic, readwrite) dispatch_source_t source;
#endif

@property (nonatomic, strong) dispatch_block_t block;
 
@end


@implementation QuickTimer

@synthesize block = _block;
@synthesize source = _source;
@synthesize queue = _queue;

@synthesize currentState = mCurrentState;
@synthesize timeInterval = mTimeInterval;

- (id)init {
    self = [super init];
    if (self) {
        mCurrentState = eQuickTimerStateStopped;
        mTimeInterval = 0;
        
        _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
        
        //timer.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        
        _source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _queue);
        
        
    }
    return self;
}


/*  每秒执行 */
+ (QuickTimer *)createTimerWithTimerInterval:(NSTimeInterval)seconds block:(dispatch_block_t)block
{
    QuickTimer *timer = [[self alloc]init];
    
    timer.block = block;
    
    timer.timeInterval = seconds;


    
    uint64_t sec = (uint64_t)(seconds * NSEC_PER_SEC ); /* seconds 秒 */
    
    
//    uint64_t msec = (uint64_t)(seconds * NSEC_PER_MSEC ); /* microseconds per second 毫秒*/    
//    uint64_t nsec = (uint64_t)(seconds * NSEC_PER_USEC ) ; /* nanoseconds 纳妙*/
    
    dispatch_source_set_timer(timer.source, dispatch_walltime(NULL, 0), sec, 0);  //每秒执行一次
 

    dispatch_source_set_event_handler(timer.source, block);
        
 

    return timer;
    
}


- (void)dealloc
{
    [self stop];
}

/** 定时开始*/
- (void)start
{
    //self.block();
    if (self.source){
        dispatch_resume(self.source);
    }
    
    mCurrentState = eQuickTimerStateRunning;
}

/** 关闭定时 */
- (void)close
{
    [self stop];
    
    
}

/** 定时结束
*/
- (void)stop
{
    if (self.source){
        if ((mCurrentState == eQuickTimerStateRunning ) || (mCurrentState == eQuickTimerStatePaused))
        {
            dispatch_source_cancel(self.source);
        }
        
        self.source = NULL;
    }
    
    self.block = NULL;
    
    mCurrentState = eQuickTimerStateStopped;
    
    mTimeInterval = 0;
}

/** 定时暂停 */
- (void)pause
{
    if (self.source)
    {
        dispatch_suspend(self.source);
        
        
    }
    
    mCurrentState = eQuickTimerStatePaused;
    
}

- (void)resume
{
    if (self.source)
    {
        dispatch_resume(self.source);
        
        
        
    }
    
    mCurrentState = eQuickTimerStateRunning;
}

@end
