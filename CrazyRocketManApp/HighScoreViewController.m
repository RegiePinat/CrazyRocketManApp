//
//  HighScoreViewController.m
//  CrazyRocketManApp
//
//  Created by Edainne Ladys S. Silva on 10/25/12.
//  Copyright (c) 2012 Regie G. Pinat. All rights reserved.
//

#import "HighScoreViewController.h"

@interface HighScoreViewController ()

@end

@implementation HighScoreViewController

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
    highScoreLabel.text = [NSString stringWithFormat:@"%d", highscore];
    [highScoreLabel setFrame:CGRectMake(90, 35, 100, 100)];
    [highScoreLabel setFont:[UIFont boldSystemFontOfSize:10]];
    [highScoreLabel setTextColor:[UIColor whiteColor]];
    highScoreLabel.textAlignment = UITextAlignmentCenter;
    [highScoreLabel setBackgroundColor:[UIColor blackColor]];
    [highScoreLabel setAlpha:.5];
    [[self view] addSubview:highScoreLabel];
    
    // Do any additional setup after loading the view from its nib.
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
