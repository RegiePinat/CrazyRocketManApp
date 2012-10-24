//
//  GameViewController.m
//  CrazyRocketManApp
//
//  Created by Regie G. Pinat on 10/18/12.
//  Copyright (c) 2012 Regie G. Pinat. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController
@synthesize arrayOfPlatforms;
@synthesize arrayOfCoins;
@synthesize arrayOfEnemies;

@synthesize arrayOfOil;
@synthesize arrayOfRefinery;
@synthesize arrayOfCoil;
@synthesize arrayOfBattery;


@synthesize rocketOnButton;
@synthesize magnetOnButton;







//G vars
float xpos =0;
float ypos;

float maxDistanceBetweenStep ;
float minDistanceBetweenStep ;
float distanceBetweenSteps=200,distanceyBetweenSteps = 50;
float accelmoveX=0,deltaX=0;
float score=0;

int coinsCounts;
int platformsFinished;

int rocketDuration = 10;


int gasNum;
int refNum;
int coilNum;
int batteryNum;

BOOL delayTime = YES;
BOOL NeedsTojump = NO;
BOOL mainJumping = NO;
BOOL gameSuspended = NO;

BOOL rocketOn =NO;
//how quickly should the jump start off
float jumpSpeedLimit = 15;
//the current speed of the jump;
float jumpSpeed;
//platform speed;
float platformSpeedmove;
//Enemy Respawn time
float enemyRespawnTime;
//Oil RespawnRate
float oilRespawnTime;
//refinery RespawnRate
float refineryRespawnTime;

CGPoint rocketManNewPosition;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
     
        
        
        timeCounter = 0;
        
        
        
         //Accelerometer
        accelerometer = [UIAccelerometer sharedAccelerometer];
        accelerometer.delegate = self;
        [accelerometer setUpdateInterval:.07];
        
         //Platforms
          arrayOfPlatforms= [NSMutableArray array];
          CGSize stepRect = CGSizeMake(100, 35);
           ypos= (self.view.bounds.size.height)-stepRect.height;  
          
        for (int i=0; i<kNumOfPlatforms ; i++)
        {
       
           if ([arrayOfPlatforms count]>0)
           {
               
             //Previous Object add to be reference
               UIImageView *before= [arrayOfPlatforms objectAtIndex:i-1];
               
               
               maxDistanceBetweenStep = before.center.x + distanceBetweenSteps;
               minDistanceBetweenStep = before.center.x - distanceBetweenSteps;
               
               if (maxDistanceBetweenStep > [self view].frame.size.width - (stepRect.width)-10)
               {
                   xpos = [self getRandomNumber:minDistanceBetweenStep to:([self view].frame.size.width - (stepRect.width/2)-10) ];
               }
               
               else if(minDistanceBetweenStep <= 10)
               {
                   xpos = [self getRandomNumber:0+stepRect.width to:maxDistanceBetweenStep];
               }
               
               else
               {
                   xpos = [self getRandomNumber:minDistanceBetweenStep to:maxDistanceBetweenStep ];
                   
               }
               
               //Out of bounds xpos
               if (xpos < 0 + stepRect.width/2 )
               {
                   
                   if (xpos <= 0)
                   {
                       xpos = (xpos * -1)+stepRect.width/2 ;
                   }
                   else
                       
                   {
                       xpos = 0 + stepRect.width/2 ;
                   }
                   
                   
                   
               }
               
               if (xpos >320 - stepRect.width/2 )
               {
                   if (xpos > 320)
                   {
                       xpos = (xpos - 200) - stepRect.width/2;
                   }
                   else
                   {
                       xpos =320 - stepRect.width/2;
                   }
               }
           }
           
           else
           {
               
             xpos = self.view.frame.size.width/2 - stepRect.width/2;
               
           }
           
           
           //Add image object to Array of platforms
           [arrayOfPlatforms addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"platform.png"]]];
           //platform Object rect
           [[arrayOfPlatforms objectAtIndex:i] setFrame:CGRectMake(xpos, ypos, stepRect.width, stepRect.height)];
       
                    
           
           
           ypos = ypos - distanceyBetweenSteps;
       }
        
       //Add images to View
        for ( UIImageView *steps in  arrayOfPlatforms)
        {
            
            
            [[self view] addSubview: steps];
            
        }
        
        
        
        
        
        
        
    
        
        //coins
        arrayOfCoins = [NSMutableArray array];
        
        
        //enemy
        arrayOfEnemies = [NSMutableArray array];
        
        //oil
        arrayOfOil =  [NSMutableArray array];
        
        //refinery
        arrayOfRefinery =  [NSMutableArray array];
        
        //coil
        arrayOfCoil =  [NSMutableArray array];
        
        //battery
        arrayOfBattery =  [NSMutableArray array];
        
        
        
        
        
        
        
        
        
        
        
        
        //ADD Character
        UIImageView *first = [arrayOfPlatforms objectAtIndex:0];
        rocketMan = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BH2.png"]];
        
        
        rocketMan.center = CGPointMake(first.center.x, first.frame.origin.y -rocketMan.bounds.size.height/2-5);
       rocketManNewPosition.x = rocketMan.center.x;
       rocketManNewPosition.y = rocketMan.center.y;
        [[self view] addSubview:rocketMan ];
        
        
        //Jump Speed
        jumpSpeed = jumpSpeedLimit;
        
        
        
        
        
        
        
        
        
        [self labelsCreate];

        
        
        //INITIALIZE button Alpha zero
        [rocketOnButton setAlpha:0];
        [magnetOnButton setAlpha:0];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
   timerdelay = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(startbouncing) userInfo:nil repeats:YES];
 
    // Do any additional setup after loading the view from its nib.
}


