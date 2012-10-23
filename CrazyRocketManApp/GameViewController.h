//
//  GameViewController.h
//  CrazyRocketManApp
//
//  Created by Regie G. Pinat on 10/18/12.
//  Copyright (c) 2012 Regie G. Pinat. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kNumOfPlatforms 9

@interface GameViewController : UIViewController <UIAccelerometerDelegate>
{
  
    NSTimer *GameTimer;
    NSTimer *timerRocket;
    NSTimer *timerBounce;
    NSTimer *timerdelay;
    NSTimer *timerMovePlatform;
    UIImageView *rocketMan;
    UIAccelerometer *accelerometer;
}

@property (nonatomic,strong) NSMutableArray *arrayOfPlatforms;
@property  (nonatomic,strong) NSMutableArray *arrayOfCoins;

-(int)getRandomNumber:(int)from to:(int)to;
-(void)jump;
-(BOOL)CheckifJump:(UIImageView *)platform;
-(BOOL)CheckifCoinGet:(UIImageView *)coins;

-(void)startbouncing;
-(IBAction)moveCharbutton:(UIButton *)sender;
-(IBAction)rocketOnMode:(UIButton *)sender;
-(void)movePlatforms;
-(void)resetPlatform:(UIImageView*)platform;

@end
