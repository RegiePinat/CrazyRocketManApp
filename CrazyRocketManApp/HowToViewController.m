//
//  HowToViewController.m
//  CrazyRocketManApp
//
//  Created by Edainne Ladys S. Silva on 10/24/12.
//  Copyright (c) 2012 Regie G. Pinat. All rights reserved.
//

#import "HowToViewController.h"
#import "MainViewController.h"
@interface HowToViewController ()
{
//    UIViewController *howTo1;
//    UIViewController *howTo2;
//    UIViewController *howTo3;
    
    MainViewController *mainview;
    
    int index;

}
@property (strong, nonatomic) IBOutlet UIButton *homeButton;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *goButton;
@property (strong, nonatomic) NSArray *arrayOfHowTo;

-(IBAction) clickGo;
-(IBAction) clickBack;
-(IBAction) home;

@end

@implementation HowToViewController
@synthesize viewImage;
@synthesize homeButton, backButton, goButton, arrayOfHowTo;
    //iphone resolution 320x480
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    
        
        arrayOfHowTo = [NSArray arrayWithObjects:@"howTo1.png", @"howTo2.png", @"howTo3.png", @"howTo4.png", @"howTo5.png", nil];

        index = 0;
      
      
        

    }
    return self;
}

-(IBAction) clickGo
{
    index++;
    
    NSString *str = [arrayOfHowTo objectAtIndex:index];
    
    [viewImage setImage:[UIImage imageNamed:str]];
    
    if (index == 4) {
        [goButton setAlpha:0];
    }
    [backButton setAlpha:1];
}
-(IBAction) clickBack
{
    index--;
    [viewImage setImage:[UIImage imageNamed:[arrayOfHowTo objectAtIndex:index]]];
    
    if (index == 0) {
        [backButton setAlpha:0];
    }
    
    if (index <=3) {
        [goButton setAlpha:1];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
      [backButton setAlpha:0];
//    howTo1 = [[UIViewController alloc] initWithNibName:(NSString *)nil bundle:(NSBundle *)nil];
//    [self.view addSubview:howTo1.view];
//    [howTo2.view removeFromSuperview];
//    [howTo3.view removeFromSuperview];
//    
//    
//    
//    UIButton *buttonHowTo1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    buttonHowTo1.frame = CGRectMake(230, 380, 80, 50);
//    buttonHowTo1.backgroundColor = [UIColor clearColor];
//    [buttonHowTo1 setBackgroundImage:[UIImage imageNamed:@"goarrow.png"] forState:UIControlStateNormal];
//    [buttonHowTo1 addTarget:self action:@selector(click1To2) forControlEvents:UIControlEventTouchUpInside];
//    [howTo1.view addSubview:buttonHowTo1];
    
//    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    homeButton.frame = CGRectMake(280, 0, 30, 30);
//    homeButton.backgroundColor = [UIColor clearColor];
//    [homeButton setBackgroundImage:[UIImage imageNamed:@"homebutton.png"] forState:UIControlStateNormal];
//    [homeButton addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
//    [howTo1.view addSubview:homeButton];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction) home
{
    mainview = [[MainViewController alloc] init];
    
    mainview.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController: mainview animated:YES];
}
- (void)viewDidUnload
{
    [self setViewImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
