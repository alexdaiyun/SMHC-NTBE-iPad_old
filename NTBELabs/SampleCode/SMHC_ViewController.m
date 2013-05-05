//
//  SMHC_ViewController.m
//  NTBELabs
//
//  Created by dai yun on 13-4-3.
//  Copyright (c) 2013年 alexday. All rights reserved.
//

#import "SMHC_ViewController.h"
#import "MMMarkdown.h"

@interface SMHC_ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView_RichText;
 
@property (weak, nonatomic) IBOutlet UIWebView *webView_RichText;

@end

@implementation SMHC_ViewController



#pragma mark - sample

- (void)t1
{
    NSMutableArray *_dataArray = [[NSMutableArray alloc]init];
    SLLog(@"----");
    SubjectsBLL *_SubjectsBLL = [[SubjectsBLL alloc]init];
    _dataArray = [_SubjectsBLL getAllSubjects];
    
    [_dataArray enumerateObjectsUsingBlock:^(Subjects *subjects, NSUInteger idx, BOOL *stop){
        subjects = _dataArray[idx];
        SLog(@"%lu  %@ %@",(unsigned long)subjects.SubjectID, subjects.CodeID
             ,subjects.Name);

        if (subjects.BasicProfile != nil)
        {
            SLog(@"basicProfile count %d", [subjects.BasicProfile count]);
            SLog(@"HomeAddress: %@ ", [subjects.BasicProfile objectForKey:@"HomeAddress1"]);
        }
    }];
    
}

- (void)t2
{
    SLLog(@"----");
    SubjectsBLL *_SubjectsBLL = [[SubjectsBLL alloc]init];
    [_SubjectsBLL getAllSubjects];
    
    //add subjects
    
    
}

- (void)getDataByID
{
    SubjectsBLL *_SubjectsBLL = [[SubjectsBLL alloc]init];
    
    Subjects *_Subjects = [[Subjects alloc]init];
    
    _Subjects = [_SubjectsBLL getSubjectsByID:2];
    
    SLog(@"---  %lu  %@ %@",(unsigned long)_Subjects.SubjectID, _Subjects.CodeID
         ,_Subjects.Name);
    
}

- (void)insertData
{
    SubjectsBLL *_SubjectsBLL = [[SubjectsBLL alloc]init];
    
    NSMutableDictionary *record = [NSMutableDictionary dictionary];
    
    //NSString *name = [NSString stringWithFormat:@"李",@""];
    
    [record setObject:@"A9011" forKey:@"CodeID"];
    [record setObject:@"唐诗1" forKey:@"Name"];
    [record setObject:@"ts" forKey:@"NameAbbr"];
    [record setObject:@"" forKey:@"SituationType"];
    [record setObject:@"男" forKey:@"Gender"];
    [record setObject:@"1965-10-11" forKey:@"Birthdate"];
    [record setObject:@"40" forKey:@"Age"];
    [record setObject:@"12" forKey:@"EduYears"];
    [record setObject:@"0" forKey:@"EduMonths"];
    
    [_SubjectsBLL addSubjects:record];
    
    
    
}


#pragma mark - test MMMarkdown

- (void)displayMarkdownText
{
    NSError  *error;
    NSString *markdown   = @"# 1 Example 测试 \n第二行测试What a library!\n# 2 Example 测试 \n第二行测试What a library!\n# 3 Example 测试 \n第二行测试What a library!\n# 4 Example 测试 \n第二行测试What a library!\n# 5 Example 测试 \n第二行测试What a library!\n";
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:markdown error:&error];
    // Returns @"<h1>Example</h1>\n<p>What a library!</p>"
    
    _textView_RichText.Text = htmlString;
    [_webView_RichText loadHTMLString:htmlString baseURL:nil];
}

#pragma mark - View lifecyle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    [self t1];
//    [self insertData];
//    [self t1];
//    [self getDataByID];
    
    
    [self displayMarkdownText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTextView_RichText:nil];
    [self setWebView_RichText:nil];
    [super viewDidUnload];
}


#pragma mark - SupportedOrientations

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskLandscape;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation //NS_AVAILABLE_IOS(6_0);
{
    if ( UIDeviceOrientationIsLandscape(orientation))
    {
        
        return YES;
    }
    return NO;
}

@end
