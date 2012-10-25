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
    UIViewController *howTo1;
    UIViewController *howTo2;
    UIViewController *howTo3;
    
    MainViewController *mainview;

}
-(void) click1To2;
-(void) click2To3;

-(void) home;
@end

@implementation HowToViewController
    //iphone resolution 320x480
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        

    }
    return self;
}

-(void) click1To2
{

    howTo2 = [[UIViewController alloc] initWithNibName:(NSString *)nil bundle:(NSBundle *)nil];
    [self.view addSubview:howTo2.view];
    [howTo1.view removeFromSuperview];
    [howTo3.view removeFromSuperview];

    
    UIButton *buttonHowTo2 = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonHowTo2.frame = CGRectMake(230, 380, 80, 50);
    buttonHowTo2.backgroundColor = [UIColor clearColor];
    [buttonHowTo2 setBackgroundImage:[UIImage imageNamed:@"goarrow.png"] forState:UIControlStateNormal];
    [buttonHowTo2 addTarget:self action:@selector(click2To3) forControlEvents:UIControlEventTouchUpInside];
    [howTo2.view addSubview:buttonHowTo2];
    
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBack.frame = CGRectMake(10, 380, 80, 50);
    buttonBack.backgroundColor = [UIColor clearColor];
    [buttonBack setBackgroundImage:[UIImage imageNamed:@"backarrow.png"] forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(viewDidLoad) forControlEvents:UIControlEventTouchUpInside];
    [howTo2.view addSubview:buttonBack];
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    homeButton.frame = CGRectMake(280, 0, 30, 30);
    homeButton.backgroundColor = [UIColor clearColor];
    [homeButton setBackgroundImage:[UIImage imageNamed:@"homebutton.png"] forState:UIControlStateNormal];
    [homeButton addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    [howTo2.view addSubview:homeButton];
       
}
-(void) click2To3
{
    howTo3 = [[UIViewController alloc] initWithNibName:(NSString *)nil bundle:(NSBundle *)nil];
    [self.view addSubview:howTo3.view];
    [howTo2.view removeFromSuperview];
    [howTo1.view removeFromSuperview];
    
//    UIButton *buttonHowTo3 = [UIButton buttonWithType:UIButtonTypeCustom];
//    buttonHowTo3.frame = CGRectMake(230, 380, 80, 50);
//    buttonHowTo3.backgroundColor = [UIColor clearColor];
//    [buttonHowTo3 setBackgroundImage:[UIImage imageNamed:@"goarrow.png"] forState:UIControlStateNormal];
//    [buttonHowTo3 addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
//    [howTo3.view addSubview:buttonHowTo3];
    
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBack.frame = CGRectMake(10, 380, 80, 50);
    buttonBack.backgroundColor = [UIColor clearColor];
    [buttonBack setBackgroundImage:[UIImage imageNamed:@"backarrow.png"] forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(click1To2) forControlEvents:UIControlEventTouchUpInside];
    [howTo3.view addSubview:buttonBack];
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    homeButton.frame = CGRectMake(280, 0, 30, 30);
    homeButton.backgroundColor = [UIColor clearColor];
    [homeButton setBackgroundImage:[UIImage imageNamed:@"homebutton.png"] forState:UIControlStateNormal];
    [homeButton addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    [howTo3.view addSubview:homeButton];
    

    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    howTo1 = [[UIViewController alloc] initWithNibName:(NSString *)nil bundle:(NSBundle *)nil];
    [self.view addSubview:howTo1.view];
    [howTo2.view removeFromSuperview];
    [howTo3.view removeFromSuperview];
    
    
    
    UIButton *buttonHowTo1 = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonHowTo1.frame = CGRectMake(230, 380, 80, 50);
    buttonHowTo1.backgroundColor = [UIColor clearColor];
    [buttonHowTo1 setBackgroundImage:[UIImage imageNamed:@"goarrow.png"] forState:UIControlStateNormal];
    [buttonHowTo1 addTarget:self action:@selector(click1To2) forControlEvents:UIControlEventTouchUpInside];
    [howTo1.view addSubview:buttonHowTo1];
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    homeButton.frame = CGRectMake(280, 0, 30, 30);
    homeButton.backgroundColor = [UIColor clearColor];
    [homeButton setBackgroundImage:[UIImage imageNamed:@"homebutton.png"] forState:UIControlStateNormal];
    [homeButton addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    [howTo1.view addSubview:homeButton];
    // Do any additional setup after loading the view from its nib.
}

-(void) home
{
    mainview = [[MainViewController alloc] init];
    
    mainview.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController: mainview animated:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
