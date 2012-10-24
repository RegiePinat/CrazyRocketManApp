//
//  GameViewController.h
//  CrazyRocketManApp
//
//  Created by Regie G. Pinat on 10/18/12.
//  Copyright (c) 2012 Regie G. Pinat. All rights reserved.
//

#import <UIKit/UIKit.h>
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
    
    UIImageView *gasImage;
    UIImageView *refineImage;
    UIImageView *coilImage;
    UIImageView *batteryImage;
    
    
    
}

@property (nonatomic,strong) NSMutableArray *arrayOfPlatforms;
@property  (nonatomic,strong) NSMutableArray *arrayOfCoins;
@property (nonatomic,strong) NSMutableArray *arrayOfEnemies;

@property (weak, nonatomic) IBOutlet UIButton *rocketOnButton;
@property (weak, nonatomic) IBOutlet UIButton *magnetOnButton;




-(int)getRandomNumber:(int)from to:(int)to;
-(void)jump;
-(BOOL)CheckifJump:(UIImageView *)platform;
-(BOOL)CheckifCoinGet:(UIImageView *)coins;

-(void)startbouncing;


-(IBAction)moveCharbutton:(UIButton *)sender;
-(IBAction)rocketOnMode:(UIButton *)sender;
-(IBAction)magnetOnMode:(UIButton *)sender;


-(void)movePlatforms;
-(void)resetPlatform:(UIImageView*)platform;
-(void)gameTimeMethod;


-(void) getFuel;
-(void) getElectroMagnet;

@end
