//
//  BrushCanvas.h
//  ADTestLabs
//
//  Created by dai yun on 12-11-3.
//  Copyright (c) 2012年 alexday. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ColorPickerController;

@interface BrushCanvas : UIView <UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    
}


@property (nonatomic,strong) UIImage *pickedImage;
@property (nonatomic,strong) UIImage *screenImage;
@property (nonatomic,strong) NSMutableArray *arrayStrokes;
@property (nonatomic,strong) NSMutableArray *arrayAbandonedStrokes;
@property (nonatomic,strong) UIColor *currentColor;
@property (nonatomic) float currentSize;

@property (nonatomic,weak) IBOutlet UISlider *sliderSize;
@property (nonatomic,weak) IBOutlet UIButton *buttonColor;
@property (nonatomic,weak) IBOutlet UIToolbar *toolBar;
@property (nonatomic,weak) IBOutlet UILabel *labelSize;

@property (nonatomic, weak) IBOutlet UIButton *btnClosed;


@property (nonatomic,strong) ColorPickerController *colorPC;
@property (nonatomic,strong) UIPopoverController *colorPopoverController;
//@property (nonatomic,strong) UIPopoverController *sharePopoverController;
@property (nonatomic,strong) UIImagePickerController *imagePC;
@property (nonatomic,strong) UIPopoverController *imagePopoverController;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic,strong) NSArray *permissions;
@property (nonatomic,strong) id owner;



- (IBAction) didClickChoosePhoto;
- (IBAction) didClickColorButton;
- (IBAction) setBrushSize:(UISlider*)sender;
- (IBAction) eraser;
- (IBAction) undo;
- (IBAction) redo;
- (IBAction) clearCanvas;
- (IBAction) savePic;

- (void) viewJustLoaded;
- (void) saveToPhoto;
- (void) setColor:(UIColor*)theColor;
- (void) pickedColor:(UIColor*)color;

- (IBAction)CloseTouchPainterView;


@end