- (void)viewDidUnload
{
    accelerometer.delegate = nil;
    
    
    [timerdelay invalidate];
    timerdelay = nil;
    
    [timerBounce invalidate];    
    timerBounce =nil;
    
    [timerMovePlatform invalidate];
    timerMovePlatform = nil;
    
   
    
    [timerRocket invalidate];
    timerRocket = nil;
   
    [gameTimer invalidate];
    gameTimer =nil;
    
    [self setArrayOfPlatforms:nil];
    [self setArrayOfCoins:nil];
    [self setRocketOnButton:nil];
    [self setMagnetOnButton:nil];
    
    
    [self setArrayOfOil:nil];
    [self setArrayOfRefinery:nil];
    [self setArrayOfCoil:nil];
    [self setArrayOfBattery:nil];
    
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




-(void )dealloc
{
    
    accelerometer.delegate = nil;
    [timerdelay invalidate];
    timerdelay = nil;
    
    [timerBounce invalidate];
    timerBounce =nil;
    
    [timerMovePlatform invalidate];
    timerMovePlatform = nil;
    
    [timerRocket invalidate];
    timerRocket = nil;
    
    [gameTimer invalidate];
    gameTimer =nil;
    
    
    [self setRocketOnButton:nil];
    [self setMagnetOnButton:nil];
    
    [self setArrayOfPlatforms:nil];
    [self setArrayOfCoins:nil];
    
    
    [self setArrayOfOil:nil];
    [self setArrayOfRefinery:nil];
    [self setArrayOfCoil:nil];
    [self setArrayOfBattery:nil];
}









- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




-(void)labelsCreate
{

    //initialization
    gasNum = 0;
    refNum = 0;
    coilNum = 0;
    batteryNum = 0;
    
    //gas image
    gasImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"crudeoil.png"]];
    [gasImage setFrame:CGRectMake(10, 10, 30, 35)];
    [gasImage setAlpha:.5];
    [[self view] addSubview:gasImage];
    
    //Gas number label
    numberOfGas = [[UILabel alloc]init];
    numberOfGas.text = [NSString stringWithFormat:@"%i", gasNum];
    [numberOfGas setFrame:CGRectMake(30, 35, 10, 10)];
    [numberOfGas setFont: [UIFont boldSystemFontOfSize:10]];
    [numberOfGas setTextColor:[UIColor whiteColor]];
    numberOfGas.textAlignment = UITextAlignmentCenter;
    [numberOfGas setBackgroundColor:[UIColor blackColor]];
    [numberOfGas setAlpha:.5];
    [[self view] addSubview:numberOfGas];
    
    //refinery image
    refineImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"refinery.jpg"]];
    [refineImage setFrame:CGRectMake(60, 10, 40, 35)];
    [refineImage setAlpha:.5];
    [[self view] addSubview:refineImage];
    
    //Refinery number label
    numberOfRef = [[UILabel alloc]init];
    numberOfRef.text = [NSString stringWithFormat:@"%i", refNum];
    [numberOfRef setFrame:CGRectMake(90, 35, 10, 10)];
    [numberOfRef setFont:[UIFont boldSystemFontOfSize:10]];
    [numberOfRef setTextColor:[UIColor whiteColor]];
    numberOfRef.textAlignment = UITextAlignmentCenter;
    [numberOfRef setBackgroundColor:[UIColor blackColor]];
    [numberOfRef setAlpha:.5];
    [[self view] addSubview:numberOfRef];
    
    coilImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coil.png"]];
    [coilImage setFrame:CGRectMake(120, 10, 30, 35)];
    [coilImage setAlpha:0.5];
    [[self view] addSubview:coilImage];
    
    numberOfCoil = [[UILabel alloc]init];
    numberOfCoil.text = [NSString stringWithFormat:@"%i", coilNum];
    [numberOfCoil setFrame:CGRectMake(140, 35, 10, 10)];
    [numberOfCoil setFont:[UIFont boldSystemFontOfSize:10]];
    [numberOfCoil setTextColor:[UIColor whiteColor]];
    numberOfCoil.textAlignment = UITextAlignmentCenter;
    [numberOfCoil setBackgroundColor:[UIColor blackColor]];
    [numberOfCoil setAlpha:.5];
    [[self view] addSubview:numberOfCoil];
    
    batteryImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"battery.png"]];
    [batteryImage setFrame:CGRectMake(170, 10, 30, 35)];
    [batteryImage setAlpha:0.5];
    [[self view] addSubview:batteryImage];
    
    numberOfbattery = [[UILabel alloc]init];
    numberOfbattery.text = [NSString stringWithFormat:@"%i", batteryNum];
    [numberOfbattery setFrame:CGRectMake(190, 35, 10, 10)];
    [numberOfbattery setFont:[UIFont boldSystemFontOfSize:10]];
    [numberOfbattery setTextColor:[UIColor whiteColor]];
    numberOfbattery.textAlignment = UITextAlignmentCenter;
    [numberOfbattery setBackgroundColor:[UIColor blackColor]];
    [numberOfbattery setAlpha:.5];
    [[self view] addSubview:numberOfbattery];
    
    
}




