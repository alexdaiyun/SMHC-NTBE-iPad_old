//
//  BrushCanvas.m
//  ADTestLabs
//
//  Created by dai yun on 12-11-3.
//  Copyright (c) 2012年 alexday. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "BrushCanvas.h"
#import "ColorPickerController.h"

@interface BrushCanvas()


@end


@implementation BrushCanvas{
}

@synthesize pickedImage;
@synthesize screenImage;
@synthesize arrayStrokes;
@synthesize arrayAbandonedStrokes;
@synthesize currentColor;
@synthesize currentSize;

@synthesize sliderSize;
@synthesize buttonColor;
@synthesize toolBar;
@synthesize labelSize;

@synthesize btnClosed;


@synthesize colorPC;
@synthesize colorPopoverController;
@synthesize imagePC;
@synthesize imagePopoverController;
@synthesize activityIndicator;
@synthesize permissions;
@synthesize owner;

#pragma mark - Actions

- (IBAction)CloseTouchPainterView
{
    [owner dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) viewJustLoaded {
	NSLog(@"viewJustLoaded");
	
	// color picker and popover
	colorPC = [[ColorPickerController alloc] init];
    colorPC.pickedColorDelegate = self;
	colorPopoverController = [[UIPopoverController alloc] initWithContentViewController:colorPC];
	[colorPopoverController setPopoverContentSize:colorPC.view.frame.size];
	
    /*
	// share view controller and popover
	shareVC = [[ShareViewController alloc] init];
	shareVC.delegate = self;
	sharePopoverController = [[UIPopoverController alloc] initWithContentViewController:shareVC];
	[sharePopoverController setPopoverContentSize:shareVC.view.frame.size];
	*/
    
	// image picker and popover
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
		imagePC = [[UIImagePickerController alloc] init];
		imagePC.delegate = self;
		imagePC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		imagePopoverController = [[UIPopoverController alloc] initWithContentViewController:imagePC];
		//[imagePopoverController setPopoverContentSize:imagePC.view.frame.size];
	}
	
	self.arrayStrokes = [NSMutableArray array];
	self.arrayAbandonedStrokes = [NSMutableArray array];
	self.currentSize = 5.0;
	self.labelSize.text = @"Size: 5";
	[self setColor:[UIColor blackColor]];
	
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	activityIndicator.center = CGPointMake(512, 384);
	
    /*
	facebook = [[Facebook alloc] init];
	_permissions =  [[NSArray arrayWithObjects:
                     @"read_stream", @"offline_access",nil] retain];
	isLoggedIn = NO;
	//shareVC.buttonLog.titleLabel.text = @"Facebook Log In";
	[shareVC.buttonLog setTitle:@"Facebook Log In" forState:UIControlStateNormal];
	[shareVC.buttonLog setTitle:@"Facebook Log In" forState:UIControlStateHighlighted | UIControlStateSelected];
	shareVC.buttonUpload.enabled = NO;
	shareVC.buttonUpload.hidden = YES;
     */
    
}

-(void) saveToPhoto {
	// save to photo album
	UIImageWriteToSavedPhotosAlbum(self.screenImage, nil, nil, nil);
	
	// stop activityIndicator
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	
	// show alert
	UIAlertView* alertSheet = [[UIAlertView alloc] initWithTitle:nil message:@"Image Saved" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertSheet show];
    //[alertSheet release];
}


- (void) setColor:(UIColor *)theColor
{
	self.buttonColor.backgroundColor = theColor;
	self.currentColor = theColor;
}



- (void) pickedColor:(UIColor*)color
{
	NSLog(@"pickedColor");
	[colorPopoverController dismissPopoverAnimated:YES];
	[self setColor:color];
}




- (void) imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
	self.pickedImage = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
	
	[imagePopoverController dismissPopoverAnimated:YES];
	
	[self setNeedsDisplay];
}




#pragma mark - IBAction


- (IBAction) setBrushSize:(UISlider*)sender {
	currentSize = sender.value;
	self.labelSize.text = [NSString stringWithFormat:@"Size: %.0f",sender.value];
}

