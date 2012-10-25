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

#define kNumOfPlatforms 8

@interface GameViewController : UIViewController <UIAccelerometerDelegate>
{
  
    NSTimer *gameTimer;
    NSTimer *timerRocket;
    NSTimer *timerBounce;
    NSTimer *timerdelay;
    NSTimer *timerMovePlatform;
    UIImageView *rocketMan;
    UIAccelerometer *accelerometer;
    int timeCounter;
    
    
    
    

    
    UILabel *numberOfGas;
    UILabel *numberOfRef;
    UILabel *numberOfCoil;
    UILabel *numberOfbattery;
    UILabel *labelScore;
    
    
    UIImageView *gasImage;
    UIImageView *refineImage;
    UIImageView *coilImage;
    UIImageView *batteryImage;
    UIView *viewPanelFormItems;
    
    
    
    UIButton *rocketOnButton;
    UIButton *magnetOnButton;
    
    UIImageView *rocketOnButtonBG;
    UIImageView *magnetOnButtonBG;
    
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


-(void)startbouncing;


-(IBAction)moveCharbutton:(UIButton *)sender;





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

@end
