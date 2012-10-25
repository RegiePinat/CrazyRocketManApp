//
//  MainViewController.h
//  CrazyRocketManApp
//
//  Created by Edainne Ladys S. Silva on 10/25/12.
//  Copyright (c) 2012 Regie G. Pinat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
{
    IBOutlet UIButton *startButton;
    IBOutlet UIButton *howToButton;
    IBOutlet UIButton *highscoreButton;
}
@property (retain, nonatomic) IBOutlet UIButton *startButton;
@property (retain, nonatomic) IBOutlet UIButton *howToButton;
@property (retain, nonatomic) IBOutlet UIButton *highscoreButton;


-(IBAction)clickStart:(UIButton *)start;
-(IBAction)clickHowTo:(UIButton *)howTo;
-(IBAction)clickHighScore:(UIButton *)highscore;
@end