-(int)getRandomNumber:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}



-(void)jump
{
    
     //rocketManNewPosition.x += 2;


    [self getFuel];
    [self getElectroMagnet];
    
    
    
    
    if (rocketManNewPosition.x + deltaX*40 >= 0 + rocketMan.frame.size.width/2 && rocketManNewPosition.x + deltaX*40 <= 320 -rocketMan.frame.size.width/2  )
    {
          rocketManNewPosition.x += deltaX*40;
    }
       else
    {
         //restrict movement with bounds
           if (rocketManNewPosition.x + deltaX*40 < 0 + rocketMan.frame.size.width/2)
           {
               rocketManNewPosition.x = 0 +rocketMan.frame.size.width/2;
           }
           else if (rocketManNewPosition.x + deltaX*40 > 320 - rocketMan.frame.size.width/2)
           {
               rocketManNewPosition.x = 320 - rocketMan.frame.size.width/2;
           }
       
    }

    
    
    
    
    
    //HITS coin
    for (UIImageView *coins in arrayOfCoins)
    {
        
        //Remove if hit and add score
        if ([self CheckifCoinGet:coins])
        {
            
            NSLog(@"Coin Get");
            
         
            [arrayOfCoins removeObject:coins];
            NSLog(@"%d",[arrayOfCoins count]);

            [coins removeFromSuperview];
            
            score = score +10;
            NSLog(@"Score:%.0f",score);
            break;
        }
    }
    
    

    
    
    
    
    
   //jumping && Rocket on
    
    if (rocketOn)
    {
        
    }
    
    
    
    
    //jump
    else
    {
        
        
        
     
        if(!mainJumping)
        {
		//then start jumping
		mainJumping = YES;
		jumpSpeed = jumpSpeedLimit*-1;
		rocketManNewPosition.y += jumpSpeed;
        }
    
    
        else
        {
            
        //if  paakyat n
        if(jumpSpeed < 0)
        {
        //Speed up gradually
        jumpSpeed *= 1 - jumpSpeedLimit/75;
          
        //Determine if pababa n
        
             if(jumpSpeed > -jumpSpeedLimit/5 || rocketMan.center.y  <= 0 + rocketMan.frame.size.height/2)
            {
        jumpSpeed *= -1;
            }
		}
        
        //speed up gradually but much faster 
		if(jumpSpeed > 0 && jumpSpeed <= jumpSpeedLimit)
        {
			jumpSpeed *= 1 + jumpSpeedLimit/50;
		}
      

      
        rocketManNewPosition.y += jumpSpeed;
        rocketMan.center = CGPointMake(rocketManNewPosition.x, rocketManNewPosition.y);
        
          
       
 
            
        
	  //if main hits the platform, then stop jumping
     //Check Each Platform if hit
        
     
            if(jumpSpeed >0)
            {
        
               //Jump Again If Collided and moving Down
                for (UIImageView *checkplatform in arrayOfPlatforms)
                {
        
                    //speed up when
                    if (rocketMan.center.y < self.view.bounds.size.height/2 - 70)
                    {
                        platformSpeedmove =4;
             rocketMan.center = CGPointMake(rocketMan.center.x, rocketMan.center.y + 1);
                    
                    }
                    
                    else
                    {
                        platformSpeedmove =1;
                    }
                    
                    
                 if(rocketManNewPosition.y >=  checkplatform.frame.origin.y - rocketMan.frame.size.height/2 +10  && [self CheckifJump:checkplatform]  &&  jumpSpeed  >0  )
                      {
                          
                          if (platformSpeedmove !=4) {
                              mainJumping = NO;
                              rocketManNewPosition.y = checkplatform.frame.origin.y - rocketMan.frame.size.height/2 +10;
                              rocketMan.center = CGPointMake(rocketManNewPosition.x, rocketManNewPosition.y);
                          }
            
                  
              
   
        
                
                break;
             
            }
                 }
    
            }
        
            
            
        //Check if on Ground
            if (rocketMan.frame.origin.y   > self.view.frame.size.height)
            {
                NSLog(@"aw");
            

              
            
                
                accelerometer.delegate = nil;
                [timerdelay invalidate];
                timerdelay = nil;
                
                [timerBounce invalidate];
                timerBounce =nil;
                
                [timerMovePlatform invalidate];
                timerMovePlatform = nil;
                
                [timerRocket invalidate];
                timerRocket = nil;
                
                [timerdelay invalidate];
                timerdelay = nil;
                
                [gameTimer invalidate];
                gameTimer = nil;
                
                
                
            }
    
    }
    }
    
    
    
    
    
    
    //move rocketman
     rocketMan.center = CGPointMake(rocketManNewPosition.x, rocketManNewPosition.y);
}





