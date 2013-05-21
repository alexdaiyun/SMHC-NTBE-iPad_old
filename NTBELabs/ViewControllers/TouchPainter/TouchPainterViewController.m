//
//  TouchPainterViewController.m
//  ADTestLabs
//
//  Created by dai yun on 12-11-3.
//  Copyright (c) 2012年 alexday. All rights reserved.
//

#import "TouchPainterViewController.h"
#import "BrushCanvas.h"

@interface TouchPainterViewController ()


- (void)initBrushCanvas;


@end

@implementation TouchPainterViewController


#pragma mark - Actions

- (void)initBrushCanvas
{
    BrushCanvas *canvasView = (BrushCanvas *)self.view;
    [canvasView viewJustLoaded];
    canvasView.owner = self;
    
}



#pragma mark - View lifecyle

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    

    [self initBrushCanvas];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
