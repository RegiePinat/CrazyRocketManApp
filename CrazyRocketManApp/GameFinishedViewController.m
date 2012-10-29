//
//  GameFinishedViewController.m
//  CrazyRocketManApp
//
//  Created by Regie G. Pinat on 10/29/12.
//  Copyright (c) 2012 Regie G. Pinat. All rights reserved.
//

#import "GameFinishedViewController.h"

@interface GameFinishedViewController ()

@end

@implementation GameFinishedViewController
@synthesize scoreLabel;
@synthesize finishLabel;

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
    [self setScoreLabel:nil];
    [self setFinishLabel:nil];
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

@end