-(void)movePlatforms
{
    
   
    

//ENEMY
    for (UIImageView   *enemy in arrayOfEnemies)
    {
        enemy.center = CGPointMake(enemy.center.x, enemy.center.y + platformSpeedmove);
    }
    
    
    //if off screen remove
    for (UIImageView  *enemy in arrayOfEnemies)
    {
        if (enemy.frame.origin.y > self.view.bounds.size.height)
        {
            
            [arrayOfEnemies removeObject:enemy];
            [enemy removeFromSuperview];
            break;
            
        }
        
        
    }
    
    
//COINS
    
    for (UIImageView   *coins in arrayOfCoins)
    {
        coins.center = CGPointMake(coins.center.x, coins.center.y + platformSpeedmove);
        
        
    }
    
    //if off screen remove
    for (UIImageView  *coins in arrayOfCoins)
    {
        if (coins.frame.origin.y > self.view.bounds.size.height)
        {
            
            [arrayOfCoins removeObject:coins];
            [coins removeFromSuperview];
            break;
            
        }
        
        
    }
    
    
    
    
    
    //OIL
    
    for (UIImageView   *oil in arrayOfOil)
    {
        oil.center = CGPointMake(oil.center.x, oil.center.y + platformSpeedmove);
        
        
    }
    
    //if off screen remove
    for (UIImageView  *oil in arrayOfOil)
    {
        if (oil.frame.origin.y > self.view.bounds.size.height)
        {
            
            [arrayOfOil removeObject:oil];
            [oil removeFromSuperview];
            break;
            
        }
        
        
    }
    
    
    
    
    //REFINERY
    
    for (UIImageView   *ref in arrayOfRefinery)
    {
        ref.center = CGPointMake(ref.center.x, ref.center.y + platformSpeedmove);
        
        
    }
    
    //if off screen remove
    for (UIImageView  *ref in arrayOfRefinery)
    {
        if (ref.frame.origin.y > self.view.bounds.size.height)
        {
            
            [arrayOfOil removeObject:ref];
            [ref removeFromSuperview];
            break;
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    //move platform and reuse if off screen
    for (UIImageView *steps in arrayOfPlatforms)
    {
        steps.center = CGPointMake(steps.center.x, steps.center.y + platformSpeedmove);
    
        
        
        if (steps.frame.origin.y > self.view.bounds.size.height)
        {
            platformsFinished++;
           
            [self resetPlatform:steps];
            
        }
        
        
    }

    
    
}




-(BOOL)CheckifJump:(UIImageView *)platform
{
   
 
    if (rocketMan.center.x >= platform.frame.origin.x && rocketMan.center.x <= (platform.frame.origin.x + platform.bounds.size.width) && CGRectIntersectsRect(platform.frame,rocketMan.frame))
    {
        
        return YES;
      
    }
    

    
    return NO;
}






-(BOOL)CheckifCoinGet:(UIImageView *)coins
{
    if (CGRectIntersectsRect(rocketMan.frame, coins.frame)) {
    return YES;
    }

    return NO;
}

-(BOOL)CheckifOilGet:(UIImageView *)oil
{
    if (CGRectIntersectsRect(rocketMan.frame, oil.frame)) {
        return YES;
    }
    
    return NO;
}

-(BOOL)CheckifRefineryGet:(UIImageView *)ref
{
    if (CGRectIntersectsRect(rocketMan.frame, ref.frame)) {
        return YES;
    }
    
    return NO;
}

-(BOOL)CheckifCoilGet:(UIImageView *)coil
{
    if (CGRectIntersectsRect(rocketMan.frame, coil.frame)) {
        return YES;
    }
    
    return NO;
}




-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	if(gameSuspended) return;
	float accel_filter = 0.1f;
	//rocketManNewPosition.x = rocketManNewPosition.x * accel_filter + acceleration.x * (1.0f - accel_filter) * 500.0f;

    
         deltaX=(acceleration.x *accel_filter ) + (deltaX * (1.0 - accel_filter));
    
}


-(void)startbouncing
{
    platformSpeedmove =1;
    
    if (!delayTime) {
        timerBounce = [NSTimer scheduledTimerWithTimeInterval:.07 target:self selector:@selector(jump) userInfo:nil repeats:YES];
        
        
        timerMovePlatform = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(movePlatforms) userInfo:nil repeats:YES];
        
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(gameTimeMethod) userInfo:nil repeats:YES];
        
        
        [timerdelay invalidate];
        timerdelay = nil;
    }


    else
    {
        delayTime = NO;
    }
}













