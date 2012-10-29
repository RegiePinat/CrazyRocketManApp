//
//  MainViewController.m
//  CrazyRocketManApp
//
//  Created by Edainne Ladys S. Silva on 10/25/12.
//  Copyright (c) 2012 Regie G. Pinat. All rights reserved.
//

#import "MainViewController.h"
#import "GameViewController.h"
#import "HowToViewController.h"
#import "HighScoreViewController.h"


@interface MainViewController ()
@end

@implementation MainViewController
{
    GameViewController *gamevc;
    HowToViewController *howtovc;
    MainViewController *mainvc;
    HighScoreViewController *hsvc;
}
@synthesize startButton;
@synthesize howToButton;
@synthesize highscoreButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [startButton setTitle:@"START" forState:UIControlStateNormal];
        [startButton.titleLabel setFont:[UIFont fontWithName:@"robom" size:15]];
        [[self view]addSubview:startButton];
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"crazy_kart_intro" withExtension: @"mp3"];
        
        NSError *error;
        audioplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        [audioplayer setNumberOfLoops:-1];
        [audioplayer prepareToPlay];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(callMusic) userInfo:nil repeats:NO];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setStartButton:nil];
    [self setHowToButton:nil];
    [self setHighscoreButton:nil];
    [timer invalidate];
    timer = nil;
    
    [[self view] removeFromSuperview];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(IBAction)clickStart:(UIButton *)start
{
    

    gamevc = [[GameViewController alloc]init];
    [self.view addSubview:gamevc.view];
    
    [mainvc.view removeFromSuperview];
    [howtovc.view removeFromSuperview];
    [hsvc.view removeFromSuperview];
    [self stopMusic];
}
-(IBAction)clickHowTo:(UIButton *)howTo
{
    
    howtovc = [[HowToViewController alloc]init];
    [self.view addSubview:howtovc.view];
    
    [mainvc.view removeFromSuperview];
    [gamevc.view removeFromSuperview];
    [hsvc.view removeFromSuperview];
    [self stopMusic];
}
-(IBAction)clickHighScore:(UIButton *)highscore
{
    hsvc = [[HighScoreViewController alloc]init];
    [self.view addSubview:hsvc.view];
    
    [mainvc.view removeFromSuperview];
    [gamevc.view removeFromSuperview];
    [howtovc.view removeFromSuperview];
        [self stopMusic];
}

-(void)callMusic
{
    [audioplayer play];

}

-(void)stopMusic
{
    
    [audioplayer stop];
    audioplayer = nil;
}

@end
