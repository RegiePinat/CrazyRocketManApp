//
//  GameOverViewController.m
//  CrazyRocketManApp
//
//  Created by Regie G. Pinat on 10/25/12.
//  Copyright (c) 2012 Regie G. Pinat. All rights reserved.
//

#import "GameOverViewController.h"
#import "MainViewController.h"

@interface GameOverViewController ()
{
    UIViewController *mainview;
}
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
-(IBAction)home;

@end

@implementation GameOverViewController
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



-(void)finishedScore:(float)passedscore
{
    score = passedscore;
    
    
    float highscore = [[NSUserDefaults standardUserDefaults] integerForKey: @"highScore"];


    
    UILabel *highScoreLabel1= [[UILabel alloc]init];
    highScoreLabel1.text = [NSString stringWithFormat:@"SCORE: %.0f", score];
    [highScoreLabel1 setFrame:CGRectMake(self.view.center.x-100, self.view.center.y-30, 200, 100)];
    [highScoreLabel1 setFont:[UIFont boldSystemFontOfSize:20]];
    [highScoreLabel1 setTextColor:[UIColor blackColor]];
    highScoreLabel1.textAlignment = UITextAlignmentCenter;
    [highScoreLabel1 setBackgroundColor:[UIColor clearColor]];
    [highScoreLabel1 setAlpha:.5];
    [[self view] addSubview:highScoreLabel1];
    
      
    if (highscore< score)
    {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:score forKey:@"highScore"];
    [defaults synchronize];

    }
    highscore = [[NSUserDefaults standardUserDefaults] integerForKey: @"highScore"];
    NSLog(@"%.0f",score);
    NSLog(@"%.0f",highscore);
}
-(IBAction) home
{
    mainview = [[MainViewController alloc] init];
    
    mainview.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController: mainview animated:YES];
}
@end