-(void)resetPlatform:(UIImageView*)platform
{
    CGSize stepRect = CGSizeMake(100, 35);
    NSUInteger index;
    
    //get Index of previous Object
    if ([arrayOfPlatforms indexOfObject:platform]== 0)
    {
        index = kNumOfPlatforms-1;
    }
    else
    {
        index = [arrayOfPlatforms indexOfObject:platform]-1;
    }
    
    
    UIImageView *before= [arrayOfPlatforms objectAtIndex:index];
    
    maxDistanceBetweenStep = 0;
    minDistanceBetweenStep = 0;
    
    maxDistanceBetweenStep = before.center.x + distanceBetweenSteps;
    minDistanceBetweenStep = before.center.x -distanceBetweenSteps;
    
    
    //set Coordinate based on previous object
    if (maxDistanceBetweenStep >  [self view].frame.size.width - (stepRect.width)-10)
    {
        xpos = [self getRandomNumber:minDistanceBetweenStep to:([self view].bounds.size.width - (stepRect.width/2)-10) ];
    }
    
    else if(minDistanceBetweenStep <= 0)
    {
        xpos = [self getRandomNumber:10 + stepRect.width to:maxDistanceBetweenStep];
     
    }
    
    else
    {
        xpos = [self getRandomNumber:minDistanceBetweenStep to:maxDistanceBetweenStep ];
        
    }
    
    
    //Out of bounds xpos
    if (xpos < 0 + stepRect.width/2 )
    {
        
        if (xpos <= 0)
        {
        xpos = (xpos * -1)+stepRect.width/2 ;
        }
        else
            
        {
        xpos = 0 + stepRect.width/2 ;
        }
        
       

    }
    
    if (xpos >320 - stepRect.width/2 )
    {
        if (xpos > 320)
        {
            xpos = xpos - 50 - stepRect.width/2;
        }
        else
        {
        xpos =320 - stepRect.width/2;
        }
    }
    
    

    ypos = -10;
    
    


    platform.center = CGPointMake (xpos,ypos);

    
    if (platformsFinished < 20) {
        coinsCounts = 1;
    }
    else if (platformsFinished > 20)
    {
        coinsCounts = 5;
    
    }
    
    if ([arrayOfCoins count]< coinsCounts) {
        if ((arc4random() %2)+1 == 1)
        {
            
            CGRect coinsRect = CGRectMake(0, 0, 20, 20);
            UIImageView  *coinsView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"goldcoin.png"]];
            [coinsView setFrame:coinsRect];
            
            coinsView.center = CGPointMake(xpos,platform.frame.origin.y);
            
            [arrayOfCoins addObject:coinsView];
            
            [self.view addSubview:coinsView];
            
            
       }
    }
      
    

}







