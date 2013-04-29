//  MacroUtils.h
//  定义标识符、常量、宏等
//

#ifndef MacroDefines_h
#define MacroDefines_h


#pragma mark - custom constants

#warning
// NEED_OUTPUT_LOG   0 not output / 1 output
#define NEED_OUTPUT_LOG                     1



#define AppDBName                           @"SampleData.sqlite"

#define LabsOrgName         @"FMDB Sample"

#define kLeftMargin				20.0
#define kTopMargin				20.0
#define kRightMargin			20.0
#define kTweenMargin			10.0

#define kTextFieldHeight		30.0

#define masterWidth 224.0f
#define kSplitWidth 1.0f


#define EMPTY_STRING            @""


#pragma mark - AppStroe

#define APP_STORE_LINK_http                 @""
//https://itunes.apple.com/cn/app/dou-ban-xiang-ce-jing-xuan-ji/id588070942?ls=1&mt=8"

#define APP_STORE_LINK_iTunes               @""
//itms-apps://itunes.apple.com/cn/app/id588070942?mt=8"

#define APP_COMMENT_LINK_iTunes             @""
//itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=588070942"




#pragma mark - define Method / variable / constants



#define VERSION                     [[UIDevice currentDevice] systemVersion]
#define AT_LEAST_IOS(xxx)           ( [[VERSION substringToIndex:1] intValue] >= xxx )


#define DeviceScale                 [[UIScreen mainScreen] scale]

#define DevicePortraitWindowWidth   CGRectGetWidth( [[UIScreen mainScreen] bounds] )
#define DevicePortraitWindowHeight  CGRectGetHeight( [[UIScreen mainScreen] bounds] )

#define APP_CACHES_PATH             [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define APP_SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define APP_SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height

#define APP_SCREEN_CONTENT_HEIGHT   ([UIScreen mainScreen].bounds.size.height-20.0)

#define IS_4_INCH                   (APP_SCREEN_HEIGHT > 480.0)



//iOS 5 Declaring the Supported Interface Orientations
#define UIDeviceOrientationIsPortrait(orientation)  ((orientation) == UIDeviceOrientationPortrait || (orientation) == UIDeviceOrientationPortraitUpsideDown)
#define UIDeviceOrientationIsLandscape(orientation) ((orientation) == UIDeviceOrientationLandscapeLeft || (orientation) == UIDeviceOrientationLandscapeRight)

//iOS 6 Declaring the Supported Interface Orientations
#define UIInterfaceOrientationMaskPortrait          (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown)
#define UIInterfaceOrientationMaskLandscape         (UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight)


#define PATH_OF_APP_HOME        NSHomeDirectory()
#define PATH_OF_APP_RESOURCE    [[NSBundle mainBundle] resourcePath]
#define PATH_OF_TEMP            NSTemporaryDirectory()
#define PATH_OF_DOCUMENT        [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define USER_DEFAULT                [NSUserDefaults standardUserDefaults]



#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBCOLOR(r,g,b)             [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a)          [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define NOTIFICATION_CENTER         [NSNotificationCenter defaultCenter]


#define DownArrowCharacter @"▼"
#define UpArrowCharacter @"▲"



#define NSNumberFromInt(i)  [NSNumber numberWithInt:i]

// assuming CGRect b is smaller than CGRect a, returns a single origin point for rect b such that it is centered,
// by size, within rect a
#define CGPointCenteredOriginPointForRects(a, b)    CGPointMake( \
CGRectGetMinX(a) + floorf( ( ABS( CGRectGetWidth( a ) - CGRectGetWidth( b ) ) ) / 2.0f ), \
CGRectGetMinY(a) + floorf( ( ABS( CGRectGetHeight( a ) - CGRectGetHeight( b ) ) ) / 2.0f ) )

#define AppPrimaryColor UIColorFromRGB(0x222222)
#define AppSecondaryColor UIColorFromRGB(0x1797C0)
#define AppLinkColor UIColorFromRGB(0x1679c9)
#define AppTextCellColor RGB( 57.0f, 85.0f, 135.0f )


#define LOADVIEWBOXSIZE 100
#define LOADINGVIEWTAG -11









#pragma mark - Log

#if NEED_OUTPUT_LOG

    #define SLog(xx, ...)   NSLog(xx, ##__VA_ARGS__)
    #define SLLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

    #define SLLogRect(rect) \
    SLLog(@"%s x=%f, y=%f, w=%f, h=%f", #rect, rect.origin.x, rect.origin.y, \
    rect.size.width, rect.size.height)

    #define SLLogPoint(pt) \
    SLLog(@"%s x=%f, y=%f", #pt, pt.x, pt.y)

    #define SLLogSize(size) \
    SLLog(@"%s w=%f, h=%f", #size, size.width, size.height)

    #define SLLogColor(_COLOR) \
    SLLog(@"%s h=%f, s=%f, v=%f", #_COLOR, _COLOR.hue, _COLOR.saturation, _COLOR.value)

    #define SLLogSuperViews(_VIEW) \
    { for (UIView* view = _VIEW; view; view = view.superview) { SLLog(@"%@", view); } }

    #define SLLogSubViews(_VIEW) \
    { for (UIView* view in [_VIEW subviews]) { SLLog(@"%@", view); } }

#else

    #define SLog(xx, ...)  ((void)0)
    #define SLLog(xx, ...)  ((void)0)

#endif /* if NEED_OUTPUT_LOG */


#endif