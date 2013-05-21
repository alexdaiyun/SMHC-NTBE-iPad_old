//
//  ColorPickerController.h
//  ADTestLabs
//
//  Created by dai yun on 12-11-3.
//  Copyright (c) 2012年 alexday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorPickerController : UIViewController {
    
   // IBOutlet UIImageView* imgView;
   //	UIColor* lastColor;
   //	id pickedColorDelegate;
}



@property (nonatomic,weak) IBOutlet UIImageView *imgView;
@property (nonatomic,strong) UIColor *lastColor;
@property (nonatomic) id pickedColorDelegate;

- (UIColor *) getPixelColorAtLocation:(CGPoint)point;
- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef)inImage;


@end