-(void)checkRocketDuration
{
if (rocketDuration <=0) {
    [timerRocket invalidate];
    timerRocket = nil;
    rocketOn = NO;
    platformSpeedmove = 1;
    }
    rocketDuration--;
}



-(IBAction)rocketOnMode:(id)sender
{
[rocketOnButton setAlpha:0];
    
    
    
    if (rocketOn)
    {
    rocketOn = NO;
    platformSpeedmove = 1;
    }
    else
    {
    
    rocketDuration =10;
    rocketOn = YES;
    timerRocket = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(checkRocketDuration) userInfo:nil repeats:YES];
        
    platformSpeedmove = 5;
        
    }
}






-(IBAction)moveCharbutton:(UIButton *)sender
{


        if (sender.tag==1)
        {
            if (rocketManNewPosition.x - 25 >=0 +rocketMan.frame.size.width/2)
            {
                rocketManNewPosition.x-= 25;
            }
            else
            {
                rocketManNewPosition.x=0 + rocketMan.frame.size.width/2;
            }
            
        }
    
        else
        {
            if (rocketManNewPosition.x + 25 <=320 - rocketMan.frame.size.width/2)
            {
                rocketManNewPosition.x+= 25;
            }
            else
            {
                rocketManNewPosition.x=320 - rocketMan.frame.size.width/2;
            }
        }
    
    
      
}




-(void)gameTimeMethod
{
    timeCounter ++;

    NSLog(@"%d",timeCounter);

    
    if (timeCounter %10 == 0)
    {
    
        CGRect EnemyRect = CGRectMake(0, 0, 20, 20);
        UIImageView  *enemyView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BH2.png"]];
        [enemyView setFrame:EnemyRect];
        
        enemyView.center = CGPointMake(abs(arc4random()%300)+10 ,0);
        
        [arrayOfEnemies addObject:enemyView];
        
        [self.view addSubview:enemyView];
    }
    


if (timeCounter % 3 ==0)
    {
        
            //add gas
        CGRect oilRect = CGRectMake(0, 0, 30, 30);
        
        UIImageView  *oilView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"crudeoil.png"]];
        
        [oilView setFrame:oilRect];
        
        oilView.center = CGPointMake(abs(arc4random()%300)+10 ,0);
        
        [arrayOfOil addObject:oilView];
        [self.view addSubview:oilView];
        
        
        
    

        
        
        //add refinery
        CGRect refRect = CGRectMake(0, 0, 35, 30);
        
        UIImageView  *refView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"refinery.jpg"]];
        
        [refView setFrame:refRect];
        
        refView.center = CGPointMake(abs(arc4random()%300)+10 ,0);
        
        [arrayOfRefinery addObject:refView];
        [self.view addSubview:refView];
        
        
        
        
        

