//
//  GameViewController.h
//  CrazyRocketManApp
//
//  Created by Regie G. Pinat on 10/18/12.
//  Copyright (c) 2012 Regie G. Pinat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coins.h"
#import "GameOverViewController.h"
#import "GameFinishedViewController.h"
#import <AVFoundation/AVFoundation.h>


#define kNumOfPlatforms 8

@interface GameViewController : UIViewController <UIAccelerometerDelegate>
{
  
    NSTimer *gameTimer;
    NSTimer *timerRocket;
    NSTimer *timerBounce;
    NSTimer *timerdelay;
    NSTimer *timerMovePlatform;
    
    
    UIImageView *rocketMan;
    UIImageView *electroShield;
    UIImageView *magnetized;
    
    UIAccelerometer *accelerometer;
    int timeCounter;
    
    float score;
    
    

    
    UILabel *numberOfGas;
    UILabel *numberOfRef;
    UILabel *numberOfCoil;
    UILabel *numberOfbattery;
    UILabel *numberOftesla;
    
    UILabel *labelScore;
    
    
    UIImageView *gasImage;
    UIImageView *refineImage;
    UIImageView *coilImage;
    UIImageView *batteryImage;
    UIImageView *teslaImage;
    
    
    
    UIView *viewPanelFormItems;
    
    
    
    UIButton *pauseButton;
    
    UIButton *rocketOnButton;
    UIButton *magnetOnButton;
    UIButton *shieldOnButton;
    
    UIImageView *rocketOnButtonBG;
    UIImageView *magnetOnButtonBG;
    UIImageView *shieldOnButtonBG;
    
    AVAudioPlayer *audioplayer;
    AVAudioPlayer *audioplayer2;
    AVAudioPlayer *audioplayer3;
    
    
}

@property (nonatomic,strong) NSMutableArray *arrayOfPlatforms;
@property  (nonatomic,strong) NSMutableArray *arrayOfCoins;
@property (nonatomic,strong) NSMutableArray *arrayOfEnemies;

@property (nonatomic,strong) NSMutableArray *arrayOfOil;
@property (nonatomic,strong) NSMutableArray *arrayOfRefinery;
@property (nonatomic,strong) NSMutableArray *arrayOfCoil;
@property (nonatomic,strong) NSMutableArray *arrayOfBattery;
@property (nonatomic,strong) NSMutableArray *arrayOfTesla;









-(void)labelsCreate;
-(int)getRandomNumber:(int)from to:(int)to;
-(void)jump;
-(BOOL)CheckifJump:(UIImageView *)platform;
-(BOOL)CheckifCoinGet:(UIImageView *)coins;
-(BOOL)CheckifOilGet:(UIImageView *)oil;
-(BOOL)CheckifRefineryGet:(UIImageView *)ref;
-(BOOL)CheckifCoilGet:(UIImageView *)coil;
-(BOOL)CheckifBatteryGet:(UIImageView *)bat;
-(BOOL)CheckifEnemyHit:(UIImageView *)enemy;
-(BOOL)CheckifEnemyHitShield:(UIImageView *)enemy;

-(void)startbouncing;








-(void)rocketOnMode;
-(void)magnetOnMode;
-(void)shieldOnMode;

-(void)movePlatforms;
-(void)resetPlatform:(UIImageView*)platform;


-(void)gameTimeMethod;


-(void)excuteMoveAndRemoveFromArray:(NSMutableArray *)array;

-(void) createOil;
-(void) createRefinery;
-(void) createCoil;
-(void) createBattery;


-(void)checkRocketDuration;
-(void)checkMagnetDuration;
-(void)checkShieldDuration;

-(void) getFuel;
-(void) getElectroMagnet;


-(void)movetoGameOverScene;
-(void)movetoGameFinishScene;

-(void)pauseGame;
@end
