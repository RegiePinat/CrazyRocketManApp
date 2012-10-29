//
//  HighScoreViewController.m
//  CrazyRocketManApp
//
//  Created by Edainne Ladys S. Silva on 10/25/12.
//  Copyright (c) 2012 Regie G. Pinat. All rights reserved.
//

#import "HighScoreViewController.h"
#import "MainViewController.h"

@interface HighScoreViewController ()
{
    
}
@property (weak, nonatomic) IBOutlet UIButton *homeButton;

-(IBAction) home;

@end

@implementation HighScoreViewController
@synthesize homeButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     int highscore = [[NSUserDefaults standardUserDefaults] integerForKey: @"highScore"];
 
    NSLog(@"%d",highscore);
    
    UILabel *highScoreLabel= [[UILabel alloc]init];
    highScoreLabel.text = [NSString stringWithFormat:@"HIGHSCORE: %d", highscore];
    [highScoreLabel setFrame:CGRectMake(self.view.center.x-100, self.view.center.y-30, 200, 100)];
    [highScoreLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [highScoreLabel setTextColor:[UIColor blackColor]];
    highScoreLabel.textAlignment = UITextAlignmentCenter;
    [highScoreLabel setBackgroundColor:[UIColor clearColor]];
    [highScoreLabel setAlpha:.5];
    [[self view] addSubview:highScoreLabel];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setHomeButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction) home
{
   MainViewController *mainview = [[MainViewController alloc] init];
    
    mainview.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController: mainview animated:YES];
}

@end