//        //add coil
//        CGRect coilRect = CGRectMake(0, 0, 30, 30);
//        
//        UIImageView  *coilView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"refinery.png"]];
//        
//        [coilView setFrame:coilRect];
//        
//        coilView.center = CGPointMake(abs(arc4random()%300)+10 ,0);
//        
//        [arrayOfCoil addObject:coilView];
//        [self.view addSubview:coilView];
        
        
     


        

    }



    
    
}




-(void) getFuel
{
    
    //HITS oil
    for (UIImageView *oil in arrayOfOil)
    {
        
        //Remove if hit and add score
        if ([self CheckifOilGet:oil])
        {
            
            NSLog(@"oil Get");
            [numberOfGas setAlpha:1];
            [gasImage setAlpha:1];
            
            numberOfGas.text = [NSString stringWithFormat:@"%i", gasNum = gasNum+1];
          
            [arrayOfOil removeObject:oil];
            NSLog(@"%d",[arrayOfOil count]);
            
            [oil removeFromSuperview];
            
            NSLog(@"OIL");
            break;
        }
    }
    
   
 
        
    
    //HITS ref
    for (UIImageView *ref in arrayOfRefinery)
    {
        
        //Remove if hit and add count
        if ([self CheckifRefineryGet:ref])
        {
            
            NSLog(@"refinery Get");
            [numberOfRef setAlpha:1];
            [refineImage setAlpha:1];
            
            numberOfRef.text = [NSString stringWithFormat: @"%i", refNum = refNum + 1];
            
            [arrayOfRefinery removeObject:ref];
            NSLog(@"%d",[arrayOfRefinery count]);
            
            [ref removeFromSuperview];
            
            NSLog(@"REFINERY");
            break;
        }
    }
    
    
    
    
    
    if (gasNum >= 1 && refNum >= 1 && rocketOnButton.alpha != 1 && !rocketOn)
    {
        numberOfRef.text = [NSString stringWithFormat:@"%i", refNum = refNum - 1];
        numberOfGas.text = [NSString stringWithFormat:@"%i", gasNum = gasNum - 1];
        [rocketOnButton setAlpha:1];
        
    }
    
    
    if (gasNum == 0)
    {
        numberOfGas.alpha = 0.5;
        [gasImage setAlpha:0.5];
    }
    
    if (refNum == 0)
    {
        [numberOfRef setAlpha:0.5];
        [refineImage setAlpha:0.5];
    }
    
}





-(void) getElectroMagnet
{
//    if (CGRectIntersectsRect(rocketMan.frame, coil.frame))
//    {
//        [numberOfCoil setAlpha:1];
//        [coilImage setAlpha:1];
//        numberOfCoil.text = [NSString stringWithFormat:@"%i", coilNum = coilNum+1];
//        
//        [coil removeFromSuperview];
//      
//        
//    } else if (CGRectIntersectsRect(rocketMan.frame, battery.frame))
//    {
//        [numberOfbattery setAlpha:1];
//        [batteryImage setAlpha:1];
//        numberOfbattery.text = [NSString stringWithFormat: @"%i", batteryNum = batteryNum + 1];
//        
//        [battery removeFromSuperview];
//        
//    }
//    
//    if (coilNum >= 1 && batteryNum >= 1)
//    {
//        numberOfCoil.text = [NSString stringWithFormat:@"%i", coilNum = coilNum - 1];
//        numberOfbattery.text = [NSString stringWithFormat:@"%i", batteryNum = batteryNum - 1];
//        [magnetOnButton setAlpha:1];
//        
//    }
//    
//    if (batteryNum == 0)
//    {
//        numberOfbattery.alpha = 0.5;
//        [batteryImage setAlpha:0.5];
//    }
//    
//    if (coilNum == 0)
//    {
//        [numberOfCoil setAlpha:0.5];
//        [coilImage setAlpha:0.5];
//    }
    
}










-(IBAction)magnetOnMode:(UIButton *)sender
{
    NSLog (@"Magnet On!");
}
@end
