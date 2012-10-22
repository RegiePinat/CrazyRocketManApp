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

//G vars
float xpos =0;
float ypos;

float maxDistanceBetweenStep ;
float minDistanceBetweenStep ;
float distanceBetweenSteps=300,distanceyBetweenSteps = 50;
float accelmoveX=0,deltaX=0;

BOOL delayTime = YES;
BOOL NeedsTojump = NO;
BOOL mainJumping = NO;
BOOL gameSuspended = NO;

//how quickly should the jump start off
float jumpSpeedLimit = 15;
//the current speed of the jump;
float jumpSpeed;

CGPoint rocketManNewPosition;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
     
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
                   xpos = [self getRandomNumber:minDistanceBetweenStep to:([self view].frame.size.width - (stepRect.width)-10) ];
               }
               
               else if(minDistanceBetweenStep <= 10)
               {
                   xpos = [self getRandomNumber:0+stepRect.width to:maxDistanceBetweenStep];
                   NSLog(@"wafa" );
               }
               
               else
               {
                   xpos = [self getRandomNumber:minDistanceBetweenStep to:maxDistanceBetweenStep ];
                   
               }
               
               //Out of bounds xpos
               if (xpos <0 )
               {
                   xpos =10;
                   NSLog(@"x min");
               }
               
               if (xpos >320 )
               {
                   xpos =310;
                     NSLog(@"x max");
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
       
           // [[arrayOfPlatforms objectAtIndex:i] setBackgroundColor:[UIColor redColor]];
           
           ypos = ypos - distanceyBetweenSteps;
       }
        
       //Add images to View
        for ( UIImageView *steps in  arrayOfPlatforms)
        {
            
            [[self view] addSubview: steps];
            
        }
        
        //ADD Character
        UIImageView *first = [arrayOfPlatforms objectAtIndex:0];
        rocketMan = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BH2.png"]];
        NSLog(@"%f",rocketMan.bounds.size.height);
        
        rocketMan.center = CGPointMake(first.center.x, first.frame.origin.y -rocketMan.bounds.size.height/2-5);
       rocketManNewPosition.x = rocketMan.center.x;
       rocketManNewPosition.y = rocketMan.center.y;
        [[self view] addSubview:rocketMan ];
        
        
        //Jump Speed
        jumpSpeed = jumpSpeedLimit;
        
        
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
    
   
    
    
    [timerPlatformMove invalidate];
    timerPlatformMove =nil;
    
        
    [self setArrayOfPlatforms:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





-(int)getRandomNumber:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}



-(void)jump
{
     //rocketManNewPosition.x += 2;

    if (rocketManNewPosition.x + deltaX*40 >= 0 + rocketMan.frame.size.width/2 || rocketManNewPosition.x + deltaX*40 <= 320 ) {
          rocketManNewPosition.x += deltaX*40;
    }
       else
       {
           if (rocketManNewPosition.x + deltaX*40 < 0 + rocketMan.frame.size.width/2)
           {
               rocketManNewPosition.x = 0 +rocketMan.frame.size.width/2;
           }
           else if (rocketManNewPosition.x + deltaX*40 > 320 - rocketMan.frame.size.width/2)
           {
               rocketManNewPosition.x = 320 - rocketMan.frame.size.width/2;
           }
       }

   
    
    if(!mainJumping){
		//then start jumping
		mainJumping = YES;
		jumpSpeed = jumpSpeedLimit*-1;
		rocketManNewPosition.y += jumpSpeed;
      
        rocketMan.center = CGPointMake(rocketManNewPosition.x, rocketManNewPosition.y);
	}
    
    
    else
    {
        //if  paakyat n
        if(jumpSpeed < 0)
        {
            //Speed up gradually
			jumpSpeed *= 1 - jumpSpeedLimit/75;
          
			 //Determine if pababa n
        
            if(jumpSpeed > -jumpSpeedLimit/5){
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
        
            
            if(rocketManNewPosition.y >=  checkplatform.frame.origin.y - rocketMan.frame.size.height/2 +10  && [self CheckifJump:checkplatform]  &&  jumpSpeed  >0 )
            {
                         mainJumping = NO;
                rocketManNewPosition.y = checkplatform.frame.origin.y - rocketMan.frame.size.height/2 +10;
                rocketMan.center = CGPointMake(rocketManNewPosition.x, rocketManNewPosition.y);
                  
                 break;
             
            }
        }
    
            }
        
        //Check if on Ground
            if (rocketMan.frame.origin.y   > self.view.frame.size.height)
            {
                NSLog(@"aw");
            
                [timerBounce invalidate];
                timerBounce =nil;
            
                [timerMovePlatform invalidate];
                timerMovePlatform = nil;
            
            
            
            }
    
    }
}





-(void)movePlatforms{
    for (UIImageView *steps in arrayOfPlatforms) {
        steps.center = CGPointMake(steps.center.x, steps.center.y + .1);
        
        if (steps.frame.origin.y > self.view.bounds.size.height) {
                       [self resetPlatform:steps];
        }
    
    }

    
    
}




-(BOOL)CheckifJump:(UIImageView *)platform{
   
 
    if (rocketMan.center.x >= platform.frame.origin.x && rocketMan.center.x <= (platform.frame.origin.x + platform.bounds.size.width) && CGRectIntersectsRect(platform.frame,rocketMan.frame))
    {
        
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
    if (!delayTime) {
        timerBounce = [NSTimer scheduledTimerWithTimeInterval:.07 target:self selector:@selector(jump) userInfo:nil repeats:YES];
        
        
        timerMovePlatform = [NSTimer scheduledTimerWithTimeInterval:.005 target:self selector:@selector(movePlatforms) userInfo:nil repeats:YES];
        
        
        [timerdelay invalidate];
        timerdelay = nil;
    }


    else
    {
        delayTime = NO;
    }
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
    
    
    
    
    [timerPlatformMove invalidate];
    timerPlatformMove =nil;

}



-(void)resetPlatform:(UIImageView*)platform
{
    CGSize stepRect = CGSizeMake(100, 35);
    NSUInteger index;
    if ([arrayOfPlatforms indexOfObject:platform]== 0) {
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
    
    if (maxDistanceBetweenStep >  [self view].frame.size.width - (stepRect.width)-10)
    {
        xpos = [self getRandomNumber:minDistanceBetweenStep to:([self view].bounds.size.width - (stepRect.width)-10) ];
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
        xpos = 0 + stepRect.width/2 ;
    }
    
    if (xpos >320 - stepRect.width/2 )
    {
        xpos =320 - stepRect.width/2;
    }
    
    ypos = 0;
    
    platform.center = CGPointMake (xpos , ypos);
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
@end