- (IBAction) didClickColorButton {
	[colorPopoverController presentPopoverFromRect:CGRectMake(435, 700, 30, 30) inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction) didClickChoosePhoto {
	//[imagePopoverController presentPopoverFromRect:CGRectMake(490, 700, 30, 30) inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction) eraser {
	[self setColor:[UIColor whiteColor]];
}



- (IBAction) undo {
	if ([arrayStrokes count]>0) {
		NSMutableDictionary* dictAbandonedStroke = [arrayStrokes lastObject];
		[self.arrayAbandonedStrokes addObject:dictAbandonedStroke];
		[self.arrayStrokes removeLastObject];
		[self setNeedsDisplay];
	}
}

- (IBAction) redo {
	if ([arrayAbandonedStrokes count]>0) {
		NSMutableDictionary* dictReusedStroke = [self.arrayAbandonedStrokes lastObject];
		[self.arrayStrokes addObject:dictReusedStroke];
		[self.arrayAbandonedStrokes removeLastObject];
		[self setNeedsDisplay];
	}
}

- (IBAction) clearCanvas {
	self.pickedImage = nil;
	[self.arrayStrokes removeAllObjects];
	[self.arrayAbandonedStrokes removeAllObjects];
	[self setNeedsDisplay];
}

- (IBAction) savePic {
	// remove toolbar temporarily
	[self.toolBar removeFromSuperview];
	
	UIGraphicsBeginImageContext(self.bounds.size);
    
  
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	self.screenImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	// add toolbar back
	[self addSubview:toolBar];
	[self bringSubviewToFront:self.labelSize];
	
	// add activityIndicator
	[self addSubview:activityIndicator];
	[activityIndicator startAnimating];
	
	[self performSelector:@selector(saveToPhoto) withObject:nil afterDelay:0.0];
}

#pragma mark - Touch Actions

// Start new dictionary for each touch, with points and color
- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
	
	NSMutableArray *arrayPointsInStroke = [NSMutableArray array];
	NSMutableDictionary *dictStroke = [NSMutableDictionary dictionary];
	[dictStroke setObject:arrayPointsInStroke forKey:@"points"];
	[dictStroke setObject:self.currentColor forKey:@"color"];
	[dictStroke setObject:[NSNumber numberWithFloat:self.currentSize] forKey:@"size"];
	
	CGPoint point = [[touches anyObject] locationInView:self];
	[arrayPointsInStroke addObject:NSStringFromCGPoint(point)];
	
	[self.arrayStrokes addObject:dictStroke];
}

// Add each point to points array
- (void) touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event
{
	CGPoint point = [[touches anyObject] locationInView:self];
	CGPoint prevPoint = [[touches anyObject] previousLocationInView:self];
	NSMutableArray *arrayPointsInStroke = [[self.arrayStrokes lastObject] objectForKey:@"points"];
	[arrayPointsInStroke addObject:NSStringFromCGPoint(point)];
	
	CGRect rectToRedraw = CGRectMake(\
									 ((prevPoint.x>point.x)?point.x:prevPoint.x)-currentSize,\
									 ((prevPoint.y>point.y)?point.y:prevPoint.y)-currentSize,\
									 fabs(point.x-prevPoint.x)+2*currentSize,\
									 fabs(point.y-prevPoint.y)+2*currentSize\
									 );
	[self setNeedsDisplayInRect:rectToRedraw];
	//[self setNeedsDisplay];
}

// Send over new trace when the touch ends
- (void) touchesEnded:(NSSet *) touches withEvent:(UIEvent *) event
{
	[self.arrayAbandonedStrokes removeAllObjects];
}


#pragma mark - Custome DrawRect

// Draw all points, foreign and domestic, to the screen
- (void) drawRect: (CGRect) rect
{
	int width = self.pickedImage.size.width;
	int height = self.pickedImage.size.height;
	CGRect rectForImage = CGRectMake(512-width/2, 384-height/2, width, height);
	[self.pickedImage drawInRect:rectForImage];
	
	if (self.arrayStrokes)
	{
		int arraynum = 0;
		// each iteration draw a stroke
		// line segments within a single stroke (path) has the same color and line width
		for (NSDictionary *dictStroke in self.arrayStrokes)
		{
			NSArray *arrayPointsInstroke = [dictStroke objectForKey:@"points"];
			UIColor *color = [dictStroke objectForKey:@"color"];
			float size = [[dictStroke objectForKey:@"size"] floatValue];
			[color set];
            
            // equivalent to both setFill and setStroke
			
            // won't draw a line which is too short
            //			if (arrayPointsInstroke.count < 3)	{
            //				arraynum++;
            //				continue;
            // if continue is executed, the program jumps to the next dictStroke
            //			}
			
			// draw the stroke, line by line, with rounded joints
			UIBezierPath* pathLines = [UIBezierPath bezierPath];
			CGPoint pointStart = CGPointFromString([arrayPointsInstroke objectAtIndex:0]);
			[pathLines moveToPoint:pointStart];
			for (int i = 0; i < (arrayPointsInstroke.count - 1); i++)
			{
				CGPoint pointNext = CGPointFromString([arrayPointsInstroke objectAtIndex:i+1]);
				[pathLines addLineToPoint:pointNext];
			}
			pathLines.lineWidth = size;
			pathLines.lineJoinStyle = kCGLineJoinRound;
			pathLines.lineCapStyle = kCGLineCapRound;
			[pathLines stroke];
			
			arraynum++;
		}
	}
}


#pragma mark - View lifecyle

-(BOOL)isMultipleTouchEnabled {
	return NO;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
