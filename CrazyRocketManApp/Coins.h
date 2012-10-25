//
//  Coins.h
//  CrazyRocketManApp
//
//  Created by Regie G. Pinat on 10/24/12.
//  Copyright (c) 2012 Regie G. Pinat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Coins : UIImageView
@property  float value;



typedef struct {
    float xdistance;
    float ydistance;
    float mainDistance;
} distance;


-(distance)getDistanceFrom:(UIImageView *)character;
@end
