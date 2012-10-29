//
//  GameFinishedViewController.h
//  CrazyRocketManApp
//
//  Created by Regie G. Pinat on 10/29/12.
//  Copyright (c) 2012 Regie G. Pinat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameFinishedViewController : UIViewController
{
    float score;
    
}

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishLabel;

-(void)finishedScore:(float)passedscore;

@end
